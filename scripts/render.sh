#!/usr/bin/env bash
# Rend un document HTML du kit en PDF avec Chrome/Chromium headless.
#
#   scripts/render.sh chemin/document.html [chemin/sortie.pdf]
#
# Le document référence le kit par le préfixe « kit/ » (kit/templates/civilisation-it.css,
# kit/brand/logo/…). Si aucun dossier « kit » n'existe à côté du document, le script crée
# un lien temporaire vers ce kit le temps du rendu, puis le retire.
#
# Navigateur : variable CHROME, sinon détection automatique (Hermes, Linux, macOS).

set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "usage : $0 document.html [sortie.pdf]" >&2
  exit 2
fi

input="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
[[ -f "$input" ]] || { echo "introuvable : $1" >&2; exit 1; }
output="${2:-${input%.*}.pdf}"
output="$(cd "$(dirname "$output")" && pwd)/$(basename "$output")"

find_chrome() {
  if [[ -n "${CHROME:-}" ]]; then echo "$CHROME"; return; fi
  local candidate
  for candidate in /opt/hermes/tools/chromium-*/chrome-linux64/chrome; do
    [[ -x "$candidate" ]] && { echo "$candidate"; return; }
  done
  for candidate in chromium chromium-browser google-chrome google-chrome-stable; do
    command -v "$candidate" >/dev/null 2>&1 && { command -v "$candidate"; return; }
  done
  for candidate in "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
                   "/Applications/Chromium.app/Contents/MacOS/Chromium"; do
    [[ -x "$candidate" ]] && { echo "$candidate"; return; }
  done
  return 1
}

chrome="$(find_chrome)" || { echo "Chrome/Chromium introuvable : définir CHROME=/chemin/vers/chrome" >&2; exit 1; }

link="$(dirname "$input")/kit"
created_link=0
if [[ ! -e "$link" ]]; then
  ln -s "$KIT_DIR" "$link"
  created_link=1
fi
cleanup() { [[ $created_link -eq 1 ]] && rm -f "$link"; }
trap cleanup EXIT

flags=(--headless=new --disable-gpu --hide-scrollbars --no-pdf-header-footer
       --run-all-compositor-stages-before-draw --virtual-time-budget=15000
       --allow-file-access-from-files)
# Le bac à sable de Chrome est indisponible dans la plupart des conteneurs.
[[ -f /.dockerenv || "$(id -u)" -eq 0 ]] && flags+=(--no-sandbox)

"$chrome" "${flags[@]}" --print-to-pdf="$output" "file://$input" >/dev/null 2>&1

[[ -s "$output" ]] || { echo "échec du rendu : aucun PDF produit" >&2; exit 1; }
echo "$output"
