<%@page import="model.CustomerStatisticDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <%@include file="/admin/ad_header.jsp"%>
    <%@include file="/admin/ad_sidebar.jsp"%>   
<body>

    <main id="main" class="main">
        <div class="pagetitle">
            <h1>Thống kê khách hàng</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Thống kê</li>
                </ol>
            </nav>
        </div>

        <section class="section">
            <div class="row">
                <div class="col-12">
                    <div class="card mb-4">
                        <div class="card-body py-3">
                            <form action="<%= request.getContextPath()%>/customer_report" method="get" class="row g-3 align-items-center">
                                <div class="col-auto">
                                    <label class="col-form-label fw-bold"><i class="bi bi-calendar3"></i> Từ ngày:</label>
                                </div>
                                <div class="col-auto">
                                    <input type="date" name="startDate" class="form-control" value="${startDate}">
                                </div>
                                <div class="col-auto">
                                    <label class="col-form-label fw-bold">Đến ngày:</label>
                                </div>
                                <div class="col-auto">
                                    <input type="date" name="endDate" class="form-control" value="${endDate}">
                                </div>
                                <div class="col-auto">
                                    <button type="submit" class="btn btn-primary"><i class="bi bi-filter"></i> Lọc dữ liệu</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Top khách hàng theo doanh thu</h5>
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Khách hàng</th>
                                        <th scope="col">Số đơn</th>
                                        <th scope="col">Tổng tiền</th>
                                        <th scope="col">Xem</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${topRevenueList}" varStatus="loop">
                                        <tr>
                                            <th scope="row">${loop.index + 1}</th>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="ms-2">
                                                        <a href="javascript:void(0)" class="fw-bold  text-decoration-none"
                                                           onclick="showDetail(
                                                               '${item.customerInfo.cus_firstname}&nbsp;${item.customerInfo.cus_lastname}',
                                                               '${item.customerInfo.cus_email}',
                                                               '${item.customerInfo.cus_phone}',
                                                               '${item.customerInfo.cus_address}',
                                                               '${item.customerInfo.cus_gender}',
                                                               '${item.customerInfo.cus_dob}',
                                                               '${item.customerInfo.cus_avt_url}',
                                                               '${item.totalBookingCount}',
                                                               '<fmt:formatNumber value="${item.totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>'
                                                           )">
                                                            ${item.customerInfo.cus_firstname}&nbsp;${item.customerInfo.cus_lastname}
                                                        </a>
                                                        <br>
                                                        <small class="text-muted">${item.customerInfo.cus_email}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-center">${item.totalBookingCount}</td>
                                            <td class="text-success fw-bold">
                                                <fmt:formatNumber value="${item.totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </td>
                                            <td>
                                                <button class="btn btn-sm btn-light text-info"
                                                    onclick="showDetail(
                                                       '${item.customerInfo.cus_firstname}&nbsp;${item.customerInfo.cus_lastname}',
                                                       '${item.customerInfo.cus_email}',
                                                       '${item.customerInfo.cus_phone}',
                                                       '${item.customerInfo.cus_address}',
                                                       '${item.customerInfo.cus_gender}',
                                                       '${item.customerInfo.cus_dob}',
                                                       '${item.customerInfo.cus_avt_url}',
                                                       '${item.totalBookingCount}',
                                                       '<fmt:formatNumber value="${item.totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>'
                                                   )">
                                                    <i class="bi bi-eye-fill"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">Top khách hàng theo số lượng đơn</h5>
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Khách hàng</th>
                                        <th scope="col">Doanh thu</th>
                                        <th scope="col">Số đơn</th>
                                        <th scope="col">Xem</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${topBookingList}" varStatus="loop">
                                        <tr>
                                            <th scope="row">${loop.index + 1}</th>
                                            <td>
                                                <h6 class="mb-0">${item.customerInfo.cus_firstname}&nbsp;${item.customerInfo.cus_lastname}</h6>
                                                <small class="text-muted">${item.customerInfo.cus_phone}</small>
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${item.totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </td>
                                            <td class="text-primary fw-bold text-center">${item.totalBookingCount}</td>
                                            <td>
                                                 <button class="btn btn-sm btn-light text-info"
                                                    onclick="showDetail(
                                                       '${item.customerInfo.cus_firstname}&nbsp;${item.customerInfo.cus_lastname}',
                                                       '${item.customerInfo.cus_email}',
                                                       '${item.customerInfo.cus_phone}',
                                                       '${item.customerInfo.cus_address}',
                                                       '${item.customerInfo.cus_gender}',
                                                       '${item.customerInfo.cus_dob}',
                                                       '${item.customerInfo.cus_avt_url}',
                                                       '${item.totalBookingCount}',
                                                       '<fmt:formatNumber value="${item.totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>'
                                                   )">
                                                    <i class="bi bi-eye-fill"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-12">
                    <div class="card mt-4">
                        <div class="card-body">
                            <h5 class="card-title">Biểu đồ Doanh thu Top 5 Khách hàng</h5>
                            <div id="revenueChart"></div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </main>

    <div class="modal fade" id="customerDetailModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Thông Tin Chi Tiết Khách Hàng</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="text-center mb-4">
                        <div class="rounded-circle bg-light d-inline-flex align-items-center justify-content-center border shadow-sm" style="width: 90px; height: 90px;">
                             <img alt="" src="" id="mAvt">
                        </div>
                        <h4 class="mt-3 fw-bold" id="mName"></h4>
                        <span class="badge bg-success fs-6" id="mRevenue"></span>
                    </div>
                    
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span class="text-muted"><i class="bi bi-telephone me-2"></i>Số điện thoại:</span>
                            <span class="fw-bold" id="mPhone"></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span class="text-muted"><i class="bi bi-envelope me-2"></i>Email:</span>
                            <span class="fw-bold" id="mEmail"></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span class="text-muted"><i class="bi bi-gender-ambiguous me-2"></i>Giới tính:</span>
                            <span class="fw-bold" id="mGender"></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span class="text-muted"><i class="bi bi-calendar-event me-2"></i>Ngày sinh:</span>
                            <span class="fw-bold" id="mDob"></span>
                        </li>
                        <li class="list-group-item">
                            <span class="text-muted d-block mb-1"><i class="bi bi-geo-alt me-2"></i>Địa chỉ:</span>
                            <span class="fw-bold" id="mAddress"></span>
                        </li>
                        <li class="list-group-item bg-light mt-2 rounded">
                            <div class="d-flex justify-content-between">
                                <span>Tổng số đơn trong kỳ:</span>
                                <span class="fw-bold text-primary" id="mCount"></span>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/admin/assets/vendor/apexcharts/apexcharts.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/js/main.js"></script>

    <script>
        // 1. Hàm hiển thị Modal
        function showDetail(name, email, phone, address, gender, dob, avt, count, revenue) {
            // Lấy các element trong Modal
            let avatarSrc = (avt && avt.trim() !== '' && avt !== 'null') ? avt : '${pageContext.request.contextPath}/images/anhdaidien.jpg';
            
            // Gán src cho thẻ img. Lưu ý: Thẻ img cần có style width/height 100% để vừa khung tròn
            let imgElement = document.getElementById('mAvt');
            imgElement.src = avatarSrc;
            imgElement.style.width = "100%";
            imgElement.style.height = "100%";
            imgElement.style.objectFit = "cover"; // Giúp ảnh không bị méo
	
            
            document.getElementById('mName').innerText = name;
            
            document.getElementById('mEmail').innerText = (email && email !== 'null') ? email : '---';
            document.getElementById('mPhone').innerText = (phone && phone !== 'null') ? phone : '---';
            document.getElementById('mAddress').innerText = (address && address !== 'null') ? address : 'Chưa cập nhật';
            
            // Xử lý giới tính (Giả sử 1 là Nam, 0 là Nữ)
            let genderText = 'Khác';
            if(gender == '0') genderText = 'Nam';
            else if(gender == '1') genderText = 'Nữ';
            document.getElementById('mGender').innerText = genderText;

            document.getElementById('mDob').innerText = (dob && dob !== 'null') ? dob : '---';
            document.getElementById('mCount').innerText = count + " đơn hàng";
            document.getElementById('mRevenue').innerText = revenue;

            // Mở Modal bằng Bootstrap API
            var myModal = new bootstrap.Modal(document.getElementById('customerDetailModal'));
            myModal.show();
        }

        // 2. Vẽ biểu đồ (Giữ nguyên logic cũ)
        document.addEventListener("DOMContentLoaded", () => {
            const names = [];
            const revenues = [];

            <c:forEach var="item" items="${topRevenueList}">
                names.push("${item.customerInfo.cus_firstname} ${item.customerInfo.cus_lastname}");
                revenues.push(${item.totalRevenue});
            </c:forEach>

            new ApexCharts(document.querySelector("#revenueChart"), {
                series: [{
                    name: 'Doanh thu',
                    data: revenues
                }],
                chart: {
                    height: 350,
                    type: 'bar',
                },
                plotOptions: {
                    bar: {
                        borderRadius: 4,
                        horizontal: true,
                        columnWidth: '55%',
                    }
                },
                dataLabels: {
                    enabled: false
                },
                xaxis: {
                    categories: names,
                    labels: {
                        formatter: function (val) {
                            return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);
                        }
                    }
                },
                fill: {
                    opacity: 1
                },
                tooltip: {
                    y: {
                        formatter: function (val) {
                            return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);
                        }
                    }
                }
            }).render();
        });
    </script>
</body>
</html>