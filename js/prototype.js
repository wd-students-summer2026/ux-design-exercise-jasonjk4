const screens = document.querySelectorAll("[data-prototype-screen]");
const links = document.querySelectorAll("[data-prototype-link]");

function showScreen(screenName) {
  screens.forEach((screen) => {
    screen.classList.toggle(
      "is-active",
      screen.dataset.prototypeScreen === screenName
    );
  });

  links.forEach((link) => {
    link.classList.toggle("is-active", link.dataset.prototypeLink === screenName);
  });
}

links.forEach((link) => {
  link.addEventListener("click", () => {
    showScreen(link.dataset.prototypeLink);
  });
});

if (window.location.hash) {
  showScreen(window.location.hash.slice(1));
} else {
  showScreen("discover");
}
