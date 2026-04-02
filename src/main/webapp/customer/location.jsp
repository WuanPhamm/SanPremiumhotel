<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">

<%@include file="/customer/header.jsp"%>
  <main class="main">

    <!-- Page Title -->
    <div class="page-title light-background">
      <div class="container d-lg-flex justify-content-between align-items-center">
        <h1 class="mb-2 mb-lg-0">Vị trí</h1>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="${pageContext.request.contextPath}/trangchu">Trang chủ</a></li>
            <li class="current">Vị trí</li>
          </ol>
        </nav>
      </div>
    </div><!-- End Page Title -->

    <!-- Hotel Location Section -->
    <section id="hotel-location" class="hotel-location section">

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <!-- Main Location Content -->
        <div class="row align-items-center mb-5">

          <!-- Location Details -->
          <div class="col-lg-6 order-2 order-lg-1" data-aos="fade-right" data-aos-delay="200">
            <div class="location-content">
              <div class="location-badge">
                <i class="bi bi-geo-alt-fill"></i>
                <span>Vị trí đắc địa</span>
              </div>
              <h2 class="location-title">Trải nghiệm sang trọng tại trung tâm thành phố</h2>
              <p class="location-description">Khám phá kỳ nghỉ đáng nhớ ngay giữa lòng thành phố, nơi sự tiện nghi hiện đại hòa quyện với nét thanh lịch vượt thời gian. Tận hưởng vị trí thuận tiện gần các điểm tham quan nổi tiếng, nhà hàng sang trọng và cuộc sống về đêm sôi động.</p>

              <div class="info-grid">
                <div class="info-item">
                  <div class="info-icon">
                    <i class="bi bi-building"></i>
                  </div>
                  <div class="info-text">
                    <h6>Địa chỉ</h6>
                    <p>36 P. Hà Trung <br>Hàng Bông, Hoàn Kiếm, Hà Nội</p>
                  </div>
                </div>

                <div class="info-item">
                  <div class="info-icon">
                    <i class="bi bi-airplane"></i>
                  </div>
                  <div class="info-text">
                    <h6>Sân bay gần nhất</h6>
                    <p>Sân bay Gia Lâm - 35 min</p>
                  </div>
                </div>

                <div class="info-item">
                  <div class="info-icon">
                    <i class="bi bi-telephone"></i>
                  </div>
                  <div class="info-text">
                    <h6>Liên hệ</h6>
                    <p>+84 383-952-771<br>2uannene@gmail.com</p>
                  </div>
                </div>

                <div class="info-item">
                  <div class="info-icon">
                    <i class="bi bi-clock"></i>
                  </div>
                  <div class="info-text">
                    <h6>Check-in</h6>
                    <p>3:00 PM - 11:00 PM<br>Check-out: 11:00 AM</p>
                  </div>
                </div>
              </div>

              <div class="action-buttons">
                <a href="https://maps.app.goo.gl/kvAQAn9Ctn47tWB46" class="btn btn-primary">Xem trên bản đồ</a>
                <a href="${pageContext.request.contextPath}/booking?id=${sessionScope.customer.cus_id}" class="btn btn-outline">Đặt ngay</a>
              </div>
            </div>
          </div>

          <!-- Interactive Map -->
          <div class="col-lg-6 order-1 order-lg-2" data-aos="fade-left" data-aos-delay="300">
            <div class="map-container">
             <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.0595157687935!2d105.84077169678957!3d21.03030450000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abf0720a11ed%3A0x6b72eb0861b71229!2sSan%20Premium%20Hotel!5e0!3m2!1svi!2s!4v1761982065937!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
              <div class="map-overlay">
                <div class="hotel-marker">
                  <i class="bi bi-building"></i>
                  SweetHomeHotel
                </div>
              </div>
            </div>
          </div>

        </div>

        <!-- Transportation Hub -->
        <div class="transportation-hub" data-aos="fade-up" data-aos-delay="400">
          <div class="row">
            <div class="col-12">
              <div class="section-header">
                  <h3>Đến với chúng tôi thật dễ dàng</h3>
                  <p>Trải nghiệm hành trình thuận tiện với nhiều lựa chọn di chuyển linh hoạt để đến khách sạn của chúng tôi</p>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-lg-6 col-md-6 mb-4" data-aos="slide-up" data-aos-delay="500">
              <div class="transport-card">
                <div class="transport-header">
                  <div class="transport-icon-box">
                    <i class="bi bi-car-front-fill"></i>
                  </div>
                  <div class="transport-title">
                    <h5>Ô tô</h5>
                    <span class="transport-time">Thuận tiện nhất</span>
                  </div>
                </div>
                <div class="transport-details">
                    <p>
                        Tận hưởng dịch vụ đỗ xe hộ miễn phí, cùng bãi đỗ xe cao cấp có lối vào trực tiếp khách sạn.
                        Khách sử dụng xe điện có thể an tâm với trạm sạc EV hiện đại được trang bị ngay trong khuôn viên.
                    </p>
                  <div class="transport-features">
                      <span class="feature-tag">Đỗ xe hộ</span>
                      <span class="feature-tag">Sạc xe điện</span>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-lg-6 col-md-6 mb-4" data-aos="slide-up" data-aos-delay="600">
              <div class="transport-card">
                <div class="transport-header">
                  <div class="transport-icon-box">
                    <i class="bi bi-train-front-fill"></i>
                  </div>
                  <div class="transport-title">
                    <h5>Tàu điện ngầm</h5>
                    <span class="transport-time">Chỉ 5 phút đi bộ</span>
                  </div>
                </div>
                <div class="transport-details">
                    <p>
                        Ga State Street nằm ngay gần khách sạn, kết nối trực tiếp đến các tuyến chính trong thành phố.
                        Tuyến Blue Line dẫn đến sân bay, trong khi Red Line đưa bạn đến khu ngoại ô và các trung tâm giải trí sôi động.
                    </p>
                  <div class="transport-features">
                    <span class="feature-tag">Blue Line</span>
                    <span class="feature-tag">Red Line</span>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-lg-6 col-md-6 mb-4" data-aos="slide-up" data-aos-delay="700">
              <div class="transport-card">
                <div class="transport-header">
                  <div class="transport-icon-box">
                    <i class="bi bi-airplane-fill"></i>
                  </div>
                  <div class="transport-title">
                    <h5>Xe đưa đón từ sân bay</h5>
                    <span class="transport-time">Khởi hành mỗi 30 phút</span>
                  </div>
                </div>
                <div class="transport-details">
                    <p>
                        Tận hưởng dịch vụ đưa đón cao cấp đến cả hai sân bay lớn trong thành phố.
                        Mỗi chuyến xe được trang bị Wi-Fi miễn phí, đồ uống nhẹ và hỗ trợ hành lý chuyên nghiệp, đảm bảo hành trình thoải mái và tiện lợi nhất.
                    </p>
                  <div class="transport-features">
                    <span class="feature-tag">WiFi</span>
                    <span class="feature-tag">Đồ uống</span>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-lg-6 col-md-6 mb-4" data-aos="slide-up" data-aos-delay="800">
              <div class="transport-card">
                <div class="transport-header">
                  <div class="transport-icon-box">
                    <i class="bi bi-taxi-front-fill"></i>
                  </div>
                  <div class="transport-title">
                    <h5>Dịch vụ xe công nghệ</h5>
                    <span class="transport-time">Luôn sẵn sàng 24/7</span>
                  </div>
                </div>
                <div class="transport-details">
                    <p>
                        Khách sạn có khu vực đón riêng dành cho các dịch vụ gọi xe như Grab hoặc Uber.
                        Đội ngũ lễ tân chuyên trách luôn sẵn sàng hỗ trợ đặt xe, sắp xếp thời gian đón và đáp ứng mọi yêu cầu đặc biệt của quý khách.
                    </p>
                  <div class="transport-features">
                    <span class="feature-tag">Lễ tân hỗ trợ</span>
                    <span class="feature-tag">đón nhanh</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Attractions Gallery -->
        <div class="attractions-section" data-aos="fade-up" data-aos-delay="900">
          <div class="row">
            <div class="col-12">
              <div class="section-header">
                <h3>Khám phá khu vực lân cận</h3>
                <p>Những điểm tham quan và giải trí đẳng cấp thế giới – chỉ cách bạn vài bước chân.</p>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="1000">
              <div class="attraction-item">
                <div class="attraction-photo">
                  <img src="assets/img/hotel/location-5.webp" alt="Millennium Park" class="img-fluid" loading="lazy">
                  <div class="distance-badge">
                    <i class="bi bi-geo-alt"></i>
                    <span>cách 600m</span>
                  </div>
                </div>
                <div class="attraction-info">
                  <h5>Công viên Millennium</h5>
                  <p class="walk-time"><i class="bi bi-clock"></i> 8 phút đi bộ</p>
                  <p>Thư giãn giữa không gian xanh mát và chiêm ngưỡng tác phẩm điêu khắc Cloud Gate biểu tượng của Chicago. Một điểm đến không thể bỏ lỡ dành cho du khách yêu thiên nhiên và nghệ thuật.</p>
                </div>
              </div>
            </div>

            <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="1100">
              <div class="attraction-item">
                <div class="attraction-photo">
                  <img src="assets/img/hotel/location-6.webp" alt="Art Institute" class="img-fluid" loading="lazy">
                  <div class="distance-badge">
                    <i class="bi bi-geo-alt"></i>
                    <span>cách 1000m</span>
                  </div>
                </div>
                <div class="attraction-info">
                  <h5>Viện nghệ thuật Chicago</h5>
                  <p class="walk-time"><i class="bi bi-clock"></i> 12 phút đi bộ</p>
                  <p>Khám phá bộ sưu tập nghệ thuật đẳng cấp thế giới, nơi lưu giữ những kiệt tác nổi tiếng từ các họa sĩ vĩ đại. Một hành trình nghệ thuật tinh tế giữa lòng thành phố.</p>
                </div>
              </div>
            </div>

            <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="1200">
              <div class="attraction-item">
                <div class="attraction-photo">
                  <img src="assets/img/hotel/location-7.webp" alt="Navy Pier" class="img-fluid" loading="lazy">
                  <div class="distance-badge">
                    <i class="bi bi-geo-alt"></i>
                    <span>cách 1600m</span>
                  </div>
                </div>
                <div class="attraction-info">
                  <h5>Bên cảng Navy Pier</h5>
                  <p class="walk-time"><i class="bi bi-clock"></i> 18 phút đi bộ</p>
                  <p>Tận hưởng không khí sôi động bên hồ, cùng các khu mua sắm, ẩm thực và giải trí. Địa điểm lý tưởng để dạo mát, ngắm cảnh và thưởng thức bữa tối ven hồ lãng mạn.</p>
                </div>
              </div>
            </div>

            <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="1300">
              <div class="attraction-item">
                <div class="attraction-photo">
                  <img src="assets/img/hotel/location-8.webp" alt="Theater District" class="img-fluid" loading="lazy">
                  <div class="distance-badge">
                    <i class="bi bi-geo-alt"></i>
                    <span>cách 800m</span>
                  </div>
                </div>
                <div class="attraction-info">
                  <h5>Theater District</h5>
                  <p class="walk-time"><i class="bi bi-clock"></i> 10 phút đi bộ</p>
                  <p>Thưởng thức những vở diễn Broadway nổi tiếng và các chương trình biểu diễn nghệ thuật đẳng cấp thế giới mỗi đêm. Trải nghiệm văn hóa sống động và sang trọng của thành phố.</p>
                </div>
              </div>
            </div>

            <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="1400">
              <div class="attraction-item">
                <div class="attraction-photo">
                  <img src="assets/img/hotel/location-9.webp" alt="Shopping District" class="img-fluid" loading="lazy">
                  <div class="distance-badge">
                    <i class="bi bi-geo-alt"></i>
                    <span>Cách 400m</span>
                  </div>
                </div>
                <div class="attraction-info">
                  <h5>Đại lộ Magnificent Mile</h5>
                  <p class="walk-time"><i class="bi bi-clock"></i> 5 phút đi bộ</p>
                  <p>Thiên đường mua sắm với các thương hiệu cao cấp, cửa hàng sang trọng và nhà hàng tinh tế. Một trải nghiệm đậm chất thượng lưu giữa trung tâm đô thị hiện đại.</p>
                </div>
              </div>
            </div>

            <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="1500">
              <div class="attraction-item">
                <div class="attraction-photo">
                  <img src="assets/img/hotel/location-10.webp" alt="Lakefront" class="img-fluid" loading="lazy">
                  <div class="distance-badge">
                    <i class="bi bi-geo-alt"></i>
                    <span>cách 1400m</span>
                  </div>
                </div>
                <div class="attraction-info">
                  <h5>Lake Michigan Shore</h5>
                  <p class="walk-time"><i class="bi bi-clock"></i> 15 phút đi bộ</p>
                  <p>Tản bộ dọc bờ hồ thơ mộng, tận hưởng bãi biển, đường mòn dạo bộ và những nhà hàng ven sông tuyệt đẹp – nơi lý tưởng để thư giãn và ngắm hoàng hôn.</p>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </section><!-- /Hotel Location Section -->

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