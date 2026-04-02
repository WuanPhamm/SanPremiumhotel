<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>San Premium </title>
  <meta name="description" content="">
  <meta name="keywords" content="">

  <!-- Favicons -->
  <link href="assets/img/favicon1.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Josefin+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Main CSS File -->
  <link href="${pageContext.request.contextPath}/assets/css/main.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/assets/css/accdetail.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600&family=Playfair+Display:wght@500;600;700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
  
  
  
  <!-- =======================================================
  * Template Name: Grandoria
  * Template URL: https://bootstrapmade.com/grandoria-bootstrap-hotel-template/
  * Updated: Jul 29 2025 with Bootstrap v5.3.7
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  
  
  <style type="text/css">
 .luxury-text {
  background: linear-gradient(90deg, #f9e79f, #f4d03f, #d4af37, #b7950b);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  font-family: 'Playfair Display', serif;
  font-weight: 700;
  letter-spacing: 1px;
  text-shadow: 0 2px 8px rgba(0, 0, 0, 0.4);
  font-size: 70px;
}
  </style>
</head>

<body class="room-details-page">

  <header id="header" class="header sticky-top">

    <div class="topbar d-flex align-items-center dark-background">
      <div class="container d-flex justify-content-center justify-content-md-between">
        <div class="contact-info d-flex align-items-center">
          <i class="bi bi-envelope d-flex align-items-center"><a href="mailto:contact@example.com">2uannene@gmail.com</a></i>
          <i class="bi bi-phone d-flex align-items-center ms-4"><span>+84 383 952 771</span></i>
        </div>
        <div class="social-links d-none d-md-flex align-items-center">
          <a href="#" class="twitter"><i class="bi bi-twitter-x"></i></a>
          <a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
          <a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
          <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
        </div>
      </div>
    </div><!-- End Top Bar -->

    <div class="branding d-flex align-items-cente">

      <div class="container position-relative d-flex align-items-center justify-content-between">
        <a href="${pageContext.request.contextPath}/trangchu" class="logo d-flex align-items-center">
          <!-- Uncomment the line below if you also wish to use an image logo -->
          <!-- <img src="assets/img/logo.webp" alt=""> -->
          <h1 class="sitename">San Premium</h1>
        </a>

        <nav id="navmenu" class="navmenu">
          <ul>
            <li><a href="${pageContext.request.contextPath}/trangchu">Trang chủ</a></li>
            <li><a href="${pageContext.request.contextPath}/about">Thông tin</a></li>
            <li><a href="${pageContext.request.contextPath}/viewrooms">Phòng</a></li>
            <li><a href="${pageContext.request.contextPath}/service">Dịch vụ</a></li>
            <li><a href="${pageContext.request.contextPath}/location">Địa chỉ</a></li>
            <li class="dropdown"><a href="#"><span>Các trang</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
              <ul>
                <li><a href="${pageContext.request.contextPath}/restaurant">Nhà hàng</a></li>
                <li><a href="${pageContext.request.contextPath}/events">Sự kiện</a></li>
                <li><a href="${pageContext.request.contextPath}/gallery">Bộ sưu tập</a></li>
                <li><a href="${pageContext.request.contextPath}/booking?id=${sessionScope.customer.cus_id}">Đặt phòng</a></li>
                <li><a href="${pageContext.request.contextPath}/terms">Điều khoản dịch vụ</a></li>
                <li><a href="${pageContext.request.contextPath}/privacy">Chính sách bảo mật</a></li>
              </ul>
            </li>
            <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>

						<li class="dropdown"><a href="#"> 
								<c:choose>
									<c:when test="${not empty sessionScope.customer}">
										<span>Xin chào, ${sessionScope.customer.cus_lastname}</span>
									</c:when>
									<c:when test="${not empty sessionScope.user}">
										<span>${sessionScope.user.fullname}</span>
									</c:when>
									<c:otherwise>
										<span>Tài khoản</span>
									</c:otherwise>
								</c:choose>
								<i class="bi bi-person"></i>
						</a>
							<ul>
								<c:choose>
									<c:when test="${not empty sessionScope.customer}">
										<li><a href="${pageContext.request.contextPath}/accdetail?id=${sessionScope.customer.cus_id}">Hồ
												sơ</a></li>
										<li><a href="${pageContext.request.contextPath}/my-bookings?id=${sessionScope.customer.cus_id}">Phòng
												của tôi</a></li>
										<li><a href="${pageContext.request.contextPath}/wallet">Số dư tài khoản</a></li>
										<li><a href="${pageContext.request.contextPath}/logout">Đăng
												xuất</a></li>
									</c:when>
									
									<c:otherwise>
										<li><a href="${pageContext.request.contextPath}/login">Đăng
												nhập</a></li>
										<li><a href="${pageContext.request.contextPath}/register">Đăng
												ký</a></li>
									</c:otherwise>
								</c:choose>
							</ul></li>


					</ul>
          <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
        </nav>

      </div>

    </div>

  </header>

  


  <!-- Preloader -->
  

