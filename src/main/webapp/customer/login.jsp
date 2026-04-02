<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Đăng nhập - San Premium</title>
  <meta content="" name="description">
  <meta content="" name="keywords">
<link href="assets/img/favicon1.png" rel="icon">
  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="advendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="advendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
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
      top: 0; left: 0; right: 0; bottom: 0;
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
      text-shadow: 0 2px 8px rgba(0,0,0,0.4);
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
    }

    .btn-primary:hover {
      
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

    .small a:hover {
      text-decoration: underline;
      color: #3c7a59;
    }
   .card {
  background: rgba(255, 255, 255, 0.08); /* giảm độ đục xuống -> trong hơn */
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
  font-size:70px;
}

.btn-cus {
      background-color: linear-gradient(90deg, #f9e79f, #f4d03f, #d4af37, #b7950b);
      border: none;
      height:40px;
      width:40px;
      transition: 0.3s;
      font-size: 20px;
    }
.btn-cus:hover {
  transform: scale(1.1);
  box-shadow: 0 6px 12px rgba(0,0,0,0.3);
}

/* Nếu bạn muốn icon có hiệu ứng gradient thay vì nền */
.btn-cus i {
  background:linear-gradient(90deg, #e1c65d, #cda434, #b8860b, #8B7500);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
/* .btn-cus , .bi bi-facebook {
  background: #1877F2;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
} */

  </style>
</head>

<body>

  <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex flex-column align-items-center py-4">
                <a href="<%=request.getContextPath()%>/login" class="logo d-flex flex-column align-items-center w-auto text-center text-decoration-none">
                  <span class="luxury-text" style="color:#F9F9F9;">San Premium</span>
                  
                </a>
              </div><!-- End Logo -->

              <div class="card mb-3">
                <div class="card-body p-4">

                  <div class="pt-2 pb-3 text-center">
                    <h6 class="card-title text-center pb-0 fs-4">ĐĂNG NHẬP</h6>
                  </div>

                  <form class="row g-3 needs-validation" action="${pageContext.request.contextPath}/login" method="post" novalidate>

                    <c:if test="${not empty error}">
                      <div class="alert alert-danger text-center">${error}</div>
                    </c:if>

                    <div class="col-12">
                      <label for="yourUsername" class="form-label">Tên đăng nhập</label>
                      <div class="input-group has-validation">
                        <span class="input-group-text" id="inputGroupPrepend">@</span>
                        <input type="text" name="username" class="form-control" id="yourUsername" required>
                        <div class="invalid-feedback">Nhập tên đăng nhập của bạn</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="yourPassword" class="form-label">Mật khẩu</label>
                      <input type="password" name="password" class="form-control" id="yourPassword" required>
                      <div class="invalid-feedback">Nhập mật khẩu của bạn</div>
                    </div>

                    <div class="col-12">
                      <button class="btn btn-success w-100" type="submit" style="color:#E8E8E8;">Đăng nhập</button>
                      
                    </div>

					<div class="col-12  text-center">
							<p style="font-size:15px">hoặc đăng nhập với</p>
							
							
							<a href="${pageContext.request.contextPath}/login-google"
							class="btn btn-cus"> <i class="bi bi-google" ></i> 
							</a>
							
							<a href="${pageContext.request.contextPath}/login-facebook"
							class="btn btn-cus"> <i class="bi bi-facebook"></i>
							</a>			
							</div>

						<div class="col-12 text-center">
                      <p class="small mb-0">Chưa có tài khoản? 
                        <a href="<%=request.getContextPath()%>/register">Tạo tài khoản</a>
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

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center">
    <i class="bi bi-arrow-up-short"></i>
  </a>

  <!-- Vendor JS Files -->
  <script src="advendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>
