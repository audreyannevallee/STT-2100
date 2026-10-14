# Sources pédagogiques STT-2100

Les fichiers d'Archives sont la référence de départ; ils restent inchangés. Ce dossier contient les versions maintenues et compilables pour le site.

- `notes/notes.tex` : livre commun, chapitres 1 à 11. Les chapitres 1 à 6 reprennent les sources révisées `3-*` d'Archives; les chapitres 7 à 11 adaptent les chapitres historiques. Les exemples encadrés, la police sans empattement, les symboles et la numérotation sont conservés.
- `exercices/chapitre-*.tex` : fiches étudiantes, avec solutions dans les commandes `\prof{...}`.
- `fiches-r/chapitre-*.tex` : fiches pratiques R. Les nouveaux exemples exécutables sont aussi dans `../fichiers/chapitre-*.R`.

## Compilation

À la racine du dépôt : `python3 scripts/build_documents.py`, avec Tectonic et pypdf installés. Les notes sont extraites du livre compilé pour que les renvois entre chapitres restent cohérents. Le recueil complet inclut la bibliographie.

Pour générer un corrigé d'exercices, créer un fichier temporaire à côté du chapitre, contenant par exemple :

```tex
\def\avecsolutions{1}
\input{chapitre-06.tex}
```

Puis compiler ce fichier avec Tectonic. Les solutions sont affichées en bleu, comme dans les sources révisées. Les PDF étudiants publiés ne contiennent pas ces solutions.

## Adaptations des archives

Corrections techniques : casse des noms de fichiers, chemins des figures, options de paquets et environnements de versions, en-têtes des fiches et compatibilité de compilation. Les fichiers historiques redondants ne sont pas copiés dans les sources maintenues.

Les notes des chapitres 7 à 11 conservent les sujets et les développements du matériel archivé, avec les corrections suivantes :

- Chapitre 7 : renvoi dynamique à l'exemple d'interaction; ne pas assimiler un non-rejet à une preuve d'adéquation.
- Chapitre 8 : famille de Box-Cox, loi asymptotique du test de White, modèle de l'exemple de manque d'ajustement, carré des résidus dans PRESS et erreur de validation calculée sur le jeu de validation. La log-vraisemblance utilisée par AIC est celle maximisée, et non une vraisemblance restreinte. La formulation ridge précise le centrage et la standardisation et exclut la constante de la pénalité.
- Chapitre 9 : distinction coefficients non identifiables / valeurs ajustées uniques, précision des effets de la colinéarité sur les prédictions, racine carrée dans le conditionnement de la matrice de modèle et constante dans la régression sur composantes.
- Chapitre 10 : degrés de liberté des résidus studentisés externes, DFBETAS standardisés, somme sur toutes les valeurs ajustées dans Cook, formule du COVRATIO et nombre de coefficients incluant la constante. Les repères diagnostiques appellent une analyse, pas un retrait automatique.
- Chapitre 11 : linéarité en les paramètres, distinction variance connue / facteur de variance estimé pour l'inférence pondérée, et condition de stationnarité du modèle AR(1).

Les chapitres 1 à 6 révisés conservent leur contenu; les changements concernent la compilation et les chemins des figures, avec des corrections typographiques au chapitre 6 : dimension $p'$ de la loi des coefficients, inverse de la matrice de Gram dans l'exemple d'IC, notation des degrés de liberté et de la loi F, et inversion des libellés des carrés moyens (régression et résidus). La bibliographie et les auteurs du document collaboratif sont conservés.

Les exercices 6 à 11 couvrent calcul, interprétation, limites et application dans R. Les fiches R 6 à 11 utilisent des exemples reproductibles avec les fonctions usuelles de R; les exemples de diagnostics et d'ANOVA ont été vérifiés avec la documentation officielle de R.
