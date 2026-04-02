<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<%@include file="/customer/header.jsp"%>

  <main class="main">

    <!-- Page Title -->
    <div class="page-title light-background">
      <div class="container d-lg-flex justify-content-between align-items-center">
        <h1 class="mb-2 mb-lg-0">Liên hệ</h1>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="index.html">Trang Chủ</a></li>
            <li class="current">Liên hệ</li>
          </ol>
        </nav>
      </div>
    </div><!-- End Page Title -->

    <!-- Contact Section -->
    <section id="contact" class="contact section">

      <!-- Map Section -->
      <div class="map-container mb-5">
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.059516253107!2d105.84296037508086!3d21.03030448061931!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abf0720a11ed%3A0x6b72eb0861b71229!2sSan%20Premium%20Hotel!5e0!3m2!1svi!2s!4v1761986951700!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
      </div>

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <!-- Contact Info -->
        <div class="row g-4 mb-5" data-aos="fade-up" data-aos-delay="300">
          <div class="col-md-6">
            <div class="contact-info-card">
              <div class="icon-box">
                <i class="bi bi-geo-alt"></i>
              </div>
              <div class="info-content">
                <h4>Địa Chỉ</h4>
                <p>36 P. Hà Trung, Hàng Bông, Hoàn Kiếm, Hà Nội</p>
              </div>
            </div>
          </div>

          <div class="col-md-6">
            <div class="contact-info-card">
              <div class="icon-box">
                <i class="bi bi-telephone"></i>
              </div>
              <div class="info-content">
                <h4>Điện thoại &amp; Email</h4>
                <p>+84 383-952-771</p>
                <p>2uannene@gmail.com</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Contact Form -->
        <div class="row justify-content-center mb-5" data-aos="fade-up" data-aos-delay="200">
    <div class="col-lg-10">
        <div class="contact-form-wrapper">
            <h2 class="text-center mb-4">Gửi ý kiến đóng góp</h2>

            <form action="${pageContext.request.contextPath}/contact" method="post" >
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="form-group">
                            <input type="text" class="form-control" name="name" placeholder="Họ và Tên" >
                        </div>
                    </div>

								<div class="col-md-6">
									<input type="email" class="form-control" name="email"
										placeholder="Email" required>
								</div>

								<div class="col-md-6">
									<input type="text" class="form-control" name="subject"
										placeholder="Tiêu đề" required>
								</div>

								<div class="col-12">
                        <div class="form-group">
                            <textarea class="form-control" name="message" placeholder="Nội Dung Tin Nhắn" rows="6" ></textarea>
                        </div>
                    </div>

                    <div class="col-12 text-center">
                        <button type="submit" class="btn-submit">GỬI</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

      </div>

    </section><!-- /Contact Section -->

  </main>

 

  <%@include file="/customer/footer.jsp"%>


	<div class="modal fade" id="resultModal" tabindex="-1" aria-labelledby="resultModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="resultModalLabel">Thông Báo</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center">
        <div id="modal-icon" class="mb-3">
          </div>
        <p id="modal-message" class="fs-5"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
      </div>
    </div>
  </div>
</div>

<script>
    // Kiểm tra và hiển thị Modal sau khi trang tải lại từ Servlet
    document.addEventListener("DOMContentLoaded", function() {
        // Lấy thông báo từ session attribute (sử dụng JSTL/Expression Language)
        const status = '${sessionScope.contact_status}';
        const message = '${sessionScope.contact_message}';

        if (status && message) {
            const modal = new bootstrap.Modal(document.getElementById('resultModal'));
            const modalTitle = document.getElementById('resultModalLabel');
            const modalMessage = document.getElementById('modal-message');
            const modalIcon = document.getElementById('modal-icon');
            
            modalMessage.innerText = message;
            modalIcon.innerHTML = ''; // Xóa icon cũ
            
            if (status === 'success') {
                modalTitle.innerText = "Thành Công! 🎉";
                modalIcon.innerHTML = '<i class="bi bi-check-circle-fill text-success" style="font-size: 3rem;"></i>';
                document.querySelector('.modal-header').classList.add('bg-success', 'text-white');
                document.querySelector('.modal-header').classList.remove('bg-danger');
            } else if (status === 'error') {
                modalTitle.innerText = "Lỗi! ❌";
                modalIcon.innerHTML = '<i class="bi bi-x-circle-fill text-danger" style="font-size: 3rem;"></i>';
                document.querySelector('.modal-header').classList.add('bg-danger', 'text-white');
                document.querySelector('.modal-header').classList.remove('bg-success');
            }

            modal.show();

            // Xóa session attribute sau khi hiển thị để không hiện lại khi F5
            // Đây là cách xóa session attribute trong JSP/JSTL
            <c:remove var="contact_status" scope="session" />
            <c:remove var="contact_message" scope="session" />
        }
    });
</script>
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

</body>

</html>