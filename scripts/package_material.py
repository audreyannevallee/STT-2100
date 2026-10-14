#!/usr/bin/env python3
"""Archive les sources compilables et actualise les empreintes du matériel."""
from pathlib import Path
from datetime import date
import hashlib
import json
import re
from zipfile import ZipFile, ZIP_DEFLATED

ROOT = Path(__file__).resolve().parents[1]
manifest = ROOT / 'materiel-2026.json'
data = json.loads(manifest.read_text())
entries = {item['fichier']: item for item in data['documents']}
notes_ar = 'Archives/STT-2100 - Notes de cours/'
archive_notes = {
    7: 'Chap7-CategoriquesInteractions/CategoriquesInteractions.tex',
    8: 'Chap8-ChoixModeleRLM/ChoixModeleRLM.tex',
    9: 'Chap9-Multicolinearite/Multicolinearite.tex',
    10: 'Chap10-DonneesInfluentes/DonneesInfluentes.tex',
    11: 'Chap11-TechniquesAvancees/TechniquesAvancees.tex',
}
for pdf in sorted((ROOT / 'documents').glob('*.pdf')):
    path = pdf.relative_to(ROOT).as_posix()
    match = re.fullmatch(r'chapitre-(\d+)-(notes|exercices|fiche-r)\.pdf', pdf.name)
    sources = []
    provenance = []
    if match:
        n, kind = int(match[1]), match[2]
        if kind == 'notes':
            section = next((ROOT / 'sources/notes').glob(f'3-{n}-*.tex'))
            sources = [section.relative_to(ROOT).as_posix(), 'sources/notes/notes.tex']
            provenance = [notes_ar + (section.name if n <= 6 else archive_notes[n])]
        elif kind == 'exercices':
            sources = [f'sources/exercices/chapitre-{n:02}.tex']
            provenance = ([f'Archives/STT-2100 - Exercices/{n}- Chapitre {n}.tex']
                          if n <= 5 else [next((ROOT / 'sources/notes').glob(f'3-{n}-*.tex')).relative_to(ROOT).as_posix()])
        else:
            sources = [f'sources/fiches-r/chapitre-{n:02}.tex']
            if n in [2, 3, 5]:
                k = {2: 1, 3: 2, 5: 3}[n]
                provenance = [f'Archives/STT-2100 - Fiches R/{k}- Chapitre {n} - Fiche R.tex']
            else:
                sources.append(f'fichiers/chapitre-{n:02}.R')
                provenance = [next((ROOT / 'sources/notes').glob(f'3-{n}-*.tex')).relative_to(ROOT).as_posix()]
    elif pdf.name == 'notes-completes.pdf':
        sources = ['sources/notes/notes.tex'] + [p.relative_to(ROOT).as_posix() for p in sorted((ROOT / 'sources/notes').glob('3-*.tex'))]
    item = entries.setdefault(path, {'fichier': path})
    if sources:
        if 'source' in item and not item['source'].startswith('sources/'):
            item['source_publication_initiale'] = item['source']
        item['source'] = sources[0]
        item['sources_compilation'] = sources
        item['provenance'] = provenance
        item['generation'] = date.today().isoformat()
        item.pop('modification_source', None)
    item['sha256'] = hashlib.sha256(pdf.read_bytes()).hexdigest()
data['critere'] = "Matériel pédagogique révisé pour l'automne 2026 : sources révisées d'Archives pour les chapitres 1 à 6; adaptation des archives et nouveaux exercices et fiches R pour les chapitres 6 à 11. Les diapositives et compléments déjà publiés sont conservés."
data['documents'] = sorted(entries.values(), key=lambda item: item['fichier'])
manifest.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')
(ROOT / 'fichiers').mkdir(exist_ok=True)
with ZipFile(ROOT / 'fichiers/sources-latex.zip', 'w', ZIP_DEFLATED) as archive:
    for directory in ['sources', 'scripts']:
        for p in sorted((ROOT / directory).rglob('*')):
            if p.is_file() and '__pycache__' not in p.parts:
                archive.write(p, 'STT-2100/' + p.relative_to(ROOT).as_posix())
    for p in sorted((ROOT / 'fichiers').glob('chapitre-*.R')):
        archive.write(p, 'STT-2100/' + p.relative_to(ROOT).as_posix())
    # Un extrait peut être recompilé sans le reste du site ou les Archives.
    archive.writestr('STT-2100/materiel-2026.json', json.dumps({'documents': [], 'critere': data['critere']}, ensure_ascii=False))
print('Archive des sources et manifeste actualisés.')
