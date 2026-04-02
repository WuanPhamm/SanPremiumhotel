<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Đăng ký - San Premium</title>
<meta content="" name="description">
<meta content="" name="keywords">
<link href="assets/img/favicon1.png" rel="icon">
<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;600;700&family=Poppins:wght@300;400;500;600&display=swap"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="advendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="advendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="advendor/boxicons/css/boxicons.min.css" rel="stylesheet">

<!-- Custom CSS -->
<style>
body {
	font-family: 'Poppins', sans-serif;
	color: #333;
	margin: 0;
	padding: 0;
}

main {
	background-image: url('adimages/hotel1.jpg');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	min-height: 100vh;
	position: relative;
}

main::before {
	content: "";
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.5);
	z-index: 0;
}

.register {
	position: relative;
	z-index: 1;
}

.logo span {
	font-family: 'Playfair Display', serif;
	font-weight: 600;
	font-size: 36px;
	color: #2e5b45; /* Xanh lá đậm */
	letter-spacing: 1px;
	text-shadow: 0 2px 8px rgba(0, 0, 0, 0.4);
}

.logo p {
	color: #e8f0eb;
	font-size: 14px;
	margin-top: 6px;
	font-weight: 300;
}

.card {
	background: rgba(255, 255, 255, 0.92);
	border: none;
	border-radius: 16px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
	transition: all 0.3s ease;
	backdrop-filter: blur(10px);
}

.card:hover {
	transform: translateY(-4px);
	box-shadow: 0 12px 30px rgba(0, 0, 0, 0.35);
}

.card-title {
	font-family: 'Playfair Display', serif;
	color: #2e5b45;
	letter-spacing: 1px;
	font-size: 24px;
}

.btn-success {
	background-color: #2e5b45;
	border: none;
	font-weight: 500;
	transition: 0.3s;
	--bs-btn-active-bg: #2e5b45;
}

.btn-primary:hover {
	background-color: #3c7a59;
	transform: translateY(-2px);
}

label {
	font-weight: 500;
	color: #2e5b45;
}

input.form-control {
	border-radius: 10px;
	border: 1px solid #a8c0b0;
	transition: 0.3s;
}

input.form-control:focus {
	border-color: #2e5b45;
	box-shadow: 0 0 0 0.2rem rgba(46, 91, 69, 0.25);
}

.alert-danger {
	border-radius: 10px;
}

.small a {
	color: #2e5b45;
	font-weight: 500;
	text-decoration: none;
}




.form-check-label a {
	background: linear-gradient(90deg, #f9e79f, #f4d03f, #d4af37, #b7950b) !important;
	-webkit-background-clip: text !important;
	-webkit-text-fill-color: transparent !important;
	background-clip: text !important;
	font-family: 'Playfair Display', serif !important;
	
	letter-spacing: 1px !important;
	text-shadow: 0 2px 8px rgba(0, 0, 0, 0.4) !important;
	
}

.form-check-label a:hover {
	text-decoration: underline !important;
	
}


.form-check-input:checked {
    background-color: #2e5b45;
    border-color: #2e5b45;
}

.form-check-input[type=checkbox] {
    border: none !important;
}


.small a:hover {
	text-decoration: underline;
	color: #3c7a59;
}

.card {
	background: rgba(255, 255, 255, 0.08);
	/* giảm độ đục xuống -> trong hơn */
	border: 1px solid rgba(255, 255, 255, 0.2);
	border-radius: 18px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.25);
	backdrop-filter: blur(10px); /* làm mờ nền phía sau rõ hơn */
	-webkit-backdrop-filter: blur(10px);
	transition: all 0.3s ease;
}

.card:hover {
	transform: translateY(-4px);
	box-shadow: 0 12px 30px rgba(0, 0, 0, 0.35);
}

.card-body {
	color: #E8E8E8;
}

label, .card-title, .small a {
	color: #E8E8E8;
}

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
	<main style="background-image: url('adimages/hotel1.jpg');">
		<div class="container">

			<section
				class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
				<div class="container">
					<div class="row justify-content-center">
						<div
							class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

							<div class="d-flex flex-column align-items-center py-4">
								<a href="<%=request.getContextPath()%>/register"
									class="logo d-flex flex-column align-items-center w-auto text-center text-decoration-none">
									<span class="luxury-text" style="color: #F9F9F9;">San Premium</span>

								</a>
							</div>
							<!-- End Logo -->

							<div class="card mb-3">

								<div class="card-body">

									<div class="pt-2 pb-3 text-center">
										<h6 class="card-title text-center pb-0 fs-4"
											style="text-decoration: none">ĐĂNG KÝ</h6>

									</div>

									<form class="row g-3 needs-validation" action="register"
										method="POST" novalidate>
										<input type="hidden" name="action" value="reg" />

										<c:if test="${not empty error}">
											<div class="alert alert-danger text-center">${error}</div>
										</c:if>
										<c:if test="${not empty noti}">
											<div class="alert alert-success text-center">${noti}</div>
										</c:if>


										<div class="col-12">
											<label for="yourUsername" class="form-label">Tên đăng
												nhập</label>
											<div class="input-group has-validation">
												<span class="input-group-text" id="inputGroupPrepend">@</span>
												<input type="text" name="username" class="form-control"
													id="yourUsername" required>
												<div class="invalid-feedback">Hãy nhập tên đăng nhập
													hợp lệ</div>
											</div>
										</div>

										<div class="col-12">
											<label for="password" class="form-label">Mật khẩu</label> <input
												type="password" name="password" class="form-control"
												id="password" required>
											<div class="invalid-feedback">Hãy nhập mật khẩu hợp lệ</div>
										</div>

										<div class="col-12">
											<label for="confirmPassword" class="form-label">Xác
												nhận mật khẩu</label> <input type="password" name="confirmPassword"
												class="form-control" id="confirmPassword" required>
											<div class="invalid-feedback">Mật khẩu không khớp</div>
										</div>

										<div class="col-12">
											<div class="form-check">
												<input class="form-check-input" name="terms" type="checkbox"
													value="" id="acceptTerms" required> <label
													class="form-check-label" for="acceptTerms">Tôi đồng ý
													với <a  href="#" style="text-decoration:none ">điều khoản dịch vụ</a>
												</label>
												<div class="invalid-feedback">Bạn phải đồng ý trước khi đăng ký
													</div>
											</div>
										</div>

										<div class="col-12">
											<button class="btn btn-success w-100" type="submit"
												style="color: #E8E8E8;">Đăng ký</button>
										</div>
										<div class="col-12">
											<p class="small mb-0">
												Đã có tài khoản? <a
													href="<%=request.getContextPath()%>/login">Đăng nhập</a>
											</p>
										</div>
									</form>

								</div>
							</div>
						</div>
					</div>
				</div>

			</section>

		</div>
	</main>
	<!-- End #main -->
</body>
<!-- Vendor JS Files -->
<script src="advendor/apexcharts/apexcharts.min.js"></script>
<script src="advendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="advendor/chart.js/chart.umd.js"></script>
<script src="advendor/echarts/echarts.min.js"></script>
<script src="advendor/simple-datatables/simple-datatables.js"></script>
<script src="advendor/tinymce/tinymce.min.js"></script>

<!-- Template Main JS File -->
<script src="adjs/main.js"></script>
<script src="adjs/validate-register.js"></script>

<script>
document.querySelector("form").addEventListener("submit", function (e) {
  const password = document.getElementById("password").value.trim();
  const confirm = document.getElementById("confirmPassword").value.trim();

  // Kiểm tra mật khẩu rỗng
  if (!password || !confirm) {
    Swal.fire({
      icon: "warning",
      title: "Thiếu thông tin",
      text: "Vui lòng nhập đầy đủ mật khẩu!",
      confirmButtonColor: "#2e5b45"
    });
    e.preventDefault();
    return;
  }

  // Kiểm tra mật khẩu khớp
  if (password !== confirm) {
    Swal.fire({
      icon: "error",
      title: "Mật khẩu không khớp",
      text: "Vui lòng kiểm tra lại mật khẩu của bạn!",
      confirmButtonColor: "#2e5b45"
    });
    e.preventDefault();
    return;
  }

  // (Tuỳ chọn) Kiểm tra độ dài mật khẩu
  if (password.length < 6) {
    Swal.fire({
      icon: "info",
      title: "Mật khẩu quá ngắn",
      text: "Mật khẩu phải có ít nhất 6 ký tự!",
      confirmButtonColor: "#2e5b45"
    });
    e.preventDefault();
    return;
  }

  // Nếu mọi thứ hợp lệ thì cho submit
});
</script>


</html>