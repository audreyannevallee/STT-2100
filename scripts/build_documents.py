#!/usr/bin/env python3
"""Compile les sources et extrait les chapitres du livre commun.

Dépendances : Tectonic et pypdf. Les PDF sont livrés dans documents/;
les fichiers de travail restent dans un répertoire temporaire.
"""
from pathlib import Path
import argparse
import shutil
import subprocess
import tempfile
import sys
from pypdf import PdfReader, PdfWriter
from pypdf.generic import DictionaryObject, NameObject, ArrayObject, NumberObject, TextStringObject

ROOT = Path(__file__).resolve().parents[1]

def compile_tex(compiler, source, dest):
    dest.mkdir(parents=True, exist_ok=True)
    result = subprocess.run(
        [compiler, '--keep-logs', '--keep-intermediates', '--outdir', str(dest), str(source)],
        capture_output=True, text=True)
    (dest / 'compilation.txt').write_text(result.stdout + result.stderr)
    if result.returncode:
        raise RuntimeError(f'{source}:\n{result.stdout[-2000:]}\n{result.stderr[-4000:]}')
    return dest / (source.stem + '.pdf')

def split_notes(pdf):
    reader = PdfReader(pdf)
    chapters = []
    bibliography = len(reader.pages)
    for item in reader.outline:
        if isinstance(item, list):
            continue
        title = str(item.get('/Title', ''))
        page = reader.get_destination_page_number(item)
        if title and 'Bibliographie' not in title:
            chapters.append((title, page))
        elif 'Bibliographie' in title:
            bibliography = page
    for i, page in enumerate(reader.pages):
        if (page.extract_text() or '').lstrip().startswith('Bibliographie'):
            bibliography = i
            break
    if len(chapters) != 11:
        raise RuntimeError(f'11 chapitres attendus dans les signets, obtenu : {chapters}')
    for i, (_, start) in enumerate(chapters):
        end = chapters[i + 1][1] if i + 1 < len(chapters) else bibliography
        # Extrait depuis le même livre : numérotation et références concordent.
        writer = PdfWriter()
        # Preserve all link rectangles; resolve named targets before extracting.
        # Cross-chapter links point to the complete book beside the chapter PDF.
        for page in reader.pages[start:end]:
            writer.add_page(page, excluded_keys=['/Annots'])
        for local, original in enumerate(reader.pages[start:end]):
            annotations = ArrayObject()
            for ref in original.get('/Annots', []):
                old = ref.get_object()
                if old.get('/Subtype') != '/Link':
                    continue
                link = DictionaryObject()
                for key in ['/Type', '/Subtype', '/Rect', '/Border', '/H', '/C', '/BS']:
                    if key in old:
                        link[NameObject(key)] = old[key].clone(writer)
                action = old.get('/A', {})
                target = action.get('/D') if action.get('/S') == '/GoTo' else old.get('/Dest')
                if target is not None:
                    if isinstance(target, str):
                        destination = reader.named_destinations.get(target)
                        if destination is None:
                            raise RuntimeError(f'Destination PDF inconnue : {target}')
                        target_page = reader.get_destination_page_number(destination)
                    else:
                        target_page = reader.get_page_number(target[0].get_object())
                    if start <= target_page < end:
                        link[NameObject('/A')] = DictionaryObject({
                            NameObject('/S'): NameObject('/GoTo'),
                            NameObject('/D'): ArrayObject([writer.pages[target_page - start].indirect_reference, NameObject('/Fit')])})
                    else:
                        link[NameObject('/A')] = DictionaryObject({
                            NameObject('/S'): NameObject('/GoToR'),
                            NameObject('/F'): TextStringObject('notes-completes.pdf'),
                            NameObject('/D'): ArrayObject([NumberObject(target_page), NameObject('/Fit')])})
                elif '/A' in old:
                    link[NameObject('/A')] = old['/A'].clone(writer)
                annotations.append(writer._add_object(link))
            if annotations:
                writer.pages[local][NameObject('/Annots')] = annotations
        writer.add_metadata({'/Title': f'STT-2100 - Chapitre {i + 1}', '/Author': 'Document collaboratif - STT-2100'})
        with (ROOT / f'documents/chapitre-{i + 1:02}-notes.pdf').open('wb') as stream:
            writer.write(stream)
    shutil.copy2(pdf, ROOT / 'documents/notes-completes.pdf')

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', default='tectonic')
    parser.add_argument('--work-dir', type=Path)
    args = parser.parse_args()
    context = tempfile.TemporaryDirectory(prefix='stt2100-latex-') if not args.work_dir else None
    work = args.work_dir or Path(context.name)
    (ROOT / 'documents').mkdir(parents=True, exist_ok=True)
    notes = compile_tex(args.compiler, ROOT / 'sources/notes/notes.tex', work / 'notes')
    split_notes(notes)
    for category, suffix in [('exercices', 'exercices'), ('fiches-r', 'fiche-r')]:
        for source in sorted((ROOT / 'sources' / category).glob('chapitre-*.tex')):
            pdf = compile_tex(args.compiler, source, work / category / source.stem)
            shutil.copy2(pdf, ROOT / 'documents' / f'{source.stem}-{suffix}.pdf')
            print(f'{source.stem}-{suffix}.pdf')
    subprocess.run([sys.executable, str(ROOT / 'scripts/package_material.py')], check=True)
    if context:
        context.cleanup()

if __name__ == '__main__':
    main()
