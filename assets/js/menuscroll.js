window.addEventListener("DOMContentLoaded", function () {
  var pageID = document.head.querySelector("[data-id]")
  var pageItemElement = document.getElementById(pageID.getAttribute("data-id"));
  var menuElement = document.getElementById("menu");
  var detailsElement = pageItemElement.closest("details");
  while (detailsElement) {
    detailsElement.open = true;
    if (detailsElement.parentElement) {
      detailsElement = detailsElement.parentElement.closest("details");
    }
  }

  if (pageItemElement) {
    var yOffset = pageItemElement.getBoundingClientRect().top;
    var position = yOffset - window.innerHeight / 2;
    menuElement.scrollTo(0, position);
  }
}, false);
