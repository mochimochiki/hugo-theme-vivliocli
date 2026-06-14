#!/usr/bin/env bash
#
# build_pdf.sh (Linux/Docker)
#
# Windows の build_pdf.bat の Linux 移植版。exampleSite の Hugo ビルドと Vivliostyle に
# よる PDF 生成を一気通貫で実行する。
#
# Usage:
#   build_pdf.sh [config_env]
#     config_env を省略すると hugo.toml のみでビルド（publish dir: public_default）。
#     config_env を指定すると --config hugo.toml,config/<env>.toml でビルド。
#
# Env:
#   OUT_DIR        生成 PDF の集約先（既定: <CI/linux>/out）
#   CHROMIUM_PATH  Chromium 実行ファイル（pre-render / Vivliostyle 用、Docker では /usr/bin/chromium）
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HUGO_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"   # = exampleSite

CONFIG_ENV="${1:-default}"
if [ "${CONFIG_ENV}" = "default" ]; then
  CONFIG_OPT=()
else
  CONFIG_OPT=(--config "hugo.toml,config/${CONFIG_ENV}.toml")
fi
PUBLISH_DIR="public_${CONFIG_ENV}"
OUT_DIR="${OUT_DIR:-${SCRIPT_DIR}/out}"

export HUGO_PARAMS_ISPDF=true

echo "-------------------------------------"
echo "Build Hugo site"
echo "config           : ${CONFIG_ENV}"
echo "target directory : ${PUBLISH_DIR}"
echo "-------------------------------------"

# 1. exampleSite の npm 依存（postinstall で @vivliostyle/viewer を static/viewer へコピー）
( cd "${HUGO_DIR}" && npm install )

# 2. Hugo ビルド（isPDF=true / baseURL=""）
rm -rf "${HUGO_DIR:?}/${PUBLISH_DIR}"
( cd "${HUGO_DIR}" && hugo "${CONFIG_OPT[@]}" -b "" -d "${PUBLISH_DIR}" )

# 3. PDF ツールチェーンの npm 依存
echo "-------------------------------------"
echo "node : $(node -v)"
echo "npm  : $(npm -v)"
echo "-------------------------------------"
( cd "${SCRIPT_DIR}" && npm install )

# 4. JS 事前レンダリング（MathJax / Mermaid）
node "${SCRIPT_DIR}/pre_js_rendering.js" "${HUGO_DIR}/${PUBLISH_DIR}"

# 5. 言語ごとに config を集約して PDF 生成
mkdir -p "${OUT_DIR}"
for lang_path in "${HUGO_DIR}"/content/*/; do
  lang="$(basename "${lang_path}")"
  lang_root="${HUGO_DIR}/${PUBLISH_DIR}/${lang}"
  [ -d "${lang_root}" ] || continue

  echo "-------------------------------------"
  echo "Build PDF  (language: ${lang})"
  echo "-------------------------------------"
  node "${SCRIPT_DIR}/collect_config.js" "${lang_root}"
  node "${SCRIPT_DIR}/run_vivlio.js" "${lang_root}"

  # 6. 生成 PDF を OUT_DIR/<lang>/ へ集約
  shopt -s nullglob
  pdfs=("${lang_root}"/*.pdf)
  if [ ${#pdfs[@]} -gt 0 ]; then
    mkdir -p "${OUT_DIR}/${lang}"
    cp "${pdfs[@]}" "${OUT_DIR}/${lang}/"
  fi
  shopt -u nullglob
done

echo ""
echo "build was completed."
echo "PDFs: ${OUT_DIR}"
ls -R "${OUT_DIR}" || true
