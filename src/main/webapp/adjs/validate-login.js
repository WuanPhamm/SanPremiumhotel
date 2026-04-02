// validate-login.js

// Chờ toàn bộ DOM load xong
document.addEventListener("DOMContentLoaded", function () {
  const forms = document.querySelectorAll(".needs-validation");

  // Lặp qua tất cả các form có class 'needs-validation'
  Array.prototype.slice.call(forms).forEach(function (form) {
    form.addEventListener("submit", function (event) {
      if (!form.checkValidity()) {
        // Nếu form không hợp lệ, ngăn submit
        event.preventDefault();
        event.stopPropagation();
      }

      form.classList.add("was-validated");
    }, false);
  });
});
