<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">

<%@include file="/admin/ad_header.jsp"%>
<%@include file="/admin/ad_sidebar.jsp"%>	
 
<%-- Thông báo thành công/lỗi tương tự trang Booking --%>
<%
    String successMsg = (String) session.getAttribute("successMsg");
    String errorMsg = (String) session.getAttribute("errorMsg");

    if (successMsg != null) {
%>
    <div class="alert alert-success"><%= successMsg %></div>
<%
        session.removeAttribute("successMsg");
    }

    if (errorMsg != null) {
%>
    <div class="alert alert-danger"><%= errorMsg %></div>
<%
        session.removeAttribute("errorMsg");
    }
%>

<main id="main" class="main">
    <div class="pagetitle">
        <h1>Quản lý hoàn tiền </h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/home">Trang chủ</a></li>
                <li class="breadcrumb-item active">Yêu cầu rút tiền</li>
            </ol>
        </nav>
    </div>

    <section class="section">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="card-title">Danh sách phiếu yêu cầu</h5>
                            
                            <form action="${pageContext.request.contextPath}/withdrawal-management" method="GET" class="d-flex gap-2">
                                <select name="filterStatus" class="form-select form-select-sm" onchange="this.form.submit()">
                                    <option value="all" ${param.filterStatus == 'all' ? 'selected' : ''}>Tất cả trạng thái</option>
                                    <option value="0" ${param.filterStatus == '0' ? 'selected' : ''}>Chờ xử lý</option>
                                    <option value="1" ${param.filterStatus == '1' ? 'selected' : ''}>Đã thanh toán</option>
                                </select>
                            </form>
                        </div>
        
                        <table class="table datatable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Mã Ví</th>
                                    <th>Số tiền rút</th>
                                    <th>Ngân hàng</th>
                                    <th>Số tài khoản</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="bill" items="${billList}">
                                    <tr>
                                        <td>#${bill.wdb_id}</td>
                                        <td>${bill.cw_id}</td>
                                        <td class="fw-bold text-danger">
                                            <fmt:formatNumber value="${bill.withdrawal_amount}" pattern="#,##0" />₫
                                        </td>
                                        <td>${bill.bank_name}</td>
                                        <td><code>${bill.bank_id}</code></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${bill.wdb_status == 0}">
                                                    <span class="badge bg-warning text-dark">Chờ xử lý</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success">Đã thanh toán</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:if test="${bill.wdb_status == 0}">
                                                <button class="btn btn-primary btn-sm" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#confirmPaymentModal"
                                                        data-id="${bill.wdb_id}"
                                                        data-amount="<fmt:formatNumber value="${bill.withdrawal_amount}" pattern="#,##0" />"
                                                        data-bank="${bill.bank_name} - ${bill.bank_id}">
                                                    <i class="bi bi-cash"></i> Xác nhận
                                                </button>
                                            </c:if>
                                            <c:if test="${bill.wdb_status == 1}">
                                                <button class="btn btn-secondary btn-sm" disabled>
                                                    <i class="bi bi-check-all"></i> Hoàn tất
                                                </button>
                                            </c:if>
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

<div class="modal fade" id="confirmPaymentModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/withdrawal-management" method="GET">
                <input type="hidden" name="action" value="confirm">
                <input type="hidden" name="id" id="modal_wdb_id">
                <input type="hidden" name="filterStatus" value="${param.filterStatus}">
                
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận đã chuyển khoản</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn xác nhận đã chuyển số tiền <strong id="modal_amount" class="text-danger"></strong> VNĐ vào tài khoản:</p>
                    <p><i class="bi bi-bank"></i> <span id="modal_bank_info"></span></p>
                    <div class="alert alert-info">
                        <small>Hành động này sẽ cập nhật trạng thái phiếu thành <strong>Đã thanh toán</strong> và không thể hoàn tác.</small>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-success">Xác nhận</button>
                </div>
            </form>
        </div>
    </div>
</div>

 <script>
    document.addEventListener("DOMContentLoaded", function () {
        // Xử lý truyền dữ liệu vào Modal
        const confirmModal = document.getElementById('confirmPaymentModal');
        if (confirmModal) {
            confirmModal.addEventListener('show.bs.modal', function (event) {
                const button = event.relatedTarget;
                const id = button.getAttribute('data-id');
                const amount = button.getAttribute('data-amount');
                const bank = button.getAttribute('data-bank');

                this.querySelector('#modal_wdb_id').value = id;
                this.querySelector('#modal_amount').textContent = amount;
                this.querySelector('#modal_bank_info').textContent = bank;
            });
        }
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
</body>
</html>