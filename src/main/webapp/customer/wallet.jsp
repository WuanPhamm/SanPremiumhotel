<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">

<style>
    /* Tùy chỉnh CSS để làm đẹp hơn */
    .wallet-card {
        border: none;
        border-radius: 20px;
        transition: transform 0.3s ease;
    }
    .balance-display {
        background: linear-gradient(135deg, #436e62 0%, #2d4a42 100%);
        color: white;
        border-radius: 15px;
        padding: 30px;
        text-align: center;
        margin-bottom: 25px;
    }
    .balance-amount {
        font-size: 2.5rem; /* Chữ số dư to hơn */
        font-weight: 700;
        display: block;
    }
    .form-label {
        font-weight: 600;
        font-size: 1.1rem;
        color: #333;
    }
    .form-control {
        padding: 12px 15px;
        border-radius: 10px;
        border: 1px solid #ddd;
        font-size: 1rem;
    }
    .form-control:focus {
        border-color: #436e62;
        box-shadow: 0 0 0 0.25rem rgba(67, 110, 98, 0.25);
    }
    .btn-withdraw {
        padding: 15px;
        font-size: 1.2rem;
        font-weight: 600;
        border-radius: 10px;
        background-color: #436e62;
        border: none;
        transition: all 0.3s;
    }
    .btn-withdraw:hover {
        background-color: #34564d;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    #amountInWords {
        display: block;
        margin-top: 8px;
        font-style: italic;
        color: #436e62 !important;
        font-weight: 500;
    }
    .alert {
        border-radius: 10px;
        font-weight: 500;
    }
</style>

<%@include file="/customer/header.jsp"%>

<main class="main">
    <div class="page-title light-background py-4">
        <div class="container">
            <h1><i class="bi bi-wallet2 me-2"></i>Quản lý ví điện tử</h1>
        </div>
    </div>

    <section class="section py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    
                    <c:if test="${not empty sessionScope.message}">
                        <div class="alert alert-success alert-dismissible fade show shadow-sm mb-4" role="alert">
                            <i class="bi bi-check-circle me-2"></i> ${sessionScope.message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="message" scope="session" />
                    </c:if>

                    <c:if test="${not empty sessionScope.error}">
                        <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4" role="alert">
                            <i class="bi bi-exclamation-triangle me-2"></i> ${sessionScope.error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="error" scope="session" />
                    </c:if>

                    <div class="card wallet-card shadow-lg p-4">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="balance-display shadow-sm">
                                    <span class="text-uppercase small fw-light">Số dư khả dụng</span>
                                    <span class="balance-amount my-2">
                                        <fmt:formatNumber value='${wallet.balance}' type='number' maxFractionDigits='0' groupingUsed='true'/> 
                                        <small style="font-size: 1.2rem"> VNĐ</small>
                                    </span>
                                </div>
                            </div>

                            <div class="col-md-10 mx-auto">
                                <h4 class="mb-4 text-center fw-bold text-secondary">Yêu cầu rút tiền</h4>
                                
                                <form action="${pageContext.request.contextPath}/wallet" method="post" class="row g-3">
                                    <div class="col-12">
                                        <label class="form-label">Số tiền muốn rút</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white"><i class="bi bi-cash-stack"></i></span>
                                            <input type="number" class="form-control" name="withdrawAmount" 
                                                   id="withdrawAmount" min="10000" placeholder="Tối thiểu 10,000đ" required>
                                        </div>
                                        <small id="amountInWords"></small>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Ngân hàng hưởng thụ</label>
                                        <input type="text" class="form-control" name="bankName" placeholder="VD: Vietcombank, MB Bank..." required>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Số tài khoản</label>
                                        <input type="text" class="form-control" name="bankId" placeholder="Nhập số tài khoản" required>
                                    </div>

                                    <div class="col-12 mt-4">
                                        <div class="d-grid">
                                            <button type="submit" class="btn btn-withdraw text-white shadow-sm" style="background-color:#436e62">
                                                Gửi yêu cầu rút tiền ngay
                                            </button>
                                        </div>
                                        <p class="text-center text-muted small mt-3">
                                            <i class="bi bi-shield-lock me-1"></i> Giao dịch an toàn & bảo mật
                                        </p>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div> </div>
            </div>
        </div>
    </section>
</main>

<script>
    // ... [Hàm numberToVietnameseWords giữ nguyên như cũ] ...
    function numberToVietnameseWords(number) {
        const units = [ "", "nghìn", "triệu", "tỷ" ];
        const digits = [ "không", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín" ];
        if (!number || number === 0) return "";
        function readThreeDigits(num) {
            let hundred = Math.floor(num / 100);
            let ten = Math.floor((num % 100) / 10);
            let unit = num % 10;
            let result = "";
            if (hundred > 0) result += digits[hundred] + " trăm ";
            if (ten > 1) {
                result += digits[ten] + " mươi ";
                if (unit === 1) result += "mốt ";
                else if (unit === 5) result += "lăm ";
                else if (unit > 0) result += digits[unit] + " ";
            } else if (ten === 1) {
                result += "mười ";
                if (unit === 5) result += "lăm ";
                else if (unit > 0) result += digits[unit] + " ";
            } else if (ten === 0 && unit > 0) {
                if (hundred > 0) result += "lẻ ";
                result += digits[unit] + " ";
            }
            return result;
        }
        let str = ""; let i = 0;
        while (number > 0) {
            let threeDigits = number % 1000;
            if (threeDigits !== 0) str = readThreeDigits(threeDigits) + units[i] + " " + str;
            number = Math.floor(number / 1000); i++;
        }
        return str.trim() + " đồng";
    }

    document.getElementById("withdrawAmount").addEventListener("input", function() {
        let value = parseInt(this.value);
        let display = document.getElementById("amountInWords");
        if (!value || value < 10000) {
            display.innerHTML = "";
            return;
        }
        display.innerHTML = '<i class="bi bi-chat-left-dots me-1"></i> Bằng chữ: ' + numberToVietnameseWords(value);
    });
</script>

<%@include file="/customer/footer.jsp"%>