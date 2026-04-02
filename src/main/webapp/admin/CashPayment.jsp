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



<%@include file="/admin/ad_header.jsp"%>
<%@include file="/admin/ad_sidebar.jsp"%>
<style>

.btn-outline-secondary:hover {
    border: 2px solid #2f5d50 !important;
    background-color:#f8f9fa !important;
    color: #2f5d50 !important;
}

section.py-5 {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 70vh; /* tăng chiều cao để card nổi bật */
    background-color: #f8f9fa;
    padding-top: 80px;
    padding-bottom: 80px;
}
</style>

<main class="main">

	<%-- 
	=================================================
	PHẦN NỘI DUNG THAY THẾ
	=================================================
	Bắt đầu thay thế từ đây.
	--%>

	<section class="py-5 center"
		style="margin-top: 50px; background-color: #f8f9fa; min-height: 60vh; display: flex; align-items: center;">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2">
					
					<%-- Dùng Card của Bootstrap để tạo khung viền đẹp --%>
					<div class="card shadow-sm border-0 p-4 p-md-5 text-center">

						<div class="mb-4">
								<i class="bi bi-check-circle-fill"
									style="font-size: 80px; color: var(--bs-success); color:#0d6efd"></i>
							</div>
							
							<%-- Dùng các lớp font của Bootstrap --%>
							<h2 class="fw-bold  mb-3">Đặt phòng
								thành công!</h2>
							
							
							<%-- Biến đổi link <a> thành Button (CTA) rõ ràng --%>
							<div
								class="d-grid gap-2 d-md-flex justify-content-md-center">
								<a href="${contextPath}/home"
									class="btn btn-primary btn-lg px-4" style="background-color:#0d6efd">Quay lại trang chủ</a>
								
								<a
									href="${pageContext.request.contextPath}/export-invoice?id=${bookingId}"
									class="btn btn-warning btn-lg px-4 text-white"> <i
									class="bi bi-printer-fill"></i> Xuất hóa đơn PDF
								</a>
							</div>

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

