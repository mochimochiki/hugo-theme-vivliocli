const playwright = require('playwright-core');

(async () => {
  const browser = await playwright.chromium.launch({ channel: 'msedge', headless: true });
  const page = await browser.newPage();
  await page.goto(`file://${process.argv[2]}`);
  const content = await page.content();
  const fs = require("fs");
  fs.writeFile(process.argv[2], content, (err) => {
    if (err) throw err;
    console.log('OK.');
  });

  await page.waitForTimeout(500)
  await browser.close();
})();