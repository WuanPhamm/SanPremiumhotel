<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">


<%@include file="/customer/header.jsp"%>

<fmt:formatDate value="${book.booking_start_date}" pattern="dd/MM/yyyy" var="startDate" />
<fmt:formatDate value="${book.booking_end_date}" pattern="dd/MM/yyyy" var="endDate" />
<fmt:formatNumber value="${book.booking_total}" type="number" groupingUsed="true" maxFractionDigits="0" var="formattedTotal" />
<c:set var="totalAmount" value="${formattedTotal} VNĐ" />

<main class="main">

	
	<section id="starter-section" class="starter-section section">

		<div class="container" data-aos="fade-up">
			
			<div class="row g-5 justify-content-center">

				<div class="col-lg-7">
					
					<div class="section-title">
						<h2>Chi tiết đơn đặt phòng</h2>
					</div>
					
					<div class="confirmation-details mb-4">
						<h4>Thông tin khách hàng</h4>
						<dl class="row">
							<dt class="col-sm-4">Khách hàng:</dt>
							<dd class="col-sm-8">${cus.cus_firstname}&nbsp;${cus.cus_lastname}</dd>

							<dt class="col-sm-4">Số CCCD:</dt>
							<dd class="col-sm-8">${cus.cus_cccd }</dd>

							<dt class="col-sm-4">Email:</dt>
							<dd class="col-sm-8">${cus.cus_email }</dd>

							<dt class="col-sm-4">Số điện thoại:</dt>
							<dd class="col-sm-8">${cus.cus_phone }</dd>
						</dl>
					</div>

					<div class="confirmation-details">
						<h4>Chi tiết đặt phòng</h4>
						<dl class="row">
							<dt class="col-sm-4">Loại phòng:</dt>
							<dd class="col-sm-8">${rt.rt_name }</dd>
							
							<dt class="col-sm-4">Ngày nhận phòng:</dt>
							<dd class="col-sm-8">${startDate}</dd>
							
							<dt class="col-sm-4">Ngày trả phòng:</dt>
							<dd class="col-sm-8">${endDate}</dd>
						</dl>
					</div>

				</div>

				<div class="col-lg-5">
					<div class="payment-summary-box p-4 rounded shadow-sm">
						
						<img src="${rt.rt_img_url }" alt="${rt.rt_name }" class="img-fluid rounded shadow-sm mb-4">
						
						<div class="text-end">
							<label style="font-size: 1.1rem;">TỔNG CỘNG:</label>
							<h2 style="font-weight: 700; color: #0d1f1a;">${totalAmount}</h2>
						</div>
						
						<form action="${contextPath}/payment?id=${book.booking_id}" method="post" class="mt-4">
							
							<input type="hidden" name="amount" value="${book.booking_total }">
							
							<button type ="submit" class="btn btn-primary btn-lg w-100" style="background-color:#2f5d50">
								<i class="bi bi-credit-card me-2"></i>
								Tiến hành thanh toán
							</button>
						</form>
					</div>
				</div>

			</div>
			
		</div>

	</section>
	</main>

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


</body>

</html>