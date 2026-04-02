<%@page import="model.room_rating"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<%@include file="/admin/ad_header.jsp"%>
<%@include file="/admin/ad_sidebar.jsp"%>	

<body>

    <c:if test="${not empty param.message}">
        <div id="alertBox" class="alert 
            ${param.message eq 'success' ? 'alert-success' : 'alert-danger'} 
            position-fixed top-0 start-50 translate-middle-x mt-3 shadow-lg rounded-3 px-4 py-3"
            style="z-index: 1055; display: none;">
            <strong>
                <c:choose>
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
            <h1>Quản lý đánh giá</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Quản lý đánh giá</li>
                </ol>
            </nav>
        </div>

        <section class="section">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mt-3 mb-3">
                                <h5 class="card-title mb-0">Danh sách đánh giá phòng</h5>
                            </div>

                            <table class="table datatable table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col">STT</th>
                                        <th scope="col">Mã Booking</th>
                                        <th scope="col">Số sao</th>
                                        <th scope="col">Nội dung</th>
                                        <th scope="col">Thời gian</th>
                                        <th scope="col">Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="r" items="${list_rating}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>#${r.booking_id}</td>
                                            <td>
                                                <span class="text-warning">
                                                    <c:forEach begin="1" end="${r.rate_star}">
                                                        <i class="bi bi-star-fill"></i>
                                                    </c:forEach>
                                                    <c:forEach begin="${r.rate_star + 1}" end="5">
                                                        <i class="bi bi-star"></i>
                                                    </c:forEach>
                                                </span>
                                                (${r.rate_star})
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${r.rate_description.length() > 50}">
                                                        ${r.rate_description.substring(0, 50)}...
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${r.rate_description}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${r.rate_time}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#viewModal"
                                                    data-id="${r.rate_id}"
                                                    data-booking="${r.booking_id}"
                                                    data-star="${r.rate_star}"
                                                    data-desc="${r.rate_description}"
                                                    data-time="<fmt:formatDate value='${r.rate_time}' pattern='dd/MM/yyyy HH:mm'/>">
                                                    <i class="bi bi-eye"></i>
                                                </button>
        
                                                <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal"
                                                    data-id="${r.rate_id}">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            </div>
                    </div>
                </div>
            </div>
        </section>

    </main>

    <div class="modal fade" id="viewModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chi tiết đánh giá</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <strong>Mã Booking: </strong> <span id="viewBookingId"></span>
                    </div>
                    <div class="mb-3">
                        <strong>Đánh giá: </strong> <span id="viewStar" class="text-warning fw-bold"></span> <i class="bi bi-star-fill text-warning"></i>
                    </div>
                    <div class="mb-3">
                        <strong>Thời gian: </strong> <span id="viewTime"></span>
                    </div>
                    <div class="mb-3">
                        <strong>Nội dung phản hồi: </strong>
                        <p id="viewDesc" class="p-2 bg-light border rounded mt-1"></p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-danger">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa đánh giá này không?</p>
                    <p class="text-danger small"><i>Lưu ý: Hành động này không thể hoàn tác.</i></p>
                    
                    <form id="deleteForm" action="ratings" method="post">
                        <input type="hidden" name="action" value="delete" />
                        <input type="hidden" name="rate_id" id="deleteRateId" />
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" form="deleteForm" class="btn btn-danger">Xóa bỏ</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // Xử lý View Modal
        const viewModal = document.getElementById('viewModal');
        viewModal.addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget; // Nút được click
            
            // Lấy dữ liệu từ data attributes
            const bookingId = button.getAttribute('data-booking');
            const star = button.getAttribute('data-star');
            const desc = button.getAttribute('data-desc');
            const time = button.getAttribute('data-time');

            // Gán dữ liệu vào modal
            document.getElementById('viewBookingId').textContent = "#" + bookingId;
            document.getElementById('viewStar').textContent = star;
            document.getElementById('viewDesc').textContent = desc;
            document.getElementById('viewTime').textContent = time;
        });

        // Xử lý Delete Modal
        const deleteModal = document.getElementById('deleteModal');
        deleteModal.addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;
            const rateId = button.getAttribute('data-id');

            // Gán ID vào hidden input của form
            document.getElementById('deleteRateId').value = rateId;
        });
    </script>

    <script src="${pageContext.request.contextPath}/admin/assets/vendor/apexcharts/apexcharts.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/vendor/chart.js/chart.umd.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/vendor/echarts/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/vendor/quill/quill.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/vendor/simple-datatables/simple-datatables.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/vendor/tinymce/tinymce.min.js"></script>
    
    <script src="${pageContext.request.contextPath}/admin/assets/js/mainadmin.js"></script>
    
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const datatables = document.querySelectorAll('.datatable');
            datatables.forEach(dt => {
                new simpleDatatables.DataTable(dt, {
                    perPageSelect: [5, 10, 15, ["Tất cả", -1]],
                    labels: {
                        placeholder: "Tìm kiếm...",
                        perPage: "{select} dòng mỗi trang",
                        noRows: "Không có dữ liệu",
                        info: "Hiển thị {start} đến {end} trong tổng {rows} dòng",
                        noResults: "Không tìm thấy kết quả phù hợp"
                    }
                });
            });
        });
    </script>
</body>
</html>