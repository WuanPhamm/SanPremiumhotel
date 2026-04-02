<%@page import="model.room"%>
<%@page import="model.customer"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
	<%@include file="/admin/ad_header.jsp"%>
	<%@include file="/admin/ad_sidebar.jsp"%>	
<body>

<c:if test="${not empty param.message}">
  <div id="alertBox" class="alert 
    ${param.message eq 'success'  ? 'alert-success' : 'alert-danger'} 
    position-fixed top-0 start-50 translate-middle-x mt-3 shadow-lg rounded-3 px-4 py-3"
    style="z-index: 1055; display: none;">
    <strong>
      <c:choose>
        <c:when test="${param.message eq 'success'}">Thao tác thành công!</c:when>
        <c:when test="${param.message eq 'fail'}">Thao tác thất bại!</c:when>
        
      </c:choose>
    </strong>
  </div>

  <script>
    document.addEventListener("DOMContentLoaded", function() {
      const alertBox = document.getElementById("alertBox");
      alertBox.style.display = "block";
      setTimeout(() => {
        alertBox.style.opacity = "0";
        setTimeout(() => alertBox.remove(), 1000);
      }, 2500);
    });
  </script>
</c:if>
	<main id="main" class="main">
		
		<div class="pagetitle">
			<h1>Quản lý tầng</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
					<li class="breadcrumb-item active">Quản lý tầng</li>
				</ol>
			</nav>
		</div>

		<section class="section">
		    <div class="row">
		        <div class="col-lg-12">
		            <div class="card">
		                <div class="card-body">
		                	<div class="d-flex justify-content-between align-items-center mt-0">
		                        <div class="d-flex align-items-center gap-2">
		                            <h5 class="card-title mb-0">Danh sách tầng</h5>
		                        </div>
		                    </div>
		                    <!-- Table with stripped rows -->
		                    <table class="table datatable">
		                        <thead>
		                            <tr>
		                                <th><b>S</b>TT</th>
		                                <th>Tầng</th>
		                                <th>Mô tả</th>
		                                <th>Chức năng</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            <c:forEach var="f" items="${list_floor_all}" varStatus="loop">
		                                <tr>
		                                    <td>${loop.index + 1}</td>
		                                    <td>${f.floor_name}</td>
		                                    <td>${f.floor_description}</td>
		                                    <td>
		                                        <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#viewModal"
		                                            data-floor-id="${f.floor_id}"
		                                            data-floor-name="${f.floor_name}"
		                                            data-floor-description="${f.floor_description}">
		                                            <i class="bi bi-eye"></i>
		                                        </button>
		
		                                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal"
		                                            data-floor-id="${f.floor_id}"
		                                            data-floor-name="${f.floor_name}"
		                                            data-floor-description="${f.floor_description}">
		                                            <i class="bi bi-pencil"></i>
		                                        </button>
		                                    </td>
		                                </tr>
		                            </c:forEach>
		                        </tbody>
		                    </table>
		                    <!-- End Table with stripped rows -->
		
		                </div>
		            </div>
		        </div>
		    </div>
		</section>

	</main>

	<!-- View Modal -->
	<div class="modal fade" id="viewModal" tabindex="-1">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">Chi tiết tầng</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	            </div>
	            <div class="modal-body">
	                <div class="mb-3">
	                    <strong>Tên tầng: </strong>
	                    <p class="floor_name"></p>
	                </div>	                
	                <div class="mb-3">
	                    <strong>Mô tả: </strong>
	                    <p class="floor_description"></p>
	                </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
	            </div>
	        </div>
	    </div>
	</div>



	<!-- Edit Customer Modal -->
	<div class="modal fade" id="editModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Chỉnh sửa khách hàng</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form id="editForm" action="floors" method="post">
						<input type="hidden" name="floor_id" />
						<input type="hidden" name="action" value="edit" />
	
						<div class="mb-3">
							<label class="form-label">Tên tầng</label>
							<input type="text" class="form-control" name="floor_name" required disabled/>
						</div>
						
						<div class="mb-3">
							<label class="form-label">Mô tả</label>
							<textarea class="form-control" name="floor_description" required></textarea>
						</div>						
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
					<button type="submit" form="editForm" class="btn btn-primary">Lưu thay đổi</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var editModal = document.getElementById('editModal');
		editModal.addEventListener('show.bs.modal', function(event) {
	    var button = event.relatedTarget;

	    var floor_id = button.getAttribute('data-floor-id');
	    var floor_name = button.getAttribute('data-floor-name');
	    var floor_description = button.getAttribute('data-floor-description');


	    var modal = this;
	    modal.querySelector('input[name="floor_id"]').value = floor_id;
	    modal.querySelector('input[name="floor_name"]').value = floor_name;
	    modal.querySelector('textarea[name="floor_description"]').value = floor_description;
	});


		const viewModal = document.getElementById('viewModal');
		viewModal.addEventListener('show.bs.modal', function(event) {
		    const button = event.relatedTarget;

		    // Cập nhật thông tin cho các phần tử trong modal
		    viewModal.querySelector('.floor_name').textContent = button.getAttribute('data-floor-name');
		    viewModal.querySelector('.floor_description').textContent = button.getAttribute('data-floor-description');		    			    
			});
	</script>

</body>
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
	  const datatables = document.querySelectorAll('.datatable');
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
	});
</script>
</html>
