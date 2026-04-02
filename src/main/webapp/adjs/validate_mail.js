<script>
document.addEventListener("DOMContentLoaded", function () {
  const form = document.querySelector("form");
  const emailInput = document.getElementById("recipientEmail");

  form.addEventListener("submit", function (e) {
    const email = emailInput.value.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (email === "") {
      alert("Vui lòng nhập địa chỉ email.");
      emailInput.focus();
      e.preventDefault();
      return;
    }

    if (!emailRegex.test(email)) {
      alert("Địa chỉ email không hợp lệ. Vui lòng nhập đúng định dạng, ví dụ: abc@gmail.com.");
      emailInput.focus();
      e.preventDefault();
      return;
    }
  });
});
</script>
