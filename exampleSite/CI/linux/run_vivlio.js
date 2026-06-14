/*
 * run_vivlio.js (Linux/Docker)
 *
 * Linux 移植版。Windows の vivliocli.ps1 と同じ役割。
 *
 * 言語ルート直下の *.vivlio.config.js それぞれに対して
 *   vivliostyle build -c <config> --executable-browser $CHROMIUM_PATH
 * を実行して PDF を生成する。Vivliostyle は output / entry を config 配置ディレクトリ
 * 基準で解決するため、cwd を config のディレクトリに設定して実行する。
 *
 * Usage: node run_vivlio.js <language_root_dir>
 */
const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

(function main() {
  const dir = process.argv[2];
  if (!dir || !fs.existsSync(dir)) {
    console.error(`run_vivlio: target dir not found: ${dir}`);
    process.exit(1);
  }

  const configs = fs
    .readdirSync(dir, { withFileTypes: true })
    .filter((e) => e.isFile() && e.name.endsWith('.vivlio.config.js'))
    .map((e) => e.name);

  if (configs.length === 0) {
    console.log(`No vivlio config found in ${dir}. Skip.`);
    return;
  }

  const vivlioBin = path.resolve(__dirname, 'node_modules', '.bin', process.platform === 'win32' ? 'vivliostyle.cmd' : 'vivliostyle');

  for (const cfg of configs) {
    console.log('-------------------------------------');
    console.log(`Build PDF with config: ${cfg}`);
    console.log('-------------------------------------');

    const args = ['build', '-c', cfg];
    if (process.env.CHROMIUM_PATH) {
      args.push('--executable-browser', process.env.CHROMIUM_PATH);
    }
    // Docker(root)では Chromium のサンドボックスを無効化しないと起動できない
    if (process.env.CHROMIUM_PATH || process.env.VIVLIO_NO_SANDBOX === '1') {
      args.push('--no-sandbox');
    }

    const res = spawnSync(vivlioBin, args, {
      cwd: dir,
      stdio: 'inherit',
      env: process.env,
    });

    if (res.status !== 0) {
      console.error(`vivliostyle build failed for ${cfg} (exit ${res.status})`);
      process.exit(res.status || 1);
    }
  }
})();
