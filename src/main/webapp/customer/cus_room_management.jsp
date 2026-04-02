<%@page import="dao.room_typeDAO"%>
<%@page import="model.room_type"%>
<%@page import="dao.roomDAO"%>
<%@page import="model.room"%>
<%@page import="model.booking"%>
<%@page import="dao.room_ratingDAO"%>
<%@page import="model.room_rating"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="en">

<style>
/* Giả định màu chủ đạo là màu xanh lục đậm từ thanh navigation */
:root {
	--main-green: #38705B; /* Màu xanh lục đậm */
	--light-green: #599279;
	--text-green: #2B5746;
	--border-subtle: #D8E3DF; /* Màu border tinh tế, mờ nhạt */
}

/* Kiểu cho Card đặt phòng tinh tế */
.booking-card-subtle {
	border-radius: 8px;
	border: 1px solid var(--border-subtle);
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); /* Shadow nhẹ nhàng */
	transition: all 0.3s;
}

.booking-card-subtle:hover {
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
	border-color: var(--light-green);
}

/* Kiểu cho Tab Xanh Lục */
.nav-pills .nav-link.active, .nav-pills {
	background-color: var(--main-green) !important;
	color: white !important;
}

.nav-link:hover {
	border: 2px solid var(--main-green);
	color: var(--main-green) !important;
}

.nav-pills .nav-link {
	color: var(--text-green)
}

/* Kiểu cho badge trạng thái màu xanh lục */
.badge-green {
	background-color: var(--main-green);
	color: white;
}

.badge-pending {
	background-color: #FFC107; /* Vẫn giữ màu vàng cho chờ thanh toán */
	color: #333;
}

.badge-cancelled {
	background-color: #6C757D; /* Màu xám cho đã hủy */
}
</style>

<%@include file="/customer/header.jsp"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

<main id="main" class="main">

	<!-- Page Title -->
	<div class="page-title light-background">
		<div
			class="container d-lg-flex justify-content-between align-items-center">
			<h1 class="mb-2 mb-lg-0">Quản lý đặt phòng</h1>
			<nav class="breadcrumbs">
				<ol>
					<li><a href="index.html">Trang chủ</a></li>
					<li class="current">Quản lý đặt phòng</li>
				</ol>
			</nav>
		</div>
	</div>
	<!-- End Page Title -->

	<section class="section pt-4 pb-5" style="background-color: #F8F9FA;">
		<div class="container">

			<div class="row">
				<div class="col-lg-12">
					<div class="card shadow-sm border-0">
						<div class="card-body p-0">

							<ul class="nav nav-pills nav-fill p-3 bg-white border-bottom"
								id="myBookingsTab" role="tablist">
								<li class="nav-item" role="presentation">
									<button class="nav-link active" id="upcoming-tab"
										data-bs-toggle="tab" data-bs-target="#bookings-upcoming"
										type="button" role="tab" aria-controls="bookings-upcoming"
										aria-selected="true">Sắp tới</button>
								</li>
								<li class="nav-item" role="presentation">
									<button class="nav-link" id="pending-tab" data-bs-toggle="tab"
										data-bs-target="#bookings-pending" type="button" role="tab"
										aria-controls="bookings-pending" aria-selected="false">Chờ
										thanh toán</button>
								</li>
								<li class="nav-item" role="presentation">
									<button class="nav-link" id="completed-tab"
										data-bs-toggle="tab" data-bs-target="#bookings-completed"
										type="button" role="tab" aria-controls="bookings-completed"
										aria-selected="false">Đã hoàn thành</button>
								</li>

								<li class="nav-item" role="presentation">
									<button class="nav-link" id="completed-tab"
										data-bs-toggle="tab" data-bs-target="#bookings-rated"
										type="button" role="tab" aria-controls="bookings-rated"
										aria-selected="false">Đã đánh giá</button>
								</li>
								<li class="nav-item" role="presentation">
									<button class="nav-link" id="cancelled-tab"
										data-bs-toggle="tab" data-bs-target="#bookings-cancelled"
										type="button" role="tab" aria-controls="bookings-cancelled"
										aria-selected="false">Đã hủy</button>
								</li>
							</ul>
							<div class="tab-content p-4" id="myBookingsTabContent">

								<div class="tab-pane fade show active" id="bookings-upcoming"
									role="tabpanel" aria-labelledby="upcoming-tab">

									<c:if test="${empty upcomingBookings}">
										<div class="alert alert-light text-center border-2"
											role="alert">
											<i class="bi bi-info-circle me-2"></i>Bạn không có đơn đặt
											phòng nào sắp tới.
										</div>
									</c:if>

									<c:forEach var="booking" items="${upcomingBookings}">
										<c:set var="roomId" value="${booking.room_id}" scope="page" />
										<%
										// Lấy giá trị roomId đã được đặt qua EL ra bằng cú pháp Java
										String roomIdStr = pageContext.getAttribute("roomId").toString();
										int roomId = Integer.parseInt(roomIdStr); // Chuyển đổi sang kiểu dữ liệu phù hợp

										// Sử dụng roomId trong mã Java
										room r = roomDAO.getIns().selectById(roomId);
										room_type rt = room_typeDAO.getIns().selectById(r.getRt_id());

										// Đặt thuộc tính ảnh cho phòng hiện tại
										pageContext.setAttribute("roomImgUrl", rt.getRt_img_url());
										pageContext.setAttribute("room_name", r.getRoom_name());
										pageContext.setAttribute("room_type_name", rt.getRt_name());
										%>
										<div class="card booking-card-subtle mb-4">
											<div class="card-body p-4">
												<div class="row align-items-center">

													<div class="col-lg-2 col-md-2 text-center">
														<img src="${roomImgUrl}" alt="Ảnh phòng"
															class="rounded-3 shadow-sm"
															style="width: 100%; max-width: 100px; height: auto; aspect-ratio: 1/1; object-fit: cover;">
													</div>

													<div class="col-lg-5 col-md-5 mt-3 mt-md-0">
														<h5 class="mb-1 fw-bold">
															<a
																href="${pageContext.request.contextPath}/booking-details?id=${booking.booking_id}"
																class="text-decoration-none"
																style="color: var(--text-green);"> Phòng:
																${room_name} </a>
														</h5>
														<p class="small mb-1 text-muted">
															Loại phòng: <span class="fw-semibold">${room_type_name}</span>
														</p>
														<p class="mb-1 small">
															<i class="bi bi-calendar-check me-1"
																style="color: var(--main-green);"></i> Nhận phòng:
															<fmt:formatDate value="${booking.booking_start_date}"
																pattern="dd/MM/yyyy" />
														</p>
														<p class="mb-0 small">
															<i class="bi bi-calendar-x me-1 text-danger"></i> Trả
															phòng:
															<fmt:formatDate value="${booking.booking_end_date}"
																pattern="dd/MM/yyyy" />
														</p>
													</div>

													<div class="col-lg-2 col-md-2 text-center mt-3 mt-md-0">
														<c:choose>
															<c:when test="${booking.bs_id == 1}">
																<span class="badge badge-green py-2 px-3 fw-normal">Đã
																	thanh toán - Chờ xác nhận</span>
															</c:when>
															<c:when test="${booking.bs_id == 2}">
																<span class="badge badge-green py-2 px-3 fw-normal">Đã
																	xác nhận</span>
															</c:when>
															<c:when test="${booking.bs_id == 3}">
																<span
																	class="badge bg-warning text-dark py-2 px-3 fw-normal">Đang
																	chờ hủy</span>
															</c:when>
														</c:choose>

													</div>

													<div
														class="col-lg-3 col-md-3 text-md-end text-center mt-3 mt-md-0">
														<h6 class="mb-1 small text-muted">Tổng tiền:</h6>
														<h4 class="fw-bold mb-3" style="color: var(--main-green);">
															<fmt:formatNumber value="${booking.booking_total}"
																type="currency" currencyCode="VND" />
														</h4>

														<div class="d-grid gap-2">
															<c:if test="${booking.bs_id != 3}">
																<a
														            href="${pageContext.request.contextPath}/my-bookings?action=cancel&id=${booking.booking_id}"
														            class="btn btn-sm btn-outline-danger"
														            id="cancel-btn-upcoming-${booking.booking_id}" data-booking-url="${pageContext.request.contextPath}/my-bookings?action=cancel&id=${booking.booking_id}" > <i class="bi bi-x-circle me-1"></i> Yêu cầu Hủy
														        </a>
															</c:if>
														</div>
													</div>

												</div>
											</div>
										</div>
									</c:forEach>
								</div>
								<div class="tab-pane fade" id="bookings-pending" role="tabpanel"
									aria-labelledby="pending-tab">

									<c:if test="${empty pendingBookings}">
										<div class="alert alert-light text-center  border-2"
											role="alert">
											<i class="bi bi-info-circle me-2"></i>Bạn không có đơn đặt
											phòng nào đang chờ thanh toán.
										</div>
									</c:if>

									<c:forEach var="booking" items="${pendingBookings}">
										<c:set var="roomId" value="${booking.room_id}" scope="page" />
										<%
										// Lấy giá trị roomId đã được đặt qua EL ra bằng cú pháp Java
										String roomIdStr = pageContext.getAttribute("roomId").toString();
										int roomId = Integer.parseInt(roomIdStr); // Chuyển đổi sang kiểu dữ liệu phù hợp

										// Sử dụng roomId trong mã Java
										room r = roomDAO.getIns().selectById(roomId);
										room_type rt = room_typeDAO.getIns().selectById(r.getRt_id());

										// Đặt thuộc tính ảnh cho phòng hiện tại
										pageContext.setAttribute("roomImgUrl", rt.getRt_img_url());
										pageContext.setAttribute("room_name", r.getRoom_name());
										pageContext.setAttribute("room_type_name", rt.getRt_name());
										%>
										<div class="card booking-card-subtle mb-4">
											<div class="card-body p-4">
												<div class="row align-items-center">

													<div class="col-lg-2 col-md-2 text-center">
														<img src="${roomImgUrl}" alt="Ảnh phòng"
															class="rounded-3 shadow-sm"
															style="width: 100%; max-width: 100px; height: auto; aspect-ratio: 1/1; object-fit: cover;">
													</div>

													<div class="col-lg-5 col-md-5 mt-3 mt-md-0">
														<h5 class="mb-1 fw-bold">
															<a
																href="${pageContext.request.contextPath}/booking-details?id=${booking.booking_id}"
																class="text-decoration-none"
																style="color: var(--text-green);"> Phòng:
																${room_name} </a>
														</h5>
														<p class="small mb-1 text-muted">
															Loại phòng: <span class="fw-semibold">${room_type_name}</span>
														</p>
														<p class="mb-1 small">
															<i class="bi bi-calendar-check me-1"
																style="color: var(--main-green);"></i> Nhận phòng:
															<fmt:formatDate value="${booking.booking_start_date}"
																pattern="dd/MM/yyyy" />
														</p>
														<p class="mb-0 small">
															<i class="bi bi-calendar-x me-1 text-danger"></i> Trả
															phòng:
															<fmt:formatDate value="${booking.booking_end_date}"
																pattern="dd/MM/yyyy" />
														</p>
													</div>

													<div class="col-lg-2 col-md-2 text-center mt-3 mt-md-0">
														<span class="badge badge-pending py-2 px-3 fw-normal">Chờ
															thanh toán</span>
													</div>

													<div
														class="col-lg-3 col-md-3 text-md-end text-center mt-3 mt-md-0">
														<h6 class="mb-1 small text-muted">Tổng tiền:</h6>
														<h4 class="fw-bold mb-3" style="color: var(--main-green);">
															<fmt:formatNumber value="${booking.booking_total}"
																type="currency" currencyCode="VND" />
														</h4>

														<div class="d-grid gap-2">
															<form action="${pageContext.request.contextPath}/payment"
																method="post" class="d-grid gap-2">
																<input type="hidden" name="id"
																	value="${booking.booking_id}"> <input
																	type="hidden" name="amount"
																	value="${booking.booking_total}">
																<button type="submit" class="btn btn-sm mb-2"
																	style="background-color: var(--main-green); color: white;">
																	<i class="bi bi-wallet2 me-1"></i> Thanh toán ngay
																</button>
															</form>

															<a
																href="${pageContext.request.contextPath}/my-bookings?action=cancel&id=${booking.booking_id}"
																class="btn btn-sm btn-outline-danger"
																id="cancel-btn-${booking.booking_id}"
																data-booking-url="${pageContext.request.contextPath}/my-bookings?action=cancel&id=${booking.booking_id}">
																<i class="bi bi-x-circle me-1"></i> Yêu cầu Hủy
															</a>
														</div>
													</div>

												</div>
											</div>
										</div>
									</c:forEach>

								</div>
								<div class="tab-pane fade" id="bookings-completed"
									role="tabpanel" aria-labelledby="completed-tab">

									<c:if test="${empty completedBookings}">
										<div class="alert alert-light text-center border-2"
											role="alert">
											<i class="bi bi-info-circle me-2"></i>Bạn không có đơn đặt
											phòng nào đã hoàn thành.
										</div>
									</c:if>

									<c:forEach var="booking" items="${completedBookings}">
										<c:set var="roomId" value="${booking.room_id}" scope="page" />
										<%
										// Lấy giá trị roomId đã được đặt qua EL ra bằng cú pháp Java
										String roomIdStr = pageContext.getAttribute("roomId").toString();
										int roomId = Integer.parseInt(roomIdStr); // Chuyển đổi sang kiểu dữ liệu phù hợp

										// Sử dụng roomId trong mã Java
										room r = roomDAO.getIns().selectById(roomId);
										room_type rt = room_typeDAO.getIns().selectById(r.getRt_id());

										// Đặt thuộc tính ảnh cho phòng hiện tại
										pageContext.setAttribute("roomImgUrl", rt.getRt_img_url());
										pageContext.setAttribute("room_name", r.getRoom_name());
										pageContext.setAttribute("room_type_name", rt.getRt_name());
										%>
										<div class="card booking-card-subtle mb-4">
											<div class="card-body p-4">
												<div class="row align-items-center">

													<div class="col-lg-2 col-md-2 text-center">
														<img src="${roomImgUrl}" alt="Ảnh phòng"
															class="rounded-3 shadow-sm"
															style="width: 100%; max-width: 100px; height: auto; aspect-ratio: 1/1; object-fit: cover;">
													</div>

													<div class="col-lg-5 col-md-5 mt-3 mt-md-0">
														<h5 class="mb-1 fw-bold">
															<a
																href="${pageContext.request.contextPath}/booking-details?id=${booking.booking_id}"
																class="text-decoration-none"
																style="color: var(--text-green);"> Phòng:
																${room_name} </a>
														</h5>
														<p class="small mb-1 text-muted">
															Loại phòng: <span class="fw-semibold">${room_type_name}</span>
														</p>
														<p class="mb-1 small">
															<i class="bi bi-calendar-check me-1"
																style="color: var(--main-green);"></i> Đã ở từ:
															<fmt:formatDate value="${booking.booking_start_date}"
																pattern="dd/MM/yyyy" />
														</p>
														<p class="mb-0 small">
															<i class="bi bi-calendar-x me-1 text-danger"></i> Đã trả:
															<fmt:formatDate value="${booking.booking_end_date}"
																pattern="dd/MM/yyyy" />
														</p>
													</div>

													<div class="col-lg-2 col-md-2 text-center mt-3 mt-md-0">
														<span class="badge bg-secondary py-2 px-3 fw-normal">Hoàn
															thành</span>

													</div>

													<div
														class="col-lg-3 col-md-3 text-md-end text-center mt-3 mt-md-0">
														<h6 class="mb-1 small text-muted">Tổng tiền:</h6>
														<h4 class="text-secondary fw-bold mb-3">
															<fmt:formatNumber value="${booking.booking_total}"
																type="currency" currencyCode="VND" />
														</h4>

														<div class="d-grid gap-2">
															<a
																href="${pageContext.request.contextPath}/rate-booking?id=${booking.booking_id}"
																class="btn btn-sm btn-outline-warning mb-2"> <i
																class="bi bi-star me-1"></i> Đánh giá
															</a> <a
																href="${pageContext.request.contextPath}/re_booking?cus_id=${sessionScope.customer.cus_id}&book_id=${booking.booking_id}"
																class="btn btn-sm"
																style="border-color: var(--main-green); color: var(--main-green);">
																<i class="bi bi-arrow-repeat me-1"></i> Đặt lại
															</a>
														</div>
													</div>

												</div>
											</div>
										</div>
									</c:forEach>
								</div>


								<div class="tab-pane fade" id="bookings-rated" role="tabpanel"
									aria-labelledby="rated-tab">

									<c:if test="${empty ratedBookings}">
										<div class="alert alert-light text-center border-2"
											role="alert">
											<i class="bi bi-info-circle me-2"></i>Bạn không có đơn đặt
											phòng nào đã đánh giá.
										</div>
									</c:if>

									<c:forEach var="booking" items="${ratedBookings}">
										<c:set var="roomId" value="${booking.room_id}" scope="page" />
										<%
										// Lấy giá trị roomId đã được đặt qua EL ra bằng cú pháp Java
										String roomIdStr = pageContext.getAttribute("roomId").toString();
										int roomId = Integer.parseInt(roomIdStr); // Chuyển đổi sang kiểu dữ liệu phù hợp

										// Sử dụng roomId trong mã Java
										room r = roomDAO.getIns().selectById(roomId);
										room_type rt = room_typeDAO.getIns().selectById(r.getRt_id());

										// Đặt thuộc tính ảnh cho phòng hiện tại
										pageContext.setAttribute("roomImgUrl", rt.getRt_img_url());
										pageContext.setAttribute("room_name", r.getRoom_name());
										pageContext.setAttribute("room_type_name", rt.getRt_name());
										
										int bookingIdForRating = ((model.booking)pageContext.getAttribute("booking")).getBooking_id();
								        room_rating rating = room_ratingDAO.getIns().selectByBookingId(bookingIdForRating);
								        pageContext.setAttribute("rating", rating);
										%>
										<div class="card booking-card-subtle mb-4">
											<div class="card-body p-4">
												<div class="row align-items-center">

													<div class="col-lg-2 col-md-2 text-center">
														<img src="${roomImgUrl}" alt="Ảnh phòng"
															class="rounded-3 shadow-sm"
															style="width: 100%; max-width: 100px; height: auto; aspect-ratio: 1/1; object-fit: cover;">
													</div>

													<div class="col-lg-5 col-md-5 mt-3 mt-md-0">
														<h5 class="mb-1 fw-bold">
															<a
																href="${pageContext.request.contextPath}/booking-details?id=${booking.booking_id}"
																class="text-decoration-none"
																style="color: var(--text-green);"> Phòng:
																${room_name} </a>
														</h5>
														<p class="small mb-1 text-muted">
															Loại phòng: <span class="fw-semibold">${room_type_name}</span>
														</p>
														<p class="mb-1 small">
															<i class="bi bi-calendar-check me-1"
																style="color: var(--main-green);"></i> Đã ở từ:
															<fmt:formatDate value="${booking.booking_start_date}"
																pattern="dd/MM/yyyy" />
														</p>
														<p class="mb-0 small">
															<i class="bi bi-calendar-x me-1 text-danger"></i> Đã trả:
															<fmt:formatDate value="${booking.booking_end_date}"
																pattern="dd/MM/yyyy" />
														</p>
													</div>

													<div class="col-lg-2 col-md-2 text-center mt-3 mt-md-0">
														<span class="badge bg-secondary py-2 px-3 fw-normal">Đã
															đánh giá</span>

													</div>

													<div
														class="col-lg-3 col-md-3 text-md-end text-center mt-3 mt-md-0">
														<h6 class="mb-1 small text-muted">Tổng tiền:</h6>
														<h4 class="text-secondary fw-bold mb-3">
															<fmt:formatNumber value="${booking.booking_total}"
																type="currency" currencyCode="VND" />
														</h4>

														<div class="d-grid gap-2">
															<c:if test="${not empty rating}">
														<button type="button" 
															class="btn btn-sm btn-outline-warning mb-2"
															data-bs-toggle="modal" 
															data-bs-target="#viewRatingModal"
															data-room-name="${room_name}"
															data-rate-star="${rating.rate_star}"
															data-rate-desc="${rating.rate_description}"
															data-rate-time="<fmt:formatDate value="${rating.rate_time}" pattern="dd/MM/yyyy HH:mm" />">
															<i class="bi bi-eye me-1"></i> Xem đánh giá
														</button>
													</c:if>
													<c:if test="${empty rating}">
														<span class="btn btn-sm btn-outline-secondary mb-2 disabled">
															<i class="bi bi-eye-slash me-1"></i> Lỗi đánh giá
														</span>
													</c:if>
															
															
															<a
																href="${pageContext.request.contextPath}/re_booking?cus_id=${sessionScope.customer.cus_id}&book_id=${booking.booking_id}"
																class="btn btn-sm"
																style="border-color: var(--main-green); color: var(--main-green);">
																<i class="bi bi-arrow-repeat me-1"></i> Đặt lại
															</a>
														</div>
													</div>

												</div>
											</div>
										</div>
									</c:forEach>
								</div>


								<div class="tab-pane fade" id="bookings-cancelled"
									role="tabpanel" aria-labelledby="cancelled-tab">

									<c:if test="${empty cancelledBookings}">
										<div class="alert alert-light text-center border-2"
											role="alert">
											<i class="bi bi-info-circle me-2"></i>Bạn không có đơn đặt
											phòng nào đã hủy.
										</div>
									</c:if>

									<c:forEach var="booking" items="${cancelledBookings}">
										<c:set var="roomId" value="${booking.room_id}" scope="page" />
										<%
										// Lấy giá trị roomId đã được đặt qua EL ra bằng cú pháp Java
										String roomIdStr = pageContext.getAttribute("roomId").toString();
										int roomId = Integer.parseInt(roomIdStr); // Chuyển đổi sang kiểu dữ liệu phù hợp

										// Sử dụng roomId trong mã Java
										room r = roomDAO.getIns().selectById(roomId);
										room_type rt = room_typeDAO.getIns().selectById(r.getRt_id());

										// Đặt thuộc tính ảnh cho phòng hiện tại
										pageContext.setAttribute("roomImgUrl", rt.getRt_img_url());
										pageContext.setAttribute("room_name", r.getRoom_name());
										pageContext.setAttribute("room_type_name", rt.getRt_name());
										%>
										<div class="card booking-card-subtle mb-4 opacity-75">
											 
											<div class="card-body p-4">
												<div class="row align-items-center">

													<div class="col-lg-2 col-md-2 text-center">
														<img src="${roomImgUrl}" alt="Ảnh phòng"
															class="rounded-3 shadow-sm"
															style="width: 100%; max-width: 100px; height: auto; aspect-ratio: 1/1; object-fit: cover;">
													</div>

													<div class="col-lg-5 col-md-5 mt-3 mt-md-0">
														<h5 class="mb-1 text-muted fw-bold">Phòng:
															${room_name}</h5>
														<p class="small mb-1 text-muted">
															Loại phòng: <span class="fw-semibold">${room_type_name}</span>
														</p>
														<p class="mb-0 small">
															<i class="bi bi-clock me-1"></i> Ngày đặt:
															<fmt:formatDate value="${booking.booking_time}"
																pattern="dd/MM/yyyy HH:mm" />
														</p>
													</div>

													<div class="col-lg-2 col-md-2 text-center mt-3 mt-md-0">
														<span class="badge badge-cancelled py-2 px-3 fw-normal">Đã
															hủy</span>

													</div>

													<div
														class="col-lg-3 col-md-3 text-md-end text-center mt-3 mt-md-0">
														<h6 class="mb-1 small text-muted">Tổng tiền:</h6>
														<h4 class="text-secondary fw-bold mb-3">
															<fmt:formatNumber value="${booking.booking_total}"
																type="currency" currencyCode="VND" />
														</h4>
													</div>

												</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</section>

</main>

<div class="modal fade" id="viewRatingModal" tabindex="-1"
	aria-labelledby="viewRatingModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header" style="background-color: var(--main-green); color: white;">
				<h5 class="modal-title" id="viewRatingModalLabel" style="color: white">
					Đánh giá cho <span id="modalRoomName"></span>
				</h5>
				<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				
				<div class="mb-3">
					<label class="form-label fw-bold">Số sao:</label>
					<div id="modalRateStars" class="fs-4" style="color: #FFC107;">
						</div>
				</div>

				<div class="mb-3">
					<label class="form-label fw-bold">Nội dung đánh giá:</label>
					<p id="modalRateDesc" class="text-muted"
						style="white-space: pre-wrap;"></p>
				</div>
				
				<hr>
				<p class="text-end text-muted small mb-0">
					Đánh giá lúc: <span id="modalRateTime"></span>
				</p>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Đóng</button>
			</div>
		</div>
	</div>
</div>
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', (event) => {
    // Lấy modal
    var viewRatingModal = document.getElementById('viewRatingModal');
    
    // Hàm tạo sao
    function generateStars(starCount) {
        let starsHTML = '';
        for (let i = 1; i <= 5; i++) {
            if (i <= starCount) {
                starsHTML += '<i class="bi bi-star-fill"></i> ';
            } else {
                starsHTML += '<i class="bi bi-star"></i> ';
            }
        }
        return starsHTML;
    }

    // Lắng nghe sự kiện khi modal được kích hoạt
    viewRatingModal.addEventListener('show.bs.modal', function (event) {
        // 'event.relatedTarget' chính là nút bấm đã kích hoạt modal
        var button = event.relatedTarget; 

        // Lấy dữ liệu từ các thuộc tính data-*
        var roomName = button.getAttribute('data-room-name');
        var rateStar = parseInt(button.getAttribute('data-rate-star'), 10);
        var rateDesc = button.getAttribute('data-rate-desc');
        var rateTime = button.getAttribute('data-rate-time');

        // Tìm các phần tử trong modal
        var modalTitle = viewRatingModal.querySelector('#modalRoomName');
        var modalStars = viewRatingModal.querySelector('#modalRateStars');
        var modalDesc = viewRatingModal.querySelector('#modalRateDesc');
        var modalTime = viewRatingModal.querySelector('#modalRateTime');

        // Gán dữ liệu vào modal
        modalTitle.textContent = roomName;
        modalStars.innerHTML = generateStars(rateStar);
        modalDesc.textContent = rateDesc;
        modalTime.textContent = rateTime;
    });
});
</script>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    // Lắng nghe tất cả các click trên body để bắt sự kiện của các nút Hủy
    document.body.addEventListener('click', function(event) {
        // Kiểm tra xem phần tử được click có phải là nút "Yêu cầu Hủy" hay không
        // Giả sử tất cả các nút đều có class "btn-outline-danger" và nằm trong d-grid gap-2
        const target = event.target.closest('.btn-outline-danger');
        
        // Hoặc dùng một class cụ thể hơn:
        // const target = event.target.closest('.cancel-booking-btn');
        
        if (target && target.tagName === 'A' && target.textContent.includes('Yêu cầu Hủy')) {
            event.preventDefault(); // Ngăn chặn hành động chuyển hướng mặc định của thẻ <a>
            
            const bookingUrl = target.getAttribute('data-booking-url'); // Lấy URL từ data attribute

            Swal.fire({
                title: 'Xác nhận hủy',
                text: "Bạn có chắc muốn gửi yêu cầu hủy đặt phòng này?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#2f5d50',
                confirmButtonText: 'Đồng ý',
                cancelButtonText: 'Quay lại'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Nếu người dùng xác nhận, chuyển hướng đến URL hủy phòng
                    window.location.href = bookingUrl;
                }
            });
        }
    });
});
</script>

</body>

</html>