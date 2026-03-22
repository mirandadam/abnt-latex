#!/usr/bin/env bash
# compilar-tudo.sh — Compila todos os testes e templates do projeto,
# copia o guia do usuário para a raiz e gera os zips do Overleaf.
# Uso: ./scripts/compilar-tudo.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TEXINPUTS="${REPO_ROOT}/src:"
export TEXINPUTS

FAILED=()
PASSED=()

build() {
  local tex_file="$1"
  local dir
  dir="$(dirname "$tex_file")"
  local label="${tex_file#"$REPO_ROOT/"}"

  printf '%-60s ' "$label"
  if latexmk -pdf -interaction=nonstopmode -halt-on-error \
       -output-directory="$dir" "$tex_file" > /dev/null 2>&1; then
    echo "OK"
    PASSED+=("$label")
  else
    echo "FALHOU"
    FAILED+=("$label")
  fi
}

echo "========================================"
echo " Compilação de testes e templates"
echo "========================================"
echo ""

# --- Testes ---
echo "--- Testes ---"
for f in "$REPO_ROOT"/tests/*.tex; do
  build "$f"
done

echo ""

# --- Templates ---
echo "--- Templates ---"
for f in "$REPO_ROOT"/templates/*/main.tex; do
  build "$f"
done

echo ""
echo "========================================"
echo " Resultado: ${#PASSED[@]} OK, ${#FAILED[@]} falhas"
echo "========================================"

if [ ${#FAILED[@]} -gt 0 ]; then
  echo ""
  echo "Falhas:"
  for f in "${FAILED[@]}"; do
    echo "  - $f"
  done
  exit 1
fi

# --- Copiar guia do usuário para a raiz ---
echo ""
cp "$REPO_ROOT/templates/guia-usuario/main.pdf" "$REPO_ROOT/Guia do Usuário.pdf"
echo "Copiado: Guia do Usuário.pdf"

# --- Gerar zips do Overleaf ---
echo ""
echo "--- Overleaf ---"
"$REPO_ROOT/scripts/overleaf-zip.sh" trabalho-academico
"$REPO_ROOT/scripts/overleaf-zip.sh" projeto-pesquisa
"$REPO_ROOT/scripts/overleaf-zip.sh" unb-A
"$REPO_ROOT/scripts/overleaf-zip.sh" unb-B
"$REPO_ROOT/scripts/overleaf-zip.sh" unb-projeto-pesquisa
