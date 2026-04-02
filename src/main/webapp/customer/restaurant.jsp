<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">

<%@include file="/customer/header.jsp"%>
  
<main class="main">

    <!-- Page Title -->
    <div class="page-title light-background">
      <div class="container d-lg-flex justify-content-between align-items-center">
        <h1 class="mb-2 mb-lg-0">Restaurant</h1>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="index.html">Home</a></li>
            <li class="current">Restaurant</li>
          </ol>
        </nav>
      </div>
    </div><!-- End Page Title -->

    <!-- Restaurant Section -->
    <section id="restaurant" class="restaurant section">

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="row g-5 align-items-center">
          <div class="col-lg-6" data-aos="fade-up">
            <div class="about-content">
                <h2>Trải Nghiệm Phong Cách Riêng Biệt Của Chúng Tôi</h2>
                <p class="fst-italic">Trải nghiệm dịch vụ đẳng cấp, nơi phong cách và sự tinh tế hòa quyện trong từng khoảnh khắc nghỉ dưỡng của bạn.</p>
                <p>Chúng tôi không ngừng hoàn thiện để mang đến cho quý khách sự thoải mái tuyệt đối, từ không gian sang trọng, ẩm thực tinh tế cho đến dịch vụ tận tâm và chuyên nghiệp.</p>

              <div class="row mt-4">
                <div class="col-md-6">
                  <div class="feature-item" data-aos="fade-up" data-aos-delay="150">
                    <i class="bi bi-award"></i>
                    <h4>Dịch Vụ Hoàn Hảo</h4>
                    <p>Mỗi chi tiết đều được chăm chút tỉ mỉ, đảm bảo mang đến cho quý khách trải nghiệm vượt ngoài mong đợi.</p>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="feature-item" data-aos="fade-up" data-aos-delay="200">
                    <i class="bi bi-trophy"></i>
                    <h4>Được Công Nhận Trong Ngành</h4>
                    <p>Tự hào là thương hiệu được vinh danh với nhiều giải thưởng uy tín, khẳng định vị thế trong ngành dịch vụ lưu trú cao cấp.</p>
                  </div>
                </div>
              </div>

              <div class="signature mt-4" data-aos="fade-up" data-aos-delay="250">
                  <p class="chef-name"> Giám đốc Điều hành Jane Smith</p>
                <img src="assets/img/misc/signature-1.webp" alt="Chef Signature" class="img-fluid">
              </div>
            </div>
          </div>

          <div class="col-lg-6" data-aos="fade-up" data-aos-delay="300">
            <div class="about-gallery">
              <div class="row g-3">
                <div class="col-6">
                  <img src="assets/img/restaurant/showcase-3.webp" class="img-fluid rounded" alt="Restaurant Image">
                </div>
                <div class="col-6">
                  <img src="assets/img/restaurant/showcase-8.webp" class="img-fluid rounded" alt="Restaurant Image">
                </div>
                <div class="col-12 mt-3">
                  <div class="years-badge">
                    <span class="number">18</span>
                    <span class="text">Years of Dedication</span>
                  </div>
                  <img src="assets/img/restaurant/showcase-6.webp" class="img-fluid rounded" alt="Restaurant Image">
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </section><!-- /Restaurant Section -->

    <!-- Menu Section -->
    <section id="menu" class="menu section">

      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <span class="description-title">Menu</span>
        <h2>Menu</h2>
        <p>Tinh hoa ẩm thực được chế tác tinh tế, mang đến trải nghiệm vị giác độc đáo và trọn vẹn.</p>
      </div><!-- End Section Title -->

      <div class="container" data-aos="fade-up">

        <div class="isotope-layout" data-default-filter="*" data-layout="masonry" data-sort="original-order">

          <div class="menu-filters isotope-filters mb-5">
            <ul>
              <li data-filter="*" class="filter-active">Tất cả món ăn</li>
              <li data-filter=".filter-starters">Khai vị</li>
              <li data-filter=".filter-main">Món chính</li>
              <li data-filter=".filter-dessert">Tráng miệng</li>
              <li data-filter=".filter-drinks">Thức uống</li>
            </ul>
          </div>

          <div class="menu-container isotope-container row gy-4">

            <!-- Regular Menu Items -->
            <div class="col-lg-6 isotope-item filter-starters">
              <div class="menu-item d-flex align-items-center gap-4">
                <img src="assets/img/restaurant/starter-2.webp" alt="Starter" class="menu-img img-fluid rounded-3">
                <div class="menu-content">
                  <h5>Bruschetta Trio <span class="menu-tag">Món chay</span></h5>
                  <p>Bánh mì nướng Ý giòn tan phủ cà chua tươi, dầu ô liu và thảo mộc – món khai vị thanh đạm đậm hương vị Địa Trung Hải.</p>
                  <div class="price">$8.95</div>
                </div>
              </div>
            </div>

            <div class="col-lg-6 isotope-item filter-starters">
              <div class="d-flex menu-item align-items-center gap-4">
                <img src="assets/img/restaurant/starter-5.webp" alt="Starter" class="menu-img img-fluid rounded-3">
                <div class="menu-content">
                  <h5>Calamari Fritti <span class="menu-tag">Hải sản</span></h5>
                  <p>
                      Mực chiên giòn vàng ruộm, chấm cùng sốt aioli cay nhẹ – sự hòa quyện hoàn hảo giữa biển khơi và vị béo ngậy tinh tế.
                  </p>
                  <div class="price">$10.95</div>
                </div>
              </div>
            </div>

            <div class="col-lg-6 isotope-item filter-main">
              <div class="d-flex menu-item align-items-center gap-4">
                <img src="assets/img/restaurant/main-1.webp" alt="Main Course" class="menu-img img-fluid rounded-3">
                <div class="menu-content">
                  <h5>Wild Mushroom Risotto <span class="menu-tag">Món chay</span></h5>
                  <p>Cơm Ý nấu cùng nấm rừng tươi, quyện cùng vị kem béo và phô mai Parmesan – hương vị ấm áp, thanh lịch.</p>
                  <div class="price">$18.95</div>
                </div>
              </div>
            </div>

            <div class="col-lg-6 isotope-item filter-main">
              <div class="d-flex menu-item align-items-center gap-4">
                <img src="assets/img/restaurant/main-4.webp" alt="Main Course" class="menu-img img-fluid rounded-3">
                <div class="menu-content">
                  <h5>Braised Lamb Shank <span class="menu-tag">Bếp trưởng đề xuất</span></h5>
                  <p>Chân cừu hầm mềm trong rượu vang đỏ và thảo mộc châu Âu – món ăn được bếp trưởng khuyên dùng.</p>
                  <div class="price">$26.95</div>
                </div>
              </div>
            </div>

            <div class="col-lg-6 isotope-item filter-dessert">
              <div class="d-flex menu-item align-items-center gap-4">
                <img src="assets/img/restaurant/dessert-2.webp" alt="Dessert" class="menu-img img-fluid rounded-3">
                <div class="menu-content">
                  <h5>Chocolate Lava Cake <span class="menu-tag">Không Gluten</span></h5>
                  <p>Bánh sô-cô-la nhân chảy nóng hổi, tan chảy trong miệng – lựa chọn hoàn hảo cho người yêu vị ngọt tinh tế.</p>
                  <div class="price">$9.95</div>
                </div>
              </div>
            </div>

            <div class="col-lg-6 isotope-item filter-dessert">
              <div class="d-flex menu-item align-items-center gap-4">
                <img src="assets/img/restaurant/dessert-7.webp" alt="Dessert" class="menu-img img-fluid rounded-3">
                <div class="menu-content">
                  <h5>Tiramisu <span class="menu-tag">Truyền thống</span></h5>
                  <p>Bánh tiramisu truyền thống với lớp mascarpone béo mịn và hương cà phê nồng nàn – biểu tượng của phong vị Ý cổ điển.</p>
                  <div class="price">$8.95</div>
                </div>
              </div>
            </div>

            <div class="col-lg-6 isotope-item filter-drinks">
              <div class="d-flex menu-item align-items-center gap-4">
                <img src="assets/img/restaurant/drink-3.webp" alt="Drink" class="menu-img img-fluid rounded-3">
                <div class="menu-content">
                  <h5>Signature Cocktail <span class="menu-tag">Có cồn</span></h5>
                  <p>Thức uống đặc trưng của nhà hàng – hòa quyện giữa hương trái cây và rượu mạnh, mang đậm phong cách riêng biệt.</p>
                  <div class="price">$12.95</div>
                </div>
              </div>
            </div>

            <div class="col-lg-6 isotope-item filter-drinks">
              <div class="d-flex menu-item align-items-center gap-4">
                <img src="assets/img/restaurant/drink-8.webp" alt="Drink" class="menu-img img-fluid rounded-3">
                <div class="menu-content">
                  <h5>Berry Smoothie <span class="menu-tag">Không cồn</span></h5>
                  <p>Sinh tố dâu rừng mát lạnh, tự nhiên, giàu vitamin – lựa chọn hoàn hảo cho ngày hè tươi mới.</p>
                  <div class="price">$7.95</div>
                </div>
              </div>
            </div>
          </div>

        </div>

        <div class="text-center mt-5" data-aos="fade-up">
          <a href="#" class="download-menu">
            <i class="bi bi-file-earmark-pdf"></i> Tất cả Menu
          </a>
        </div>

        <!-- Chef's Specials -->
        <div class="col-12 mt-5" data-aos="fade-up">
          <div class="specials-badge">
            <span><i class="bi bi-award"></i> Chef's Specials</span>
          </div>
          <div class="specials-container">
            <div class="row g-4">
              <div class="col-md-6">
                <div class="menu-item special-item">
                  <div class="menu-item-img">
                    <img src="assets/img/restaurant/main-3.webp" alt="Special Dish" class="img-fluid">
                    <div class="menu-item-badges">
                        <span class="badge-special">Đặc biệt</span>
                        <span class="badge-vegan">Thuần chay</span>
                    </div>
                  </div>
                  <div class="menu-item-content">
                    <h4>Mediterranean Grilled Salmon</h4>
                    <p>Cá hồi nướng kiểu Địa Trung Hải, tẩm ướp tinh tế với dầu ô liu, tiêu đen và chanh vàng – món ăn giàu dinh dưỡng, vị thanh tao.</p>
                    <div class="menu-item-price">$24.99</div>
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="menu-item special-item">
                  <div class="menu-item-img">
                    <img src="assets/img/restaurant/main-7.webp" alt="Special Dish" class="img-fluid">
                    <div class="menu-item-badges">
                        <span class="badge-special">Đặc biệt</span>
                        <span class="badge-spicy">Cay nồng</span>
                    </div>
                  </div>
                  <div class="menu-item-content">
                    <h4>Signature Ribeye Steak</h4>
                    <p>Bít tết Ribeye đậm đà, nướng chín tới với sốt tiêu cay nhẹ và rau củ tươi – trải nghiệm ẩm thực nồng nàn đầy năng lượng.</p>
                    <div class="menu-item-price">$32.99</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </section><!-- /Menu Section -->

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