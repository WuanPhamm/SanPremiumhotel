package controller;

import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.UnitValue;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.*;

import com.itextpdf.io.font.PdfEncodings;

import dao.bookingDAO;
import dao.customerDAO;
import dao.paymentDAO;
import dao.roomDAO;
import dao.room_typeDAO;
import model.booking;
import model.customer;
import model.payment;
import model.room;
import model.room_type;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;

@WebServlet("/export-invoice")
public class ExportInvoiceServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. Lấy ID booking từ tham số
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/trangchu");
                return;
            }
            int bookingId = Integer.parseInt(idStr);

            // 2. Lấy thông tin booking từ Database
            bookingDAO dao = bookingDAO.getIns();
            booking b = dao.selectById(bookingId);
            
            
            if (b == null) {
                response.getWriter().write("Không tìm thấy đơn đặt phòng.");
                return;
            }
            room r= roomDAO.getIns().selectById(b.getRoom_id());
            room_type rt = room_typeDAO.getIns().selectById(r.getRt_id());
            customer cus=  customerDAO.getIns().selectById(b.getCus_id());
            payment pay = paymentDAO.getIns().selectById(b.getPay_id());
            
            // 3. Cấu hình Response trả về file PDF
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=HoaDon_SanPremium_" + bookingId + ".pdf");

            // 4. Khởi tạo PDF Writer
            PdfWriter writer = new PdfWriter(response.getOutputStream());
            PdfDocument pdf = new PdfDocument(writer);
            Document document = new Document(pdf);

            // --- CẤU HÌNH FONT TIẾNG VIỆT ---
            // Để hiển thị tiếng Việt, bạn cần trỏ đường dẫn đến file font .ttf (ví dụ: windows/fonts/arial.ttf hoặc copy file font vào resources)
            // Dưới đây là cách dùng font mặc định Unicode (nếu thư viện hỗ trợ) hoặc fallback
            // Tốt nhất: Copy file VuArial.ttf hoặc Arial.ttf vào thư mục WebContent/fonts/
            
            // Ví dụ load font (Bạn cần sửa đường dẫn này trỏ tới file ttf thực tế trên máy/server)
            // String fontPath = getServletContext().getRealPath("/fonts/arial.ttf"); 
            // PdfFont font = PdfFontFactory.createFont(fontPath, PdfEncodings.IDENTITY_H);
            
            // Nếu chưa có file font, dùng tạm font Standard (có thể lỗi hiển thị dấu tiếng Việt)
            
            
            String fontPath = getServletContext().getRealPath("/fonts/TIMES.TTF");
            
            // Kiểm tra xem có lấy được đường dẫn không (đề phòng lỗi null)
            PdfFont font;
            if (fontPath != null) {
                // IDENTITY_H là chế độ mã hóa giúp hiển thị tiếng Việt Unicode
                font = PdfFontFactory.createFont(fontPath, PdfEncodings.IDENTITY_H);
            } else {
                // Fallback: Nếu không tìm thấy file font thì dùng font mặc định (sẽ lỗi dấu)
                System.out.println("Khong tim thay file font!");
                font = PdfFontFactory.createFont(); 
            }

            // 5. Viết nội dung PDF
            
            // Tiêu đề: Khách sạn SweetHome
            Paragraph title = new Paragraph("KHÁCH SẠN SAN PREMIUM") // Viết không dấu nếu chưa cấu hình font
                    .setFont(font)
                    .setFontSize(20)
                    .setBold()
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(10);
            document.add(title);

            Paragraph subTitle = new Paragraph("HÓA ĐƠN THANH TOÁN")
                    .setFont(font)
                    .setFontSize(16)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(20);
            document.add(subTitle);

            // Thông tin chung
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            NumberFormat nf = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

            document.add(new Paragraph("Mã đơn đặt phòng: " + b.getBooking_id()).setFont(font));
            document.add(new Paragraph("Ngày đặt: " + sdf.format(b.getBooking_time())).setFont(font));
            document.add(new Paragraph("Thời gian thanh toán: " + (b.getPayment_time() != null ? sdf.format(b.getPayment_time()) : "Chưa xác định")).setFont(font));
            document.add(new Paragraph("------------------------------------------------").setTextAlignment(TextAlignment.CENTER));
            document.add(new Paragraph("Tên khách hàng: " + cus.getCus_firstname() + " " + cus.getCus_lastname()).setFont(font));
            document.add(new Paragraph("Loại phòng: " + rt.getRt_name()).setFont(font));
            // Bảng chi tiết
            float[] columnWidths = {3, 7}; // Tỉ lệ cột
            Table table = new Table(UnitValue.createPercentArray(columnWidths));
            table.setWidth(UnitValue.createPercentValue(100));

            // Hàng 1: Ngày Check-in
            table.addCell(new Cell().add(new Paragraph("Ngày nhận phòng:")).setFont(font).setBold());
            table.addCell(new Cell().add(new Paragraph(b.getBooking_start_date().toString())).setFont(font));

            // Hàng 2: Ngày Check-out
            table.addCell(new Cell().add(new Paragraph("Ngày trả phòng:")).setFont(font).setBold());
            table.addCell(new Cell().add(new Paragraph(b.getBooking_end_date().toString())).setFont(font));

            // Hàng 3: Loại phòng (Room ID) - *Nên dùng RoomDAO để lấy tên phòng*
            table.addCell(new Cell().add(new Paragraph("Tên phòng:")).setFont(font).setBold());
            table.addCell(new Cell().add(new Paragraph(String.valueOf(r.getRoom_name()))).setFont(font));
            
            // Hàng 4: Yêu cầu đặc biệt
            table.addCell(new Cell().add(new Paragraph("Ghi chú:")).setFont(font).setBold());
            String req = b.getBooking_requirements();
            table.addCell(new Cell().add(new Paragraph(req != null ? req : "Không")).setFont(font));

            document.add(table);
            
            document.add(new Paragraph("Phương thức thanh toán: " + pay.getPay_name()).setFont(font));
            // Tổng tiền
            Paragraph total = new Paragraph("\nTỔNG THANH TOÁN: " + nf.format(b.getBooking_total()))
                    .setFont(font)
                    .setFontSize(14)
                    .setBold()
                    .setTextAlignment(TextAlignment.RIGHT)
                    .setMarginTop(5);
            document.add(total);

            // Footer
            Paragraph footer = new Paragraph("\n\nCảm ơn quý khách đã sử dụng dịch vụ của San Premium!")
                    .setFont(font)
                    .setItalic()
                    .setTextAlignment(TextAlignment.CENTER);
            document.add(footer);

            // 6. Đóng document
            document.close();

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu lỗi, trả về trang lỗi hoặc thông báo đơn giản
            response.setContentType("text/html");
            response.getWriter().println("<h3>Lỗi khi xuất hóa đơn: " + e.getMessage() + "</h3>");
        }
    }
}
