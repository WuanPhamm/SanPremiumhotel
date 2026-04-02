 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



<!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link ${fn:endsWith(pageContext.request.requestURI, '/home') ? 'active' : 'collapsed'}" href="${pageContext.request.contextPath}/home">
          <i class="bi bi-house-door"></i>
          <span>Trang chủ</span>
        </a>
      </li><!-- End Dashboard Nav -->
      
       <li class="nav-item">
        <a class="nav-link collapsed" href="${pageContext.request.contextPath}/booking-management">
          <i class="bi bi-calendar-check"></i>
          <span>Đơn đặt phòng</span>
        </a>
      </li><!-- End Dashboard Nav -->
      

      <li class="nav-item">
        <a class="nav-link ${fn:endsWith(pageContext.request.requestURI, '/accounts') ? 'active' : 'collapsed'}" href="${pageContext.request.contextPath}/accounts">
          <i class="bi bi-person"></i>
          <span>Tài khoản</span>
        </a>
      </li><!-- End Dashboard Nav -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" href="${pageContext.request.contextPath}/customers">
          <i class="bi bi-people"></i>
          <span>Khách hàng</span>
        </a>
      </li><!-- End Dashboard Nav -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-building-gear"></i><span>Cơ sở vật chất</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="${pageContext.request.contextPath}/floors">
              <i class="bi bi-buildings"></i><span>Các tầng</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/rooms">
              <i class="bi bi-door-closed"></i><span>Các phòng</span>
            </a>
          </li>
          
          <li>
            <a href="${pageContext.request.contextPath}/room_type">
              <i class="bi bi-door-open"></i><span>Loại phòng</span>
            </a>
          </li>
        </ul>
      </li><!-- End Tables Nav -->

		<li class="nav-item">
        <a class="nav-link collapsed" href="${pageContext.request.contextPath}/ratings">
          <i class="bi bi-chat-dots"></i>
          <span>Đánh giá</span>
        </a>
      </li><!-- End Dashboard Nav -->
		
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#charts-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-bar-chart"></i><span>Thống kê</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="charts-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="${pageContext.request.contextPath}/booking-report">
              <i class="bi bi-clipboard"></i><span>Đơn đặt phòng</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/rt_report">
              <i class="bi bi-door-closed"></i><span>Top phòng</span>
            </a>
          </li>
          
          <li>
            <a href="${pageContext.request.contextPath}/customer_report">
              <i class="bi bi-people"></i><span>Top khách hàng</span>
            </a>
          </li>
          
        </ul>
      </li><!-- End Charts Nav -->

      

      <li class="nav-heading">Người quản trị</li>

      <li class="nav-item">
        <a class="nav-link collapsed" href="${pageContext.request.contextPath}/profile-admin?id=${sessionScope.user.user_id}">
          <i class="bi bi-person-lock"></i>
          <span>Hồ sơ</span>
        </a>
      </li><!-- End Profile Page Nav -->
		
		<li class="nav-item">
        <a class="nav-link collapsed" href="${pageContext.request.contextPath}/ad_contacts">
          <i class="bi bi-envelope"></i>
          <span>Góp ý khách hàng</span>
        </a>
      </li>

      <li class="nav-item">
        <a class="nav-link collapsed" href="${pageContext.request.contextPath}/withdrawal-management">
          <i class="bi bi-cash-coin"></i>
          <span>Yêu cầu rút tiền</span>
        </a>
      </li>

    </ul>

  </aside><!-- End Sidebar-->
