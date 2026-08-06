window.addEventListener("DOMContentLoaded", function () {
  var pageID = document.head.querySelector("[data-id]")
  // メニュー本体は js/menu-tree-<言語>.js が差し込む。読み込みに失敗した場合や、
  // メニューに載らないページでは対象が見つからないので、ここで打ち切る。
  // (以前は下の if より前で pageItemElement を手繰っており、見つからないと例外になっていた)
  if (!pageID) { return; }
  var pageItemElement = document.getElementById(pageID.getAttribute("data-id"));
  var menuElement = document.getElementById("menu");
  if (!pageItemElement || !menuElement) { return; }
  var detailsElement = pageItemElement.closest("details");
  while (detailsElement) {
    detailsElement.open = true;
    if (detailsElement.parentElement) {
      detailsElement = detailsElement.parentElement.closest("details");
    }
  }

  var yOffset = pageItemElement.getBoundingClientRect().top;
  var position = yOffset - window.innerHeight / 2;
  menuElement.scrollTo(0, position);
}, false);
