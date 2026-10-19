---
name: civilisation-it-pdf
description: "Générer des PDF corporate aux couleurs de Civilisation IT (rapport, proposition, compte rendu, devis, fiche technique) à partir d'un gabarit HTML A4 rendu par Chrome. À utiliser dès qu'on demande un PDF, un document « propre », « corporate » ou « à la charte » pour Civilisation IT."
version: 1.0.0
author: Killian Stein
license: MIT
platforms: [linux, macos]
metadata:
  hermes:
    tags: [PDF, Document, Branding, Civilisation-IT, Corporate]
---

# PDF corporate Civilisation IT

Ce kit produit des PDF A4 à la charte Civilisation IT : page de garde bleu nuit à motif circuit, en-tête avec logo, pied de page numéroté, typographie Inter, composants repris du site civilisation-it.fr.

On écrit le document en **HTML** à partir du gabarit, puis `scripts/render.sh` le transforme en PDF avec Chrome/Chromium. Aucune dépendance à installer en plus d'un Chrome ou Chromium.

## Démarche

1. **Copier le gabarit** dans un dossier de travail (à côté des images éventuelles) :
   ```sh
   KIT=<chemin du kit>
   mkdir -p ~/documents/mon-doc && cp "$KIT/templates/document.html" ~/documents/mon-doc/mon-doc.html
   ```
2. **Remplir le document** : titre dans `--doc-title` (sur `<html>`) et dans `<title>`, couverture, puis le contenu dans `<main>`. Supprimer les composants inutiles du gabarit.
3. **Rendre** :
   ```sh
   "$KIT/scripts/render.sh" ~/documents/mon-doc/mon-doc.html
   ```
   Le PDF est écrit à côté du HTML (`mon-doc.pdf`) ; un second argument choisit un autre chemin.
4. **Vérifier** avant de livrer : nombre de pages raisonnable, pas de page presque vide, pas de titre seul en bas de page, couverture sans débordement. Si un outil de lecture PDF ou de vision est disponible, regarder au moins la couverture et une page intérieure.

Les chemins `kit/…` du gabarit sont résolus par `render.sh`, qui crée un lien temporaire `kit` à côté du document. Ne pas les remplacer par des chemins absolus.

## Composants

Tous les styles sont dans `templates/civilisation-it.css`. Le gabarit `templates/document.html` montre chaque composant ; `examples/rapport-robert.html` est un rapport complet.

| Besoin | Code |
|---|---|
| Page de garde | `<section class="couverture">` (structure du gabarit, à garder) |
| Petit texte au-dessus d'un titre | `<span class="surtitre">…</span>` |
| Sommaire | `<ol class="sommaire"><li>…</li></ol>` (numérotation automatique, sans numéros de page) |
| Titre de partie / sous-partie | `<h2>` (souligné cyan) / `<h3>` (bleu pétrole) |
| Introduction | `<p class="chapeau">…</p>` |
| Chiffres clés (2 à 4) | `<div class="chiffres"><div class="chiffre"><span class="chiffre__valeur">12</span><span class="chiffre__libelle">Serveurs</span></div>…</div>` |
| Cartes (2 ou 3 colonnes) | `<div class="cartes">` ou `<div class="cartes cartes--3">`, puis `<div class="carte"><h4><span class="pastille">1</span>Titre</h4><p>…</p></div>` |
| Couleur de pastille | `pastille--orange`, `--violet`, `--vert`, `--rose` (bleu par défaut) |
| Encadré | `<div class="encadre encadre--attention"><span class="encadre__titre">Attention</span><p>…</p></div>` ; variantes : (aucune) = note, `--astuce`, `--attention`, `--danger`, `--succes` |
| Tableau | `<table>` avec `<thead>` ; colonnes chiffrées : `class="nombre"` ; total : `<tfoot>` |
| Étiquette de statut | `<span class="etiquette etiquette--succes">Fait</span>` ; variantes : (aucune), `--clair`, `--succes`, `--attention`, `--danger` |
| Code | `<code>` en ligne, `<pre><code>…</code></pre>` en bloc |
| Image | `<figure><img src="schema.png" alt="…"><figcaption>…</figcaption></figure>` |
| Deux colonnes | `<div class="colonnes"><div>…</div><div>…</div></div>` |
| Saut de page | `class="nouvelle-page"` sur le titre qui doit ouvrir une page |
| Bloc non sécable | `class="insecable"` |
| Signatures (devis, contrat) | `<div class="signatures"><div class="signature">Pour le client</div><div class="signature">Pour Civilisation IT</div></div>` |
| Clôture avec coordonnées | `<div class="contact">` (voir le gabarit) |

## Règles de mise en page

- **Une seule couverture**, en première page. Titre de deux lignes au plus, bandeau d'une phrase, quatre informations au plus dans `couverture__infos` (Client, Date, Version, Auteur…).
- **Le titre courant** (`--doc-title`) doit être court : il tient sur la moitié de la largeur de l'en-tête.
- **Une idée par encadré**, trois encadrés au plus d'affilée. Le cyan est une touche, pas un fond : ne pas ajouter d'aplats cyan.
- **Pas d'emoji** : la police n'en contient pas et le rendu varie selon la machine. Utiliser des pastilles, des étiquettes ou du texte.
- **Pas de nouvelles couleurs** dans le document : uniquement les variables de `brand/tokens.css` (`var(--cit-petrole)`, etc.). Si un style manque, l'ajouter dans `civilisation-it.css` plutôt qu'en ligne.
- **Typographie française** : espace insécable (`&nbsp;`) avant `: ; ! ?` et dans les nombres (`1&nbsp;200,00&nbsp;€`), guillemets « », dates en toutes lettres (19 octobre 2026).
- Les tableaux, encadrés, cartes et blocs de code ne se coupent pas entre deux pages ; un tableau plus long qu'une page se coupe quand même et répète son en-tête.

## Ton

Civilisation IT vulgarise le DevOps, le système, le réseau et la sécurité. Le ton est clair, direct et accessible, sans jargon inutile, en tutoyant uniquement si le document s'adresse à la communauté (tutoriel, support de formation), en vouvoyant pour un client.

## Dépannage

- **« Chrome/Chromium introuvable »** : définir `CHROME=/chemin/vers/chrome`. Dans Hermes, Chromium est livré dans `/opt/hermes/tools/chromium-*/chrome-linux64/chrome`, détecté automatiquement.
- **Police différente d'Inter** : le document n'a pas trouvé `kit/templates/civilisation-it.css` ; vérifier qu'il est rendu avec `render.sh` et que le lien `kit` n'est pas masqué par un autre dossier `kit`.
- **Page de garde sur deux pages** : trop de texte sur la couverture ; raccourcir le titre ou le bandeau.
