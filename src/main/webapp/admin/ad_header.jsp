<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Quản lí khách sạn</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="${pageContext.request.contextPath}/admin/assets/img/favicon.png" rel="icon">
  <link href="${pageContext.request.contextPath}/admin/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="${pageContext.request.contextPath}/admin/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/admin/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/admin/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/admin/assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/admin/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/admin/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/admin/assets/vendor/simple-datatables/style.css" rel="stylesheet">
  
  

  <!-- Template Main CSS File -->
  <link href="${pageContext.request.contextPath}/admin/assets/css/styleadmin.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/admin/assets/css/show.css?v=2" rel="stylesheet">
  
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-datatables@6.0/dist/style.css">
  <script src="https://cdn.jsdelivr.net/npm/simple-datatables@6.0" defer></script>
  
  

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Updated: Apr 20 2024 with Bootstrap v5.3.3
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  
  <style>
		.dataTable-dropdown select {
    padding: 6px 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
    font-size: 14px;
    outline: none;
    cursor: pointer;
}

.dataTable-dropdown {
    display: flex;
    align-items: center;
    gap: 6px;
}
		  
  </style>
</head>

<body>

	<%
		String message = request.getParameter("message");
		if (message != null) {
		%>
		<script>
			$(document).ready(function() {
		<%if ("success".equals(message)) {%>
			$.bootstrapGrowl("Thao tác thành công!", {
					type : "success",
					offset : {
						from : "top",
						amount : 50
					},
					align : "right",
					delay : 3000,
					allow_dismiss : true,
					stackup_spacing : 10
				});
		<%} else if ("fail".equals(message)) {%>
			$.bootstrapGrowl("Thao tác thất bại!", {
					type : "danger",
					offset : {
						from : "top",
						amount : 50
					},
					align : "right",
					delay : 3000,
					allow_dismiss : true,
					stackup_spacing : 10
				});
		<%}%>
 			});
		</script>
		<%
 		}
 		%>	 
  <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
      <a href="<%=request.getContextPath() %>/home" class="logo d-flex align-items-center">
        <img src="" alt="">
        <span class="d-none d-lg-block">San Premium</span>
      </a>
      <i class="bi bi-list toggle-sidebar-btn"></i>
    </div><!-- End Logo -->

   

    <nav class="header-nav ms-auto">
      <ul class="d-flex align-items-center">

        

   

        <li class="nav-item dropdown pe-3">

          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
            <img src="${sessionScope.user.user_avatar_url}" alt="Profile" class="rounded-circle" style="height:40px; width:40px ;object-fit:cover;">
            <span class="d-none d-md-block dropdown-toggle ps-2">${sessionScope.user.user_fullname}</span>
          </a><!-- End Profile Iamge Icon -->

          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
            <li class="dropdown-header">
              <h6>${sessionScope.user.user_fullname}</h6>
              <span>Quản trị viên</span>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/profile-admin?id=${sessionScope.user.user_id}">
                <i class="bi bi-person"></i>
                <span>Hồ sơ</span>
              </a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            
            <li>
              <hr class="dropdown-divider">
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/logout">
                <i class="bi bi-box-arrow-right"></i>
                <span>Đăng xuất</span>
              </a>
            </li>

          </ul><!-- End Profile Dropdown Items -->
        </li><!-- End Profile Nav -->

      </ul>
    </nav><!-- End Icons Navigation -->

  </header><!-- End Header -->