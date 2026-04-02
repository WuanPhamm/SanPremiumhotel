<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi">
<%@include file="/admin/ad_header.jsp"%>
<%@include file="/admin/ad_sidebar.jsp"%>

<style>


.form-row-2 {
  display: grid;
  grid-template-columns: 1fr 1fr; /* 2 cột ngang 1 hàng */
  gap: 20px;
  align-items: start;
  margin-bottom: 16px;
}

/* Grid 2 ô trong mỗi cột */
.form-grid-2 {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}

.form-grid-2 .form-control,
.form-grid-2 .form-select {
  border-radius: 8px;
}

/* Wrapper tổng thể */
.reservation-wrapper {
  background: #ffffff;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.06);
  border: 1px solid #f0f0f0;
}

/* Chia grid form */
.booking-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 22px;
}

/* Form container */
.form-container {
  background: #fafafa;
  padding: 22px;
  border-radius: 14px;
  border: 1px solid #e8e8e8;
}

/* Tiêu đề các section */
.form-section h4 {
  color: #4e73df !important;
  font-weight: 700;
  font-size: 20px;
  color: #2d2d2d;
  margin-bottom: 16px;
 margin-top: 16px;

  display: inline-block;
}

/* Grid input 2 cột */
.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 14px;
}

/* Label */
.form-label {
  font-weight: 600;
  font-size: 14px;
  color: #444;
  margin-bottom: 4px;
}

/* Select, input, textarea */
.form-select, .form-control {
  border-radius: 8px;
  border: 1px solid #d8d8d8;
  transition: 0.3s;
}

.form-select:focus, .form-control:focus {
  border-color: #4e73df;
  box-shadow: 0 0 0 3px rgba(78,115,223,0.15);
}

/* Nút submit */
.form-actions button {
  border-radius: 10px;
  font-weight: 600;
  padding: 10px 18px;
  font-size: 15px;
  background: #4e73df;
  border: none;
  transition: 0.3s;
}

.form-actions button:hover {
  background: #3755c4;
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(55,85,196,0.3);
}

/* Hiển thị đơn giá & tổng tiền */
#room-price-display {
  color: #1a1a1a;
  font-weight: 600;
}

#total-amount-display {
  color: #d9534f;
}

/* Style alert đẹp hơn */
#alertBox {
  animation: slideFade 0.5s ease-out;
}

@keyframes slideFade {
  from {
    opacity: 0;
    transform: translate(-50%, -20px);
  }
  to {
    opacity: 1;
    transform: translate(-50%, 0);
  }
}

/* Responsive nhỏ hơn cho mobile */
@media (max-width: 768px) {
  .reservation-wrapper {
    padding: 16px;
  }
  .form-container {
    padding: 16px;
  }
  .form-section h4 {
    font-size: 16px;
  }
}
</style>

<body>

	<c:if test="${not empty param.message}">
		<div id="alertBox"
			class="alert 
    ${param.message eq 'success'  ? 'alert-success' : 'alert-danger'} 
    position-fixed top-0 start-50 translate-middle-x mt-3 shadow-lg rounded-3 px-4 py-3"
			style="z-index: 1055; display: none;">
			<strong> <c:choose>
					<c:when test="${param.message eq 'success'}">Thao tác thành công!</c:when>
					<c:when test="${param.message eq 'fail'}">Thao tác thất bại!</c:when>

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
			<h1>Đặt phòng</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="<%=request.getContextPath() %>/home">Trang chủ</a></li>
					<li class="breadcrumb-item active">Đặt phòng</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<!-- Booking Section -->
		<section id="booking" class="booking section">

			<div class="container" data-aos="fade-up" data-aos-delay="100">

				<div class="reservation-wrapper">

					<div class="booking-grid">

						<div class="booking-form-section" data-aos="fade-right"
							data-aos-delay="300">
							<div class="form-container">
								<form class="reservation-form" action="${contextPath}/admin-booking"
									method="POST">
									

									<input type="hidden" name="booking_total"
										id="booking-total-hidden">


									<div class="form-section">
										<h4>Thông tin khách hàng</h4>
										<div class="form-grid">
											<div class="form-group">
												<label for="primary-guest" class="form-label">Họ</label> <input
													type="text" class="form-control" id="primary-guest"
													name="firstname" value="${cus.cus_firstname }"
													required="">
											</div>
											<div class="form-group">
												<label for="primary-guest" class="form-label">Tên</label> <input
													type="text" class="form-control" id="primary-guest"
													name="lastname" value="${cus.cus_lastname }"
													required="">
											</div>
											<div class="form-group">
												<label for="contact-email" class="form-label">Địa
													Chỉ Email</label> <input type="email" class="form-control"
													id="contact-email" name="email"
													value="${cus.cus_email }" required="">
											</div>
											<div class="form-group">
												<label for="contact-phone" class="form-label">Số
													Điện Thoại</label> <input type="tel" class="form-control"
													id="cus_phone" name="cus_phone" value="${cus.cus_phone }"
													required="">
											</div>

											<div class="form-group">
												<label for="cccd" class="form-label">Số CCCD </label> <input
													type="tel" class="form-control" id="cus_cccd"
													name="cus_cccd" value="${cus.cus_cccd }" required="">
											</div>
										</div>
										
									</div>
									

									<div class="form-row-2">
										<div class="form-section">
										<h4>Loại phòng ưa thích</h4>
										<div class="form-group">
											<label for="accommodation-type" class="form-label">Loại
												phòng</label> <select class="form-select" id="accommodation-type"
												name="rt_id" required>

												<option value="" disabled selected hidden>Chọn loại
													phòng</option>
												<c:forEach var="rt" items="${list_room_type_all}">

													<option value="${rt.rt_id }" data-price="${rt.rt_price }">${rt.rt_name }</option>
												</c:forEach>
											</select>
										</div>

										<div class="form-grid">
											<div class="form-group">
												<label for="floor-select" class="form-label" style="margin-top: 15px">Chọn
													tầng
													
													</label> <select class="form-select" id="floor-select"
													name="floor_id" required="" disabled>

													<option value="" disabled selected hidden>Vui lòng
														chọn loại phòng trước</option>
												</select>
											</div>
											<div class="form-group">
												<label for="room-select" class="form-label">Chọn
													phòng</label> <select class="form-select" id="room-select"
													name="room_id" required="" disabled>
													<option value="" disabled selected hidden>Vui lòng
														chọn tầng trước</option>
												</select>
											</div>
										</div>



									</div>

									<div class="form-section">
										<h4>Chi tiết đặt phòng</h4>
										<div class="form-grid">
											<div class="form-group">
												<label for="arrival-date" class="form-label">Ngày
													nhận phòng</label> <input type="date" class="form-control"
													id="arrival-date" name="arrival_date" required="">
											</div>
											<div class="form-group">
												<label for="departure-date" class="form-label">Ngày
													trả phòng</label> <input type="date" class="form-control"
													id="departure-date" name="departure_date" required="">
											</div>

										</div>
										
										<div class="form-group" style="grid-column: 1/-1;">
										<div id="date-error-message"
											style="color: red; font-size: 0.9em; display: none; padding: 5px; border: 1px solid red; border-radius: 4px; background-color: #fff5f5;"></div>
									</div>
									</div>

									
									
									</div>
									
									<div class="form-group">

										<div class="form-group">
											<label for="additional-notes" class="form-label">Yêu
												cầu bổ sung</label>
											<textarea class="form-control" id="additional-notes"
												name="requirements" rows="3"
												placeholder="Vui lòng ghi rõ các yêu cầu đặc biệt hoặc sở thích của bạn..."></textarea>
										</div>
										
										
									</div>

									<div class="form-section">
										<h4>Phương thức thanh toán</h4>
										<div class="d-flex flex-wrap gap-4 mt-2">

											<div class="form-check">
												<input class="form-check-input" type="radio"
													name="payment_method" id="pay-vnpay" value="vnpay" checked>
												<label class="form-check-label fw-semibold" for="pay-vnpay">
													<i class="bi bi-credit-card-2-front me-1"></i> VNPAY
												</label>
											</div>

											<div class="form-check">
												<input class="form-check-input" type="radio"
													name="payment_method" id="pay-cash" value="cash"> <label
													class="form-check-label fw-semibold" for="pay-cash">
													<i class="bi bi-cash-stack me-1"></i> Tiền mặt
												</label>
											</div>

										</div>
									</div>



									<div class="form-actions">
										<label style="text-align: right; display: block;"> ĐƠN
											GIÁ: <span id="room-price-display">0 VND</span>
										</label> <label
											style="text-align: right; display: block; font-weight: bold; font-size: 24px;">
											TỔNG TIỀN: <span id="total-amount-display">0 VND</span>
										</label>
										<button type="submit" class="btn btn-primary" id="submit">
											<i class="bi bi-calendar-plus me-2"></i> Gửi Yêu Cầu Đặt
											Phòng
										</button>
									</div>

								</form>
							</div>
						</div>

						

					</div>

				</div>

			</div>

		</section>
		<!-- /Booking Section -->

	</main>

	<!-- View Modal -->




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
<!-- Vendor JS Files -->
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/apexcharts/apexcharts.min.js"></script>
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/chart.js/chart.umd.js"></script>
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/echarts/echarts.min.js"></script>
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/quill/quill.js"></script>
<%--  <script src="${pageContext.request.contextPath}/admin/assets/vendor/simple-datatables/simple-datatables.js"></script> --%>
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/tinymce/tinymce.min.js"></script>
<script
	src="${pageContext.request.contextPath}/admin/assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script
	src="${pageContext.request.contextPath}/admin/assets/js/main${pageContext.request.contextPath}/admin.js"></script>



</html>
