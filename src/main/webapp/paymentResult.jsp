<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 
    Thêm biến contextPath để dễ dàng gọi link, 
    giống như bạn đã làm ở các trang trước.
--%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">



<%@include file="/customer/header.jsp"%>

<style>

.btn-outline-secondary:hover {
    border: 2px solid #2f5d50 !important;
    background-color:#f8f9fa !important;
    color: #2f5d50 !important;
}

</style>

<main class="main">

	<%-- 
	=================================================
	PHẦN NỘI DUNG THAY THẾ
	=================================================
	Bắt đầu thay thế từ đây.
	--%>

	<section class="py-5"
		style="margin-top: 50px; background-color: #f8f9fa; min-height: 60vh; display: flex; align-items: center;">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2">
					
					<%-- Dùng Card của Bootstrap để tạo khung viền đẹp --%>
					<div class="card shadow-sm border-0 p-4 p-md-5 text-center">

						<c:if test="${transResult}">
							<%-- 
							    Dùng Bootstrap Icon (giống các trang khác của bạn)
							    cho đồng bộ và chuyên nghiệp.
							--%>
							<div class="mb-4">
								<i class="bi bi-check-circle-fill"
									style="font-size: 80px; color: var(--bs-success); color:#2f5d50"></i>
							</div>
							
							<%-- Dùng các lớp font của Bootstrap --%>
							<h2 class="fw-bold  mb-3">Bạn đã giao dịch
								thành công!</h2>
							<p class="fs-5 text-muted mb-4">Vui lòng chờ xác nhận từ
								khách sạn</p>
							
							<%-- Biến đổi link <a> thành Button (CTA) rõ ràng --%>
							<div
								class="d-grid gap-2 d-md-flex justify-content-md-center">
								<a href="${contextPath}/trangchu"
									class="btn btn-primary btn-lg px-4" style="background-color:#2f5d50">Quay lại trang chủ</a>
								<a href="${contextPath}/my-bookings"
									class="btn btn-outline-secondary btn-lg px-4 ">Xem đơn đặt
									phòng</a> 
								<a
									href="${pageContext.request.contextPath}/export-invoice?id=${bookingId}"
									class="btn btn-warning btn-lg px-4 text-white"> <i
									class="bi bi-printer-fill"></i> Xuất hóa đơn PDF
								</a>
							</div>
						</c:if>

						<c:if test="${transResult == false}">
							<div class="mb-4">
								<i class="bi bi-x-circle-fill"
									style="font-size: 80px; color: var(--bs-danger);"></i>
							</div>
							<h2 class="fw-bold text-danger mb-3">Giao dịch thất bại!</h2>
							<p class="fs-5 text-muted mb-4">Đã có lỗi xảy ra trong
								quá trình xử lý thanh toán. Vui lòng thử lại hoặc liên hệ hỗ
								trợ.</p>
							<div
								class="d-grid gap-2 d-md-flex justify-content-md-center">
								<%-- Nút này nên dẫn về trang thanh toán hoặc "Đơn của tôi" --%>
								<a href="${contextPath}/my-bookings"
									class="btn btn-danger btn-lg px-4">Thử lại</a> <a
									href="${contextPath}/trangchu"
									class="btn btn-outline-secondary btn-lg px-4">Quay lại
									trang chủ</a>
							</div>
						</c:if>

						<c:if test="${transResult == null}">
							<%-- Thêm Spinner (vòng xoay) của Bootstrap --%>
							<div class="mb-4">
								<div class="spinner-border text-primary" role="status"
									style="width: 5rem; height: 5rem;">
									<span class="visually-hidden">Loading...</span>
								</div>
							</div>
							<h2 class="fw-bold text-primary mb-3">Đang xử lý đơn đặt
								phòng...</h2>
							<p class="fs-5 text-muted mb-4">Chúng tôi đã tiếp nhận đơn
								đặt phòng của bạn. Vui lòng chờ trong giây lát.</p>
						</c:if>

					</div>
					</div>
				</div>
			</div>
		</section>

	<%-- 
	=================================================
	Kết thúc phần thay thế
	=================================================
	--%>

</main>

<%@include file="/customer/footer.jsp"%>