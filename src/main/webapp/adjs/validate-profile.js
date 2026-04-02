document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector('#profile-edit form');
    const fullName = document.getElementById('user_fullname');
    const dob = document.getElementById('user_date_of_birth');
    const address = document.getElementById('user_address');
    const gender = document.getElementById('user_gender');
    const phone = document.getElementById('user_phone_number');
    const email = document.getElementById('user_email');

    if (form) {
        form.addEventListener("submit", function (e) {
            let isValid = true;
            let messages = [];

            if (!fullName.value.trim()) {
                isValid = false;
                messages.push("Họ tên không được để trống.");
            }

            if (!dob.value) {
                isValid = false;
                messages.push("Ngày sinh không được để trống.");
            }

            if (!address.value.trim()) {
                isValid = false;
                messages.push("Địa chỉ không được để trống.");
            }

            if (gender.value !== "0" && gender.value !== "1") {
                isValid = false;
                messages.push("Vui lòng chọn giới tính hợp lệ.");
            }

            const phoneRegex = /^(0|\+84)[0-9]{9,10}$/;
            if (!phoneRegex.test(phone.value.trim())) {
                isValid = false;
                messages.push("Số điện thoại không hợp lệ.");
            }

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email.value.trim())) {
                isValid = false;
                messages.push("Email không hợp lệ.");
            }

            if (!isValid) {
                e.preventDefault();
                alert(messages.join("\n"));
            }
        });
    }
});
