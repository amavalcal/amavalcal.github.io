<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Drag and Drop Quiz</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      padding: 20px;
      max-width: 900px;
      margin: auto;
    }

    h2 {
      margin-bottom: 10px;
    }

    .container {
      display: flex;
      flex-wrap: wrap;
      gap: 15px;
      margin-bottom: 20px;
    }

    .icon {
      font-size: 32px;
      cursor: grab;
      border: 2px solid #ccc;
      padding: 10px;
      margin: 5px;
      display: inline-block;
      background-color: #f9f9f9;
    }

    .dropzone-wrapper {
      display: flex;
      flex-direction: column;
      align-items: center;
      width: 180px;
    }

    .dropzone-title {
      margin-bottom: 5px;
      font-weight: bold;
    }

    .dropzone {
      width: 160px;
      height: 140px;
      border: 2px dashed #666;
      display: flex;
      flex-wrap: wrap;
      gap: 5px;
      padding: 5px;
      justify-content: center;
      align-content: flex-start;
      background-color: #fff;
    }

    .dropzone.correct {
      border-color: green;
      background-color: #e5ffe5;
    }

    .dropzone.incorrect {
      border-color: red;
      background-color: #ffe5e5;
    }

    .button-row {
      display: flex;
      gap: 10px;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>

  <h2>Drag the icons into the correct categories</h2>

  <div class="container" id="icons">
    <!-- 🎯 12 Icons to sort (you can change emojis + categories freely!) -->
    <div class="icon" draggable="true" data-answer="fruits">🍎</div>
    <div class="icon" draggable="true" data-answer="fruits">🍌</div>
    <div class="icon" draggable="true" data-answer="fruits">🍇</div>
    <div class="icon" draggable="true" data-answer="animals">🐶</div>
    <div class="icon" draggable="true" data-answer="animals">🐱</div>
    <div class="icon" draggable="true" data-answer="animals">🐸</div>
    <div class="icon" draggable="true" data-answer="vehicles">🚗</div>
    <div class="icon" draggable="true" data-answer="vehicles">🚲</div>
    <div class="icon" draggable="true" data-answer="vehicles">✈️</div>
    <div class="icon" draggable="true" data-answer="education">📚</div>
    <div class="icon" draggable="true" data-answer="education">✏️</div>
    <div class="icon" draggable="true" data-answer="education">🎓</div>
  </div>

  <div class="container" id="dropzones">
    <!-- 🔲 Drop Zones with custom titles -->
    <div class="dropzone-wrapper">
      <div class="dropzone-title">Fruits</div>
      <div class="dropzone" id="fruits"></div>
    </div>
    <div class="dropzone-wrapper">
      <div class="dropzone-title">Animals</div>
      <div class="dropzone" id="animals"></div>
    </div>
    <div class="dropzone-wrapper">
      <div class="dropzone-title">Vehicles</div>
      <div class="dropzone" id="vehicles"></div>
    </div>
    <div class="dropzone-wrapper">
      <div class="dropzone-title">Education</div>
      <div class="dropzone" id="education"></div>
    </div>
  </div>

  <div class="button-row">
    <button onclick="checkAnswers()">Check Answers</button>
    <button onclick="resetGame()">Reset</button>
  </div>

  <script>
    const iconsContainer = document.getElementById("icons");
    const originalIcons = Array.from(iconsContainer.children).map(icon => icon.cloneNode(true));
    const dropzones = document.querySelectorAll(".dropzone");

    function makeDraggable(icon) {
      icon.addEventListener("dragstart", e => {
        e.dataTransfer.setData("text/plain", icon.innerHTML);
        e.dataTransfer.setData("answer", icon.dataset.answer);
      });
    }

    document.querySelectorAll(".icon").forEach(makeDraggable);

    dropzones.forEach(zone => {
      zone.addEventListener("dragover", e => e.preventDefault());

      zone.addEventListener("drop", e => {
        e.preventDefault();
        const content = e.dataTransfer.getData("text/plain");
        const answer = e.dataTransfer.getData("answer");
        const iconDiv = document.createElement("div");
        iconDiv.innerHTML = content;
        iconDiv.className = "icon";
        iconDiv.setAttribute("data-answer", answer);
        makeDraggable(iconDiv);
        zone.appendChild(iconDiv);
      });
    });

    function checkAnswers() {
      dropzones.forEach(zone => {
        const icons = zone.querySelectorAll(".icon");
        let allCorrect = true;
        icons.forEach(icon => {
          if (icon.dataset.answer !== zone.id) {
            allCorrect = false;
          }
        });
        zone.classList.remove("correct", "incorrect");
        if (icons.length > 0) {
          zone.classList.add(allCorrect ? "correct" : "incorrect");
        }
      });
    }

    function resetGame() {
      dropzones.forEach(zone => {
        zone.innerHTML = '';
        zone.classList.remove("correct", "incorrect");
      });

      iconsContainer.innerHTML = '';
      originalIcons.forEach(icon => {
        const clone = icon.cloneNode(true);
        makeDraggable(clone);
        iconsContainer.appendChild(clone);
      });
    }
  </script>

</body>
</html>

