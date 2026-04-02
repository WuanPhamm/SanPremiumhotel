<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">


<%@include file="/admin/ad_header.jsp"%>
	
<%@include file="/admin/ad_sidebar.jsp"%>	
 
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
			<h1>Quản lý tài khoản</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="<%=request.getContextPath() %>/home">Trang chủ</a></li>
					<li class="breadcrumb-item active">Quản lý tài khoản</li>
				</ol>
			</nav>
		</div>

		<section class="section">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
							
							  <!-- Nhóm bên trái: tiêu đề, lọc và upload -->
							  <div class="d-flex flex-wrap align-items-center gap-3">
							
							    <!-- Tiêu đề -->
							    <h5 class="card-title mb-0">Danh sách tài khoản</h5>
							    
							
							    <!-- Form lọc tài khoản -->
							    <form id="filterForm" class="d-flex align-items-center gap-2">
							      <select name="filter" id="filterSelect" class="form-select form-select-sm" onchange="filterByRole()">
									  <option value="all" ${filter == 'all' ? 'selected' : ''}>Tất cả</option>
									  <option value="admin" ${filter == 'admin' ? 'selected' : ''}>Người quản trị</option>
									  <option value="cus" ${filter == 'cus' ? 'selected' : ''}>Khách hàng</option>
									  <option value="tam" ${filter == 'tam' ? 'selected' : ''}>Bị khóa</option>
								   </select>
							    </form>
							    
							
							    <!-- Form upload Excel -->
							   <!--  <form action="accounts" method="post" enctype="multipart/form-data" class="d-flex align-items-center gap-2">
							    	<input type="hidden" name="action" value="addbyexcel"/>
							     	 <label for="excelFile" class="form-label mb-0">Thêm bằng file Excel:</label>
							      		<input type="file" name="file" id="excelFile" class="form-control form-control-sm" accept=".xlsx" />
							      	<button type="submit" class="btn btn-sm btn-primary">Thêm</button>
							    </form> -->
							
							  </div>
							
							  <!-- Nút thêm tài khoản mới -->
							  <button type="button" class="btn btn-primary d-flex align-items-center gap-1"
							    data-bs-toggle="modal" data-bs-target="#addModal">
							    <i class="bi bi-plus-circle"></i>
							    <span>Thêm tài khoản mới</span>
							  </button>
							</div>
			
			 				<!-- Form upload by sheet link -->
							<!-- <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
							    <form action="accounts" method="post" class="d-flex align-items-center gap-2 flex-grow-1">
							        <input type="hidden" name="action" value="addbysheet"/>
							        <label for="linkInput" class="form-label mb-0 flex-shrink-0">Thêm bằng link Sheet:</label>
							        <input type="text" id="linkInput" name="linksheet" placeholder="https://docs.google.com/spreadsheets/d/e/xxx/pub?output=csv" 
							        class="form-control form-control-sm flex-grow-1" style="min-width: 200px;" />
							        <button type="submit" class="btn btn-sm btn-primary">Thêm</button>
							    </form>
							</div> -->

							<!-- Table with stripped rows -->
							<table class="table datatable">
								<thead>
									<tr>
										<th><b>S</b>TT</th>
										<th>Tên đăng nhập</th>
										<th>Vai trò</th>
										<th>Chức năng</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="acc" items="${list_acc}" varStatus="loop">
								        <tr>
								            <td>${loop.index + 1}</td>
								            <td>${acc.acc_username}</td>
								            <td>
								                <c:choose>
								                    <c:when test="${acc.role_id == 1}">Người quản trị</c:when>
								                    <c:otherwise>Khách hàng</c:otherwise>
								                </c:choose>
								            </td>
								            <td>
								            	<button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#viewModal"
								                    data-account-id="${acc.acc_id}"
								                    data-account-username="${acc.acc_username}"
								                    data-account-password="Secured"
								                    data-account-status="${acc.acc_status}"
								                    data-account-created-at="${acc.acc_created_at}"
								                    data-account-updated-at="${acc.acc_updated_at}"
								                    data-account-last-login-at="${acc.acc_last_login_at}"
								                    data-account-login-time="${acc.acc_login_time}"
								                    data-role-id="${acc.role_id}">
								                    <i class="bi bi-eye"></i>
								                </button>
								                <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal"
								                    data-account-id="${acc.acc_id}"
								                    data-account-username="${acc.acc_username}"
								                    data-account-password="${acc.acc_password}"
								                    data-account-status="${acc.acc_status}"
								                    data-account-created-at="${acc.acc_created_at}"
								                    data-account-updated-at="${acc.acc_updated_at}"
								                    data-account-last-login-at="${acc.acc_last_login_at}"
								                    data-account-login-time="${acc.acc_login_time}"
								                    data-role-id="${acc.role_id}">
								                    <i class="bi bi-pencil"></i>
								                </button>
								            	<c:choose>
								                    <c:when test="${acc.acc_status == 1}">
										                
										                <button class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModalTam"
										                    data-account-id="${acc.acc_id}"
										                    data-account-username="${acc.acc_username}">
										                    <i class="bi bi-lock"></i>
										                </button>
										                
										                <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal"
										                    data-account-id="${acc.acc_id}"
										                    data-account-username="${acc.acc_username}">
										                    <i class="bi bi-trash"></i>
										                </button>
								                    </c:when>
								                    <c:when test="${acc.acc_status == 0}">
								                    	<button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal"
										                    data-account-id="${acc.acc_id}"
										                    data-account-username="${acc.acc_username}">
										                    <i class="bi bi-trash"></i>
										                </button>
										                <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModalKP"
										                    data-account-id="${acc.acc_id}"
										                    data-account-username="${acc.acc_username}">
										                    <i class="bi bi-arrow-counterclockwise"></i>
										                </button>
								                    </c:when>
								                </c:choose>
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
  </body>

	<!-- Add Modal -->
	<div class="modal fade" id="addModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Thêm tài khoản mới</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form id="addForm" action="accounts" method="post">
						<input type="hidden" name="action" value="add" />
						<div class="mb-3">
							<label class="form-label">Tên đăng nhập</label> <input
								type="text" class="form-control" name="username" required>
						</div>
						<div class="mb-3">
							<label class="form-label">Mật khẩu</label> <input type="password"
								class="form-control" name="password" required>
						</div>
						<div class="mb-3">
							<label class="form-label">Vai trò</label> <select
								class="form-select" name="role_id" required>
								<option value="1">Người quản trị</option>
								<option value="2">Khách hàng</option>
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Đóng</button>
					<button type="submit" form="addForm" class="btn btn-primary">Lưu</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="viewModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content shadow">
      <div class="modal-header">
        <h5 class="modal-title fw-bold">Chi tiết tài khoản</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        <div class="container-fluid">

          <div class="row gy-3">

            <div class="col-md-6">
              <strong class="d-block">Tên đăng nhập:</strong>
              <p class="account_username mb-0"></p>
            </div>

            <div class="col-md-6">
              <strong class="d-block">Mật khẩu:</strong>
              <p class="account_password mb-0"></p>
            </div>

            <div class="col-md-6">
              <strong class="d-block">Vai trò:</strong>
              <p class="mb-0"><span class="role_id badge"></span></p>
            </div>

            <div class="col-md-6">
              <strong class="d-block">Ngày tạo:</strong>
              <p class="account_created_at mb-0"></p>
            </div>

            <div class="col-md-6">
              <strong class="d-block">Ngày cập nhật:</strong>
              <p class="account_updated_at mb-0"></p>
            </div>

            <div class="col-md-6">
              <strong class="d-block">Lần đăng nhập gần nhất:</strong>
              <p class="account_last_login_at mb-0"></p>
            </div>

            <div class="col-md-6">
              <strong class="d-block">Số lần đăng nhập:</strong>
              <p class="account_login_time mb-0"></p>
            </div>

            <div class="col-md-6">
              <strong class="d-block">Trạng thái:</strong>
              <p class="mb-0"><span class="account_status badge"></span></p>
            </div>

          </div>

        </div>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
      </div>
    </div>
  </div>
</div>
	

	<!-- Edit Modal -->
	<div class="modal fade" id="editModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Chỉnh sửa tài khoản</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form id="editForm" action="accounts" method="post">
						<input type="hidden" name="account_id" id="account_id" /> 
						<input type="hidden" name="action" value="edit" />
						<div class="mb-3">
							<label class="form-label">Tên đăng nhập</label> <input
								type="text" class="form-control" name="account_username" required
								disabled>
						</div>
						<div class="mb-3">
							<label class="form-label">Mật khẩu</label> <input type="password"
								class="form-control" name="account_password" required disabled>
						</div>
						<div class="mb-3">
							<label class="form-label">Vai trò</label> <select
								class="form-select" name="role_id" >
								<option value="1">Admin</option>
								<option value="2">Khách hàng</option>
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Đóng</button>
					<button type="submit" form="editForm" class="btn btn-primary">Lưu
						thay đổi</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Delete vinh vien Modal -->
	<div class="modal fade" id="deleteModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="deleteForm3" action="accounts" method="post">
					<!-- Hidden field để truyền username hoặc id -->
					<input type="hidden" name="account_id" id="account_id_delete" /> <input type="hidden"
						name="action" value="delete" />
					<div class="modal-header">
						<h5 class="modal-title">Xác nhận xóa tài khoản</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<p>Bạn có chắc chắn muốn xóa tài khoản này?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-danger">Xóa</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- Delete tam Modal -->
	<div class="modal fade" id="deleteModalTam" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="deleteForm1" action="accounts" method="post">
					<!-- Hidden field để truyền username hoặc id -->
					<input type="hidden" name="account_id" id="account_id_tam" /> <input type="hidden"
						name="action" value="delete_tam" />
					<div class="modal-header">
						<h5 class="modal-title">Xác nhận khóa tài khoản</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<p>Bạn có chắc chắn khóa tài khoản này?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-danger">Khóa</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- Khoi phuc Modal -->
	<div class="modal fade" id="deleteModalKP" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="deleteForm2" action="accounts" method="post">
					<!-- Hidden field để truyền username hoặc id -->
					<input type="hidden" name="account_id" id="account_id_kp" /> <input type="hidden"
						name="action" value="khoiphuc" />
					<div class="modal-header">
						<h5 class="modal-title">Xác nhận khôi phục tài khoản</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<p>Bạn có chắc chắn muốn khôi phục tài khoản này?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-danger">Khôi phục</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script>
		function filterByRole() {
			  const filterValue = document.getElementById("filterSelect").value;
	
			  fetch("accounts?filter=" + filterValue)
			    .then(response => response.text())
			    .then(html => {
			      document.open();
			      document.write(html);
			      document.close();
			    })
			    .catch(err => console.error(err));
			  document.getElementById("filterSelect").value = filterValue;
			}
	</script>

	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function () {
		    // Modal Edit
		    document.getElementById('editModal')?.addEventListener('show.bs.modal', function (event) {
		        let button = event.relatedTarget;
		        this.querySelector('input[name="account_username"]').value = button.getAttribute('data-account-username');
		        this.querySelector('input[name="account_password"]').value = button.getAttribute('data-account-password');
		        this.querySelector('select[name="role_id"]').value = button.getAttribute('data-role-id');
		        this.querySelector('input[name="account_id"]').value = button.getAttribute('data-account-id');
		    });
	
		 // Modal View
		    document.getElementById('viewModal')?.addEventListener('show.bs.modal', function (event) {
		        let button = event.relatedTarget;

		        this.querySelector('.account_username').textContent = button.getAttribute('data-account-username');
		        this.querySelector('.account_password').textContent = button.getAttribute('data-account-password');
		        this.querySelector('.account_created_at').textContent = button.getAttribute('data-account-created-at');
		        this.querySelector('.account_updated_at').textContent = button.getAttribute('data-account-updated-at');
		        this.querySelector('.account_login_time').textContent = button.getAttribute('data-account-login-time');
		        this.querySelector('.account_last_login_at').textContent = button.getAttribute('data-account-last-login-at');

		        // ========= Vai trò =========
		        const roleVal = button.getAttribute('data-role-id');
		        const roleEl = this.querySelector('.role_id');
		        roleEl.textContent = (roleVal == '1') ? 'Quản trị viên' : 'Người dùng';
		        roleEl.className = 'role_id badge ' + (roleVal == '1' ? 'bg-primary' : 'bg-secondary');

		        // ========= Trạng thái =========
		        const statusVal = button.getAttribute('data-account-status');
		        const statusEl = this.querySelector('.account_status');
		        statusEl.textContent = (statusVal == '1') ? 'Hoạt động' : 'Bị khóa';
		        statusEl.className = 'account_status badge ' + (statusVal == '1' ? 'bg-success' : 'bg-danger');
		    });

	
		    // Xóa vĩnh viễn
		    document.getElementById('deleteModal')?.addEventListener('show.bs.modal', function (event) {
		        this.querySelector('#account_id_delete').value = event.relatedTarget.getAttribute('data-account-id');
		    });
	
		    // Xóa tạm thời
		    document.getElementById('deleteModalTam')?.addEventListener('show.bs.modal', function (event) {
		        this.querySelector('#account_id_tam').value = event.relatedTarget.getAttribute('data-account-id');
		    });
	
		    // Khôi phục
		    document.getElementById('deleteModalKP')?.addEventListener('show.bs.modal', function (event) {
		        this.querySelector('#account_id_kp').value = event.relatedTarget.getAttribute('data-account-id');
		    });
		});			
	</script>
  
  
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
  

  <!--  <script>
    document.addEventListener("DOMContentLoaded", function () {
        const table = document.querySelector(".datatable");
        if (table) {
            new simpleDatatables.DataTable(table, {
                searchable: true,
                fixedHeight: true,
                perPage: 10
            });
        }
    });
</script>
 -->
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

   
</body>

</html>