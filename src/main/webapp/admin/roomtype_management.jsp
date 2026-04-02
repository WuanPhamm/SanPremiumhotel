<%@page import="model.room_type"%>
<%@page import="java.util.ArrayList"%>
<%-- Các import cũ không cần thiết đã được loại bỏ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<%@include file="/admin/ad_header.jsp"%>
<%@include file="/admin/ad_sidebar.jsp"%>
<body>

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>Quản lý loại phòng</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
					<li class="breadcrumb-item active">Quản lý loại phòng</li>
				</ol>
			</nav>
		</div>

		<section class="section">
		
			<c:if test="${not empty param.message}">
				<div class="row">
					<div class="col-lg-12">
						<c:choose>
							<c:when test="${param.message == 'success'}">
								<div class="alert alert-success alert-dismissible fade show" role="alert">
									<i class="bi bi-check-circle-fill me-2"></i>
									<strong>Thao tác thành công!</strong> 
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
								</div>
							</c:when>
							<c:when test="${param.message == 'fail'}">
								<div class="alert alert-danger alert-dismissible fade show" role="alert">
									<i class="bi bi-exclamation-triangle-fill me-2"></i>
									<strong>Thất bại!</strong> Có lỗi xảy ra, vui lòng thử lại.
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
								</div>
							</c:when>
							<c:when test="${param.message == 'invalid_id' || param.message == 'missing_id'}">
								 <div class="alert alert-warning alert-dismissible fade show" role="alert">
									<i class="bi bi-exclamation-triangle-fill me-2"></i>
									<strong>Lỗi:</strong> ID không hợp lệ hoặc bị thiếu.
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
								</div>
							</c:when>
							<c:when test="${param.message == 'uploadfail'}">
								 <div class="alert alert-danger alert-dismissible fade show" role="alert">
									<i class="bi bi-exclamation-triangle-fill me-2"></i>
									<strong>Lỗi:</strong> Tải tệp lên thất bại.
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
								</div>
							</c:when>
							 <c:when test="${param.message == 'invaliddata'}">
								 <div class="alert alert-warning alert-dismissible fade show" role="alert">
									<i class="bi bi-exclamation-triangle-fill me-2"></i>
									<strong>Lỗi:</strong> Dữ liệu nhập vào không hợp lệ (ví dụ: giá, số lượng).
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
								</div>
							</c:when>
						</c:choose>
					</div>
				</div>
			</c:if>
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div
								class="d-flex justify-content-between align-items-center mt-0">
								<div class="d-flex align-items-center gap-2">
									<h5 class="card-title mb-0">Danh sách loại phòng</h5>
								</div>
								<button class="btn btn-primary btn-sm" data-bs-toggle="modal"
									data-bs-target="#addModal">
									<i class="bi bi-plus"></i> Thêm loại phòng mới
								</button>
							</div>
							<table class="table datatable">
								<thead>
									<tr>
										<th><b>S</b>TT</th>
										<th>Loại phòng</th>
										<th>Giá</th>
										<th>Số lượng người</th>

										<th>Chức năng</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="rt" items="${list_room_type_all}"
										varStatus="loop">
										<tr>
											<td>${loop.index + 1}</td>
											<td>${rt.rt_name}</td>
											<td><fmt:formatNumber value="${rt.rt_price}"
													type="number" /> VNĐ</td>
											<td>${rt.rt_max_people}</td>
											<td>
												<button class="btn btn-info btn-sm" data-bs-toggle="modal"
													data-bs-target="#viewModal" data-rt-id="${rt.rt_id}"
													data-rt-name="${rt.rt_name}"
													data-rt-description="${rt.rt_description}"
													data-rt-price="${rt.rt_price}"
													data-rt-max-people="${rt.rt_max_people}"
													data-rt-area="${rt.rt_area}"
													data-rt-special="${rt.rt_special}"
													data-rt-img-url="${rt.rt_img_url}">
													<i class="bi bi-eye"></i>
												</button>

												<button class="btn btn-warning btn-sm"
													data-bs-toggle="modal" data-bs-target="#editModal"
													data-rt-id="${rt.rt_id}" data-rt-name="${rt.rt_name}"
													data-rt-description="${rt.rt_description}"
													data-rt-price="${rt.rt_price}"
													data-rt-max-people="${rt.rt_max_people}"
													data-rt-area="${rt.rt_area}"
													data-rt-special="${rt.rt_special}"
													data-rt-img-url="${rt.rt_img_url}">
													<i class="bi bi-pencil"></i>
												</button> 
												
												<button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal"
										                data-rt-id="${rt.rt_id}"
										                data-rt-name="${rt.rt_name}">
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

	<div class="modal fade" id="viewModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Chi tiết loại phòng</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<div class="mb-3">
						<strong>Tên loại: </strong>
						<p class="rt_name"></p>
					</div>
					<div class="mb-3">
						<strong>Mô tả: </strong>
						<p class="rt_description" style="white-space: pre-wrap;"></p>
					</div>
					<div class="mb-3">
						<strong>Giá: </strong>
						<p class="rt_price"></p>
					</div>
					<div class="mb-3">
						<strong>Số người tối đa: </strong>
						<p class="rt_max_people"></p>
					</div>
					<div class="mb-3">
						<strong>Diện tích: </strong>
						<p class="rt_area"></p>
					</div>
					<div class="mb-3">
						<strong>Tiện ích đặc biệt: </strong>
						<p class="rt_special"></p>
					</div>
					<div class="mb-3">
						<strong>Hình ảnh: </strong> <img class="rt_img_preview" src=""
							alt="Hình ảnh loại phòng"
							style="width: 100%; max-height: 300px; object-fit: cover; margin-top: 5px; border-radius: 5px; display: none;">
						<!-- <p class="rt_img_url_text" style="word-break: break-all; font-size: 0.8rem; color: #6c757d; margin-top: 5px;"></p> -->
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Đóng</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="addModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Thêm loại phòng mới</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form id="addForm" action="room_type" method="post" enctype="multipart/form-data">
						<input type="hidden" name="action" value="add" />

						<div class="mb-3">
							<label class="form-label">Tên loại phòng</label> <input
								type="text" class="form-control" name="rt_name" required />
						</div>

						<div class="mb-3">
							<label class="form-label">Mô tả</label>
							<textarea class="form-control" name="rt_description" rows="3"
								required></textarea>
						</div>

						<div class="mb-3">
							<label class="form-label">Giá (VNĐ)</label> <input type="number"
								class="form-control" name="rt_price" min="0" required />
						</div>

						<div class="mb-3">
							<label class="form-label">Số người tối đa</label> <input
								type="number" class="form-control" name="rt_max_people" min="1"
								required />
						</div>

						<div class="mb-3">
							<label class="form-label">Diện tích (m²)</label> <input
								type="number" class="form-control" name="rt_area" min="0"
								required />
						</div>

						<div class="mb-3">
							<label class="form-label">Tiện ích đặc biệt</label> <input
								type="text" class="form-control" name="rt_special" />
						</div>

						<div class="mb-3">
							<label class="form-label"></label> <input type="hidden"
								name="current_img_url" />
							<div class="mb-3">
								<label class="form-label">Hình ảnh</label> <img
									class="current_img_preview" src=""
									style="max-width: 100%; height: auto; display: none; margin-bottom: 10px;">
							</div>

							<div class="mb-3">
								<label class="form-label">Chọn ảnh </label> <input
									type="file" class="form-control" name="rt_new_img_file"
									accept="image/*" />
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Đóng</button>
					<button type="submit" form="addForm" class="btn btn-primary">Thêm
						mới</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="editModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Chỉnh sửa loại phòng</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form id="editForm" action="room_type" method="post"
						enctype="multipart/form-data">
						<input type="hidden" name="rt_id" /> <input type="hidden"
							name="action" value="edit" />

						<div class="mb-3">
							<label class="form-label">Tên loại phòng</label> <input
								type="text" class="form-control" name="rt_name" required />
						</div>

						<div class="mb-3">
							<label class="form-label">Mô tả</label>
							<textarea class="form-control" name="rt_description" rows="3"
								required></textarea>
						</div>

						<div class="mb-3">
							<label class="form-label">Giá (VNĐ)</label> <input type="number"
								class="form-control" name="rt_price" min="0" required />
						</div>

						<div class="mb-3">
							<label class="form-label">Số người tối đa</label> <input
								type="number" class="form-control" name="rt_max_people" min="1"
								required />
						</div>

						<div class="mb-3">
							<label class="form-label">Diện tích (m²)</label> <input
								type="number" class="form-control" name="rt_area" min="0"
								required />
						</div>

						<div class="mb-3">
							<label class="form-label">Tiện ích đặc biệt</label> <input
								type="text" class="form-control" name="rt_special" />
						</div>

						<div class="mb-3">
							<label class="form-label"></label> <input type="hidden"
								name="current_img_url" />
							<div class="mb-3">
								<label class="form-label">Hình ảnh</label> <img
									class="current_img_preview" src=""
									style="max-width: 100%; height: auto; display: none; margin-bottom: 10px;">
							</div>

							<div class="mb-3">
								<label class="form-label">Chọn ảnh mới </label> <input
									type="file" class="form-control" name="rt_new_img_file"
									accept="image/*" />
							</div>
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
				<form id="deleteForm3" action="room_type" method="get">
					<!-- Hidden field để truyền username hoặc id -->
					<input type="hidden" name="rt_id" id="rt_id" /> <input type="hidden"
						name="action" value="delete" />
					<div class="modal-header">
						<h5 class="modal-title">Xác nhận xóa loại phòng</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<p>Bạn có chắc chắn muốn xóa loại phòng này?</p>
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
	
	
	<script type="text/javascript">
		// JavaScript cho Edit Modal (Không thay đổi)
		var editModal = document.getElementById('editModal');
		editModal.addEventListener('show.bs.modal', function(event) {
		    var button = event.relatedTarget;
		
		    // Lấy dữ liệu từ các thuộc tính data-*
		    var rt_id = button.getAttribute('data-rt-id');
		    var rt_name = button.getAttribute('data-rt-name');
		    var rt_description = button.getAttribute('data-rt-description');
		    var rt_price = button.getAttribute('data-rt-price');
		    var rt_max_people = button.getAttribute('data-rt-max-people'); 
		    var rt_area = button.getAttribute('data-rt-area');
		    var rt_special = button.getAttribute('data-rt-special');
		    var rt_img_url = button.getAttribute('data-rt-img-url');
		
		    // Cập nhật giá trị cho các trường trong form
		    var modal = this;
		    modal.querySelector('input[name="rt_id"]').value = rt_id;
		    modal.querySelector('input[name="rt_name"]').value = rt_name;
		    modal.querySelector('textarea[name="rt_description"]').value = rt_description;
		    modal.querySelector('input[name="rt_price"]').value = rt_price;
		    modal.querySelector('input[name="rt_max_people"]').value = rt_max_people;
		    modal.querySelector('input[name="rt_area"]').value = rt_area;
		    modal.querySelector('input[name="rt_special"]').value = rt_special;
		    var rt_img_url = button.getAttribute('data-rt-img-url'); // Lấy URL ảnh cũ

		    // Cập nhật giá trị cho các trường trong form
		    var modal = this;
		    // ... (Cập nhật các trường dữ liệu cũ) ...

		    // THAY ĐỔI: Xử lý trường ảnh
		    modal.querySelector('input[name="current_img_url"]').value = rt_img_url; // Gán URL cũ vào trường ẩn
		    
		    const imgPreview = modal.querySelector('.current_img_preview');
		    if (rt_img_url && rt_img_url.trim() !== '') {
		        imgPreview.src = rt_img_url;
		        imgPreview.style.display = 'block';
		    } else {
		        imgPreview.src = '';
		        imgPreview.style.display = 'none';
		    }
		    
		    // Đảm bảo reset trường file khi mở modal
		    modal.querySelector('input[name="rt_new_img_file"]').value = '';
		});
		
		// JavaScript cho View Modal (SỬA LẠI ĐỂ HIỂN THỊ HÌNH ẢNH)
		const viewModal = document.getElementById('viewModal');
		viewModal.addEventListener('show.bs.modal', function(event) {
		    const button = event.relatedTarget;
			
		    // Cập nhật thông tin cho các phần tử trong modal
		    viewModal.querySelector('.rt_name').textContent = button.getAttribute('data-rt-name');
		    viewModal.querySelector('.rt_description').textContent = button.getAttribute('data-rt-description');
		    
		    // Định dạng giá tiền cho đẹp
		    let price = parseFloat(button.getAttribute('data-rt-price'));
		    viewModal.querySelector('.rt_price').textContent = price.toLocaleString('vi-VN') + ' VNĐ';
		    
		    viewModal.querySelector('.rt_max_people').textContent = button.getAttribute('data-rt-max-people');
		    viewModal.querySelector('.rt_area').textContent = button.getAttribute('data-rt-area') + ' m²';
		    viewModal.querySelector('.rt_special').textContent = button.getAttribute('data-rt-special');
		    
		    // Xử lý hình ảnh
		    const imgUrl = button.getAttribute('data-rt-img-url');
		    const imgPreview = viewModal.querySelector('.rt_img_preview');
		    const imgUrlText = viewModal.querySelector('.rt_img_url_text');
		    
		    if (imgUrl && imgUrl.trim() !== '') {
		        imgPreview.src = imgUrl;
		        imgPreview.style.display = 'block'; // Hiển thị thẻ img
		        imgUrlText.textContent = imgUrl; // Hiển thị URL text
		    } else {
		        imgPreview.src = ''; // Xóa src cũ
		        imgPreview.style.display = 'none'; // Ẩn thẻ img nếu không có URL
		        imgUrlText.textContent = 'Không có hình ảnh'; // Thông báo
		    }
		});
		
		
		var deleteModal = document.getElementById('deleteModal');
		deleteModal.addEventListener('show.bs.modal', function(event) {
		    var button = event.relatedTarget;
		    var rt_id = button.getAttribute('data-rt-id');
		    var modal = this;
		    // Gán rt_id vào input ẩn trong form
		    modal.querySelector('input[name="rt_id"]').value = rt_id;
		});
	</script>
	
	<script type="text/javascript">
		// Xóa tham số 'message' khỏi URL sau khi trang đã tải
		(function() {
			if (window.history.replaceState) {
				// Lấy URL hiện tại
				let url = new URL(window.location.href);
				
				// Nếu có tham số 'message' thì mới xử lý
				if (url.searchParams.has('message')) {
					// Xóa tham số 'message'
					url.searchParams.delete('message');
					// Cập nhật URL trong lịch sử trình duyệt mà không tải lại trang
					window.history.replaceState({ path: url.href }, '', url.href);
				}
			}
		})();
	</script>

</body>
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/apexcharts/apexcharts.min.js"></script>
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/chart.js/chart.umd.js"></script>
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/echarts/echarts.min.js"></script>
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/quill/quill.js"></script>
<%--  <script src="${pageContext.request.contextPath}/admin/assets/vendor/simple-datatables/simple-datatables.js"></script> --%>
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/tinymce/tinymce.min.js"></script>
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/php-email-form/validate.js"></script>

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
	  
	});
</script>
</html>