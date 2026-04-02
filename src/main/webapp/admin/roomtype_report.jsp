<%@page import="model.RoomTypeStat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <%@include file="/admin/ad_header.jsp"%>
    <%@include file="/admin/ad_sidebar.jsp"%>   
<body>

    <main id="main" class="main">
        <div class="pagetitle">
            <h1>Thống kê đặt phòng</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Thống kê</li>
                </ol>
            </nav>
        </div>

        <section class="section">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body pt-3">
                            <form action="<%= request.getContextPath()%>/rt_report" method="get" class="row g-3 align-items-end">
                                <div class="col-md-4">
                                    <label for="from" class="form-label fw-bold">Từ ngày:</label>
                                    <input type="date" class="form-control" id="from" name="from" value="${fromDate}">
                                </div>
                                <div class="col-md-4">
                                    <label for="to" class="form-label fw-bold">Đến ngày:</label>
                                    <input type="date" class="form-control" id="to" name="to" value="${toDate}">
                                </div>
                                <div class="col-md-4">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="bi bi-filter"></i> Lọc dữ liệu
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Biểu đồ Top loại phòng được đặt nhiều nhất</h5>
                            
                            <c:if test="${empty list_stats}">
                                <div class="alert alert-warning text-center">
                                    Không có dữ liệu đặt phòng trong khoảng thời gian này.
                                </div>
                            </c:if>
                            
                            <div id="topRoomChart" style="min-height: 400px;" class="echart"></div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Chi tiết số liệu</h5>
                            <table class="table datatable">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Loại phòng</th>
                                        <th class="text-center">Số lượt đặt</th>
                                        <th class="text-end">Tổng doanh thu</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="s" items="${list_stats}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>${s.rtName}</td>
                                            <td class="text-center">
                                                <span class="badge bg-primary rounded-pill" style="font-size: 0.9rem;">
                                                    ${s.totalBookings}
                                                </span>
                                            </td>
                                            <td class="text-end">
                                                <fmt:formatNumber value="${s.totalRevenue}" type="currency" currencySymbol="₫"/>
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

    <script src="${pageContext.request.contextPath}/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/vendor/echarts/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/vendor/simple-datatables/simple-datatables.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/js/main.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", () => {
            
            // Dữ liệu biểu đồ
            var roomNames = [
                <c:forEach var="item" items="${list_stats}" varStatus="loop">
                    "${item.rtName}"${!loop.last ? ',' : ''}
                </c:forEach>
            ];

            var bookingCounts = [
                <c:forEach var="item" items="${list_stats}" varStatus="loop">
                    ${item.totalBookings}${!loop.last ? ',' : ''}
                </c:forEach>
            ];

            // Chỉ vẽ biểu đồ nếu có dữ liệu
            if (roomNames.length > 0) {
                echarts.init(document.querySelector("#topRoomChart")).setOption({
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: { type: 'shadow' }
                    },
                    grid: {
                        left: '3%', right: '4%', bottom: '3%', containLabel: true
                    },
                    xAxis: {
                        type: 'value',
                        boundaryGap: [0, 0.01]
                    },
                    yAxis: {
                        type: 'category',
                        data: roomNames
                    },
                    series: [
                        {
                            name: 'Số lượt đặt',
                            type: 'bar',
                            data: bookingCounts,
                            itemStyle: { color: '#4154f1' }
                        }
                    ]
                });
            }

            // Khởi tạo Datatable
            const datatables = document.querySelectorAll('.datatable');
            datatables.forEach(dt => {
                new simpleDatatables.DataTable(dt, {
                    perPageSelect: [5, 10, ["All", -1]],
                });
            });
        });
    </script>
</body>
</html>