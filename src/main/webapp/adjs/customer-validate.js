// Kiểm tra định dạng email
function isValidEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

// Kiểm tra số điện thoại (10 chữ số, bắt đầu bằng số 0)
function isValidPhone(phone) {
    return /^0\d{9}$/.test(phone);
}

// Kiểm tra CCCD (12 số)
function isValidCCCD(cccd) {
    return /^\d{12}$/.test(cccd);
}

// Hiển thị thông báo lỗi
function showAlert(message) {
    alert(message);
}

// Validate form thêm khách hàng
document.getElementById("addForm")?.addEventListener("submit", function (e) {
    const firstname = this.customer_firstname.value.trim();
    const lastname = this.customer_lastname.value.trim();
    const dob = this.customer_date_of_birth.value;
    const gender = this.customer_gender.value;
    const phone = this.customer_phone_number.value.trim();
    const email = this.customer_email.value.trim();
    const address = this.customer_address.value.trim();
    const cccd = this.customer_cccd.value.trim();
    const accountId = this.account_id.value.trim();

    if (!firstname || !lastname || !dob || !gender || !phone || !email || !address || !cccd || !accountId) {
        e.preventDefault();
        showAlert("Vui lòng điền đầy đủ thông tin.");
        return;
    }

    if (!isValidPhone(phone)) {
        e.preventDefault();
        showAlert("Số điện thoại không hợp lệ. Phải bắt đầu bằng 0 và có 10 chữ số.");
        return;
    }

    if (!isValidEmail(email)) {
        e.preventDefault();
        showAlert("Email không hợp lệ.");
        return;
    }

    if (!isValidCCCD(cccd)) {
        e.preventDefault();
        showAlert("CCCD phải bao gồm đúng 12 chữ số.");
        return;
    }

    if (parseInt(accountId) < 0 || isNaN(accountId)) {
        e.preventDefault();
        showAlert("ID tài khoản phải là số hợp lệ lớn hơn bằng 0 (Bằng 0 đối với khách hàng offline)");
        return;
    }
});
