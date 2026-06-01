$(function () {
  var originalPhoto = "images/IMG_9115.jpg";
  var alternatePhoto = "images/IMG_9118.jpg";
  var routeShifted = false;

  $("#mood-button").on("click", function () {
    $("#spotlight-note").text(
      "When the frame changes, the story changes with it. The same afternoon can feel playful, focused, or calm depending on where I choose to look."
    );
    $(this).text("Angle changed");
  });

  $("#feature-photo")
    .on("mouseover", function () {
      $(this)
        .attr("src", alternatePhoto)
        .attr("alt", "Jason playing golf with a friend");
    })
    .on("mouseout", function () {
      $(this)
        .attr("src", originalPhoto)
        .attr("alt", "Jason with a friend using a camera filter");
    });

  $("#route-button").on("click", function () {
    var nextPosition = routeShifted
      ? { left: "0px", top: "0px" }
      : { left: "28px", top: "14px" };

    $("#moving-frame").stop(true).animate(nextPosition, 650);
    routeShifted = !routeShifted;
  });
});
