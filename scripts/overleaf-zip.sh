#!/usr/bin/env bash
# =============================================================================
# overleaf-zip.sh
# Gera um .zip pronto para upload no Overleaf contendo o template escolhido
# e todos os arquivos .cls e .sty necessários.
#
# Uso:
#   ./scripts/overleaf-zip.sh <template>
#
# Templates disponíveis:
#   trabalho-academico      Trabalho acadêmico genérico (NBR 14724)
#   projeto-pesquisa        Projeto de pesquisa genérico (NBR 15287)
#   unb-A                   UnB — Modelo A (engenharia)
#   unb-B                   UnB — Modelo B (clássico)
#   unb-projeto-pesquisa    UnB — Projeto de pesquisa
#
# O arquivo .zip é criado na pasta dist/ na raiz do repositório.
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

TEMPLATES=(
  trabalho-academico
  projeto-pesquisa
  unb-A
  unb-B
  unb-projeto-pesquisa
)

usage() {
  echo "Uso: $0 <template>"
  echo ""
  echo "Templates disponíveis:"
  for t in "${TEMPLATES[@]}"; do
    echo "  $t"
  done
  exit 1
}

# Validar argumento
[[ $# -lt 1 ]] && usage

TEMPLATE="$1"
TEMPLATE_DIR="$ROOT_DIR/templates/$TEMPLATE"

if [[ ! -d "$TEMPLATE_DIR" ]]; then
  echo "Erro: template '$TEMPLATE' não encontrado em templates/"
  echo ""
  usage
fi

# Criar diretório de saída
DIST_DIR="$ROOT_DIR/dist"
mkdir -p "$DIST_DIR"

ZIP_FILE="$DIST_DIR/latex-abnt-$TEMPLATE.zip"
rm -f "$ZIP_FILE"

# Montar o zip: classes e pacotes na raiz + arquivos do template na raiz
# (Overleaf espera tudo na mesma pasta)
TMPDIR_ZIP="$(mktemp -d)"
trap 'rm -rf "$TMPDIR_ZIP"' EXIT

# Copiar classes e pacotes
cp "$ROOT_DIR"/src/*.cls "$TMPDIR_ZIP/"
cp "$ROOT_DIR"/src/*.sty "$TMPDIR_ZIP/"

# Copiar arquivos do template
cp "$TEMPLATE_DIR"/*.tex "$TMPDIR_ZIP/"
cp "$TEMPLATE_DIR"/*.bib "$TMPDIR_ZIP/"

# Copiar assets extras se existirem (.ist, .pdf de logos, etc.)
for ext in ist pdf; do
  if ls "$TEMPLATE_DIR"/*."$ext" &>/dev/null; then
    cp "$TEMPLATE_DIR"/*."$ext" "$TMPDIR_ZIP/"
  fi
done

# Gerar o zip
(cd "$TMPDIR_ZIP" && zip -q "$ZIP_FILE" ./*)

echo "Criado: $ZIP_FILE"
echo "Conteúdo:"
unzip -l "$ZIP_FILE" | tail -n +4 | head -n -2 | awk '{print "  " $4}'
