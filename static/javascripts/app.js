$(document).ready(function () {
  $(".table-results tr").click(function () {
    window.location = $(this).find("a").attr("href");
  });
});