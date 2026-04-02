<%@page import="model.room"%>
<%@page import="model.customer"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
			<h1>Quản lý phòng</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
					<li class="breadcrumb-item active">Quản lý phòng</li>
				</ol>
			</nav>
		</div>


		<div class="card mt-4">
			<div class="card-body">
				<h5 class="card-title">Thêm phòng bằng file Excel</h5>
				<form action="rooms" method="post" enctype="multipart/form-data">
					<input type="hidden" name="excel_action" value="upload_excel" />
					<div class="row">
						<div class="col-md-8">
							<input type="file" name="excel_file" class="form-control"
								accept=".xlsx, .xls" required />
						</div>
						<div class="col-md-4">
							<button type="submit" class="btn btn-success w-100">
								<i class="bi bi-upload"></i> Tải lên và Thêm
							</button>
						</div>
					</div>
					<p class="mt-2 text-muted small">File Excel phải có định dạng
						các cột: Tên phòng, Mã loại phòng, Mã trạng thái, Mã tầng, Số lần đặt.</p>
				</form>
			</div>
		</div>
		
		<div class="card mt-4">
			<div class="card-body">
				<h5 class="card-title">Thêm phòng bằng Google Sheet (CSV Link)</h5>
				<form action="rooms" method="post">
					<input type="hidden" name="action" value="upload_sheet_link" />
					<div class="row">
						<div class="col-md-8">
							<input type="url" name="sheet_link" class="form-control"
								placeholder="Dán link CSV đã xuất bản của Google Sheet..." required />
						</div>
						<div class="col-md-4">
							<button type="submit" class="btn btn-info w-100">
								<i class="bi bi-link-45deg"></i> Lấy dữ liệu và Thêm
							</button>
						</div>
					</div>
					<p class="mt-2 text-muted small">
						Hướng dẫn: Mở Google Sheet > <strong>Tệp</strong> > <strong>Chia sẻ</strong> > <strong>Xuất bản lên web</strong>.
						Chọn trang tính, chọn định dạng <strong>"Giá trị được phân cách bằng dấu phẩy (.csv)"</strong>,
						nhấn <strong>Xuất bản</strong> và sao chép link dán vào đây.
						Sheet phải có 5 cột (giống file Excel).
					</p>
				</form>
			</div>
		</div>

		<section class="section">
		    <div class="row">
		        <div class="col-lg-12">
		            <div class="card">
		                <div class="card-body">
		                	<div class="d-flex justify-content-between align-items-center mt-0">
		                        <div class="d-flex align-items-center gap-2">
		                            <h5 class="card-title mb-0">Danh sách phòng</h5>
		                        </div>
		                    </div>
		                    <form action="rooms" method="get" class="mb-3">
		                        <div class="row g-3 align-items-end">
									<div class="col-md-3">
										<label class="form-label">Loại phòng</label> <select
											name="rt_id" class="form-select">
											<option value="all" ${param.rt_id == 'all' ? 'selected' : ''}>Tất
												cả</option>
											<c:forEach var="rt" items="${list_room_type}">
												<option value="${rt.rt_id}"
													${param.rt_id == fn:escapeXml(rt.rt_id) ? 'selected' : ''}>
													${rt.rt_name}</option>
											</c:forEach>
										</select>
									</div>

									<div class="col-md-3">
		                                <label class="form-label">Trạng thái</label>
		                                <select name="rs_id" class="form-select">
		                                    <option value="all">Tất cả</option>
		                                    <option value="1" ${param.rs_id == '1' ? 'selected' : ''}>Đang trống</option>
		                                    <option value="2" ${param.rs_id == '2' ? 'selected' : ''}>Đang được đặt</option>
		                                    <option value="3" ${param.rs_id == '3' ? 'selected' : ''}>Đang bảo trì</option>
		                                </select>
		                            </div>
		
		                            <div class="col-md-3">
		                                <label class="form-label">Tầng</label>
		                                <select name="floor_id" class="form-select">
		                                    <option value="all">Tất cả</option>
		                                    <c:forEach var= "fl" items="${floor_list }">
		                                    	<option value="${fl.floor_id }">${fl.floor_name}</option>
		                                    </c:forEach>
		                                </select>
		                            </div>
		
		                            <div class="col-md-3 d-flex align-items-end gap-2">
		                                <button type="submit" class="btn btn-primary">Lọc</button>
		                                <button type="submit" name="action" value="export_excel" class="btn btn-success w-100">
		                                	<i class="bi bi-file-earmark-excel"></i> Xuất file excel
		                                </button>
		                                
		                            </div>
		                        </div>
		                    </form>
		                    <table class="table datatable">
		                        <thead>
		                            <tr>
		                                <th><b>S</b>TT</th>
		                                <th>Phòng</th>
		                                <th>Tầng</th>
		                                <th>Loại phòng</th>
		                                <th>Trạng thái</th>
		                                <th>Chức năng</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            <c:forEach var="r" items="${list_room_all}" varStatus="loop">
		                                <tr>
		                                    <td>${loop.index + 1}</td>
		                                    <td>${r.room_name}</td>
		                                    <td>${r.floor_id}</td>
											<td><c:set var="roomTypeName" value="Không xác định" />
												<c:forEach var="rt" items="${list_room_type}">
													<c:if test="${r.rt_id == rt.rt_id}">
														<c:set var="roomTypeName" value="${rt.rt_name}" />
													</c:if>
												</c:forEach> ${roomTypeName}</td>
											<td>
		                                        <c:choose>
		                                            <c:when test="${r.rs_id == 1}"><p class="text-success">Đang trống</p></c:when>
		                                            <c:when test="${r.rs_id == 2}"><p class="text-danger">Đang được đặt</p></c:when>
		                                            <c:when test="${r.rs_id == 3}"><p class="text-warning">Đang bảo trì</p></c:when>
		                                            <c:otherwise>Khác</c:otherwise>
		                                        </c:choose>
		                                    </td>
		                                    <td>
		                                        <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#viewModal"
		                                            data-room-id="${r.room_id}"
		                                            data-room-name="${r.room_name}"
		                                            data-room-booking-time="${r.room_booking_time}"
		                                            data-room-floor-id="${r.floor_id}"
		                                            data-room-rt-id="${r.rt_id}"
		                                            data-room-rs-id="${r.rs_id}">
		                                            <i class="bi bi-eye"></i>
		                                        </button>
		
		                                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal"
		                                            data-room-id="${r.room_id}"
		                                            data-room-name="${r.room_name}"
		                                            data-room-booking-time="${r.room_booking_time}"
		                                            data-room-floor-id="${r.floor_id}"
		                                            data-room-rt-id="${r.rt_id}"
		                                            data-room-rs-id="${r.rs_id}">
		                                            <i class="bi bi-pencil"></i>
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

	<div class="modal fade" id="viewModal" tabindex="-1">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">Chi tiết phòng</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	            </div>
	            <div class="modal-body">
	                <div class="mb-3">
	                    <strong>Tên phòng: </strong>
	                    <p class="room_name"></p>
	                </div>	                
	                
	                 <div class="mb-3">
	                    <strong>Loại phòng: </strong>
	                    <p class="room_rt_id"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Trạng thái: </strong>
	                    <p class="room_rs_id"></p>
	                </div>
	                	               
	                <div class="mb-3">
	                    <strong>Tầng: </strong>
	                    <p class="room_floor_id"></p>
	                </div>
	                
	                <div class="mb-3">
	                    <strong>Số lần đặt: </strong>
	                    <p class="room_booking_time"></p>
	                </div>
	               
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
	            </div>
	        </div>
	    </div>
	</div>



	<div class="modal fade" id="editModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Chỉnh sửa phòng</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form id="editForm" action="rooms" method="post">
						<input type="hidden" name="room_id" />
						<input type="hidden" name="action" value="edit" />
	
						<div class="mb-3">
							<label class="form-label">Tên phòng</label>
							<input type="text" class="form-control" name="room_name" required disabled/>
						</div>
						
						<div class="mb-3">
							<label class="form-label">Loại phòng</label> 
							<select class="form-select" name="rt_id" required>
								<c:forEach var="rt" items="${list_room_type}">
									<option value="${rt.rt_id}">${rt.rt_name}</option>
								</c:forEach>
							</select>
						</div>
						
						<div class="mb-3">
							<label class="form-label">Số lần đặt</label>
							<input type="text" class="form-control" name="room_booking_time" required disabled/>
						</div>
						
						<div class="mb-3">
							<label class="form-label">Tầng</label>
							<input type="text" class="form-control" name="floor_id" required disabled/>
						</div>
						
						<div class="mb-3">
							<label class="form-label">Trạng thái</label> <select
								class="form-select" name="rs_id" required>
								<option value="1">Đang trống</option>
								<option value="2">Đang được đặt</option>
								<option value="3">Đang bảo trì</option>
							</select>
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
		// Lấy danh sách loại phòng từ JSP để dùng trong JS
		const roomTypes = [
		    <c:forEach var="rt" items="${list_room_type}">
		        {id: '${rt.rt_id}', name: '${rt.rt_name}'},
		    </c:forEach>
		];
		
		var editModal = document.getElementById('editModal');
		editModal.addEventListener('show.bs.modal', function(event) {
	    var button = event.relatedTarget;

	    // Lấy dữ liệu từ data attributes
	    var room_id = button.getAttribute('data-room-id');
	    var room_name = button.getAttribute('data-room-name');
	    var room_booking_time = button.getAttribute('data-room-booking-time');
	    var room_floor_id = button.getAttribute('data-room-floor-id');
	    var room_rt_id = button.getAttribute('data-room-rt-id');
	    var room_rs_id = button.getAttribute('data-room-rs-id');


	    var modal = this;
	    modal.querySelector('input[name="room_id"]').value = room_id;
	    modal.querySelector('input[name="room_name"]').value = room_name;
	    // Đã bỏ modal.querySelector('textarea[name="room_description"]').value = room_description || '';
	    // Đã bỏ modal.querySelector('input[name="room_view"]').value = room_view || '';
	    modal.querySelector('input[name="room_booking_time"]').value = room_booking_time;
	    modal.querySelector('input[name="floor_id"]').value = room_floor_id;
	    modal.querySelector('select[name="rt_id"]').value = room_rt_id;
	    modal.querySelector('select[name="rs_id"]').value = room_rs_id;
	});


		const viewModal = document.getElementById('viewModal');
		viewModal.addEventListener('show.bs.modal', function(event) {
		    const button = event.relatedTarget;

		    // Hàm tìm tên loại phòng từ ID
		    const getRoomTypeName = (rtId) => {
		        const rt = roomTypes.find(type => type.id === rtId);
		        return rt ? rt.name : 'Không xác định';
		    };

		    const rsMap = {
		    	    '1': 'Đang trống',
		    	    '2': 'Đang được đặt',
		    	    '3': 'Đang bảo trì'
		    	};

		    	const rtId = button.getAttribute('data-room-rt-id');
		    	const rsId = button.getAttribute('data-room-rs-id');

		    // Cập nhật thông tin cho các phần tử trong modal
		    viewModal.querySelector('.room_name').textContent = button.getAttribute('data-room-name');
		    viewModal.querySelector('.room_booking_time').textContent = button.getAttribute('data-room-booking-time');
		    viewModal.querySelector('.room_floor_id').textContent = button.getAttribute('data-room-floor-id');
		    // Đã bỏ viewModal.querySelector('.room_description').textContent = ...
		    // Đã bỏ viewModal.querySelector('.room_view').textContent = ...
		    
		    // Cập nhật Loại phòng từ danh sách động
		    viewModal.querySelector('.room_rt_id').textContent = getRoomTypeName(rtId) || 'Không xác định';
		    viewModal.querySelector('.room_rs_id').textContent = rsMap[rsId] || 'Không xác định';
		    			    
			});
	</script>

</body>

 <script src="${pageContext.request.contextPath}/admin/assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/chart.js/chart.umd.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/echarts/echarts.min.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/quill/quill.js"></script>
 <%--  <script src="${pageContext.request.contextPath}/admin/assets/vendor/simple-datatables/simple-datatables.js"></script> --%>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/php-email-form/validate.js"></script>

  <script src="${pageContext.request.contextPath}/admin/assets/js/main.js"></script>
  
  
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
	  
const params = new URLSearchParams(window.location.search);
	  
	  const rtId = params.get('rt_id');
	  if (rtId) {
	    document.querySelector('select[name="rt_id"]').value = rtId;
	  }

	  const rsId = params.get('rs_id');
	  if (rsId) {
	    document.querySelector('select[name="rs_id"]').value = rsId;
	  }
	  
	  const floorId = params.get('floor_id');
	  if (floorId) {
	    document.querySelector('select[name="floor_id"]').value = floorId;
	  }
	});
</script>
</html>