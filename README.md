# STT-2100 — Régression

Site du cours à l’Université Laval, session d’automne 2026.

**Site : https://audreyannevallee.github.io/STT-2100/**

## Modifier le site

Les cinq pages sont écrites en Quarto :

- `index.qmd` : accueil et contact;
- `cours.qmd` : notes, diapositives et exercices des chapitres 1 à 5;
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

Seuls les fichiers sources créés ou mis à jour en 2026 sont inclus, selon leur date de modification locale. Les documents des chapitres 1 à 5 ont été vérifiés avant copie. Les anciens chapitres 6 à 11, les annexes et les tables antérieures à 2026 sont exclus. Certains fichiers sources conservent « A2024 » dans leur nom mais ont été mis à jour en 2026. Le fichier `materiel-2026.json` conserve les chemins sources, les dates et les empreintes SHA-256 des copies publiées.

Le calendrier provient du PDF étudiant `A2026/Calendrier-A26.pdf`. Le calendrier et les modalités du plan de cours officiel restent prioritaires en cas de modification.

Le fichier `fichiers/bixi.csv` contient seulement la distance et la durée des 500 déplacements de l’échantillon pédagogique `Bixi.rda`, issu des données ouvertes BIXI 2025. Les deux scripts de laboratoire et le fichier R natif sont les originaux mis à jour en septembre 2026.

Le dépôt contient uniquement les fichiers du site et le matériel pédagogique sélectionné. Les listes étudiantes, notes, remises, archives d’examens et corrigés restent dans le dossier local du cours.

Aucune licence générale n’est attribuée aux documents pédagogiques; leurs auteurs conservent leurs droits.
