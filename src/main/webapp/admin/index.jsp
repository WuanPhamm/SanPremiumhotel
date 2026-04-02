<!DOCTYPE html>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>


<%@page import="model.BookingReport"%>
<%@page import="java.util.List"%>
<%@include file="/admin/ad_header.jsp"%>
<%@include file="/admin/ad_sidebar.jsp"%>


<style>
/* Mặc định: Giới hạn chiều cao, ẩn phần thừa, không cuộn */
.activity-list-wrapper {
	max-height: 400px;
	/* Điều chỉnh số này sao cho vừa khít 6 items của bạn */
	overflow: hidden;
	transition: max-height 0.3s ease; /* Hiệu ứng mượt */
	position: relative;
}

/* Khi mở rộng: Giữ nguyên chiều cao hoặc tăng thêm chút, nhưng cho phép cuộn */
.activity-list-wrapper.expanded {
	max-height: 500px; /* Có thể tăng lên nếu muốn khung to ra */
	overflow-y: auto; /* Hiện thanh cuộn dọc */
}

/* Tùy chỉnh thanh cuộn cho đẹp (Webkit browsers) */
.activity-list-wrapper::-webkit-scrollbar {
	width: 6px;
}

.activity-list-wrapper::-webkit-scrollbar-thumb {
	background-color: #ccc;
	border-radius: 4px;
}
</style>
<main id="main" class="main">

	<div class="pagetitle">
		<h1>Dashboard</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
				<li class="breadcrumb-item active">Dashboard</li>
			</ol>
		</nav>
	</div>
	<!-- End Page Title -->

	<section class="section dashboard">
		<div class="row">

			<!-- Left side columns -->
			<div class="col-lg-8">
				<div class="row">

					<!-- Sales Card -->
					<div class="col-xxl-6 col-md-6">
						<div class="card info-card sales-card" id="sales-card"
							data-today="${bookingToday}" data-month="${bookingMonth}"
							data-year="${bookingYear}">

							<div class="filter">
								<a class="icon" href="#" data-bs-toggle="dropdown"><i
									class="bi bi-three-dots"></i></a>
								<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
									<li class="dropdown-header text-start"><h6>Bộ lọc</h6></li>
									<li><a class="dropdown-item" href="javascript:void(0)"
										onclick="updateFilter('sales', 'today', 'Hôm nay')">Hôm
											nay</a></li>
									<li><a class="dropdown-item" href="javascript:void(0)"
										onclick="updateFilter('sales', 'month', 'Tháng này')">Tháng
											này</a></li>
									<li><a class="dropdown-item" href="javascript:void(0)"
										onclick="updateFilter('sales', 'year', 'Năm này')">Năm này</a></li>
								</ul>
							</div>

							<div class="card-body">
								<h5 class="card-title">
									Đơn đặt phòng <span id="sales-filter-label">| Hôm nay</span>
								</h5>

								<div class="d-flex align-items-center">
									<div
										class="card-icon rounded-circle d-flex align-items-center justify-content-center">
										<i class="bi bi-cart"></i>
									</div>
									<div class="ps-3">
										<h6 id="sales-value">${bookingToday}</h6>

									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- End Sales Card -->


					<!-- Customers Card -->
					<div class="col-xxl-6 col-xl-12">


						<div class="card info-card customers-card" id="customers-card"
							data-today="${customerToday}" data-month="${customerMonth}"
							data-year="${customerYear}">

							<div class="filter">
								<a class="icon" href="#" data-bs-toggle="dropdown"><i
									class="bi bi-three-dots"></i></a>
								<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
									<li class="dropdown-header text-start"><h6>Bộ lọc</h6></li>
									<li><a class="dropdown-item" href="javascript:void(0)"
										onclick="updateFilter('customers', 'today', 'Hôm nay')">Hôm
											nay</a></li>
									<li><a class="dropdown-item" href="javascript:void(0)"
										onclick="updateFilter('customers', 'month', 'Tháng này')">Tháng
											này </a></li>
									<li><a class="dropdown-item" href="javascript:void(0)"
										onclick="updateFilter('customers', 'year', 'Năm này')">Năm
											này </a></li>
								</ul>
							</div>

							<div class="card-body">
								<h5 class="card-title">
									Khách hàng <span id="customers-filter-label">| Hôm nay</span>
								</h5>

								<div class="d-flex align-items-center">
									<div
										class="card-icon rounded-circle d-flex align-items-center justify-content-center">
										<i class="bi bi-people"></i>
									</div>
									<div class="ps-3">
										<h6 id="customers-value">${customerToday}</h6>

									</div>
								</div>
							</div>
						</div>

					</div>
					<!-- End Customers Card -->


					<!-- Revenue Card -->
					<div class="col-12">
						<div class="col-12">
							<div class="card info-card revenue-card" id="revenue-card"
								data-today="${revenueToday}" data-month="${revenueMonth}"
								data-year="${revenueYear}">

								<div class="filter">
									<a class="icon" href="#" data-bs-toggle="dropdown"><i
										class="bi bi-three-dots"></i></a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
										<li class="dropdown-header text-start"><h6>Bộ lọc</h6></li>
										<li><a class="dropdown-item" href="javascript:void(0)"
											onclick="updateFilter('revenue', 'today', 'Hôm nay')">Hôm
												nay</a></li>
										<li><a class="dropdown-item" href="javascript:void(0)"
											onclick="updateFilter('revenue', 'month', 'Tháng này')">Tháng
												này </a></li>
										<li><a class="dropdown-item" href="javascript:void(0)"
											onclick="updateFilter('revenue', 'year', 'Năm này')">Năm
												này </a></li>
									</ul>
								</div>

								<div class="card-body">
									<h5 class="card-title">
										Doanh thu <span id="revenue-filter-label">| Hôm nay</span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-currency-dollar"></i>
										</div>
										<div class="ps-3">
											<h6 id="revenue-value">${revenueToday}</h6>

										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
					<!-- End Revenue Card -->

					<div class="col-12">
						<div class="card">

							<div class="filter">
								<a class="icon" href="${pageContext.request.contextPath}/booking-report" ><i
									class="bi bi-eye"></i></a>
								
							</div>

							<div class="card-body">
								<h5 class="card-title">
									Thống kê đặt phòng <span id="filterLabel">| Tháng này</span>
								</h5>

								<div id="reportsChart"></div>

								<script>
						                document.addEventListener("DOMContentLoaded", () => {
						                    
						                    // --- 1. LẤY DỮ LIỆU TỪ CONTROLLER ---
						                    
						                    // Dữ liệu cho "Tháng này" (Đã có trong code cũ)
						                    const catsMonth = JSON.parse('${chartCategoriesMonth}');
						                    const seriesMonth = JSON.parse('${chartSeriesMonth}');
						
						                    // Dữ liệu cho "Năm này" (Lấy từ biến chartCategories/chartSeries mà controller đã gửi ở dòng 145-146)
						                    const catsYear = JSON.parse('${chartCategories}');
						                    const seriesYear = JSON.parse('${chartSeries}');
						
						                    // --- 2. KHỞI TẠO BIỂU ĐỒ (Mặc định là Tháng) ---
						                    
						                    var options = {
						                        series: seriesMonth,
						                        chart: {
						                            height: 350,
						                            type: 'area',
						                            toolbar: { show: false },
						                        },
						                        markers: { size: 4 },
						                        colors: ['#dc3545', '#4154f1', '#2eca6a'],
						                        fill: {
						                            type: "gradient",
						                            gradient: {
						                                shadeIntensity: 1,
						                                opacityFrom: 0.3,
						                                opacityTo: 0.4,
						                                stops: [0, 90, 100]
						                            }
						                        },
						                        dataLabels: { enabled: false },
						                        stroke: { curve: 'smooth', width: 2 },
						                        xaxis: {
						                            type: 'category',
						                            categories: catsMonth // Mặc định trục X là tháng
						                        },
						                        tooltip: {
						                            x: { format: 'dd/MM/yyyy' },
						                        }
						                    };
						
						                    // Tạo biến chart toàn cục để có thể update sau này
						                    var chart = new ApexCharts(document.querySelector("#reportsChart"), options);
						                    chart.render();
						
						                    // --- 3. XỬ LÝ SỰ KIỆN CLICK BỘ LỌC ---
						
						                    const filterItems = document.querySelectorAll('.filter .dropdown-item');
						                    const filterLabel = document.getElementById('filterLabel');
						
						                    filterItems.forEach(item => {
						                        item.addEventListener('click', (e) => {
						                            e.preventDefault(); // Ngăn load lại trang
						                            const text = e.target.innerText.trim();
						
						                            if (text === "Tháng này") {
						                                // Cập nhật tiêu đề
						                                filterLabel.innerText = "| Tháng này";
						                                
						                                // Cập nhật dữ liệu biểu đồ sang Tháng
						                                chart.updateOptions({
						                                    xaxis: { categories: catsMonth }
						                                });
						                                chart.updateSeries(seriesMonth);
						                            } 
						                            else if (text === "Măm này") {
						                                // Cập nhật tiêu đề
						                                filterLabel.innerText = "| Năm này";
						
						                                // Cập nhật dữ liệu biểu đồ sang Năm (dùng biến catsYear/seriesYear)
						                                chart.updateOptions({
						                                    xaxis: { categories: catsYear }
						                                });
						                                chart.updateSeries(seriesYear);
						                            }
						                        });
						                    });
						
						                });
           						 </script>

							</div>
						</div>
					</div>




				</div>
			</div>
			<!-- End Left side columns -->

			<!-- Right side columns -->
			<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

			<div class="col-lg-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Hoạt động gần đây</h5>

						<div class="activity activity-list-wrapper" id="activityList">

							<c:forEach items="${recentActivityList}" var="item"
								varStatus="loop">
								<div class="activity-item d-flex">
									<div class="activite-label text-truncate" style="width: 80px;">${item.timeAgo}</div>

									<c:choose>
										<c:when test="${item.statusId == 1}">
											<i
												class='bi bi-circle-fill activity-badge text-warning align-self-start'></i>
										</c:when>
										<c:when test="${item.statusId == 2}">
											<i
												class='bi bi-circle-fill activity-badge text-primary align-self-start'></i>
										</c:when>
										<c:when test="${item.statusId == 4}">
											<i
												class='bi bi-circle-fill activity-badge text-danger align-self-start'></i>
										</c:when>
										<c:when test="${item.statusId == 6}">
											<i
												class='bi bi-circle-fill activity-badge text-success align-self-start'></i>
										</c:when>
										<c:when test="${item.statusId == 7}">
											<i
												class='bi bi-circle-fill activity-badge text-info align-self-start'></i>
										</c:when>
										<c:otherwise>
											<i
												class='bi bi-circle-fill activity-badge text-muted align-self-start'></i>
										</c:otherwise>
									</c:choose>

									<div class="activity-content">
										<span class="fw-bold text-dark">${item.customerName}</span>
										<c:choose>
											<c:when test="${item.statusId == 1}">vừa đặt phòng</c:when>
											<c:when test="${item.statusId == 2}">đã được xác nhận</c:when>
											<c:when test="${item.statusId == 3}">đã yêu cầu hủy phòng</c:when>
											<c:when test="${item.statusId == 4}">đã hủy phòng</c:when>
											<c:when test="${item.statusId == 5}">đã thêm phòng</c:when>
											<c:when test="${item.statusId == 6}">đã trả phòng</c:when>
											<c:when test="${item.statusId == 7}">đã đánh giá</c:when>
											<c:otherwise>tương tác với</c:otherwise>
										</c:choose>
										<a href="#" class="fw-bold text-dark"> ${item.roomName}</a>
									</div>
								</div>
							</c:forEach>

							<c:if test="${empty recentActivityList}">
								<div class="text-center p-3">Chưa có hoạt động nào.</div>
							</c:if>

						</div>
						<c:if test="${recentActivityList.size() > 6}">
							<div class="text-center mt-3">
								<button class="btn btn-outline-primary btn-sm"
									onclick="toggleActivity()" id="btnViewMore">
									Xem tất cả <i class="bi bi-chevron-down"></i>
								</button>
							</div>
						</c:if>

					</div>
				</div>
			</div>
			<!-- End Recent Activity -->



			<!-- Website Traffic -->




			<div class="card" id="floors-card"   data-today='${floorStatsDay}'
     	data-month='${floorStatsMonth}'
     	data-year='${floorStatsYear}'>
				<div class="filter">
					<a class="icon" href="#" data-bs-toggle="dropdown"><i
						class="bi bi-three-dots"></i></a>
					<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
						<li class="dropdown-header text-start"><h6>Bộ lọc</h6></li>
						<li><a class="dropdown-item" href="javascript:void(0)"
							onclick="updateFilterFl('floors', 'today', 'Hôm nay')">Hôm
								nay</a></li>
						<li><a class="dropdown-item" href="javascript:void(0)"
							onclick="updateFilterFl('floors', 'month', 'Tháng này')">Tháng
								này </a></li>
						<li><a class="dropdown-item" href="javascript:void(0)"
							onclick="updateFilterFl('floors', 'year', 'Năm này')">Năm
								này </a></li>
					</ul>
				</div>

				<div class="card-body pb-0">
					<h5 class="card-title">
						Thống kê theo tầng <span>Hôm nay</span>
					</h5>

					<div id="trafficChart" style="min-height: 400px;" class="echart"></div>

					<script>

							let floorsChart = null;
							
							// Hàm vẽ biểu đồ
							function loadFloorChartData(data) {
							
							    if (!floorsChart) {
							        floorsChart = echarts.init(document.querySelector("#trafficChart"));
							    }
							
							    floorsChart.setOption({
							        tooltip: { trigger: 'item' },
							        legend: { top: '5%', left: 'center' },
							
							        series: [{
							            name: 'Số lượng đặt',
							            type: 'pie',
							            radius: ['40%', '70%'],
							            data: data
							        }]
							    });
							}
							
							/**
							 * Hàm cập nhật dữ liệu khi chọn filter
							 */
							function updateFilterFl(cardName, timeFrame, labelText) {
							
							    const cardElement = document.getElementById(cardName + "-card");
							
							    // Lấy chuỗi JSON từ data attribute
							    let jsonStr = cardElement.dataset[timeFrame];
							
							    // Chuyển chuỗi JSON -> JS Object
							    let dataList = JSON.parse(jsonStr);
							
							    if (!dataList || dataList.length === 0) {
							        dataList = [{ name: "Không có dữ liệu", value: 0 }];
							    } else {
							        dataList = dataList.map(item => ({
							            name: item.label,
							            value: item.quantity
							        }));
							    }
							
							    // Update tiêu đề
							    cardElement.querySelector(".card-title span").innerText = labelText;
							
							    // Update biểu đồ
							    loadFloorChartData(dataList);
							}
							
							// Load mặc định "Hôm nay" khi mở trang
							document.addEventListener("DOMContentLoaded", () => {
							    updateFilterFl("floors", "today", "Hôm nay");
							});

					</script>

				</div>
			</div>
			<!-- End Website Traffic -->





		</div>
		<!-- End Right side columns -->


	</section>

</main>
<!-- End #main -->

<!-- ======= Footer ======= -->

<!-- End Footer -->

<a href="#"
	class="back-to-top d-flex align-items-center justify-content-center"><i
	class="bi bi-arrow-up-short"></i></a>

<!-- Vendor JS Files -->
<script src="admin/assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="admin/assets/vendor/chart.js/chart.umd.js"></script>
<script src="admin/assets/vendor/echarts/echarts.min.js"></script>
<script src="admin/assets/vendor/quill/quill.js"></script>
<script src="admin/assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="admin/assets/vendor/tinymce/tinymce.min.js"></script>
<script src="admin/assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="admin/assets/js/mainadmin.js"></script>

<script>
/**
 * Hàm cập nhật dữ liệu Card khi chọn Filter
 * @param {string} cardName - Tên loại card ('sales', 'customers', 'revenue')
 * @param {string} timeFrame - Khoảng thời gian ('today', 'month', 'year')
 * @param {string} labelText - Chữ hiển thị trên tiêu đề ('Today', 'This Month', ...)
 */
function updateFilter(cardName, timeFrame, labelText) {
    // 1. Lấy thẻ Card cha dựa trên ID
    const cardElement = document.getElementById(cardName + '-card');
    
    // 2. Lấy dữ liệu từ thuộc tính data- (được JSP render sẵn)
    let value = cardElement.getAttribute('data-' + timeFrame);

    // Xử lý trường hợp dữ liệu null hoặc rỗng
    if (!value || value === 'null') {
        value = 0;
    }

    // 3. Xử lý format tiền tệ riêng cho Revenue
    if (cardName === 'revenue') {
        // Chuyển string sang số float để format
        let money = parseFloat(value);
        
        // **********************************************
        // THAY ĐỔI TẠI ĐÂY: Dùng Locale 'vi-VN' và Currency 'VND'
        value = new Intl.NumberFormat('vi-VN', { 
            style: 'currency', 
            currency: 'VND' 
        }).format(money);
        // **********************************************
        
    }

    // 4. Cập nhật Text tiêu đề (VD: | This Month)
    const labelSpan = document.getElementById(cardName + '-filter-label');
    labelSpan.innerText = "| " + labelText;

    // 5. Cập nhật Giá trị chính (VD: 145, 3.200.000 ₫)
    const valueH6 = document.getElementById(cardName + '-value');
    valueH6.innerText = value;
}
 document.addEventListener("DOMContentLoaded", function() {
	    // 1. Lấy giá trị mặc định (Doanh thu đang mặc định hiển thị Home nay)
	    const revenueElement = document.getElementById('revenue-value');
	    let rawValue = revenueElement.innerText.trim();
	    
	    if (rawValue && rawValue !== 'null' && !isNaN(parseFloat(rawValue))) {
	        let money = parseFloat(rawValue);
	        
	        // Định dạng VNĐ
	        let formattedValue = new Intl.NumberFormat('vi-VN', { 
	            style: 'currency', 
	            currency: 'VND' 
	        }).format(money);
	        
	        // Cập nhật giá trị
	        revenueElement.innerText = formattedValue;
	    }
	});
</script>

<script>
    function toggleActivity() {
        var wrapper = document.getElementById("activityList");
        var btn = document.getElementById("btnViewMore");

        // Kiểm tra xem đang mở hay đóng
        if (wrapper.classList.contains("expanded")) {
            // Đang mở -> Đóng lại (Thu gọn)
            wrapper.classList.remove("expanded");
            btn.innerHTML = 'Xem tất cả <i class="bi bi-chevron-down"></i>';
            
            // Cuộn nhẹ lại lên đầu danh sách để user không bị hụt hẫng
            wrapper.scrollTop = 0; 
        } else {
            // Đang đóng -> Mở ra (Scroll view)
            wrapper.classList.add("expanded");
            btn.innerHTML = 'Thu gọn <i class="bi bi-chevron-up"></i>';
        }
    }
</script>
</body>

</html>