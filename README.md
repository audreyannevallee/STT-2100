# STT-2100 — Régression

Site du cours à l’Université Laval, session d’automne 2026.

**Site : https://audreyannevallee.github.io/STT-2100/**

## Modifier le site

Les cinq pages sont écrites en Quarto :

- `index.qmd` : accueil et contact;
- `cours.qmd` : notes, exercices et fiches R des chapitres 1 à 11, et diapositives disponibles;
- `laboratoires.qmd` : activités et exemples en R;
- `calendrier.qmd` : progression et évaluations;
- `ressources.qmd` : outils et références.

La navigation se configure dans `_quarto.yml` et les styles dans `styles.css`.

## Aperçu local

Avec Quarto 1.9.37 (également fourni avec RStudio) :

```sh
quarto preview
```

Sur ce Mac, si Quarto n’est pas dans le PATH :

```sh
/Applications/RStudio.app/Contents/Resources/app/quarto/bin/quarto preview
```

## Publication

Le workflow `.github/workflows/publish.yml` génère et publie automatiquement le site à chaque modification de `main`. Dans les paramètres du dépôt, **Settings → Pages → Source** doit être réglé sur **GitHub Actions**.

Le rendu est statique : les exemples R sont affichés sans exécution pendant la publication. Aucune installation de paquet R n’est nécessaire pour générer le site.

## Matériel et provenance

Les sources révisées des chapitres 1 à 6 proviennent de `Archives/STT-2100 - Notes de cours/3-*.tex`. Les chapitres 7 à 11 sont adaptés des chapitres historiques de ce même dossier, avec la mise en page des notes révisées. Les exercices et fiches R des chapitres 1 à 5 reprennent les sources révisées d'Archives. Les exercices et fiches R des chapitres 6 à 11 sont créés en cohérence avec les notions des notes. Les diapositives déjà publiées sont conservées.

Les sources maintenues sont dans `sources/`; le dossier `Archives/` conserve le matériel d'origine. Les ajustements pédagogiques des chapitres 7 à 11 sont décrits dans `sources/README.md`. Les fiches d'exercices PDF sont en version étudiante. Les solutions figurent dans les sources et peuvent être compilées avec `\avecsolutions`. Le fichier `materiel-2026.json` conserve la provenance et les empreintes SHA-256 des documents publiés.

### Générer les PDF

Installer [Tectonic](https://tectonic-typesetting.github.io/en-US/install.html) et Python avec `pypdf`, puis exécuter :

```sh
python3 scripts/build_documents.py
```

Le script compile le livre commun puis extrait les onze chapitres, ce qui préserve les numéros et les références croisées. Il génère aussi les exercices, les fiches R et le recueil complet dans `documents/`. Un premier lancement de Tectonic télécharge les paquets LaTeX nécessaires. Les PDF sont versionnés : le workflow GitHub Pages n'a pas besoin de compiler LaTeX.

Les scripts R des chapitres 6 à 11 sont dans `fichiers/`. Ils utilisent des données incluses dans R ou des simulations reproductibles; l'exemple AR(1) utilise le paquet recommandé `nlme`.

Le calendrier provient du PDF étudiant `A2026/Calendrier-A26.pdf`. Le calendrier et les modalités du plan de cours officiel restent prioritaires en cas de modification.

Le fichier `fichiers/bixi.csv` contient seulement la distance et la durée des 500 déplacements de l’échantillon pédagogique `Bixi.rda`, issu des données ouvertes BIXI 2025. Les deux scripts de laboratoire et le fichier R natif sont les originaux mis à jour en septembre 2026.

Le dépôt contient le site, les sources pédagogiques et les archives de cours fournies. Les listes étudiantes, notes, remises et archives d’examens restent dans le dossier local du cours.

Aucune licence générale n’est attribuée aux documents pédagogiques; leurs auteurs conservent leurs droits.
