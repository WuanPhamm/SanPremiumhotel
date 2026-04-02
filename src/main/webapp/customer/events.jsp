<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">


 <%@include file="/customer/header.jsp"%>


  <main class="main">

    <!-- Page Title -->
    <div class="page-title light-background">
      <div class="container d-lg-flex justify-content-between align-items-center">
        <h1 class="mb-2 mb-lg-0">Events</h1>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="index.html">Home</a></li>
            <li class="current">Events</li>
          </ol>
        </nav>
      </div>
    </div><!-- End Page Title -->

    <!-- Events Section -->
    <section id="events" class="events section">

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="hero-content text-center mb-5" data-aos="fade-up" data-aos-delay="200">
            <h2>Sự kiện đặc biệt &amp; Lễ kỷ niệm</h2>
            <p class="lead">Hãy làm cho phần bố cục chính trở nên dễ dàng hơn. Hãy sống thật tự tin và hài hòa, với sự gắn kết và cân bằng trong mọi việc. Phong cách tinh tế thể hiện qua cách bạn sắp xếp và điều chỉnh một cách nhịp nhàng.</p>
        </div>

        <div class="event-venues-grid" data-aos="fade-up" data-aos-delay="300">
          <div class="row g-4">
            <div class="col-xl-4 col-lg-6">
              <div class="venue-card">
                <div class="venue-image">
                  <img src="assets/img/hotel/event-2.webp" alt="Ballroom" class="img-fluid">
                  <div class="venue-overlay">
                    <div class="venue-info">
                        <h4>Hội trường lớn</h4>
                        <span class="capacity">Tối đa 400 khách mời</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-xl-4 col-lg-6">
              <div class="venue-card">
                <div class="venue-image">
                  <img src="assets/img/hotel/event-4.webp" alt="Garden Space" class="img-fluid">
                  <div class="venue-overlay">
                    <div class="venue-info">
                        <h4>>Rooftop Terrace</h4>
                      <span class="capacity">Tối đa 200 khách mời</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-xl-4 col-lg-6">
              <div class="venue-card">
                <div class="venue-image">
                  <img src="assets/img/hotel/event-7.webp" alt="Meeting Room" class="img-fluid">
                  <div class="venue-overlay">
                    <div class="venue-info">
                        <h4>Phòng Hội Nghị</h4>
                        <span class="capacity">Tối đa 80 khách mời</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="features-section" data-aos="fade-up" data-aos-delay="400">
          <div class="row align-items-center gy-5">
            <div class="col-lg-6">
              <div class="features-content">
                  <h3>Cơ sở vật chất sự kiện đẳng cấp thế giới</h3>
                  <p>Những người sống trong môi trường khó khăn sẽ quen với sự thay đổi và học cách thích nghi. Hãy giữ cho mình sự vững vàng, sống linh hoạt và biết cân bằng trong mọi hoàn cảnh.</p>

                <div class="feature-list">
                  <div class="feature-item" data-aos="slide-right" data-aos-delay="100">
                    <div class="feature-icon">
                      <i class="bi bi-soundwave"></i>
                    </div>
                    <div class="feature-details">
                        <h5>Âm thanh/Hình ảnh chất lượng</h5>
                        <p>Hệ thống âm thanh và thiết bị chiếu hiện đại nhất.</p>
                    </div>
                  </div>

                  <div class="feature-item" data-aos="slide-right" data-aos-delay="200">
                    <div class="feature-icon">
                      <i class="bi bi-wifi"></i>
                    </div>
                    <div class="feature-details">
                        <h5>Kết nối tốc độ cao</h5>
                        <p>Internet tốc độ cao miễn phí tại tất cả các địa điểm.</p>
                    </div>
                  </div>

                  <div class="feature-item" data-aos="slide-right" data-aos-delay="300">
                    <div class="feature-icon">
                      <i class="bi bi-cup-hot"></i>
                    </div>
                    <div class="feature-details">
                        <h5>Dịch vụ Tiệc Cao Cấp</h5>
                        <p>Trải nghiệm ẩm thực đặc biệt với thực đơn tùy chỉnh.</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-lg-6">
              <div class="features-gallery">
                <div class="gallery-main">
                  <img src="assets/img/hotel/event-9.webp" alt="Event Setup" class="img-fluid">
                </div>
                <div class="gallery-thumbnails">
                  <div class="thumbnail-item">
                    <img src="assets/img/hotel/event-5.webp" alt="Dining Setup" class="img-fluid">
                  </div>
                  <div class="thumbnail-item">
                    <img src="assets/img/hotel/amenities-3.webp" alt="Lounge Area" class="img-fluid">
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="event-packages" data-aos="fade-up" data-aos-delay="500">
          <div class="section-header text-center">
              <h3>Gói tổ chức sự kiện theo yêu cầu</h3>
              <p>Những đường nét tinh tế tạo nên phong cách nổi bật. Hãy làm việc một cách chủ động và linh hoạt. Hướng tới thành công bằng sự vững vàng và tự tin.</p>
          </div>

          <div class="packages-container">
            <div class="row g-4">
              <div class="col-lg-6">
                <div class="package-item" data-aos="zoom-out" data-aos-delay="100">
                  <div class="package-content">
                    <div class="package-icon">
                      <i class="bi bi-briefcase-fill"></i>
                    </div>
                    <h4>Hội nghị doanh nghiệp</h4>
                    <p>Không gian họp chuyên nghiệp với đầy đủ tiện nghi cần thiết, giúp tổ chức hiệu quả các sự kiện và hội nghị doanh nghiệp.</p>
                    <div class="package-highlights">
                        <span class="highlight">Phòng họp hiện đại</span>
                        <span class="highlight">Âm thanh – hình ảnh</span>
                        <span class="highlight">Dịch vụ ăn uống</span>
                    </div>
                    <div class="package-price">
                        Giá từ <strong>$95/Người</strong>
                    </div>
                    <a href="#" class="btn-package">Tìm hiểu thêm</a>
                  </div>
                </div>
              </div>

              <div class="col-lg-6">
                <div class="package-item featured" data-aos="zoom-out" data-aos-delay="200">
                    <div class="featured-label">Phổ biến nhất</div>
                  <div class="package-content">
                    <div class="package-icon">
                      <i class="bi bi-heart-fill"></i>
                    </div>
                    <h4>Tiệc cưới</h4>
                    <p>Trải nghiệm lễ cưới đáng nhớ với không gian sang trọng, ẩm thực tinh tế và dịch vụ được cá nhân hóa cho ngày trọng đại của bạn.</p>
                    <div class="package-highlights">
                        <span class="highlight">Phòng tân hôn</span>
                        <span class="highlight">Trang trí lễ cưới</span>
                        <span class="highlight">Tiệc chiêu đãi</span>
                    </div>
                    <div class="package-price">
                      Giá từ <strong>$185/Người </strong>
                    </div>
                    <a href="#" class="btn-package">Tìm hiểu thêm</a>
                  </div>
                </div>
              </div>

              <div class="col-lg-6">
                <div class="package-item" data-aos="zoom-out" data-aos-delay="300">
                  <div class="package-content">
                    <div class="package-icon">
                      <i class="bi bi-calendar-event"></i>
                    </div>
                    <h4>Sự kiện đặc biệt</h4>
                    <p>Hãy cùng kỷ niệm những cột mốc và khoảnh khắc ý nghĩa bằng các gói tiệc được thiết kế riêng, mang đến trải nghiệm đáng nhớ.</p>
                    <div class="package-highlights">
                        <span class="highlight">Trang trí theo chủ đề</span>
                        <span class="highlight">Giải trí</span>
                        <span class="highlight">Nhiếp ảnh chuyên nghiệp</span>
                    </div>
                    <div class="package-price">
                      Giá từ <strong>$135/Người</strong>
                    </div>
                    <a href="#" class="btn-package">Tìm hiểu thêm</a>
                  </div>
                </div>
              </div>

              <div class="col-lg-6">
                <div class="package-item" data-aos="zoom-out" data-aos-delay="400">
                    <div class="package-content">
                        <div class="package-icon">
                            <i class="bi bi-people-fill"></i>
                        </div>
                        <h4>Gặp gỡ & Giao lưu</h4>
                        <p>Những buổi tiệc thân mật với cách sắp xếp linh hoạt, hoàn hảo cho họp mặt gia đình, kỷ niệm hoặc những dịp chúc mừng nhẹ nhàng.</p>
                        <div class="package-highlights">
                            <span class="highlight">Chỗ ngồi linh hoạt</span>
                            <span class="highlight">Dịch vụ quầy bar</span>
                            <span class="highlight">Nhạc sống</span>
                        </div>
                        <div class="package-price">
                            Giá từ <strong>115 USD/người</strong>
                        </div>
                        <a href="#" class="btn-package">Tìm hiểu thêm</a>
                    </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="planning-services" data-aos="fade-up" data-aos-delay="600">
          <div class="row gy-5">
            <div class="col-lg-4">
                <div class="planning-content">
                    <h3>Sự Kiện Trọn Gói</h3>
                    <p>Chúng tôi mang đến giải pháp toàn diện cho mọi loại hình sự kiện, từ lên ý tưởng, tổ chức đến quản lý chi tiết — giúp bạn tận hưởng trọn vẹn từng khoảnh khắc mà không lo về khâu chuẩn bị.</p>
                    <a href="#" class="btn-contact">Liên hệ với đội ngũ của chúng tôi</a>
                </div>
            </div>

            <div class="col-lg-8">
              <div class="services-grid">
                <div class="service-box" data-aos="slide-up" data-aos-delay="100">
                  <div class="service-icon">
                    <i class="bi bi-person-check"></i>
                  </div>
                  <h5>Điều Phối Sự Kiện</h5>
                  <p>Đội ngũ chuyên trách quản lý tỉ mỉ từng chi tiết</p>
                </div>

                <div class="service-box" data-aos="slide-up" data-aos-delay="200">
                  <div class="service-icon">
                    <i class="bi bi-flower1"></i>
                  </div>
                  <h5>Trang Trí &amp; Phong Cách</h5>
                  <p>Chủ đề thiết kế riêng và gói trang trí sang trọng</p>
                </div>

                <div class="service-box" data-aos="slide-up" data-aos-delay="300">
                  <div class="service-icon">
                    <i class="bi bi-camera-reels"></i>
                  </div>
                  <h5>Chụp Ảnh &amp; Quay Phim</h5>
                  <p>Ghi lại chuyên nghiệp những khoảnh khắc đáng nhớ của bạn</p>
                </div>

                <div class="service-box" data-aos="slide-up" data-aos-delay="400">
                  <div class="service-icon">
                    <i class="bi bi-car-front"></i>
                  </div>
                  <h5>Đưa Đón &amp; Di Chuyển</h5>
                  <p>Dịch vụ xe đưa đón và sắp xếp phương tiện thuận tiện</p>
                </div>

                <div class="service-box" data-aos="slide-up" data-aos-delay="500">
                  <div class="service-icon">
                    <i class="bi bi-gift"></i>
                  </div>
                  <h5>Tiện Ích Dành Cho Khách</h5>
                  <p>Gói chào mừng và hỗ trợ lưu trú tận tình</p>
                </div>

                <div class="service-box" data-aos="slide-up" data-aos-delay="600">
                  <div class="service-icon">
                    <i class="bi bi-headset"></i>
                  </div>
                  <h5>Hỗ Trợ 24/7</h5>
                  <p>Hỗ trợ liên tục suốt thời gian diễn ra sự kiện</p>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </section><!-- /Events Section -->

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