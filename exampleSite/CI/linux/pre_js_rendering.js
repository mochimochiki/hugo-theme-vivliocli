/*
 * pre_js_rendering.js (Linux/Docker)
 *
 * Linux 移植版。Windows の pre_js_rendering.ps1 + pre_js_rendering.js を 1 本に統合したもの。
 *
 * 指定ディレクトリ配下の *.html を再帰的に走査し、マーカー "@pre_rendering_type_js" を
 * 含むファイル（MathJax / Mermaid を使うページ）をヘッドレス Chromium で開いて
 * JS 実行後の静的 HTML に上書き保存する。これにより Vivliostyle が JS を実行できなくても
 * 数式・図がレンダリング済みの状態で PDF 化できる。
 *
 * MathJax / Mermaid は jsdelivr CDN から読み込むためネットワーク接続が必要。
 *
 * Usage: node pre_js_rendering.js <publish_dir>
 * Browser: 環境変数 CHROMIUM_PATH（例 /usr/bin/chromium）で実行ファイルを指定。
 */
const fs = require('fs');
const path = require('path');
const playwright = require('playwright-core');

const MARKER = '@pre_rendering_type_js';

function collectHtmlFiles(dir, acc) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      collectHtmlFiles(full, acc);
    } else if (entry.isFile() && entry.name.toLowerCase().endsWith('.html')) {
      acc.push(full);
    }
  }
  return acc;
}

function launchOptions() {
  const opts = { headless: true, args: ['--no-sandbox', '--disable-dev-shm-usage'] };
  if (process.env.CHROMIUM_PATH) {
    opts.executablePath = process.env.CHROMIUM_PATH;
  } else if (process.env.PLAYWRIGHT_CHANNEL) {
    opts.channel = process.env.PLAYWRIGHT_CHANNEL; // e.g. "msedge" / "chrome" for local dev
  }
  return opts;
}

(async () => {
  const targetDir = process.argv[2];
  if (!targetDir || !fs.existsSync(targetDir)) {
    console.error(`pre_js_rendering: target dir not found: ${targetDir}`);
    process.exit(1);
  }

  console.log('-------------------------------');
  console.log('Pre javascript rendering');
  console.log(`target dir: ${targetDir}`);
  console.log('-------------------------------');

  const htmlFiles = collectHtmlFiles(targetDir, []);
  const targets = htmlFiles.filter((f) => fs.readFileSync(f, 'utf8').includes(MARKER));

  if (targets.length === 0) {
    console.log('No pre-rendering required files found.');
    return;
  }

  console.log(`Pre rendering required files exist. (Number of files: ${targets.length})`);

  const browser = await playwright.chromium.launch(launchOptions());
  try {
    for (const file of targets) {
      console.log(`rendering...${file}`);
      const page = await browser.newPage();
      try {
        const url = 'file://' + path.resolve(file).split(path.sep).join('/');
        await page.goto(url, { waitUntil: 'networkidle', timeout: 60000 });
        // CDN(MathJax/Mermaid) のレンダリング完了を待つための追加バッファ
        await page.waitForTimeout(1500);
        const content = await page.content();
        fs.writeFileSync(file, content, 'utf8');
        console.log('OK.');
      } finally {
        await page.close();
      }
    }
  } finally {
    await browser.close();
  }

  console.log(`Pre rendering is completed. (Number of files: ${targets.length})`);
})().catch((err) => {
  console.error(err);
  process.exit(1);
});
