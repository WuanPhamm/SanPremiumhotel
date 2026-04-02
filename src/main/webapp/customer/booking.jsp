<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi">

<head>
    <%@include file="/customer/header.jsp"%>
    <style>
        /* Tùy chỉnh CSS cho giao diện đặt phòng hiện đại */
        
       .main {
    background: url('${pageContext.request.contextPath}/adimages/hotel1.jpg') no-repeat center center fixed !important;
    background-size: cover !important;
}
        
        body { background-color: #f8f9fa; }
        
        
        
        .booking-section { padding: 40px 0; }
        
        .form-section-card {
            background: #fff;
            border-radius: 16px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            border: 1px solid #f0f0f0;
        }

        .form-section-card h4 {
            font-size: 1.15rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #eef2f5;
            display: flex;
            align-items: center;
        }

        .form-section-card h4 i { color: #436e62; margin-right: 10px; font-size: 1.3rem; }

        .form-control, .form-select {
            border-radius: 10px;
            padding: 12px 15px;
            border: 1px solid #ced4da;
            background-color: #fcfcfc;
            transition: all 0.3s;
        }

        .form-control:focus, .form-select:focus {
            border-color: #436e62;
            box-shadow: 0 0 0 0.25rem rgba(67, 110, 98, 0.15);
            background-color: #fff;
        }

        .form-label { font-weight: 600; color: #4a5568; font-size: 0.95rem; }

        /* Cột bên phải: Sticky Summary */
        .summary-sidebar {
            position: sticky;
            top: 100px; /* Cách header một khoảng khi cuộn */
        }

        .summary-card {
            background: #fff;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            border-top: 5px solid #436e62;
            margin-bottom: 20px;
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            font-size: 1.05rem;
            color: #4a5568;
        }

        .total-price-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px dashed #cbd5e1;
        }

        .total-price-label { font-size: 1.2rem; font-weight: 700; color: #2c3e50; }
        
        #total-amount-display {
            font-size: 1.8rem;
            font-weight: 800;
            color: #e74c3c; /* Màu đỏ nổi bật cho tổng tiền */
        }

        .btn-submit-booking {
            background-color: #436e62;
            color: white;
            border: none;
            padding: 16px;
            border-radius: 12px;
            font-size: 1.15rem;
            font-weight: 700;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .btn-submit-booking:hover:not(:disabled) {
            background-color: #325249;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(67, 110, 98, 0.3);
        }

        .btn-submit-booking:disabled {
            background-color: #95a5a6;
            cursor: not-allowed;
        }

        /* Hotel Highlights thu gọn cho Sidebar */
        .mini-highlights .highlight-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 12px;
            font-size: 0.9rem;
        }
        .mini-highlights i { color: #436e62; font-size: 1.2rem; margin-right: 10px; }
        .mini-highlights h6 { margin: 0 0 3px 0; font-weight: 600; font-size: 0.95rem; }
        .mini-highlights p { margin: 0; color: #6c757d; font-size: 0.85rem; }
    </style>
</head>

<body>
<main class="main" style="background-image: url('${pageContext.request.contextPath}/adimages/hotel1.jpg');
             background-size: cover;
             background-position: center;
             background-repeat: no-repeat;
             min-height: 100vh;">

    <div class="page-title light-background py-4" >
        <div class="container d-lg-flex justify-content-between align-items-center">
            <h1 class="mb-2 mb-lg-0 fw-bold">Tiến hành đặt phòng</h1>
            <nav class="breadcrumbs">
                <ol>
                    <li><a href="index.html">Trang Chủ</a></li>
                    <li class="current">Đặt Phòng</li>
                </ol>
            </nav>
        </div>
    </div>

    <section id="booking" class="booking-section" >
        <div class="container" data-aos="fade-up" data-aos-delay="100">
            
            <form class="reservation-form" action="${contextPath}/booking" method="POST">
                <input type="hidden" name="action" value="book">
                <input type="hidden" name="customer_id" value="${cus.cus_id}">
                <input type="hidden" name="booking_total" id="booking-total-hidden">

                <div class="row">
                    
                    <div class="col-lg-8" data-aos="fade-right" data-aos-delay="200">
                        
                        <div class="form-section-card">
                            <h4><i class="bi bi-door-open"></i> Thông tin phòng nghỉ</h4>
                            <div class="row g-3">
                                <div class="col-md-12">
                                    <label for="accommodation-type" class="form-label">Loại phòng</label>
                                    <select class="form-select" id="accommodation-type" name="rt_id" required>
                                        <option value="" disabled selected hidden>Chọn loại phòng</option>
                                        <c:forEach var="rt" items="${list_room_type_all}">
                                            <option value="${rt.rt_id}" data-price="${rt.rt_price}">${rt.rt_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="floor-select" class="form-label">Tầng</label>
                                    <select class="form-select" id="floor-select" name="floor_id" required disabled>
                                        <option value="" disabled selected hidden>Chọn loại phòng trước</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="room-select" class="form-label">Phòng</label>
                                    <select class="form-select" id="room-select" name="room_id" required disabled>
                                        <option value="" disabled selected hidden>Chọn tầng trước</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-section-card">
                            <h4><i class="bi bi-calendar-range"></i> Thời gian lưu trú</h4>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="arrival-date" class="form-label">Ngày nhận phòng</label>
                                    <input type="date" class="form-control" id="arrival-date" name="arrival_date" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="departure-date" class="form-label">Ngày trả phòng</label>
                                    <input type="date" class="form-control" id="departure-date" name="departure_date" required>
                                </div>
                                <div class="col-12">
                                    <div id="date-error-message" class="alert alert-danger py-2 mt-2" style="display: none; font-size: 0.9em;"></div>
                                </div>
                                <div class="col-12 mt-3">
                                    <label for="additional-notes" class="form-label">Yêu cầu bổ sung (Tùy chọn)</label>
                                    <textarea class="form-control" id="additional-notes" name="requirements" rows="2" placeholder="VD: Xin phòng yên tĩnh, phòng có view đẹp..."></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="form-section-card mb-lg-0">
                            <h4><i class="bi bi-person-lines-fill"></i> Thông tin khách hàng</h4>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="primary-guest-fn" class="form-label">Họ</label>
                                    <input type="text" class="form-control" id="primary-guest-fn" name="primary_guest_fn" value="${cus.cus_firstname}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="primary-guest-ln" class="form-label">Tên</label>
                                    <input type="text" class="form-control" id="primary-guest-ln" name="primary_guest_ln" value="${cus.cus_lastname}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="contact-email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="contact-email" name="contact_email" value="${cus.cus_email}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="cus_phone" class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" id="cus_phone" name="cus_phone" value="${cus.cus_phone}" required>
                                </div>
                                <div class="col-md-12">
                                    <label for="cus_cccd" class="form-label">Số CCCD / CMND</label>
                                    <input type="text" class="form-control" id="cus_cccd" name="cus_cccd" value="${cus.cus_cccd}" required>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-lg-4" data-aos="fade-left" data-aos-delay="400">
                        <div class="summary-sidebar">
                            
                            <div class="summary-card">
                                <h4 class="fw-bold mb-4 border-bottom pb-2">Chi tiết thanh toán</h4>
                                
                                <div class="price-row">
                                    <span>Đơn giá phòng / đêm:</span>
                                    <span id="room-price-display" class="fw-bold text-dark">0 VND</span>
                                </div>
                                
                                <div class="total-price-row">
                                    <div class="total-price-label">TỔNG TIỀN:
                                        <small class="d-block text-muted fw-normal" style="font-size: 0.75rem;">(Đã bao gồm thuế & phí)</small>
                                    </div>
                                    <div id="total-amount-display">0 VND</div>
                                </div>

                                <button type="submit" class="btn btn-submit-booking shadow" id="submit" disabled>
                                    <i class="bi bi-shield-lock me-2"></i> Xác nhận đặt phòng
                                </button>
                                <p class="text-center text-muted small mt-3 mb-0">
                                    <i class="bi bi-info-circle"></i> Bạn chưa bị trừ tiền ở bước này.
                                </p>
                            </div>

                            <div class="form-section-card mini-highlights bg-light border-0">
                                <h5 class="fw-bold mb-3 fs-6">Tại sao chọn chúng tôi?</h5>
                                <div class="highlight-item">
                                    <i class="bi bi-wifi"></i>
                                    <div><h6>Wifi Miễn Phí</h6><p>Tốc độ cao mọi khu vực</p></div>
                                </div>
                                <div class="highlight-item">
                                    <i class="bi bi-clock"></i>
                                    <div><h6>Hỗ trợ 24/7</h6><p>Lễ tân phục vụ suốt ngày đêm</p></div>
                                </div>
                                <div class="highlight-item mb-0">
                                    <i class="bi bi-arrow-clockwise"></i>
                                    <div><h6>Hủy phòng linh hoạt</h6><p>Theo chính sách khách sạn</p></div>
                                </div>
                            </div>

                        </div>
                    </div>
                    </div> </form>
        </div>
    </section>

</main>



 <%@include file="/customer/footer.jsp"%>

<!-- Scroll Top -->
<a href="#" id="scroll-top"
	class="scroll-top d-flex align-items-center justify-content-center"><i
	class="bi bi-arrow-up-short"></i></a>

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
  const contextPath = "${contextPath}"; 
</script>


<script>
    // Lấy Context Path (bạn đã có
    // CÁCH 2: Tạo mảng thủ công từ JSTL (Ít linh hoạt hơn nếu dữ liệu phức tạp)
    const floorData = [];
    <c:forEach var="fl" items="${list_fl}">
        floorData.push({
            id: ${fl.floor_id},
            name: "${fl.floor_name}"
        });
    </c:forEach>
</script>
<script>
	document.addEventListener("DOMContentLoaded", function() {
						
		const rtSelect = document.getElementById("accommodation-type");
						
		const flSelect = document.getElementById("floor-select");
						
		const roomSelect = document.getElementById("room-select");
		
		const arrivalDateInput = document.getElementById("arrival-date");
        const departureDateInput = document.getElementById("departure-date");
        const priceDisplay = document.getElementById("room-price-display");
        const totalDisplay = document.getElementById("total-amount-display");
        
        const submitBtn = document.getElementById("submit");
        
     // --- PHẦN THÊM MỚI: Giới hạn ngày chọn bắt đầu từ hôm nay ---
        const today = new Date();
        const yyyy = today.getFullYear();
        let mm = today.getMonth() + 1; // Tháng bắt đầu từ 0
        let dd = today.getDate();

        // Định dạng lại thành chuỗi YYYY-MM-DD
        if (dd < 10) dd = '0' + dd;
        if (mm < 10) mm = '0' + mm;
        const todayStr = yyyy + '-' + mm + '-' + dd;

        // Thiết lập thuộc tính min cho ngày nhận phòng là hôm nay
        arrivalDateInput.setAttribute('min', todayStr);

        // Khi ngày nhận phòng thay đổi, ngày trả phòng tối thiểu phải là (ngày nhận + 1)
        arrivalDateInput.addEventListener('change', function() {
            if (arrivalDateInput.value) {
                let nextDay = new Date(arrivalDateInput.value);
                nextDay.setDate(nextDay.getDate() + 1);
                
                let nY = nextDay.getFullYear();
                let nM = (nextDay.getMonth() + 1).toString().padStart(2, '0');
                let nD = nextDay.getDate().toString().padStart(2, '0');
                
                const nextDayStr = `\${nY}-\${nM}-\${nD}`;
                departureDateInput.setAttribute('min', nextDayStr);
                
                // Nếu ngày trả phòng hiện tại nhỏ hơn hoặc bằng ngày nhận mới, thì reset ngày trả phòng
                if (departureDateInput.value && departureDateInput.value <= arrivalDateInput.value) {
                    departureDateInput.value = nextDayStr;
                }
            }
        });
        // -----------------------------------------------------------
										
						// Hàm load danh sách phòng
		console.log("contextPath =", contextPath);
						
		function loadFloors() {
					        // Xóa các option cũ
			flSelect.innerHTML = '<option value="">-- Chọn tầng --</option>';
			roomSelect.innerHTML = '<option value="">Vui lòng chọn tầng trước</option>';
			roomSelect.disabled = true;
					        
			const rt_Id = rtSelect.value;
					        
			if (!rt_Id) {
				flSelect.disabled = true;
				return;
					    }

					        // Kích hoạt select tầng
			flSelect.disabled = false;
					        
					        // Đổ dữ liệu từ mảng floorData đã lấy từ JSP
			floorData.forEach(fl => {
			 const opt = document.createElement("option");
			opt.value = fl.id;
			 opt.textContent = fl.name;
			 flSelect.appendChild(opt);
			});

					        // Nếu chỉ có 1 tầng, tự động chọn và load phòng
			if (floorData.length === 1) {
				flSelect.value = floorData[0].id;
				loadRooms(); // Gọi loadRooms để tải danh sách phòng
					        }
		}
						
						function loadRooms() {
						
							// Lấy giá trị từ HTML
						    const rt_Id = rtSelect.value;
						    const fl_Id = flSelect.value;
						    
						    // In ra giá trị *ngay sau khi lấy* (đã có trong code của bạn)
						    console.log("Giá trị rtId (từ select):", rt_Id); 
						    console.log("Giá trị flId (từ select):", fl_Id);
						    
						    console.log(rtSelect, flSelect, roomSelect);
							
						    if(!rt_Id){
						    	flSelect.innerHTML = '<option value="">Vui lòng chọn loại phòng trước</option>';
						        return;		
						    }
						    
						    
						    
						     if (!rt_Id || !fl_Id) {
						        roomSelect.innerHTML = '<option value="">-- Vui lòng chọn đủ điều kiện --</option>';
						        return;
						    } 

						    // Tạo URL
						    const url = `${contextPath}/getRooms?rt_id=\${rt_Id}&floor_id=\${fl_Id}`;

						    
						    // IN RA URL NGAY LẬP TỨC để kiểm tra giá trị *thực sự* được sử dụng
						    console.log("URL gửi đi (CHECK LẠI):", url);
						    
						    roomSelect.disabled = true;
						
						console.log("URL gửi đi:", url);
						
						fetch(url)
						
						.then(response => {
						
						if (!response.ok) {
						
						// In ra chi tiết lỗi từ server (nếu có)
						
						throw new Error(`Lỗi HTTP: ${response.status}`);
						
						}
						
						return response.json();
						
						})
						
						.then(data => {
						
						roomSelect.innerHTML = "";
						
						roomSelect.disabled = false;
						
						
						
						if (data.length === 0) {
						
						roomSelect.innerHTML = '<option value="">Không có phòng trống</option>';
						
						return;
						
						}
						
						
						data.forEach(room => {
						
						// SỬ DỤNG .id VÀ .name NẾU BẠN DÙNG ROOMDTO
						
						const opt = document.createElement("option");
						
						opt.value = room.id;
						
						opt.textContent = room.name;
						
						roomSelect.appendChild(opt);
						
						});
						
						})
						
						.catch(err => {
						
						console.error("Lỗi khi tải danh sách phòng:", err);
						
						roomSelect.innerHTML = '<option value="">Lỗi tải dữ liệu</option>';
						
						roomSelect.disabled = true;
						
						});
						
						}
						
						
						function calculateTotal() {
						    const selectedOption = rtSelect.options[rtSelect.selectedIndex];
						    // ... (các biến khác) ...
						    const totalHiddenInput = document.getElementById("booking-total-hidden"); // <--- Lấy trường ẩn

						    // 1. Lấy đơn giá (rt_price) từ data-price
						    const pricePerNight = selectedOption.getAttribute('data-price') ? 
						                          parseFloat(selectedOption.getAttribute('data-price')) : 0;

						    // 2. Lấy ngày nhận và ngày trả phòng
						    const arrivalDate = new Date(arrivalDateInput.value);
						    const departureDate = new Date(departureDateInput.value);

						    let numberOfDays = 0;
						    let totalPrice = 0;
						    
						    // 3. Tính số ngày lưu trú
						    if (arrivalDateInput.value && departureDateInput.value && arrivalDate < departureDate) {
						        // Tính khoảng thời gian bằng mili giây
						        const timeDifference = departureDate.getTime() - arrivalDate.getTime();
						        // Chuyển mili giây sang số ngày (1 ngày = 86,400,000 ms)
						        numberOfDays = Math.ceil(timeDifference / (1000 * 3600 * 24)); 
						        
						        // 4. Tính tổng tiền
						        totalPrice = pricePerNight * numberOfDays;
						    }

						    // Hàm định dạng tiền tệ (cho dễ nhìn)
						    const formatCurrency = (amount) => {
						        return new Intl.NumberFormat('vi-VN', {
						            style: 'currency',
						            currency: 'VND'
						        }).format(amount);
						    };

						    // 5. Cập nhật hiển thị
						    priceDisplay.textContent = formatCurrency(pricePerNight);
						    totalDisplay.textContent = formatCurrency(totalPrice);
						    
						    // 6. CẬP NHẬT GIÁ TRỊ VÀO INPUT ẨN ĐỂ GỬI LÊN SERVER
						    totalHiddenInput.value = totalPrice.toFixed(2); // Gửi giá trị số chính xác
						    
						    // Ghi log để kiểm tra
						    console.log(`Đơn giá: ${pricePerNight}, Số ngày: ${numberOfDays}, Tổng tiền: ${totalPrice}`);
						}
						
						
						function checkStartDate() {
						    const today = new Date();
						    today.setHours(0, 0, 0, 0);
						    const arrivalDate = new Date(arrivalDateInput.value);
						    const dateErrorMessage = document.getElementById("date-error-message");

						    // Reset thông báo lỗi trước
						    dateErrorMessage.style.display = 'none';
						    dateErrorMessage.textContent = '';

						    if (!arrivalDateInput.value) return false; // Chưa nhập thì thoát

						    // 1. Kiểm tra định dạng
						    if (isNaN(arrivalDate.getTime())) {
						        dateErrorMessage.textContent = "Ngày nhận phòng không đúng định dạng (YYYY-MM-DD).";
						        dateErrorMessage.style.display = 'block';
						        submitBtn.disabled = true;
						        return false;
						    }

						    // 2. Kiểm tra ngày nhận phòng so với hôm nay
						    if (arrivalDate < today) {
						        dateErrorMessage.textContent = "Ngày nhận phòng phải bắt đầu ít nhất từ hôm nay.";
						        dateErrorMessage.style.display = 'block';
						        submitBtn.disabled = true;
						        return false;
						    }
						    
						    return true; // Ngày đến hợp lệ
						}
						
						function loadUds() {

							
							const today = new Date();
						    today.setHours(0, 0, 0, 0);
						    const r_Id = roomSelect.value;
						    const arrivalDate = new Date(arrivalDateInput.value);
						    const departureDate = new Date(departureDateInput.value);
						    const dateErrorMessage = document.getElementById("date-error-message");
						    submitBtn.disabled = true;
						    // Reset thông báo lỗi
						    dateErrorMessage.style.display = 'none';
						    dateErrorMessage.textContent = '';
						    
						    console.log("Giá trị rId (từ select):", r_Id);
						    // Kiểm tra đã chọn phòng và ngày tháng chưa
						    
							
						    if (arrivalDateInput.value && isNaN(arrivalDate.getTime())) {
						        dateErrorMessage.textContent = "Ngày nhận phòng không đúng định dạng (YYYY-MM-DD).";
						        dateErrorMessage.style.display = 'block';
						        return;
						    }

						    // 2. Kiểm tra ngày nhận phòng phải từ hôm nay trở đi
						    if (arrivalDateInput.value && arrivalDate < today) {
						        dateErrorMessage.textContent = "Ngày nhận phòng phải bắt đầu ít nhất từ hôm nay.";
						        dateErrorMessage.style.display = 'block';
						        return;
						    }
						    
						    // Kiểm tra cơ bản ngày nhận/trả
						    if (arrivalDate >= departureDate) {
						        dateErrorMessage.textContent = "Ngày trả phòng phải sau ngày nhận phòng.";
						        dateErrorMessage.style.display = 'block';
						        return;
						    }

						    if (!r_Id || !arrivalDateInput.value || !departureDateInput.value) {
						        return;
						    }
						    
						    const url = `${contextPath}/getUnavailableDates?room_id=\${r_Id}`;
						    console.log("URL gửi đi để kiểm tra ngày không khả dụng:", url);

						    fetch(url)
						    .then(response => {
						        if (!response.ok) {
						            throw new Error(`Lỗi HTTP: ${response.status}`);
						        }
						        return response.json();
						    })
						    .then(data => {
						        let isConflict = false;
						        
						        // **KHÔNG RESET roomSelect**

						        for (const ud of data) {
						            // Chuyển chuỗi ngày từ JSON thành đối tượng Date của JavaScript
						            // (Giả sử server trả về định dạng YYYY-MM-DD)
						            const ud_start = new Date(ud.startDate); 
						            const ud_end = new Date(ud.endDate);

						            // Logic kiểm tra trùng lịch: [arrival, departure] có trùng với [ud_start, ud_end] không?
						            // Trùng nếu (ngày nhận phòng <= ngày kết thúc đặt cũ) VÀ (ngày trả phòng > ngày bắt đầu đặt cũ)
						            // (Đặt phòng khách sạn thường check-out 12h, check-in 14h, nên cần xem xét logic ngày cụ thể)
						            // Logic tiêu chuẩn: [A, B) và [C, D) trùng nếu A < D và C < B
						            // Tuy nhiên, với Java Date (YYYY-MM-DD), ta dùng logic bao phủ:
						            if (arrivalDate < ud_end && departureDate > ud_start) {
						                isConflict = true;
						                break;
						            }
						        }

						        if (isConflict) {
						            dateErrorMessage.textContent = "Ngày bạn chọn bị trùng với lịch đặt trước. Vui lòng chọn ngày khác hoặc phòng khác.";
						            dateErrorMessage.style.display = 'block';
						            console.warn("TRÙNG LỊCH: Vui lòng chọn ngày khác.");
						            submitBtn.disabled = true;
						        } else {
						            console.log("Không có xung đột lịch đặt phòng.");
						            submitBtn.disabled = false;
						        }
						        
						    })
						    .catch(err => {
						        console.error("Lỗi khi tải danh sách ngày không khả dụng:", err);
						        dateErrorMessage.textContent = "Lỗi hệ thống khi kiểm tra lịch. Vui lòng thử lại.";
						        dateErrorMessage.style.display = 'block';
						    });
						}
						
						
						// Gọi hàm khi đổi loại phòng hoặc tầng
						rtSelect.addEventListener("change", loadFloors);
						
						
						
						flSelect.addEventListener("change", loadRooms);
						
						rtSelect.addEventListener("change", function() {
				            loadFloors(); // Giữ nguyên logic load tầng
				            calculateTotal(); // Thêm tính tổng tiền
				        });

				        // 2. Khi chọn Ngày Nhận Phòng
				        /* arrivalDateInput.addEventListener("change", calculateTotal, loadUds); */
						roomSelect.addEventListener("change", function() {
    						loadUds(); // Kiểm tra lịch sau khi chọn phòng (và đã có ngày)
						});
				        
				        arrivalDateInput.addEventListener("change", function() {
				            // Giữ nguyên logic load tầng
				            checkStartDate();
				            calculateTotal(); // Thêm tính tổng tiền
				            loadUds();
				            
				        });
				        
				        // 3. Khi chọn Ngày Trả Phòng
				        departureDateInput.addEventListener("change", function() {
    						calculateTotal(); 
   							 loadUds(); // Kiểm tra lịch sau khi đổi ngày trả phòng
						});				        
				        // ... (Giữ nguyên flSelect.addEventListener("change", loadRooms);) ...
				        
				        // Tính toán lần đầu khi tải trang (nếu có dữ liệu mặc định)
				        calculateTotal();
						
						});

</script>
</body>

</html>