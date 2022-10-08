/*
 * Copyright 2022 mochimochiki
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    https://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
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
          clipboard.writeText(code.textContent);
        } else {
          // for http
          var buffer = document.createElement("textarea");
          focus = document.activeElement;
          buffer.value = code.textContent;
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
