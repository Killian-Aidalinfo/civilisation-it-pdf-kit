# Charte Civilisation IT

Relevée sur [civilisation-it.fr](https://civilisation-it.fr) (thème Starlight du site) et sur sa carte de partage `og_card.png`. Les valeurs font foi dans `tokens.css`.

## Logo

L'astronaute assis sur un nuage, en monochrome.

| Fichier | Usage |
|---|---|
| `logo/logo-marine.svg` | Sur fond clair (médaillon de couverture, documents) |
| `logo/logo-noir.svg` | Impression noir et blanc |
| `logo/logo-blanc.svg` | Sur fond sombre (bloc de clôture) |
| `logo/logo-entete.svg` | Version 24 px pour l'en-tête des pages |

Le nom s'écrit **CivilisationIT** en un mot à côté du logo (comme dans l'en-tête du site), et **Civilisation IT** dans le texte courant.

## Couleurs

| Rôle | Variable | Valeur | Origine |
|---|---|---|---|
| Couleur principale : liens, boutons, nom | `--cit-petrole` | `#00547b` | accent du site, thème clair |
| Bleu secondaire | `--cit-bleu` | `#1971a0` | accent du site, thème sombre |
| Titres, aplats | `--cit-marine` | `#14364a` | accent fort du site |
| Fond de couverture | `--cit-nuit` | `#022659` | fond de la carte de partage |
| Dégradé de couverture | `--cit-roi` | `#0c3283` | carte de partage |
| Touche vive | `--cit-cyan` | `#57dffd` | bandeau de la carte de partage |
| Bandeau clair | `--cit-cyan-pale` | `#d6fafd` | carte de partage |
| Accent doux | `--cit-ciel` | `#c7dae7` | accent faible du site |

Neutres : gris bleutés du site, de `--cit-encre` (`#14191a`) à `--cit-gris-7` (`#f4f7f7`).

Le cyan reste une touche (soulignement des titres, étiquette de couverture, liseré du code) : jamais en grand aplat dans les pages intérieures.

## Typographie

[Inter](https://rsms.me/inter/) (licence SIL OFL, fichiers dans `fonts/`), proche de la police système du site et identique sur toutes les machines. Graisses utilisées : 400 texte, 600-650 accents, 700-800 titres. Code en police monospace système.

## Motifs

- `motif-circuit.svg` : pistes de circuit imprimé en cyan transparent, clin d'œil au fond de la carte de partage. Sur fonds sombres uniquement.
- Bandeau incliné (`skewX(-8deg)`) : repris des bandeaux de la carte de partage, réservé à la couverture.
- Cartes à bordure fine et pastilles colorées : reprises de la page d'accueil du site.
