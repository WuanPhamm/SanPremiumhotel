<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">

<%@include file="/customer/header.jsp"%>

<main class="main">

	<!-- Page Title -->
	<div class="page-title light-background">
		<div
			class="container d-lg-flex justify-content-between align-items-center">
			<h1 class="mb-2 mb-lg-0">Chi tiết phòng</h1>
			<nav class="breadcrumbs">
				<ol>
					<li><a href="index.html">Trang chủ</a></li>
					<li class="current">Chi tiết phòng</li>
				</ol>
			</nav>
		</div>
	</div>
	<!-- End Page Title -->

	<!-- Room Details Section -->
	<section id="room-details" class="room-details section">

		<div class="container" data-aos="fade-up" data-aos-delay="100">

			<!-- Room Header with Image and Basic Info -->
			<div class="row align-items-center mb-5">
				<div class="col-lg-7" data-aos="fade-right" data-aos-delay="200">
					<div class="room-header-image">
						<img src="${rt.rt_img_url }" alt="Deluxe Ocean View Suite"
							class="img-fluid rounded">
						<div class="room-badge">
							<span class="text-white">San Premium</span>
						</div>
					</div>
				</div>
				<div class="col-lg-5" data-aos="fade-left" data-aos-delay="300">
					<div class="room-header-content">
						<div class="room-rating mb-3">
							<span class="rating-score">${star }</span>
							<div class="stars">
								<c:set var="totalStars" value="5" />
								<c:forEach var="i" begin="1" end="${totalStars}">
									<c:choose>
										<c:when test="${i <= count}">
											<i class="bi bi-star-fill "></i>
											<!-- sao đầy -->
										</c:when>
										<c:otherwise>
											<i class="bi bi-star"></i>
											<!-- sao trống -->
										</c:otherwise>
									</c:choose>
								</c:forEach>
								
							</div>
							<span class="reviews-count">(${rate_times } reviews)</span>
						</div>
						<h1 class="room-title">${rt.rt_name }</h1>
						<p class="room-tagline">${rt.rt_description }</p>
						<div class="room-capacity mb-4">
							<div class="capacity-item">
								<i class="bi bi-people"></i> <span>Lên đến
									${rt.rt_max_people } người</span>
							</div>
							<div class="capacity-item">
								<i class="bi bi-grid"></i> <span>${rt.rt_area} m<sup>2</sup></span>
							</div>
							<div class="capacity-item">
								<i class="bi bi-bed"></i> <span>${rt.rt_special }</span>
							</div>
						</div>
						<div class="room-price">
							<span class="price-amount">${rt.rt_price}<p>VNĐ</p>>
							</span> <span class="price-period"> VND/ đêm</span>
						</div>
						<a
							href="${pageContext.request.contextPath}/booking?id=${sessionScope.customer.cus_id}"
							class="btn btn-book-now">Đặt Ngay</a>
					</div>
				</div>
			</div>

			<!-- Room Gallery -->
			<div class="room-gallery mb-5" data-aos="fade-up"
				data-aos-delay="200">
				<h3 class="section-subtitle mb-4">Bộ sưu tập</h3>
				<div class="gallery-grid">
					<div class="gallery-main">
						<a href="assets/img/hotel/room-12.webp" class="glightbox"> <img
							src="assets/img/hotel/room-12.webp" alt="Suite Interior"
							class="img-fluid">
						</a>
					</div>
					<div class="gallery-thumbnails">
						<a href="assets/img/hotel/room-8.webp" class="glightbox"> <img
							src="assets/img/hotel/room-8.webp" alt="Bedroom View"
							class="img-fluid">
						</a> <a href="assets/img/hotel/room-6.webp" class="glightbox"> <img
							src="assets/img/hotel/room-6.webp" alt="Living Area"
							class="img-fluid">
						</a> <a href="assets/img/hotel/room-18.webp" class="glightbox"> <img
							src="assets/img/hotel/room-18.webp" alt="Ocean View"
							class="img-fluid">
						</a> <a href="assets/img/hotel/dining-4.webp" class="glightbox"> <img
							src="assets/img/hotel/dining-4.webp" alt="Bathroom"
							class="img-fluid">
						</a>
					</div>
				</div>
			</div>

			<!-- Room Description -->
			
			<div class="room-reviews" data-aos="fade-up" data-aos-delay="200">
				<h3 class="section-subtitle mb-4">Đánh giá của khách hàng </h3>

				<div class="review-list">

					<c:choose>
						<%-- Kiểm tra xem danh sách đánh giá có rỗng hay không --%>
						<c:when test="${not empty allRate}">
						
							<%-- Lặp qua từng đánh giá trong danh sách --%>
							<c:forEach var="rate" items="${allRate}" varStatus="loop" >
							<c:set var="cus" value="${allCus[loop.index]}" />
								<div class="review-item border-bottom pb-3 mb-3">
									<div class="d-flex align-items-center mb-2">
										
										<%-- Avatar/Icon người dùng --%>
										<div class="reviewer-avatar me-3">
											<img class="rounded-circle" src="${cus.cus_avt_url }" style="height:40px; width:40px; object-fit:cover;">
										</div>
										
										<%-- Thông tin người đánh giá --%>
										<div class="reviewer-info">
											<h5 class="mb-0">${cus.cus_firstname }&nbsp;${cus.cus_lastname }</h5>
											
											<%-- Hiển thị sao --%>
											<div class="review-stars">
												<c:forEach begin="1" end="${rate.rate_star}">
													<i class="bi bi-star-fill text-warning"></i>
												</c:forEach>
												<c:forEach begin="${rate.rate_star + 1}" end="5">
													<i class="bi bi-star text-warning"></i>
												</c:forEach>
												<span class="ms-2 text-muted rate-time"
													style="font-size: 0.9em;" data-time="${rate.rate_time}">
												</span>

											</div>
										</div>
									</div>
									
									<%-- Nội dung bình luận --%>
									<p class="review-text mb-0">${rate.rate_description}</p>
								</div>
							</c:forEach>
							
						</c:when>
						<c:otherwise>
							<%-- Thông báo nếu không có đánh giá nào --%>
							<p class="text-muted">Chưa có đánh giá nào cho loại phòng này.</p>
						</c:otherwise>
					</c:choose>

				</div>
				</div>
			</div>
	</section>
	<!-- /Room Details Section -->

</main>

<%@include file="/customer/footer.jsp"%>

<!-- Scroll Top -->
<a href="#" id="scroll-top"
	class="scroll-top d-flex align-items-center justify-content-center"><i
	class="bi bi-arrow-up-short"></i></a>

<!-- Preloader -->
<div id="preloader"></div>

<!-- Vendor JS Files -->
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/vendor/php-email-form/validate.js"></script>
<script src="assets/vendor/aos/aos.js"></script>
<script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
<script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
<script src="assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
<script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>

<!-- Main JS File -->
<script src="assets/js/main.js"></script>
<script>
  document.querySelectorAll('.price-amount').forEach(el => {
    const num = parseFloat(el.textContent);
    el.textContent = num.toLocaleString('vi-VN');
  });
 </script>
 
 <script>
document.addEventListener("DOMContentLoaded", function() {
    const rateTimes = document.querySelectorAll(".rate-time");
    rateTimes.forEach(el => {
        const raw = el.getAttribute("data-time");
        if (raw) {
            // Chuyển sang đối tượng Date
            const date = new Date(raw.replace(" ", "T")); // hỗ trợ cả định dạng "yyyy-MM-dd HH:mm:ss"
            
            // Định dạng kiểu Việt Nam
            const formatted = date.toLocaleString("vi-VN", {
                hour12: false,
                day: "2-digit",
                month: "2-digit",
                year: "numeric",
                hour: "2-digit",
                minute: "2-digit"
            });

            el.textContent = formatted
            el.textContent = formatted.replace(",", "");
        }
    });
});
</script>
 
 <script>
document.addEventListener("DOMContentLoaded", function() {
    const rateTimes = document.querySelectorAll(".rate-time");
    rateTimes.forEach(el => {
        const raw = el.getAttribute("data-time");
        if (raw) {
            // Chuyển sang đối tượng Date
            const date = new Date(raw.replace(" ", "T")); // hỗ trợ cả định dạng "yyyy-MM-dd HH:mm:ss"
            
            // Định dạng kiểu Việt Nam
            const formatted = date.toLocaleString("vi-VN", {
                hour12: false,
                day: "2-digit",
                month: "2-digit",
                year: "numeric",
                hour: "2-digit",
                minute: "2-digit"
            });

            el.textContent = formatted
            el.textContent = formatted.replace(",", "");
        }
    });
});
</script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    // 1. Chọn container chứa danh sách đánh giá
    const reviewList = document.querySelector(".review-list");

    // Chỉ chạy nếu tìm thấy reviewList (tránh lỗi)
    if (reviewList) {
        // 2. Chọn tất cả các item đánh giá
        const reviewItems = reviewList.querySelectorAll(".review-item");

        // 3. Chuyển NodeList (danh sách tĩnh) sang Array (mảng)
        const itemsArray = Array.from(reviewItems);

        // 4. Sắp xếp mảng
        itemsArray.sort((a, b) => {
            // Lấy thời gian từ thuộc tính data-time bên trong mỗi item
            const timeA = a.querySelector(".rate-time").getAttribute("data-time");
            const timeB = b.querySelector(".rate-time").getAttribute("data-time");

            // Chuyển chuỗi thời gian sang đối tượng Date để so sánh
            const dateA = new Date(timeA.replace(" ", "T"));
            const dateB = new Date(timeB.replace(" ", "T"));

            // Sắp xếp GIẢM DẦN (mới nhất lên đầu)
            // Dùng (dateA - dateB) để sắp xếp TĂNG DẦN (cũ nhất lên đầu)
            return dateB - dateA;
        });

        // 5. Xóa các item cũ và thêm lại theo thứ tự đã sắp xếp
        // Xóa tất cả con của reviewList
        reviewItems.forEach(item => item.remove());
        
        // Thêm lại các item đã được sắp xếp vào
        itemsArray.forEach(item => reviewList.appendChild(item));
    }
});
</script>
 

</body>

</html>