<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">


<%@include file="/admin/ad_header.jsp"%>
	
<%@include file="/admin/ad_sidebar.jsp"%>	
 
 <%-- Thông báo chung (Kết hợp msg và error) --%>
<c:set var="alertMessage" value="${param.msg != null ? param.msg : param.error}" />
<c:set var="alertClass" value="${param.msg != null ? 'alert-success' : 'alert-danger'}" />

<c:if test="${not empty alertMessage}">
  <div id="alertBox" class="alert ${alertClass} position-fixed top-0 start-50 translate-middle-x mt-3 shadow-lg rounded-3 px-4 py-3"
    style="z-index: 1055;">
    <strong>${alertMessage}</strong>
  </div>

  <script>
    document.addEventListener("DOMContentLoaded", function() {
      const alertBox = document.getElementById("alertBox");
      if (alertBox) {
        alertBox.style.display = "block";
        setTimeout(() => {
          alertBox.style.opacity = "0";
          setTimeout(() => alertBox.remove(), 1000);
        }, 3000);
      }
    });
  </script>
</c:if>


<main id="main" class="main">
    
    <div class="pagetitle">
        <h1>Quản lý đơn đặt phòng</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<%=request.getContextPath() %>/home">Trang chủ</a></li>
                <li class="breadcrumb-item active">Quản lý đặt phòng</li>
            </ol>
        </nav>
    </div>

    <section class="section">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
                            <div class="d-flex flex-wrap align-items-center gap-3">
                                <h5 class="card-title mb-0">Danh sách đơn đặt phòng</h5>
                                
                                <form id="filterForm" class="d-flex align-items-center gap-2" action="<%=request.getContextPath() %>/booking-management" method="GET">
                                  <select name="filterStatus" id="filterStatusSelect" class="form-select form-select-sm" onchange="this.form.submit()">
                                      <option value="all" ${empty param.filterStatus || param.filterStatus == 'all' ? 'selected' : ''}>Tất cả trạng thái</option>
                                      <option value="1" ${param.filterStatus == '1' ? 'selected' : ''}> Chờ xác nhận</option>
                                      <option value="2" ${param.filterStatus == '2' ? 'selected' : ''}>Đã xác nhận</option>
                                      <option value="3" ${param.filterStatus == '3' ? 'selected' : ''}>Chờ hủy</option>
                                      <option value="4" ${param.filterStatus == '4' ? 'selected' : ''}>Đã hủy</option>
                                      <option value="5" ${param.filterStatus == '5' ? 'selected' : ''}>Chưa thanh toán</option>
                                      <option value="6" ${param.filterStatus == '6' ? 'selected' : ''}>Đã hoàn thành</option>
                                      <option value="7" ${param.filterStatus == '7' ? 'selected' : ''}>Đã đánh giá</option>
                                  </select>
                                </form>
                            </div>
                            
                            <a 	href="${pageContext.request.contextPath}/admin-booking"
                            	type="button" class="btn btn-primary d-flex align-items-center gap-1">
							    <i class="bi bi-plus-circle"></i>
							    <span>Thêm đơn đặt phòng mới</span>
							  </a>
                        </div>
        
                        <table class="table datatable">
                            <thead>
                                <tr>
                                    <th><b>S</b>TT</th>
                                    <th>Phòng</th> <%-- Sửa ở đây --%>
                                    <th>Ngày đến/đi</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Chức năng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="booking" items="${bookingList}" varStatus="loop">
                                    <c:set var="bsId" value="${booking.bs_id}" />
                                    
                                    <%-- THAY ĐỔI: Tìm tên phòng --%>
                                    <c:set var="roomName" value="Phòng không xác định" />
                                    <c:forEach var="room" items="${roomList}">
                                        <c:if test="${room.room_id == booking.room_id}">
                                            <c:set var="roomName" value="${room.room_name}" />
                                        </c:if>
                                    </c:forEach>
                                    
                                    <%-- THAY ĐỔI: Đặt biến cho trạng thái để dùng lại --%>
                                    <c:choose>
                                        <c:when test="${bsId == 1}"><c:set var="statusText" value="Chờ xác nhận" /><c:set var="statusClass" value="badge bg-warning" /></c:when>
                                        <c:when test="${bsId == 2}"><c:set var="statusText" value="Đã xác nhận" /><c:set var="statusClass" value="badge bg-success" /></c:when>
                                        <c:when test="${bsId == 3}"><c:set var="statusText" value="Chờ hủy" /><c:set var="statusClass" value="badge bg-info" /></c:when>
                                        <c:when test="${bsId == 4}"><c:set var="statusText" value="Đã hủy" /><c:set var="statusClass" value="badge bg-danger" /></c:when>
                                        <c:when test="${bsId == 5}"><c:set var="statusText" value="Chưa thanh toán" /><c:set var="statusClass" value="badge bg-secondary" /></c:when>
                                        <c:when test="${bsId == 6}"><c:set var="statusText" value="Đã hoàn thành" /><c:set var="statusClass" value="badge bg-primary" /></c:when>
                                         <c:when test="${bsId == 7}"><c:set var="statusText" value="Đã đánh giá" /><c:set var="statusClass" value="badge bg-primary" /></c:when>
                                        <c:otherwise><c:set var="statusText" value="Không rõ" /><c:set var="statusClass" value="badge bg-secondary" /></c:otherwise>
                                    </c:choose>
                                    
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        
                                        <td>${roomName}</td> <%-- Sửa ở đây --%>
                                        
                                        <td>
                                            <fmt:formatDate value="${booking.booking_start_date}" pattern="dd/MM/yyyy" /> -
                                            <fmt:formatDate value="${booking.booking_end_date}" pattern="dd/MM/yyyy" />
                                        </td>
                                        <td><fmt:formatNumber value="${booking.booking_total}" pattern="#,##0" />₫</td>
                                        <td>
                                            <span class="${statusClass}">${statusText}</span>
                                        </td>
                                        <td>
                                            <%-- THAY ĐỔI: Thêm data-* cho modal View --%>
                                            <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#viewModal"
                                                data-booking-id="${booking.booking_id}"
                                                data-room-name="${roomName}"
                                                data-dates="<fmt:formatDate value="${booking.booking_start_date}" pattern="dd/MM/yyyy" /> - <fmt:formatDate value="${booking.booking_end_date}" pattern="dd/MM/yyyy" />"
                                                data-total="<fmt:formatNumber value="${booking.booking_total}" pattern="#,##0" />₫"
                                                data-status-text="${statusText}"
                                                data-status-class="${statusClass}"
                                                >
                                                <i class="bi bi-eye"></i>
                                            </button>

                                            <c:if test="${bsId == 1}">
                                                <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#confirmModal"
                                                    data-booking-id="${booking.booking_id}">
                                                    <i class="bi bi-check-circle"></i> 
                                                </button>
                                            </c:if>

                                            <c:if test="${bsId == 1 || bsId == 2 || bsId==5 || bsId==3}">
                                                <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#cancelModal"
                                                    data-booking-id="${booking.booking_id}">
                                                    <i class="bi bi-x-circle"></i> 
                                                </button>
                                            </c:if>
                                            
                                            <c:if test="${bsId !=5}">
												<a
													href="${pageContext.request.contextPath}/export-invoice?id=${booking.booking_id}"
													class="btn btn-warning btn-sm"> <i
													class="bi bi-printer-fill"></i>
												</a>
											</c:if>
                                            
                                            <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal"
                                                data-booking-id="${booking.booking_id}">
                                                <i class="bi bi-trash"></i> 
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        </div>
                </div>

            </div>
        </div>
    </section>
</main>
</body>

<%-- THÊM MỚI: Modal Xem Chi Tiết --%>
<div class="modal fade" id="viewModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Chi tiết đơn đặt phòng <span id="view_booking_id" class="text-primary"></span></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p><strong>Phòng:</strong> <span id="view_room_name"></span></p>
                <p><strong>Ngày đến/đi:</strong> <span id="view_dates"></span></p>
                <p><strong>Tổng tiền:</strong> <span id="view_total" class="text-danger fw-bold"></span></p>
                <p><strong>Trạng thái:</strong> <span id="view_status"></span></p>
                <%-- Thêm các chi tiết khác nếu có, ví dụ: người đặt --%>
                <%-- <p><strong>Người đặt:</strong> <span id="view_user_name"></span></p> --%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="confirmModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="confirmForm" action="<%=request.getContextPath() %>/booking-management" method="GET">
                <input type="hidden" name="id" id="booking_id_confirm" /> 
                <input type="hidden" name="action" value="confirm" />
                <%-- THAY ĐỔI: Thêm filterStatus để giữ bộ lọc --%>
                <input type="hidden" name="filterStatus" value="${param.filterStatus}" />
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận đặt phòng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xác nhận đơn đặt phòng này?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-success">Xác nhận</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="cancelModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="cancelForm" action="<%=request.getContextPath() %>/booking-management" method="GET">
                <input type="hidden" name="id" id="booking_id_cancel" /> 
                <input type="hidden" name="action" value="cancel" />
                <%-- THAY ĐỔI: Thêm filterStatus để giữ bộ lọc --%>
                <input type="hidden" name="filterStatus" value="${param.filterStatus}" />
                <div class="modal-header">
                    <h5 class="modal-title">Hủy đơn đặt phòng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn hủy đơn đặt phòng này?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-warning">Hủy</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="deleteForm" action="<%=request.getContextPath() %>/booking-management" method="GET">
                <input type="hidden" name="id" id="booking_id_delete" /> 
                <input type="hidden" name="action" value="delete" />
                <%-- THAY ĐỔI: Thêm filterStatus để giữ bộ lọc --%>
                <input type="hidden" name="filterStatus" value="${param.filterStatus}" />
                <div class="modal-header">
                    <h5 class="modal-title">Xóa đơn đặt phòng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa đơn đặt phòng này ?.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </div>
            </form>
        </div>
    </div>
</div>

 <!-- Vendor JS Files -->
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/chart.js/chart.umd.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/echarts/echarts.min.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/quill/quill.js"></script>
 <%--  <script src="${pageContext.request.contextPath}/admin/assets/vendor/simple-datatables/simple-datatables.js"></script> --%>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="${pageContext.request.contextPath}/admin/assets/js/main${pageContext.request.contextPath}/admin.js"></script>
  
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Khởi tạo Datatable
        const datatables = document.querySelectorAll('.datatable');
        if (datatables) {
            datatables.forEach(dt => {
                new simpleDatatables.DataTable(dt, {
                    perPageSelect: [5, 10, 15, ["Tất cả", -1]],
                    labels: {
                        placeholder: "Tìm kiếm...",
                        perPage: "{select} dòng mỗi trang",
                        noRows: "Không có dữ liệu",
                        info: "Hiển thị {start} đến {end} trong tổng {rows} dòng",
                        noResults: "Không tìm thấy kết quả phù hợp"
                    }
                });
            });
        }
        
        // THÊM MỚI: Event listener cho Modal View
        document.getElementById('viewModal')?.addEventListener('show.bs.modal', function (event) {
            let button = event.relatedTarget;
            this.querySelector('#view_booking_id').textContent = '#' + button.getAttribute('data-booking-id');
            this.querySelector('#view_room_name').textContent = button.getAttribute('data-room-name');
            this.querySelector('#view_dates').textContent = button.getAttribute('data-dates');
            this.querySelector('#view_total').textContent = button.getAttribute('data-total');
            
            let statusSpan = this.querySelector('#view_status');
            statusSpan.textContent = button.getAttribute('data-status-text');
            // Xóa class cũ, thêm class mới
            statusSpan.className = button.getAttribute('data-status-class'); 
        });

        // Event listener cho Modal Xác nhận
        document.getElementById('confirmModal')?.addEventListener('show.bs.modal', function (event) {
            let button = event.relatedTarget;
            this.querySelector('#booking_id_confirm').value = button.getAttribute('data-booking-id');
        });

        // Event listener cho Modal Hủy
        document.getElementById('cancelModal')?.addEventListener('show.bs.modal', function (event) {
            let button = event.relatedTarget;
            this.querySelector('#booking_id_cancel').value = button.getAttribute('data-booking-id');
        });
        
        // Event listener cho Modal Xóa
        document.getElementById('deleteModal')?.addEventListener('show.bs.modal', function (event) {
            let button = event.relatedTarget;
            this.querySelector('#booking_id_delete').value = button.getAttribute('data-booking-id');
        });
    });
</script>


</html>