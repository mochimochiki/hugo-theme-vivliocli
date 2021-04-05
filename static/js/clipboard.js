function AddCopyButton(clipboard) {
  document.querySelectorAll("pre > code").forEach(function (code) {
    var button = document.createElement("button");
    button.className = "copy-button";
    button.type = "button";
    button.innerText = "Copy";

    button.addEventListener("click", function () {
      clipboard.writeText(code.innerText)
    });

    var pre = code.parentNode;
    if (pre.parentNode.classList.contains("highlight")) {
      var highlight = pre.parentNode;
      highlight.parentNode.insertBefore(button, highlight);
    } else {
      pre.parentNode.insertBefore(button, pre);
    }
  });
}

AddCopyButton(navigator.clipboard);
