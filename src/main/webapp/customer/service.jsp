<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">

<%@include file="/customer/header.jsp"%>
  <main class="main">

    <!-- Page Title -->
    <div class="page-title light-background">
      <div class="container d-lg-flex justify-content-between align-items-center">
        <h1 class="mb-2 mb-lg-0">Tiện Nghi</h1>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="index.html">Trang Chủ</a></li>
            <li class="current">Tiện Nghi</li>
          </ol>
        </nav>
      </div>
    </div><!-- End Page Title -->

    <!-- Amenities Section -->
    <section id="amenities" class="amenities section">

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="row gy-4">

          <div class="col-lg-6" data-aos="fade-up" data-aos-delay="200">
            <div class="amenity-card">
              <div class="amenity-image">
                <img src="assets/img/hotel/amenities-1.webp" alt="Rooftop Pool" class="img-fluid">
              </div>
              <div class="amenity-content">
                <h3>Hồ Bơi Vô Cực &amp; Sân Tắm Nắng</h3>
                <p>Trải nghiệm hồ bơi vô cực tuyệt đẹp với tầm nhìn toàn cảnh thành phố. Tận hưởng không gian thư giãn tuyệt vời tại sân tắm nắng hiện đại, hoàn hảo cho những khoảnh khắc nghỉ ngơi và thư giãn.</p>
                <ul class="amenity-features">
                  <li><i class="bi bi-clock"></i> Mở cửa 6:00 - 22:00</li>
                  <li><i class="bi bi-droplet"></i> Hồ bơi được sưởi ấm quanh năm</li>
                  <li><i class="bi bi-cup-hot"></i> Dịch vụ bar bên hồ bơi</li>
                </ul>
              </div>
            </div>
          </div><!-- End Amenity Card -->

          <div class="col-lg-6" data-aos="fade-up" data-aos-delay="300">
            <div class="amenity-card">
              <div class="amenity-image">
                <img src="assets/img/hotel/amenities-2.webp" alt="Spa Wellness" class="img-fluid">
              </div>
              <div class="amenity-content">
                <h3>Spa &amp; Chăm Sóc Sức Khỏe Sang Trọng</h3>
                <p>Trung tâm spa đẳng cấp thế giới cung cấp các liệu pháp chăm sóc sức khỏe và làm đẹp toàn diện. Đội ngũ chuyên gia giàu kinh nghiệm sẽ mang đến cho bạn trải nghiệm thư giãn và trẻ hóa tuyệt vời.</p>
                <ul class="amenity-features">
                  <li><i class="bi bi-calendar2-check"></i> Đặt lịch trị liệu trực tuyến</li>
                  <li><i class="bi bi-heart"></i> Phòng massage cho cặp đôi</li>
                  <li><i class="bi bi-flower1"></i> Sản phẩm spa hữu cơ</li>
                </ul>
              </div>
            </div>
          </div><!-- End Amenity Card -->

          <div class="col-lg-6" data-aos="fade-up" data-aos-delay="400">
            <div class="amenity-card">
              <div class="amenity-image">
                <img src="assets/img/hotel/dining-3.webp" alt="Fine Dining" class="img-fluid">
              </div>
              <div class="amenity-content">
                <h3>Nhà Hàng Signature</h3>
                <p>Thưởng thức ẩm thực cao cấp tại nhà hàng signature của chúng tôi. Menu được thiết kế tinh tế với nguyên liệu tươi ngon nhất, mang đến trải nghiệm ẩm thực đẳng cấp quốc tế.</p>
                <ul class="amenity-features">
                  <li><i class="bi bi-award"></i> Đầu bếp đến từ Michelin</li>
                  <li><i class="bi bi-list"></i> Hầm rượu đạt giải</li>
                  <li><i class="bi bi-moon-stars"></i> Mở cửa Thứ Ba - Chủ Nhật</li>
                </ul>
              </div>
            </div>
          </div><!-- End Amenity Card -->

          <div class="col-lg-6" data-aos="fade-up" data-aos-delay="500">
            <div class="amenity-card">
              <div class="amenity-image">
                <img src="assets/img/hotel/amenities-4.webp" alt="Fitness Center" class="img-fluid">
              </div>
              <div class="amenity-content">
                <h3>Trung Tâm Thể Dục 24/7</h3>
                <p>Duy trì lối sống lành mạnh với trung tâm thể dục hiện đại mở cửa 24/7. Trang bị đầy đủ máy móc tiên tiến và không gian tập luyện rộng rãi, phù hợp cho mọi nhu cầu thể dục của bạn.</p>
                <ul class="amenity-features">
                  <li><i class="bi bi-lightning"></i> Thiết bị hiện đại nhất</li>
                  <li><i class="bi bi-person-check"></i> Huấn luyện viên cá nhân</li>
                  <li><i class="bi bi-shield-check"></i> Khăn tắm miễn phí</li>
                </ul>
              </div>
            </div>
          </div><!-- End Amenity Card -->

        </div>

        <div class="row mt-5">
          <div class="col-12" data-aos="fade-up" data-aos-delay="600">
            <div class="amenities-grid">
              <h3 class="text-center mb-4">Dịch Vụ Bổ Sung Của Khách Sạn</h3>
              <div class="row g-4">
                <div class="col-lg-3 col-md-4 col-sm-6">
                  <div class="service-item">
                    <div class="service-icon">
                      <i class="bi bi-wifi"></i>
                    </div>
                    <h4>Wi-Fi Miễn Phí</h4>
                    <p>Internet tốc độ cao trong toàn bộ khách sạn</p>
                  </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                  <div class="service-item">
                    <div class="service-icon">
                      <i class="bi bi-car-front"></i>
                    </div>
                    <h4>Dịch Vụ Đỗ Xe</h4>
                    <p>Dịch vụ đỗ xe miễn phí cho tất cả khách</p>
                  </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                  <div class="service-item">
                    <div class="service-icon">
                      <i class="bi bi-airplane"></i>
                    </div>
                    <h4>Xe Đưa Đón Sân Bay</h4>
                    <p>Dịch vụ đưa đón đến các sân bay chính</p>
                  </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                  <div class="service-item">
                    <div class="service-icon">
                      <i class="bi bi-headset"></i>
                    </div>
                    <h4>Lễ Tân</h4>
                    <p>Hỗ trợ 24/7 cho đặt phòng và tour du lịch</p>
                  </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                  <div class="service-item">
                    <div class="service-icon">
                      <i class="bi bi-bell"></i>
                    </div>
                    <h4>Dịch Vụ Phòng</h4>
                    <p>Ẩm thực cao cấp phục vụ tận phòng</p>
                  </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                  <div class="service-item">
                    <div class="service-icon">
                      <i class="bi bi-shield-check"></i>
                    </div>
                    <h4>Két An Toàn</h4>
                    <p>Lưu trữ an toàn cho đồ có giá trị của bạn</p>
                  </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                  <div class="service-item">
                    <div class="service-icon">
                      <i class="bi bi-translate"></i>
                    </div>
                    <h4>Nhân Viên Đa Ngôn Ngữ</h4>
                    <p>Phục vụ bằng tiếng Anh, Tây Ban Nha, Pháp và nhiều ngôn ngữ khác</p>
                  </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                  <div class="service-item">
                    <div class="service-icon">
                      <i class="bi bi-heart-pulse"></i>
                    </div>
                    <h4>Thú Cưng Được Chào Đón</h4>
                    <p>Tiện nghi chào đón cho những người bạn lông xù của bạn</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </section><!-- /Amenities Section -->

  </main>


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

</body>

</html>