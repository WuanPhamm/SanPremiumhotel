<%@page import="model.ContactMessage"%>
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
            <h1>Quản lý liên hệ</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Danh sách liên hệ</li>
                </ol>
            </nav>
        </div>

        <section class="section">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mt-0">
                                <div class="d-flex align-items-center gap-2">
                                    <h5 class="card-title mb-0">Hộp thư khách hàng</h5>
                                </div>
                            </div>
                            <table class="table datatable">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Người gửi</th>
                                        <th>Email</th>
                                        <th>Tiêu đề</th>
                                        <th>Ngày gửi</th>
                                        <th>Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="msg" items="${list_msg}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>${msg.fullName}</td>
                                            <td>${msg.email}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${msg.subject.length() > 30}">
                                                        ${msg.subject.substring(0, 30)}...
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${msg.subject}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${msg.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <button class="btn btn-info btn-sm" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#viewModal"
                                                    data-fullname="${msg.fullName}"
                                                    data-email="${msg.email}"
                                                    data-subject="${msg.subject}"
                                                    data-message="${msg.message}"
                                                    data-date="${msg.createdAt}">
                                                    <i class="bi bi-eye"></i>
                                                </button>

                                                <button class="btn btn-danger btn-sm" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#deleteModal"
                                                    data-id="${msg.id}">
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
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chi tiết tin nhắn</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <strong>Người gửi: </strong> <span id="view-fullname"></span>
                        </div>
                        <div class="col-md-6">
                             <strong>Thời gian: </strong> <span id="view-date"></span>
                        </div>
                    </div>
                    <div class="mb-3">
                        <strong>Email: </strong> <a id="view-email-link" href="#"><span id="view-email"></span></a>
                    </div>                  
                    <div class="mb-3">
                        <strong>Tiêu đề: </strong>
                        <p id="view-subject" class="fw-bold text-primary"></p>
                    </div>
                    <div class="mb-3">
                        <strong>Nội dung: </strong>
                        <div id="view-message" class="p-3 bg-light border rounded"></div>
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
                    <h5 class="modal-title">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa tin nhắn liên hệ này không?</p>
                    <p class="text-danger"><small>Hành động này không thể hoàn tác.</small></p>
                </div>
                <div class="modal-footer">
                    <form action="<%= request.getContextPath() %>/ad_contacts" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="delete-id">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-danger">Xóa</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // Xử lý View Modal
        const viewModal = document.getElementById('viewModal');
        viewModal.addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;

            // Lấy dữ liệu từ attribute data-*
            const fullname = button.getAttribute('data-fullname');
            const email = button.getAttribute('data-email');
            const subject = button.getAttribute('data-subject');
            const message = button.getAttribute('data-message');
            const date = button.getAttribute('data-date');

            // Đổ dữ liệu vào Modal
            document.getElementById('view-fullname').textContent = fullname;
            document.getElementById('view-email').textContent = email;
            document.getElementById('view-subject').textContent = subject;
            document.getElementById('view-message').innerText = message; // Dùng innerText để tránh XSS nếu message có HTML
            document.getElementById('view-date').textContent = date;

            // Cập nhật nút Reply
            document.getElementById('reply-btn').href = "mailto:" + email + "?subject=Re: " + encodeURIComponent(subject);
        });

        // Xử lý Delete Modal
        const deleteModal = document.getElementById('deleteModal');
        deleteModal.addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;
            const id = button.getAttribute('data-id');
            document.getElementById('delete-id').value = id;
        });
    </script>

</body>

<script src="${pageContext.request.contextPath}/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/admin/assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="${pageContext.request.contextPath}/admin/assets/js/main.js"></script>
  
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
</html>