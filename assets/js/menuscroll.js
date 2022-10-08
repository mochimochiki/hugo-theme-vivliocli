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
window.addEventListener(
  "DOMContentLoaded",
  function () {
    var pageID = document.head.querySelector("[data-id]");
    var pageItemElement = document.getElementById(
      pageID.getAttribute("data-id")
    );
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
  },
  false
);
