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
			<h1 class="mb-2 mb-lg-0">Các loại phòng</h1>
			<nav class="breadcrumbs">
				<ol>
					<li><a href="index.html">Trang chủ</a></li>
					<li class="current">Các loại phòng</li>
				</ol>
			</nav>
		</div>
	</div>
	<!-- End Page Title -->

	<!-- Rooms 2 Section -->
	<section id="rooms-2" class="rooms-2 section">

		<div class="container" data-aos="fade-up" data-aos-delay="100">

			 <!-- <div class="room-filters" data-aos="fade-up" data-aos-delay="200">
          <div class="row g-3 align-items-center">
            <div class="col-lg-3 col-md-6">
              <label class="form-label"></label>
              <select class="form-select">
                <option>All Prices</option>
                <option>$100 - $200</option>
                <option>$200 - $350</option>
                <option>$350+</option>
              </select>
            </div>
            <div class="col-lg-3 col-md-6">
              <label class="form-label">Guest Capacity</label>
              <select class="form-select">
                <option>Any Capacity</option>
                <option>1-2 Guests</option>
                <option>3-4 Guests</option>
                <option>5+ Guests</option>
              </select>
            </div>
            <div class="col-lg-3 col-md-6">
              <label class="form-label">View Type</label>
              <select class="form-select">
                <option>All Views</option>
                <option>Ocean View</option>
                <option>City View</option>
                <option>Garden View</option>
              </select>
            </div>
            <div class="col-lg-3 col-md-6">
              <label class="form-label">Sort By</label>
              <select class="form-select">
                <option>Popularity</option>
                <option>Price: Low to High</option>
                <option>Price: High to Low</option>
                <option>Room Size</option>
              </select>
            </div>
          </div>
        </div> -->


			<!-- gọi data hiển thị danh sách -->
			<div class="rooms-grid" data-aos="fade-up" data-aos-delay="300">
				<div class="row g-4">

					<c:forEach var="rt" items="${list_room_type_all}" varStatus="st">
					<c:set var="star" value="${list_star[st.index]}" scope="page" />
						

						<div class="col-xl-4 col-lg-6">
							<div class="room-card">
								<div class="room-image">
									<img src="${rt.rt_img_url }" alt="Executive Business Suite"
										class="img-fluid">
									<div class="room-features">
										<span class="feature-badge business">SanPremium</span>
									</div>
								</div>
								<div class="room-content">
									<div class="room-header">
										<h3>${rt.rt_name}</h3>
										<div class="room-rating">
											<c:set var="totalStars" value="5" />
											<c:forEach var="i" begin="1" end="${totalStars}">
												<c:choose>
													<c:when test="${i <= star}">
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
									</div>
									<p class="room-description">${rt.rt_description}</p>
									<div class="room-amenities">
										<span><i class="bi bi-people"></i> Lên đến
											${rt.rt_max_people } người</span> <span><i
											class="bi bi-check"></i> ${rt.rt_special }</span>
									</div>
									<div class="room-footer">
										<div class="room-price">
											<span class="price-from">Từ</span> <span class="price-amount">${rt.rt_price }VND</span>
											<span class="price-period">/ đêm</span>
										</div>
										<a
											href="${pageContext.request.contextPath}/roomdetail?id=${rt.rt_id}"
											class="btn-room-details">Chi tiết</a>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>

				</div>
			</div>

		</div>
		

		<!-- <div class="load-more-section" data-aos="fade-up" data-aos-delay="400">
			<div class="text-center">
				<button class="btn-load-more">
					<i class="bi bi-arrow-down-circle"></i> Load More Rooms
				</button>
			</div>
		</div> -->

		

	</section>
	<!-- /Rooms 2 Section -->

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

</body>

</html>