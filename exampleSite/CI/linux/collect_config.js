/*
 * collect_config.js (Linux/Docker)
 *
 * Linux 移植版。Windows の CollectConfig.ps1 と同じ挙動。
 *
 * 言語ルート(例 public_default/ja)配下を再帰し、各 PDF セクションに生成された
 *   *.vivlio.cover.html / *.vivlio.config.js / *.vivlio.colophon.html
 * を言語ルート直下へ「フラット名」でコピーする。
 * フラット名は「言語ルートからの相対ディレクトリパスの区切りを '_' に置換」したもの。
 *   例: Manual/_pdf.vivlio.config.js -> Manual.vivlio.config.js
 *       twoColumns/_pdf.vivlio.cover.html -> twoColumns.vivlio.cover.html
 * config.js 内の cover / colophon への参照もフラット名へ書き換える。
 *
 * Vivliostyle は config の entry/cover を config 配置ディレクトリ基準で解決するため、
 * config を言語ルートに集約し cover/colophon を同階層へ置く必要がある。
 *
 * Usage: node collect_config.js <language_root_dir>
 */
const fs = require('fs');
const path = require('path');

function flatName(rootDir, fileDir) {
  const rel = path.relative(rootDir, fileDir);
  return rel.split(path.sep).join('_');
}

function processDir(rootDir, dir) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      processDir(rootDir, full);
      continue;
    }
    if (!entry.isFile()) continue;

    const name = entry.name;
    const prefix = flatName(rootDir, dir);

    if (name.includes('.vivlio.cover.html')) {
      const out = path.join(rootDir, `${prefix}.vivlio.cover.html`);
      fs.copyFileSync(full, out);
      console.log(`cover   -> ${path.basename(out)}`);
    } else if (name.includes('.vivlio.colophon.html')) {
      const out = path.join(rootDir, `${prefix}.vivlio.colophon.html`);
      fs.copyFileSync(full, out);
      console.log(`colophon-> ${path.basename(out)}`);
    } else if (name.includes('.vivlio.config.js')) {
      const out = path.join(rootDir, `${prefix}.vivlio.config.js`);
      let data = fs.readFileSync(full, 'utf8');
      data = data
        .split('_pdf.vivlio.cover.html').join(`${prefix}.vivlio.cover.html`)
        .split('_pdfcolophon.vivlio.colophon.html').join(`${prefix}.vivlio.colophon.html`);
      fs.writeFileSync(out, data, 'utf8');
      console.log(`config  -> ${path.basename(out)}`);
    }
  }
}

(function main() {
  const root = process.argv[2];
  if (!root || !fs.existsSync(root)) {
    console.error(`collect_config: language root not found: ${root}`);
    process.exit(1);
  }
  // Windows 版に合わせ、ルート直下のサブディレクトリのみを起点に再帰する
  for (const entry of fs.readdirSync(root, { withFileTypes: true })) {
    if (entry.isDirectory()) {
      processDir(root, path.join(root, entry.name));
    }
  }
})();
