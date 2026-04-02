<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">


 <%@include file="/customer/header.jsp"%>
  <style>
.hero-content h1 {
  font-family: 'Playfair Display', serif;
  font-size: 42px !important ;
  font-weight: 300 !important;
  color:#2f5d50!important;
  
}

.hero-content p.lead {
  font-family: 'Be Vietnam Pro', sans-serif;
  font-size: 18px;
  line-height: 1.7;
  color: #f9f9f9; /* trắng dịu tương phản nhẹ với nền */
  max-width: 700px;
  margin-top: 15px;
}


@media (max-width: 768px) {
    .hotel-hero .hero-stats .stat-cus-item .stat-cus-number {
        font-size: 2rem;
    }
}
.hotel-hero .hero-stats .stat-cus-item .stat-cus-number {
    display: block;
    font-size: 2.5rem;
    font-weight: 700;
    color: var(--accent-color);
    line-height: 1;
    margin-bottom: 0.5rem;
}
*, ::after, ::before {
    box-sizing: border-box;
}

</style>
  

  <main class="main">

<%-- <p>Account: ${sessionScope.account}</p>
<p>User: ${sessionScope.user}</p>
<p>Customer: ${sessionScope.customer}</p> --%>
	
    <!-- Hotel Hero Section -->
    <section id="hotel-hero" class="hotel-hero section">

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="row gy-4 align-items-center">

          <div class="col-lg-6" data-aos="fade-right" data-aos-delay="200">
            <div class="hero-content">
              <h1>Định nghĩa lại kỳ nghỉ của bạn</h1>
              <p class="lead">Trải nghiệm sự thoải mái và tinh tế tuyệt vời tại khách sạn cao cấp của chúng tôi.
					Từ những phòng sang trọng đến các tiện nghi đẳng cấp quốc tế, mọi khoảnh khắc trong kỳ nghỉ của bạn đều được chăm chút đến hoàn hảo.</p>
              <div class="hero-features">
                <div class="feature-item">
                  <i class="bi bi-wifi"></i>
                  <span>WiFi tốc độ cao</span>
                </div>
                <div class="feature-item">
                  <i class="bi bi-car-front"></i>
                  <span>Đỗ xe miễn phí</span>
                </div>
                <div class="feature-item">
                  <i class="bi bi-cup-hot"></i>
                  <span>Dịch vụ sãn sàng 24/7</span>
                </div>
              </div>
              <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/booking?id=${sessionScope.customer.cus_id}" class="btn btn-primary">Đặt ngay</a>
                <a href="${pageContext.request.contextPath}/viewrooms" class="btn btn-outline">Xem phòng</a>
              </div>
            </div>
          </div>

          <div class="col-lg-6" data-aos="fade-left" data-aos-delay="300">
            <div class="hero-images">
              <div class="main-image">
                <img src="assets/img/hotel/showcase-3.webp" alt="Luxury Hotel" class="img-fluid">
              </div>
              <div class="floating-card" data-aos="zoom-in" data-aos-delay="400">
                <div class="card-content">
                  <div class="rating">
                    <i class="bi bi-star-fill"></i>
                    <i class="bi bi-star-fill"></i>
                    <i class="bi bi-star-fill"></i>
                    <i class="bi bi-star-fill"></i>
                  </div>
                  <h6>Một trải nghiệm thật tuyệt vời</h6>
                  <p>"Thật là một khách sạn hoàn hảo! Dịch vụ chu đáo mang lại những phút giây thư giãn khó quên."</p>
                  <div class="guest-info">
                    <img src="images/jack.jpeg" alt="Guest" class="guest-avatar">
                    <span> Phương Tuấn</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

        </div>
		
        <div class="hero-stats" data-aos="fade-up">
          <div class="row text-center">
            <div class="col-md-3 col-6">
              <div class="stat-item">
                <span class="stat-number purecounter" data-purecounter-start="0" data-purecounter-end="${room_number }" data-purecounter-duration="1">${room_number }</span>
                <span class="stat-label">Phòng cao cấp</span>
              </div>
            </div>
            <div class="col-md-3 col-6">
              <div class="stat-cus-item">
                <span class="stat-cus-number ">${avg_star }</span>
                <span class="stat-label">Sao đánh giá</span>
              </div>
            </div>
            <div class="col-md-3 col-6">
              <div class="stat-item">
                <span class="stat-number purecounter" data-purecounter-start="0" data-purecounter-end="24" data-purecounter-duration="1">24</span>
                <span class="stat-label">Giờ phục vụ</span>
              </div>
            </div>
            <div class="col-md-3 col-6">
              <div class="stat-item">
                <span class="stat-number purecounter" data-purecounter-start="0" data-purecounter-end="${cus_sastified }" data-purecounter-duration="1">${cus_sastified }</span>
                <span class="stat-label">Khách hàng hài lòng</span>
              </div>
            </div>
          </div>
        </div>

      </div>

    </section><!-- /Hotel Hero Section -->

    <!-- About Home Section -->
    <section id="about-home" class="about-home section light-background">

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="row gy-4 align-items-center">

          <div class="col-lg-6" data-aos="fade-right" data-aos-delay="200">
            <div class="about-content">
              <h2>Chào mừng đến với San Premium</h2>
              <p class="lead">Nơi sang trọng hòa quyện cùng sự tĩnh lặng giữa thiên nhiên tuyệt mỹ.</p>
              <p>Nằm giữa trung tâm thành phố, San Premium đã mang đến dịch vụ hiếu khách đẳng cấp suốt hơn ba thập kỷ qua. Sự tận tâm và chú trọng đến từng chi tiết tạo nên một trải nghiệm khó quên cho những du khách yêu thích sự thoải mái và phiêu lưu.</p>
              <p>Từ những căn phòng được thiết kế tinh tế đến các tiện nghi đạt chuẩn quốc tế, mọi khoảnh khắc trong kỳ nghỉ của bạn đều được chăm chút để vượt trên mong đợi. Hãy khám phá khung cảnh ngoạn mục, ẩm thực tinh hoa và dịch vụ cá nhân hóa khiến từng giây phút trở nên đặc biệt.</p>

              <div class="stats-row">
                <div class="stat-item">
                  <div class="stat-number">${room_number }</div>
                  <div class="stat-label">Phòng cao cấp</div>
                </div>
                <div class="stat-item">
                  <div class="stat-number">${percent }%</div>
                  <div class="stat-label">Khách hàng hài lòng</div>
                </div>
                <div class="stat-item">
                  <div class="stat-number">10</div>
                  <div class="stat-label">Năm trong ngành</div>
                </div>
              </div><!-- End Stats Row -->

              <div class="about-actions">
                <a href="${pageContext.request.contextPath}/about" class="btn-primary">Thông tin</a>
                <a href="${pageContext.request.contextPath}/viewrooms" class="btn-secondary">Xem phòng</a>
              </div>
            </div>
          </div><!-- End About Content -->

          <div class="col-lg-6" data-aos="fade-left" data-aos-delay="300">
            <div class="about-images">
              <div class="main-image">
                <img src="assets/img/hotel/showcase-8.webp" alt="Grandview Resort Main View" class="img-fluid">
              </div>
              <div class="secondary-image">
                <img src="assets/img/hotel/room-12.webp" alt="Luxury Suite Interior" class="img-fluid">
              </div>
              <div class="experience-badge">
                <div class="badge-content">
                  <span class="badge-number">10+</span>
                  <span class="badge-text">Năm<br>kinh nghiệm</span>
                </div>
              </div>
            </div>
          </div><!-- End About Images -->

        </div>

      </div>

    </section><!-- /About Home Section -->

    <!-- Rooms Showcase Section -->
    <section id="rooms-showcase" class="rooms-showcase section">

      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <span class="description-title">Các loại phòng</span>
        <h2>Các loại phòng</h2>
        <p>Mang đến cho bạn không gian nghỉ dưỡng hoàn hảo với sự thoải mái và phong cách tinh tế.</p>
      </div><!-- End Section Title -->

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="row gy-5">
          <div class="col-xl-8" data-aos="zoom-in" data-aos-delay="200">
            <div class="hero-room-showcase">
              <div class="showcase-image-container">
                <img src="${r_type[0].rt_img_url }" alt="Grand Presidential Suite" class="img-fluid">
                <div class="room-category-badge">
                  <span>${r_type[0].rt_name }</span>
                </div>
                <div class="room-details-overlay">
                  <div class="room-specs">
                    <span class="spec-item">
                      <i class="bi bi-people"></i>
                      <span>${r_type[0].rt_max_people } Người</span>
                    </span>
                    <span class="spec-item">
                      <i class="bi bi-house"></i>
                      <span>${r_type[0].rt_area }m²</span>
                    </span>
                    <span class="spec-item">
                      <i class="bi bi-geo-alt"></i>
                      <span>Tầng thượng</span>
                    </span>
                  </div>
                </div>
              </div>
              <div class="showcase-content">
                <div class="room-title-section">
                  <h2>${r_type[0].rt_name }</h2>
                  
                </div>
                <p class="room-description">${r_type[0].rt_description }</p>
                <div class="amenities-grid">
                  <div class="amenity-item">
                    <i class="bi bi-check"></i>
                    <span>${r_type[0].rt_special }</span>
                 	</div>
                </div>
                <div class="booking-section">
                  <div class="price-display">
                    
                    <span class="amount">${r_type[0].rt_price }</span>
                    <span class="currency">VNĐ</span>
                    <span class="period"> /đêm</span>
                  </div>
                  <a href="${pageContext.request.contextPath}/roomdetail?id=${r_type[0].rt_id}" class="primary-booking-btn">Xem chi tiết</a>
                </div>
              </div>
            </div>
          </div><!-- End Hero Room -->

          <div class="col-xl-4">
            <div class="room-list-container">
				<c:forEach var="i" begin="1" end="3">
							<div class="standard-room-card" data-aos="slide-left" data-aos-delay="250">
                <div class="card-image">
                  <img src="${r_type[i].rt_img_url }" alt="Executive Room" class="img-fluid">
                  <div class="view-link">
                    <i class="bi bi-arrow-up-right"></i>
                  </div>
                </div>
                <div class="card-content">
                  <h4>${r_type[i].rt_name }</h4>
                  <p>${r_type[i].rt_description }</p>
                  <div class="features-list">
                    <span><i class="bi bi-check"></i>${r_type[i].rt_special }</span>
                    
                  </div>
                  <div class="booking-row">
                    <div >
    					<span class="amount">${r_type[i].rt_price}</span>
    					 <small>VNĐ/đêm</small>
					</div>
                   
                    <a href="${pageContext.request.contextPath}/hroomdetail?id=${r_type[i].rt_id}" class="book-link">Xem</a>
                  </div>
                </div>
              </div><!-- End Standard Room -->				
				</c:forEach>
            </div>
          </div>

        </div>
        <div class="text-center" data-aos="fade-up" data-aos-delay="600">
          <a href="${pageContext.request.contextPath}/viewrooms" class="explore-all-link">
            <span>Xem tất cả các phòng</span>
            <i class="bi bi-arrow-right"></i>
          </a>
        </div>

      </div>

    </section><!-- /Rooms Showcase Section -->

    <!-- Amenities Cards Section -->
    <section id="amenities-cards" class="amenities-cards section">

      <div class="container section-title" data-aos="fade-up">
        <span class="description-title">Tiện nghi</span>
        <h2>Tiện nghi</h2>
        <p>Necessitatibus eius consequatur ex aliquid fuga eum quidem sint consectetur velit</p>
      </div><div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="row g-5">

          <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
            <div class="facility-card">
              <div class="facility-image">
                <img src="assets/img/hotel/amenities-1.webp" alt="Internet Không Dây" class="img-fluid">
                <div class="facility-overlay">
                  <i class="bi bi-wifi"></i>
                </div>
              </div>
              <div class="facility-info">
                <h4>Internet tốc độ cao</h4>
                <p>Truy cập internet không dây miễn phí trong toàn bộ khuôn viên khách sạn với bảo mật cấp độ doanh nghiệp và băng thông không giới hạn cho mọi nhu cầu kết nối của bạn.</p>
                <div class="facility-features">
                  <span><i class="bi bi-check-circle"></i> Có sẵn 24/7</span>
                  <span><i class="bi bi-check-circle"></i> Tốc độ cao</span>
                </div>
              </div>
            </div>
          </div><div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="150">
            <div class="facility-card">
              <div class="facility-image">
                <img src="assets/img/hotel/amenities-3.webp" alt="Hồ Bơi" class="img-fluid">
                <div class="facility-overlay">
                  <i class="bi bi-droplet"></i>
                </div>
              </div>
              <div class="facility-info">
                <h4>Hồ bơi tầng thượng</h4>
                <p>Hồ bơi sang trọng trên tầng thượng với tầm nhìn ngoạn mục ra đường chân trời thành phố. Có nước nóng, dịch vụ bên hồ bơi và khu vực ghế dài cao cấp để thư giãn tối đa.</p>
                <div class="facility-features">
                  <span><i class="bi bi-check-circle"></i> Hồ bơi nước nóng</span>
                  <span><i class="bi bi-check-circle"></i> Tầm nhìn thành phố</span>
                </div>
              </div>
            </div>
          </div><div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
            <div class="facility-card">
              <div class="facility-image">
                <img src="assets/img/hotel/amenities-5.webp" alt="Đỗ Xe Có Người Trông" class="img-fluid">
                <div class="facility-overlay">
                  <i class="bi bi-car-front"></i>
                </div>
              </div>
              <div class="facility-info">
                <h4>Đỗ xe miễn phí</h4>
                <p>Dịch vụ đỗ xe có người trông cao cấp với cơ sở vật chất dưới lòng đất an toàn. Nhân viên chuyên nghiệp đảm bảo xe của bạn được đỗ an toàn và sẵn sàng khi bạn yêu cầu.</p>
                <div class="facility-features">
                  <span><i class="bi bi-check-circle"></i> An toàn</span>
                  <span><i class="bi bi-check-circle"></i> Dịch vụ Valet</span>
                </div>
              </div>
            </div>
          </div><div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="250">
            <div class="facility-card">
              <div class="facility-image">
                <img src="assets/img/hotel/amenities-2.webp" alt="Trung tâm Thể dục" class="img-fluid">
                <div class="facility-overlay">
                  <i class="bi bi-heart-pulse"></i>
                </div>
              </div>
              <div class="facility-info">
                <h4>Trung tâm thể dục hiện đại</h4>
                <p>Cơ sở vật chất thể dục tiên tiến với thiết bị cao cấp, dịch vụ huấn luyện viên cá nhân và các chương trình chăm sóc sức khỏe được thiết kế để duy trì thói quen sức khỏe của bạn khi đi du lịch.</p>
                <div class="facility-features">
                  <span><i class="bi bi-check-circle"></i> Truy cập 24/7</span>
                  <span><i class="bi bi-check-circle"></i> Huấn luyện cá nhân</span>
                </div>
              </div>
            </div>
          </div><div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
            <div class="facility-card">
              <div class="facility-image">
                <img src="assets/img/hotel/dining-2.webp" alt="Ẩm thực Cao cấp" class="img-fluid">
                <div class="facility-overlay">
                  <i class="bi bi-cup-hot"></i>
                </div>
              </div>
              <div class="facility-info">
                <h4>Nhà hàng đặc trưng</h4>
                <p>Trải nghiệm ẩm thực từng đoạt giải thưởng với các món ăn quốc tế do các đầu bếp nổi tiếng chế biến. Không gian trang nhã với tuyển chọn rượu vang phong phú và dịch vụ hoàn hảo.</p>
                <div class="facility-features">
                  <span><i class="bi bi-check-circle"></i> Ẩm thực cao cấp</span>
                  <span><i class="bi bi-check-circle"></i> Tuyển chọn rượu vang</span>
                </div>
              </div>
            </div>
          </div><div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="350">
            <div class="facility-card">
              <div class="facility-image">
                <img src="assets/img/hotel/amenities-4.webp" alt="Dịch vụ Spa" class="img-fluid">
                <div class="facility-overlay">
                  <i class="bi bi-flower1"></i>
                </div>
              </div>
              <div class="facility-info">
                <h4>Spa sang trọng</h4>
                <p>Khu bảo tồn yên tĩnh cung cấp các liệu pháp trị liệu, mát-xa trẻ hóa và trải nghiệm chăm sóc sức khỏe toàn diện. Trốn khỏi những căng thẳng hàng ngày trong môi trường thanh bình của chúng tôi.</p>
                <div class="facility-features">
                  <span><i class="bi bi-check-circle"></i> Dịch vụ trọn gói</span>
                  <span><i class="bi bi-check-circle"></i> Chương trình chăm sóc sức khỏe</span>
                </div>
              </div>
            </div>
          </div></div>

      </div>

    </section>
   

    <!-- Events Cards Section -->
   <section id="events-cards" class="events-cards section">

      <div class="container section-title" data-aos="fade-up">
        <span class="description-title">Sự kiện</span>
        <h2>Sự kiện</h2>
        <p>Necessitatibus eius consequatur ex aliquid fuga eum quidem sint consectetur velit</p>
      </div><div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="row g-4">

          <div class="col-lg-4 col-md-6">
            <div class="event-item" data-aos="fade-up" data-aos-delay="100">
              <div class="event-header">
                <div class="event-icon">
                  <i class="bi bi-heart-fill"></i>
                </div>
                <img src="assets/img/hotel/event-1.webp" alt="Lễ Kỷ Niệm Đám Cưới" class="img-fluid">
              </div>
              <div class="event-content">
                <h4>Tiệc Cưới</h4>
                <p>Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor</p>
                <div class="event-features">
                  <span class="feature-item"><i class="bi bi-check-circle"></i> Địa điểm cao cấp</span>
                  <span class="feature-item"><i class="bi bi-check-circle"></i> Dịch vụ ăn uống trọn gói</span>
                </div>
                <a href="${pageContext.request.contextPath}/events" class="event-link">
                  Khám phá Chi tiết <i class="bi bi-arrow-right"></i>
                </a>
              </div>
            </div>
          </div><div class="col-lg-4 col-md-6">
            <div class="event-item" data-aos="fade-up" data-aos-delay="200">
              <div class="event-header">
                <div class="event-icon">
                  <i class="bi bi-building"></i>
                </div>
                <img src="assets/img/hotel/event-4.webp" alt="Hội Nghị Kinh Doanh" class="img-fluid">
              </div>
              <div class="event-content">
                <h4>Hội Nghị Kinh Doanh</h4>
                <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium</p>
                <div class="event-features">
                  <span class="feature-item"><i class="bi bi-check-circle"></i> Công nghệ hiện đại</span>
                  <span class="feature-item"><i class="bi bi-check-circle"></i> Truy cập WiFi</span>
                </div>
                <a href="${pageContext.request.contextPath}/events" class="event-link">
                  Khám phá Chi tiết <i class="bi bi-arrow-right"></i>
                </a>
              </div>
            </div>
          </div><div class="col-lg-4 col-md-6">
            <div class="event-item" data-aos="fade-up" data-aos-delay="300">
              <div class="event-header">
                <div class="event-icon">
                  <i class="bi bi-calendar-event"></i>
                </div>
                <img src="assets/img/hotel/event-8.webp" alt="Dịp Đặc Biệt" class="img-fluid">
              </div>
              <div class="event-content">
                <h4>Các Dịp Đặc Biệt</h4>
                <p>Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi</p>
                <div class="event-features">
                  <span class="feature-item"><i class="bi bi-check-circle"></i> Thiết lập Tùy chỉnh</span>
                  <span class="feature-item"><i class="bi bi-check-circle"></i> Phối hợp Sự kiện</span>
                </div>
                <a href="${pageContext.request.contextPath}/events" class="event-link">
                  Khám phá Chi tiết <i class="bi bi-arrow-right"></i>
                </a>
              </div>
            </div>
          </div><div class="col-lg-4 col-md-6">
            <div class="event-item" data-aos="fade-up" data-aos-delay="100">
              <div class="event-header">
                <div class="event-icon">
                  <i class="bi bi-people"></i>
                </div>
                <img src="assets/img/hotel/event-5.webp" alt="Các Chuyến Nghỉ Dưỡng Công Ty" class="img-fluid">
              </div>
              <div class="event-content">
                <h4>Các Chuyến Nghỉ Dưỡng Công Ty</h4>
                <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore</p>
                <div class="event-features">
                  <span class="feature-item"><i class="bi bi-check-circle"></i> Xây dựng Đội ngũ</span>
                  <span class="feature-item"><i class="bi bi-check-circle"></i> Hoạt động Ngoài trời</span>
                </div>
                <a href="${pageContext.request.contextPath}/events" class="event-link">
                  Khám phá Chi tiết <i class="bi bi-arrow-right"></i>
                </a>
              </div>
            </div>
          </div><div class="col-lg-4 col-md-6">
            <div class="event-item" data-aos="fade-up" data-aos-delay="200">
              <div class="event-header">
                <div class="event-icon">
                  <i class="bi bi-music-note-beamed"></i>
                </div>
                <img src="assets/img/hotel/event-6.webp" alt="Sự Kiện Giải Trí" class="img-fluid">
              </div>
              <div class="event-content">
                <h4>Sự Kiện Giải Trí</h4>
                <p>Excepteur sint occaecat cupidatat non proident sunt in culpa qui officia</p>
                <div class="event-features">
                  <span class="feature-item"><i class="bi bi-check-circle"></i> Nhạc Sống</span>
                  <span class="feature-item"><i class="bi bi-check-circle"></i> Sàn Nhảy</span>
                </div>
                <a href="${pageContext.request.contextPath}/events" class="event-link">
                  Khám phá Chi tiết <i class="bi bi-arrow-right"></i>
                </a>
              </div>
            </div>
          </div><div class="col-lg-4 col-md-6">
            <div class="event-item" data-aos="fade-up" data-aos-delay="300">
              <div class="event-header">
                <div class="event-icon">
                  <i class="bi bi-star"></i>
                </div>
                <img src="assets/img/hotel/event-9.webp" alt="Tụ Họp VIP" class="img-fluid">
              </div>
              <div class="event-content">
                <h4>Tiệc Tụ Họp VIP</h4>
                <p>Mollit anim id est laborum at vero eos et accusamus et iusto odio dignissimos</p>
                <div class="event-features">
                  <span class="feature-item"><i class="bi bi-check-circle"></i> Truy cập Độc quyền</span>
                  <span class="feature-item"><i class="bi bi-check-circle"></i> Dịch vụ Cao cấp</span>
                </div>
                <a href="${pageContext.request.contextPath}/events" class="event-link">
                  Khám phá Chi tiết <i class="bi bi-arrow-right"></i>
                </a>
              </div>
            </div>
          </div></div>

      </div>

    </section>

    <!-- Location Cards Section -->
    <section id="location-cards" class="location-cards section">

      <div class="container section-title" data-aos="fade-up">
        <span class="description-title">Vị trí &amp; Hoạt động</span>
        <h2>Vị trí &amp; Hoạt động</h2>
        <p>Necessitatibus eius consequatur ex aliquid fuga eum quidem sint consectetur velit</p>
      </div><div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="row gy-5 align-items-center">
          <div class="col-lg-8">
            <div class="row gy-4">
              <div class="col-md-6" data-aos="zoom-in" data-aos-delay="200">
                <div class="area-highlight">
                  <div class="area-image-wrapper">
                    <img src="assets/img/hotel/location-3.webp" alt="Khu Giải Trí" class="img-fluid">
                    <div class="area-badge">
                      <i class="bi bi-music-note-beamed"></i>
                      <span>2 phút đi bộ</span>
                    </div>
                  </div>
                  <div class="area-info">
                    <h5>Khu Giải Trí</h5>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum.</p>
                    <div class="quick-stats">
                      <span><i class="bi bi-clock"></i> Mở cửa 24/7</span>
                      <span><i class="bi bi-star-fill"></i> Đánh giá 4.8</span>
                    </div>
                  </div>
                </div>
              </div><div class="col-md-6" data-aos="zoom-in" data-aos-delay="300">
                <div class="area-highlight">
                  <div class="area-image-wrapper">
                    <img src="assets/img/hotel/location-6.webp" alt="Bến Du Thuyền Bờ Sông" class="img-fluid">
                    <div class="area-badge">
                      <i class="bi bi-water"></i>
                      <span>5 phút lái xe</span>
                    </div>
                  </div>
                  <div class="area-info">
                    <h5>Bến Du Thuyền Bờ Sông</h5>
                    <p>Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.</p>
                    <div class="quick-stats">
                      <span><i class="bi bi-brightness-high"></i> Cảnh quan tuyệt đẹp</span>
                      <span><i class="bi bi-camera"></i> Địa điểm chụp ảnh</span>
                    </div>
                  </div>
                </div>
              </div><div class="col-md-6" data-aos="zoom-in" data-aos-delay="400">
                <div class="area-highlight">
                  <div class="area-image-wrapper">
                    <img src="assets/img/hotel/location-8.webp" alt="Khu Phố Cổ" class="img-fluid">
                    <div class="area-badge">
                      <i class="bi bi-bank"></i>
                      <span>10 phút đi bộ</span>
                    </div>
                  </div>
                  <div class="area-info">
                    <h5>Khu Phố Cổ</h5>
                    <p>Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute.</p>
                    <div class="quick-stats">
                      <span><i class="bi bi-book"></i> Tham quan có hướng dẫn</span>
                      <span><i class="bi bi-bicycle"></i> Thân thiện với xe đạp</span>
                    </div>
                  </div>
                </div>
              </div><div class="col-md-6" data-aos="zoom-in" data-aos-delay="500">
                <div class="area-highlight">
                  <div class="area-image-wrapper">
                    <img src="assets/img/hotel/location-4.webp" alt="Trung Tâm Mua Sắm" class="img-fluid">
                    <div class="area-badge">
                      <i class="bi bi-shop"></i>
                      <span>3 phút đi bộ</span>
                    </div>
                  </div>
                  <div class="area-info">
                    <h5>Trung Tâm Mua Sắm Cao Cấp</h5>
                    <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.</p>
                    <div class="quick-stats">
                      <span><i class="bi bi-credit-card"></i> Miễn thuế</span>
                      <span><i class="bi bi-cup-hot"></i> Có Quán cà phê bên trong</span>
                    </div>
                  </div>
                </div>
              </div></div>
          </div>

          <div class="col-lg-4" data-aos="fade-left" data-aos-delay="200">
            <div class="location-overview">
              <div class="overview-header">
                <div class="location-marker">
                  <i class="bi bi-geo-alt-fill"></i>
                </div>
                <h3>Vị trí đắc địa</h3>
                <p class="overview-subtitle">Trải nghiệm đầy đủ tiện ích tại trung tâm thành phố</p>
              </div>

              <div class="benefits-list">
                <div class="benefit-item">
                  <div class="benefit-icon">
                    <i class="bi bi-train-front"></i>
                  </div>
                  <div class="benefit-content">
                    <h6>Trung tâm giao thông công cộng</h6>
                    <span>Ga tàu điện ngầm cách 200m</span>
                  </div>
                </div>

                <div class="benefit-item">
                  <div class="benefit-icon">
                    <i class="bi bi-airplane"></i>
                  </div>
                  <div class="benefit-content">
                    <h6>Kết nối sân bay</h6>
                    <span>Xe đưa đón trực tiếp cứ sau 30 phút</span>
                  </div>
                </div>

                <div class="benefit-item">
                  <div class="benefit-icon">
                    <i class="bi bi-car-front"></i>
                  </div>
                  <div class="benefit-content">
                    <h6>Đỗ Xe Có Người Trông (Valet Parking)</h6>
                    <span>Miễn phí cho khách lưu trú</span>
                  </div>
                </div>

                <div class="benefit-item">
                  <div class="benefit-icon">
                    <i class="bi bi-compass"></i>
                  </div>
                  <div class="benefit-content">
                    <h6>Tiếp cận trung tâm thành phố</h6>
                    <span>Khoảng cách đi bộ đến các điểm tham quan chính</span>
                  </div>
                </div>
              </div>

              <a href="${pageContext.request.contextPath}/location" class="location-guide-btn">
                <span>Xem Hướng dẫn vị trí đầy đủ</span>
                <i class="bi bi-arrow-right"></i>
              </a>
            </div>
          </div>

        </div>

      </div>

    </section>
    <!-- Gallery Showcase Section -->
    <section id="gallery-showcase" class="gallery-showcase section">

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="gallery-carousel swiper init-swiper" data-aos="fade-up" data-aos-delay="200">
          <script type="application/json" class="swiper-config">
            {
              "loop": true,
              "speed": 600,
              "autoplay": {
                "delay": 3000
              },
              "slidesPerView": 1,
              "spaceBetween": 20,
              "centeredSlides": true,
              "breakpoints": {
                "576": {
                  "slidesPerView": 2,
                  "centeredSlides": false
                },
                "768": {
                  "slidesPerView": 3,
                  "centeredSlides": false
                },
                "992": {
                  "slidesPerView": 4,
                  "centeredSlides": false
                },
                "1200": {
                  "slidesPerView": 5,
                  "centeredSlides": false
                }
              }
            }
          </script>
          <div class="swiper-wrapper">
            <div class="swiper-slide">
              <div class="gallery-item">
                <img src="assets/img/hotel/gallery-1.webp" alt="Luxurious Suite" class="img-fluid" loading="lazy">
                <a href="assets/img/hotel/gallery-1.webp" class="gallery-overlay glightbox">
                  <i class="bi bi-eye"></i>
                </a>
              </div>
            </div>
            <div class="swiper-slide">
              <div class="gallery-item">
                <img src="assets/img/hotel/gallery-5.webp" alt="Modern Lobby" class="img-fluid" loading="lazy">
                <a href="assets/img/hotel/gallery-5.webp" class="gallery-overlay glightbox">
                  <i class="bi bi-eye"></i>
                </a>
              </div>
            </div>
            <div class="swiper-slide">
              <div class="gallery-item">
                <img src="assets/img/hotel/gallery-12.webp" alt="Elegant Dining Area" class="img-fluid" loading="lazy">
                <a href="assets/img/hotel/gallery-12.webp" class="gallery-overlay glightbox">
                  <i class="bi bi-eye"></i>
                </a>
              </div>
            </div>
            <div class="swiper-slide">
              <div class="gallery-item">
                <img src="assets/img/hotel/gallery-8.webp" alt="Grand Ballroom Setup" class="img-fluid" loading="lazy">
                <a href="assets/img/hotel/gallery-8.webp" class="gallery-overlay glightbox">
                  <i class="bi bi-eye"></i>
                </a>
              </div>
            </div>
            <div class="swiper-slide">
              <div class="gallery-item">
                <img src="assets/img/hotel/gallery-15.webp" alt="Relaxing Poolside" class="img-fluid" loading="lazy">
                <a href="assets/img/hotel/gallery-15.webp" class="gallery-overlay glightbox">
                  <i class="bi bi-eye"></i>
                </a>
              </div>
            </div>
            <div class="swiper-slide">
              <div class="gallery-item">
                <img src="assets/img/hotel/gallery-3.webp" alt="Cozy Guest Room" class="img-fluid" loading="lazy">
                <a href="assets/img/hotel/gallery-3.webp" class="gallery-overlay glightbox">
                  <i class="bi bi-eye"></i>
                </a>
              </div>
            </div>
            <div class="swiper-slide">
              <div class="gallery-item">
                <img src="assets/img/hotel/gallery-18.webp" alt="Spa and Wellness Center" class="img-fluid" loading="lazy">
                <a href="assets/img/hotel/gallery-18.webp" class="gallery-overlay glightbox">
                  <i class="bi bi-eye"></i>
                </a>
              </div>
            </div>
            <div class="swiper-slide">
              <div class="gallery-item">
                <img src="assets/img/hotel/gallery-7.webp" alt="Conference Facilities" class="img-fluid" loading="lazy">
                <a href="assets/img/hotel/gallery-7.webp" class="gallery-overlay glightbox">
                  <i class="bi bi-eye"></i>
                </a>
              </div>
            </div>
          </div>
        </div>

        <div class="text-center mt-5" data-aos="fade-up" data-aos-delay="300">
          <a href="${pageContext.request.contextPath}/gallery" class="btn btn-gallery">
            <i class="bi bi-collection me-2"></i>Khám phá bộ sưu tập của chúng tôi
          </a>
        </div>

      </div>

    </section><!-- /Gallery Showcase Section -->

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
<script>
  document.querySelectorAll('.amount').forEach(el => {
    const num = parseFloat(el.textContent);
    el.textContent = num.toLocaleString('vi-VN');
  });
 </script>


</body>

</html>