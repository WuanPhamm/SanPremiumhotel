<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<%@include file="/customer/header.jsp"%>



<c:if test="${not empty param.message}">
  <div id="alertBox" class="alert 
    ${param.message eq 'success_info' or param.message eq 'success_pw' ? 'alert-success' : 'alert-danger'} 
    position-fixed top-0 start-50 translate-middle-x mt-3 shadow-lg rounded-3 px-4 py-3"
    style="z-index: 1055; display: none;">
    <strong>
      <c:choose>
        <c:when test="${param.message eq 'success_info'}">Cập nhật thông tin thành công!</c:when>
        <c:when test="${param.message eq 'fail_info'}">Cập nhật thông tin thất bại!</c:when>
        <c:when test="${param.message eq 'success_pw'}">Đổi mật khẩu thành công!</c:when>
        <c:when test="${param.message eq 'fail_pw'}">Đổi mật khẩu thất bại!</c:when>
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
			<h2>Thông tin tài khoản</h2>
		</div>
		<!-- End Page Title -->

		<section class="section profile">
			<div class="row">
				<div class="col-xl-4">

					<div class="card">
						<div
							class="card-body profile-card pt-4 d-flex flex-column align-items-center">

							<img src="${cus.cus_avt_url }" alt="Profile"
								class="rounded-circle">
							<h3>${cus.cus_firstname }&nbsp;${cus.cus_lastname }</h3>
							<h5>Khách hàng</h5>
							
						</div>
					</div>

				</div>

				<div class="col-xl-8">

					<div class="card">
						<div class="card-body pt-3">
							<!-- Bordered Tabs -->
							<ul class="nav nav-tabs nav-tabs-bordered">

								<li class="nav-item">
									<button class="nav-link active" data-bs-toggle="tab"
										data-bs-target="#profile-overview">Tổng quan</button>
								</li>

								<li class="nav-item">
									<button class="nav-link" data-bs-toggle="tab"
										data-bs-target="#profile-edit">Sửa thông tin</button>
								</li>

							

								<li class="nav-item">
									<button class="nav-link" data-bs-toggle="tab"
										data-bs-target="#profile-change-password">Đổi mật khẩu</button>
								</li>

							</ul>
							<div class="tab-content pt-2">

								<div class="tab-pane fade show active profile-overview"
									id="profile-overview">
									
									<h5 class="card-title">Thông tin chi tiết</h5>

									<div class="row">
										<div class="col-lg-3 col-md-4 label ">Họ và tên</div>
										<div class="col-lg-9 col-md-8">${cus.cus_firstname }&nbsp;${cus.cus_lastname}</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Ngày sinh</div>
										<div class="col-lg-9 col-md-8">${cus.cus_dob }</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Giới tính</div>
									<div class="col-lg-9 col-md-8">
										<c:choose>
											<c:when test="${cus.cus_gender == 0}">Nam</c:when>
											<c:when test="${cus.cus_gender == 1}">Nữ</c:when>
											<c:otherwise>Khác</c:otherwise>
										</c:choose>
									</div>
								</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Số điện thoại</div>
										<div class="col-lg-9 col-md-8">${cus.cus_phone }</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Email</div>
										<div class="col-lg-9 col-md-8">${cus.cus_email }</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Địa chỉ</div>
										<div class="col-lg-9 col-md-8">${cus.cus_address }</div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Số căn cước</div>
										<div class="col-lg-9 col-md-8">${cus.cus_cccd }</div>
									</div>

								</div>

								<div class="tab-pane fade profile-edit pt-3" id="profile-edit">

									<!-- Profile Edit Form -->


								<form action="${pageContext.request.contextPath}/profile-edit"
									method="post" enctype="multipart/form-data"
									id="upload-image-form">
									<input type="hidden" name="action" value="u_avt"> <input
										type="hidden" name="cus_id" value="${cus.cus_id}">

									<div class="row mb-3">
										<label for="profileImage"
											class="col-md-4 col-lg-3 col-form-label">Ảnh đại diện</label>
										<div class="col-md-8 col-lg-9">
											<img src="${cus.cus_avt_url }" alt="Profile"
												style="max-width: 140px; max-height: 150px; border-radius: 15px;"
												id="current-avatar">

											<div class="pt-2 d-flex align-items-center">
												<input type="file" name="avatarFile" id="avatarFileInput"
													style="display: none;" accept="image/*">

												<button type="button" class="btn btn-primary btn-sm me-2"
													title="Upload new profile image"
													onclick="document.getElementById('avatarFileInput').click();">
													<i class="bi bi-upload"></i> Tải ảnh lên
												</button>

												<button type="submit" class="btn btn-success btn-sm"
													id="submitAvatarBtn" style="display: none;">
													<i class="bi bi-check"></i> Lưu
												</button>
											</div>
											<div id="fileNameDisplay" class="mt-2 small">Chưa có
												file nào được chọn.</div>
										</div>
									</div>
								</form>


								<form action="${pageContext.request.contextPath}/profile-edit" method="post">
									<input type="hidden" name="action" value="u_inf">
										

										<div class="row mb-3">
											<label for="fullName"
												class="col-md-4 col-lg-3 col-form-label">Họ</label>
											<div class="col-md-8 col-lg-9">
												<input name="cus_firstname" type="text" class="form-control"
													id="cus_firstname" value="${cus.cus_firstname }">
											</div>
										</div>
										<div class="row mb-3">
											<label for="fullName"
												class="col-md-4 col-lg-3 col-form-label">Tên</label>
											<div class="col-md-8 col-lg-9">
												<input name="cus_lastname" type="text" class="form-control"
													id="cus_lastname" value="${cus.cus_lastname }">
											</div>
										</div>

										<div class="row mb-3">
											<label for="fullName"
												class="col-md-4 col-lg-3 col-form-label">Ngày sinh</label>
											<div class="col-md-8 col-lg-9">
												<input name="cus_dob" type="date" class="form-control"
													id="cus_lastname" value="${cus.cus_dob }">
											</div>
										</div>
									<div class="row mb-3">
										<label class="col-md-4 col-lg-3 col-form-label">Giới
											tính</label>
										<div class="col-md-8 col-lg-9">
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio"
													name="cus_gender" id="genderMale" value="0"
													${cus.cus_gender == 0 ? "checked" : ""}> <label
													class="form-check-label" for="genderMale">Nam</label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio"
													name="cus_gender" id="genderFemale" value="1"
													${cus.cus_gender == 1 ? "checked" : ""}> <label
													class="form-check-label" for="genderFemale">Nữ</label>
											</div>
										</div>
									</div>
										<div class="row mb-3">
											<label for="fullName"
												class="col-md-4 col-lg-3 col-form-label">Số điện thoại</label>
											<div class="col-md-8 col-lg-9">
												<input name="cus_phone" type="text" class="form-control"
													id="cus_lastname" value="${cus.cus_phone }">
											</div>
										</div>
										
										<div class="row mb-3">
											<label for="fullName"
												class="col-md-4 col-lg-3 col-form-label">Email</label>
											<div class="col-md-8 col-lg-9">
												<input name="cus_email" type="text" class="form-control"
													id="cus_lastname" value="${cus.cus_email }">
											</div>
										</div>
										<div class="row mb-3">
											<label for="fullName"
												class="col-md-4 col-lg-3 col-form-label">Địa chỉ</label>
											<div class="col-md-8 col-lg-9">
												<input name="cus_address" type="text" class="form-control"
													id="cus_lastname" value="${cus.cus_address }">
											</div>
										</div>
										<div class="row mb-3">
											<label for="fullName"
												class="col-md-4 col-lg-3 col-form-label">Số căn cước</label>
											<div class="col-md-8 col-lg-9">
												<input name="cus_cccd" type="text" class="form-control"
													id="cus_lastname" value="${cus.cus_cccd }">
											</div>
										</div>
									<div class="text-center">
										<button type="submit" class="btn btn-primary">Lưu thông tin</button>
									</div>
								</form>
									<!-- End Profile Edit Form -->

								</div>


								<div class="tab-pane fade pt-3" id="profile-change-password">
									<!-- Change Password Form -->
									<form action="${pageContext.request.contextPath}/profile-edit" method="post">
										<input type="hidden" name="action" value="u_pw">
										<div class="row mb-3">
											<label for="currentPassword"
												class="col-md-4 col-lg-3 col-form-label">Mật khẩu hiện tại</label>
											<div class="col-md-8 col-lg-9">
												<input name="password" type="password" class="form-control"
													id="currentPassword">
											</div>
										</div>

										<div class="row mb-3">
											<label for="newPassword"
												class="col-md-4 col-lg-3 col-form-label">Mật khẩu mới</label>
											<div class="col-md-8 col-lg-9">
												<input name="newPassword" type="password"
													class="form-control" id="newPassword">
											</div>
										</div>

										<div class="row mb-3">
											<label for="renewPassword"
												class="col-md-4 col-lg-3 col-form-label">Nhập lại mật khẩu mới</label>
											<div class="col-md-8 col-lg-9">
												<input name="renewPassword" type="password"
													class="form-control" id="renewPassword">
											</div>
										</div>

										<div class="text-center">
											<button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
										</div>
									</form>
									<!-- End Change Password Form -->

								</div>

							</div>
							<!-- End Bordered Tabs -->

						</div>
					</div>

				</div>
			</div>
		</section>

	</main>
	<!-- End #main -->


	 <%@include file="/customer/footer.jsp"%>

  <!-- Scroll Top -->
  <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Preloader -->
  <div id="preloader"></div>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	
  <!-- Main JS File -->
  <script src="assets/js/main.js"></script>
  <script src="adjs/validate-profile.js"></script>
  <script src="admin/assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="admin/assets/vendor/chart.js/chart.umd.js"></script>
  <script src="admin/assets/vendor/echarts/echarts.min.js"></script>
  <script src="admin/assets/vendor/quill/quill.js"></script>
  <script src="admin/assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="admin/assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="admin/assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="admin/assets/js/main.js"></script>
  
  <script>
    // Script để hiển thị tên file và nút Lưu khi người dùng chọn file
    document.getElementById('avatarFileInput').addEventListener('change', function() {
        const fileNameDisplay = document.getElementById('fileNameDisplay');
        const submitBtn = document.getElementById('submitAvatarBtn');
        if (this.files && this.files.length > 0) {
            fileNameDisplay.textContent = 'Đã chọn: ' + this.files[0].name;
            submitBtn.style.display = 'inline-block';
        } else {
            fileNameDisplay.textContent = 'Chưa có file nào được chọn.';
            submitBtn.style.display = 'none';
        }
    });
</script>

</body>

</html>