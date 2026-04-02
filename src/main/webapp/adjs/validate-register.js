document.addEventListener("DOMContentLoaded", function () {
  const form = document.querySelector("form");
  const username = document.querySelector("input[name='username']");
  const password = document.querySelector("input[name='password']");
  const checkbox = document.querySelector("input[name='terms']");

  form.addEventListener("submit", function (event) {
    let valid = true;

    // Reset trạng thái lỗi trước mỗi lần submit
    username.classList.remove("is-invalid");
    password.classList.remove("is-invalid");
    checkbox.classList.remove("is-invalid");

    // Kiểm tra username >= 8 ký tự
    if (username.value.trim().length < 8) {
      username.classList.add("is-invalid");
      username.nextElementSibling.textContent = "Tên đăng nhập phải có ít nhất 8 kí tự";
      valid = false;
    }

    // Kiểm tra password >= 6 ký tự
    if (password.value.trim().length < 6) {
      password.classList.add("is-invalid");
      password.nextElementSibling.textContent = "Mật khẩu phải có ít nhất 6 kí tự";
      valid = false;
    }

    // Kiểm tra checkbox đã được tích chưa
    if (!checkbox.checked) {
      checkbox.classList.add("is-invalid");
      checkbox.parentElement.querySelector(".invalid-feedback").textContent = "Bạn cần xác nhận đồng ý";
      valid = false;
    }

    if (!valid) {
      event.preventDefault(); // Chặn submit nếu có lỗi
    }
  });
});