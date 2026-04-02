<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">


<%@include file="/customer/header.jsp"%>

<style>
/* CSS tùy chỉnh để làm giao diện giống hệt trong ảnh */
body {
	background-color: #f8f9fa; /* Màu nền xám nhạt */
}

/* Header */
.review-header {
	background-color: white;
	border-bottom: 1px solid #dee2e6;
	padding: 0.75rem 1rem;
	display: flex;
	justify-content: space-between;
	align-items: center;
	/* position: sticky; */
	top: 0;
	z-index: 1020;
}

.review-header .header-title {
	font-size: 1.1rem;
	font-weight: 600;
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
}

.review-header .icon-btn {
	font-size: 1.25rem;
	color: #333;
	text-decoration: none;
}

/* (THAY ĐỔI) CSS cho khung hiển thị phòng bên trong cột */
/* Loại bỏ border-bottom cũ của .room-info */
.review-summary-container {
    padding: 1rem;
}

.review-summary-container .room-info-new img {
	width: 80px; /* Tăng kích thước ảnh */
	height: 80px;
	object-fit: cover;
	border-radius: 8px; /* Bo góc nhiều hơn */
	border: 1px solid #eee;
}

.review-summary-container .room-info-new h5 {
	font-size: 1.15rem; /* Tăng cỡ chữ tên phòng */
	font-weight: 600;
	margin-bottom: 0.25rem;
}

.review-summary-container .room-info-new p {
	font-size: 0.95rem; /* Tăng cỡ chữ loại phòng */
	color: #6c757d;
	margin-bottom: 0;
}

/* Phần nội dung chính (viết đánh giá) */
.main-content {
	background-color: white;
	margin-top: 0.5rem;
	padding: 1rem;
}

/* Hệ thống 5 sao (quan trọng) */
.star-rating {
	/* Căn chỉnh lại để phù hợp với cột bên phải */
    padding-top: 5px; /* Điều chỉnh vị trí ngôi sao */
    padding-bottom: 5px;
}

.star-rating .stars {
	display: inline-block;
	direction: rtl;
}

/* Ẩn các radio button gốc */
.star-rating input[type="radio"] {
	display: none;
}

/* Kiểu của các ngôi sao (dùng label) */
.star-rating label {
	font-size: 2.5rem; /* Kích thước sao */
	color: #ddd; /* Màu sao trống */
	cursor: pointer;
	transition: color 0.2s;
	padding: 0 0.2rem;
}

/* Khi di chuột vào sao */
.star-rating input[type="radio"]:not(:checked) ~ label:hover,
	.star-rating input[type="radio"]:not(:checked) ~ label:hover ~ label {
	color: #ffc107; /* Màu vàng khi hover */
}

/* Khi chọn sao */
.star-rating input[type="radio"]:checked ~ label {
	color: #ffc107; /* Màu vàng khi đã chọn */
}

/* Các thẻ gợi ý */
.suggestion-tags .badge {
	cursor: pointer;
	padding: 0.5em 0.75em;
	font-size: 0.85rem;
}

/* Đếm ký tự */
#char-count {
	color: #6c757d;
}

/* Footer cố định */
.review-footer {
	position: sticky;
	bottom: 0;
	background-color: white;
	padding: 1rem;
	border-top: 1px solid #eee;
	box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
}

/* Nút "Gửi" màu xanh lục */
.btn-submit-review {
	background-color: #38705B; /* Màu xanh lục (giống theme SweetHome) */
	color: white;
	font-weight: 600;
	padding: 0.75rem;
	border: none;
}

.btn-submit-review:hover {
	background-color: #2B5746; /* Màu xanh đậm hơn khi hover */
	color: white;
}
</style>

<%-- Kiểm tra tham số 'rate' trên URL sau khi chuyển hướng --%>
<div class="container mt-3">
    <c:if test="${param.rate eq 'success'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>
            <strong>Thành công!</strong> Đánh giá của bạn đã được gửi đi. Cảm ơn bạn đã phản hồi!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${param.rate eq 'error'}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-x-circle-fill me-2"></i>
            <strong>Lỗi!</strong> Đã xảy ra lỗi khi gửi đánh giá. Vui lòng thử lại.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
</div>

<header class="review-header">
	<a href="javascript:history.back()" class="icon-btn"><i
		class="bi bi-arrow-left"></i></a> <span class="header-title">Viết
		đánh giá</span> <a href="${pageContext.request.contextPath}/my-bookings"
		class="icon-btn"><i class="bi bi-x-lg"></i></a>
</header>

<form id="reviewForm"
	action="${pageContext.request.contextPath}/rate-booking" method="post">

	<input type="hidden" name="bookingId" value="${booking.booking_id}">
	<input type="hidden" name="roomId" value="${room.room_id}">

	<div class="review-summary-container bg-white mt-1 border-bottom">
		<div class="row align-items-center">

			<div class="col-md-6 col-12 border-end py-2">
				<div class="room-info-new d-flex align-items-center">
					<img src="${roomType.rt_img_url}" alt="Ảnh phòng">
					<div class="ms-3">
						<h5>${room.room_name}</h5>
						<p>Loại phòng: ${roomType.rt_name}</p>
					</div>
				</div>
			</div>

			<div class="col-md-6 col-12 py-2">
				<div class="star-rating">
					<p class="mb-2 fw-bold">Đánh giá của bạn*</p>
					<div class="stars">
						<input type="radio" id="star5" name="rating" value="5" required><label
							for="star5" title="Tuyệt vời"><i class="bi bi-star-fill"></i></label>
						<input type="radio" id="star4" name="rating" value="4"><label
							for="star4" title="Tốt"><i class="bi bi-star-fill"></i></label>
						<input type="radio" id="star3" name="rating" value="3"><label
							for="star3" title="Ổn"><i class="bi bi-star-fill"></i></label>
						<input type="radio" id="star2" name="rating" value="2"><label
							for="star2" title="Tệ"><i class="bi bi-star-fill"></i></label>
						<input type="radio" id="star1" name="rating" value="1"><label
							for="star1" title="Rất tệ"><i class="bi bi-star-fill"></i></label>
					</div>
				</div>
			</div>

		</div>
	</div>
	<div class="main-content">
		<div class="mb-4">
			<div
				class="d-flex justify-content-between align-items-center mb-2">
				<label for="review-text" class="form-label fw-bold mb-0">Viết
					đánh giá</label> <span id="char-count" class="form-text">0/300</span>
			</div>

			<div class="suggestion-tags mb-2">
				<span class="badge bg-light text-dark border me-1"
					onclick="addSuggestion('Sạch sẽ')">Sạch sẽ</span> <span
					class="badge bg-light text-dark border me-1"
					onclick="addSuggestion('Tiện nghi')">Tiện nghi</span> <span
					class="badge bg-light text-dark border me-1"
					onclick="addSuggestion('Dịch vụ tốt')">Dịch vụ tốt</span>
			</div>

			<textarea class="form-control" id="review-text"
				name="reviewContent" rows="4"
				placeholder="Hãy chia sẻ suy nghĩ của bạn về phòng này nhé..."
				maxlength="300"></textarea>
		</div>

		<div class="form-check">
			<input class="form-check-input" type="checkbox" name="isAnonymous"
				value="true" id="anonymous-check"> <label
				class="form-check-label" for="anonymous-check"> Đánh giá
				ẩn danh </label>
		</div>
	</div>

	<div class="review-footer">
		<div class="d-grid mt-2">
			<button type="submit" class="btn btn-submit-review">Gửi</button>
		</div>
	</div>
</form>

<%@include file="/customer/footer.jsp"%>
<a href="#" id="scroll-top"
	class="scroll-top d-flex align-items-center justify-content-center"><i
	class="bi bi-arrow-up-short"></i></a>

<div id="preloader"></div>

<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/vendor/php-email-form/validate.js"></script>
<script src="assets/vendor/aos/aos.js"></script>
<script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
<script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
<script src="assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
<script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>

<script src="assets/js/main.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
	// 1. Đếm ký tự cho textarea
	const reviewText = document.getElementById('review-text');
	const charCount = document.getElementById('char-count');
	const maxLength = reviewText.getAttribute('maxlength');

	reviewText.addEventListener('input', () => {
		const currentLength = reviewText.value.length;
		charCount.textContent = `${currentLength}/${maxLength}`;
	});

	// 2. Thêm gợi ý vào textarea
	function addSuggestion(text) {
		const currentText = reviewText.value;
		if (currentText.length === 0) {
			reviewText.value = text + ". ";
		} else {
			reviewText.value = currentText + " " + text + ". ";
		}
		// Kích hoạt sự kiện input để cập nhật bộ đếm
		reviewText.dispatchEvent(new Event('input'));
		reviewText.focus();
	}

	// 4. Validate form trước khi gửi (đảm bảo đã chọn sao)
	const reviewForm = document.getElementById('reviewForm');
	reviewForm.addEventListener('submit', function(event) {
		const rating = document
				.querySelector('input[name="rating"]:checked');
		if (!rating) {
			alert('Vui lòng chọn số sao đánh giá.');
			event.preventDefault(); // Ngăn form gửi đi

			// Cuộn lên phần đánh giá sao
			document.querySelector('.star-rating').scrollIntoView({
				behavior : 'smooth'
			});
		}
	});
</script>


</body>

</html>