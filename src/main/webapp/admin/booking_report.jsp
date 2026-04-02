<%@page import="model.booking_report"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <%@include file="/admin/ad_header.jsp"%>
    <%@include file="/admin/ad_sidebar.jsp"%>
<body>
    <%! 
    public String formatDateId(String id) {
        if (id == null || id.length() < 4) return "N/A";
        try {
            if (id.length() == 4) return "Năm " + id;
            else if (id.length() == 6) return "Tháng " + Integer.parseInt(id.substring(4, 6)) + "/" + id.substring(0, 4);
            else if (id.length() == 8) return Integer.parseInt(id.substring(6, 8)) + "/" + Integer.parseInt(id.substring(4, 6)) + "/" + id.substring(0, 4);
            return id;
        } catch (Exception e) { return "Lỗi"; }
    }
    %>
    
    <%
        ArrayList<booking_report> list = (ArrayList<booking_report>) request.getAttribute("list");
        if (list == null) list = new ArrayList<>();
        Integer grandTotal = (Integer) request.getAttribute("grandTotal");
        if (grandTotal == null) grandTotal = 0;
        String message2 = (String) request.getAttribute("message"); // Nhận thông báo từ Servlet
    %>

    <main id="main" class="main">
        <div class="pagetitle">
            <h1>Thống kê lượt đặt phòng</h1>
        </div>
    
        <section class="section">
            <div class="row">
                <div class="col-lg-12">
                     <% if(message2 != null) { %>
                        <div class="alert alert-info alert-dismissible fade show" role="alert">
                            <%= message2 %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <% } %>

                    <div class="card">
                        <div class="card-body p-4">
                            
                            <form action="booking-report" method="get" class="p-3 border rounded shadow-sm bg-light mb-4">
                                <input type="hidden" name="action" value="ana" />
                                <div class="row g-4 align-items-end">
                                    <div class="col-md-3">
                                        <label class="fw-bold">Thống kê theo</label>
                                        <select name="d" class="form-select">
                                            <option value="day" ${d == 'day' ? 'selected' : ''}>Ngày</option>
                                            <option value="month" ${d == 'month' ? 'selected' : ''}>Tháng</option>
                                            <option value="year" ${d == 'year' ? 'selected' : ''}>Năm</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="fw-bold">Từ ngày</label>
                                        <input type="date" name="s" class="form-control" value="${s}"/>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="fw-bold">Đến ngày</label>
                                        <input type="date" name="e" class="form-control" value="${e}"/>
                                    </div>
                                    <div class="col-md-3">
                                        <button type="submit" class="btn btn-primary w-100">Thống kê</button>
                                    </div>
                                </div>
                            </form>
                            
                            <div class="d-flex gap-2 mb-4 justify-content-end">
                                <button onclick="exportPNG()" class="btn btn-outline-success"><i class="bi bi-card-image"></i> Xuất PNG</button>
                                <button onclick="exportPDF()" class="btn btn-outline-danger"><i class="bi bi-file-pdf"></i> Xuất PDF</button>
                                <button onclick="exportExcel()" class="btn btn-outline-success"><i class="bi bi-file-earmark-excel"></i> Xuất Excel</button>
                                <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#emailModal"><i class="bi bi-envelope"></i> Gửi Email</button>
                            </div>

                            <div id="reportContent">
                                <h5 class="card-title">Biểu đồ xu hướng đặt phòng</h5>
                                <div class="chart-container" style="position: relative; height:400px; width:100%">
                                    <canvas id="reportsChart"></canvas>
                                </div>
            
                                <h5 class="card-title mt-4">Chi tiết số liệu</h5>
                                <table class="table table-striped table-bordered text-center" id="dataTable">
                                    <thead class="table-primary">
                                        <tr>
                                            <th>STT</th>
                                            <th>Thời gian</th>
                                            <th>Số lượng đơn</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (int i = 0; i < list.size(); i++) { 
                                            booking_report br = list.get(i); %>
                                            <tr>
                                                <td><%= i + 1 %></td>
                                                <td><%= formatDateId(br.getBr_id()) %></td>
                                                <td><%= br.getBr_amount() %></td>
                                            </tr>
                                        <% } %>
                                        <tr class="fw-bold table-warning">
                                            <td colspan="2">TỔNG CỘNG</td>
                                            <td><%= grandTotal %></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                        </div>
                    </div>  
                </div>
            </div>
        </section>
    </main>

    <div class="modal fade" id="emailModal" tabindex="-1" aria-labelledby="emailModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <form action="booking-report" method="post" enctype="multipart/form-data">
              <div class="modal-header">
                <h5 class="modal-title" id="emailModalLabel">Gửi báo cáo qua Email</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                <input type="hidden" name="action" value="sendEmail">
                <input type="hidden" name="d" value="${d}">
                <input type="hidden" name="s" value="${s}">
                <input type="hidden" name="e" value="${e}">
                
                <div class="mb-3">
                    <label class="form-label">Email người nhận</label>
                    <input type="email" class="form-control" name="recipientEmail" required placeholder="example@gmail.com">
                </div>
                <div class="mb-3">
                    <label class="form-label">Tiêu đề</label>
                    <input type="text" class="form-control" name="subject" value="Báo cáo thống kê đặt phòng" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Nội dung</label>
                    <textarea class="form-control" name="body" rows="3">Gửi bạn báo cáo thống kê từ ngày ${s} đến ${e}.</textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Chọn file đính kèm (PDF/Excel vừa tải)</label>
                    <input type="file" class="form-control" name="attachment" required>
                    <small class="text-muted">Hãy tải xuống báo cáo trước rồi chọn file tại đây.</small>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                <button type="submit" class="btn btn-primary">Gửi ngay</button>
              </div>
          </form>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>

    <script>
      document.addEventListener("DOMContentLoaded", () => {
        <%
            StringBuilder labelsBuilder = new StringBuilder();
            StringBuilder dataBuilder = new StringBuilder();
            if(list != null){
                for (int i = 0; i < list.size(); i++) {
                   booking_report br = list.get(i);
                   String label = formatDateId(br.getBr_id());
                   labelsBuilder.append("\"").append(label).append("\"");
                   dataBuilder.append(br.getBr_amount());
                   if (i < list.size() - 1) {
                     labelsBuilder.append(",");
                     dataBuilder.append(",");
                   }
                }
            }
        %>
        
        const labels = [<%= labelsBuilder.toString() %>];
        const dataVal = [<%= dataBuilder.toString() %>];
    
        const whiteBackgroundPlugin = {
                id: 'customCanvasBackgroundColor',
                beforeDraw: (chart, args, options) => {
                    const {ctx} = chart;
                    ctx.save();
                    ctx.globalCompositeOperation = 'destination-over';
                    ctx.fillStyle = options.color || '#ffffff'; // Mặc định là màu trắng
                    ctx.fillRect(0, 0, chart.width, chart.height);
                    ctx.restore();
                }
            };

            const ctx = document.getElementById("reportsChart").getContext('2d');
            
            window.myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Số lượng đặt phòng',
                        data: dataVal,
                        backgroundColor: 'rgba(54, 162, 235, 0.6)',
                        borderColor: 'rgb(54, 162, 235)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: { y: { beginAtZero: true } },
                    plugins: {
                        // 2. Kích hoạt plugin và set màu trắng
                        customCanvasBackgroundColor: {
                            color: 'white',
                        }
                    }
                },
                // 3. Đăng ký plugin vào chart này
                plugins: [whiteBackgroundPlugin]
            });
        });
        
        

      // --- CHỨC NĂNG XUẤT FILE ---

      // 1. Xuất PNG (Chỉ biểu đồ)
      function exportPNG() {
        const link = document.createElement('a');
        link.download = 'bieu-do-thong-ke.png';
        link.href = document.getElementById('reportsChart').toDataURL('image/png', 1.0);
        link.click();
      }

      // 2. Xuất Excel (Bảng dữ liệu)
      function exportExcel() {
        const table = document.getElementById("dataTable");
        const wb = XLSX.utils.table_to_book(table, {sheet: "Sheet 1"});
        XLSX.writeFile(wb, 'bao-cao-thong-ke.xlsx');
      }

      // 3. Xuất PDF (Cả biểu đồ và bảng)
      function exportPDF() {
        const { jsPDF } = window.jspdf;
        const input = document.getElementById('reportContent'); // Lấy div chứa cả chart và table
        
        // Dùng html2canvas chụp lại khu vực div
        html2canvas(input, { scale: 2 }).then(canvas => {
            const imgData = canvas.toDataURL('image/png');
            const pdf = new jsPDF('p', 'mm', 'a4');
            const imgProps = pdf.getImageProperties(imgData);
            const pdfWidth = pdf.internal.pageSize.getWidth();
            const pdfHeight = (imgProps.height * pdfWidth) / imgProps.width;
            
            pdf.addImage(imgData, 'PNG', 0, 10, pdfWidth, pdfHeight);
            pdf.save('bao-cao-day-du.pdf');
        });
      }
    </script>
    
    <script src="${pageContext.request.contextPath}/admin/assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/chart.js/chart.umd.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/echarts/echarts.min.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/quill/quill.js"></script>
 <%--  <script src="${pageContext.request.contextPath}/admin/assets/vendor/simple-datatables/simple-datatables.js"></script> --%>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="${pageContext.request.contextPath}/admin/assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="${pageContext.request.contextPath}/admin/assets/js/main${pageContext.request.contextPath}/admin.js"></script>
    
    </body>
</html>