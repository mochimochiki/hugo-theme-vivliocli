window.addEventListener("DOMContentLoaded", function () {
  var menuElement = document.getElementById('menu');
  var selectedElement = document.getElementById('menu-selected');
  if (selectedElement) {
    var yOffset = selectedElement.getBoundingClientRect().top;
    var position = yOffset - window.innerHeight / 2;
    menuElement.scrollTo(0, position);  
  }
}, false);
