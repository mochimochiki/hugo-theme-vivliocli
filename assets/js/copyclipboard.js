function AddCopyButton(clipboard) {
  document.querySelectorAll("pre > code").forEach(function (code) {
    var button = document.createElement("button");
    button.className = "copy-button";
    button.type = "button";
    button.innerText = "Copy";

    button.addEventListener("click", function () {
      try {
        if (clipboard) {
          // for https
          clipboard.writeText(code.innerText);
        } else {
          // for http
          var buffer = document.createElement("textarea");
          focus = document.activeElement;
          buffer.value = code.innerText;
          document.body.appendChild(buffer);
          buffer.select();
          document.execCommand("copy");
          document.body.removeChild(buffer);
          focus.focus();
        }

        var buttonOriginalText = button.innerText;
        button.innerText = "Copied!";
        setTimeout(() => {
          button.innerText = buttonOriginalText;
        }, 1200);
      } catch (e) {
        var buttonOriginalText = button.innerText;
        button.innerText = "Copy failure.";
        setTimeout(() => {
          buttom.innerText = buttonOriginalText;
        }, 1200);
      }
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
