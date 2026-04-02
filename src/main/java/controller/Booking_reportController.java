package controller;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Properties;

import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dao.bookingDAO;
import model.booking_report;

@WebServlet("/booking-report")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class Booking_reportController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Cấu hình Email gửi đi (Nên chuyển vào file properties hoặc biến môi trường)
    private static final String SENDER_EMAIL = "2uannene@gmail.com"; 
    // Nếu dùng Gmail, phải tạo "App Password" (Mật khẩu ứng dụng) trong cài đặt bảo mật Google
    private static final String SENDER_PASSWORD = "bntz tths upar bsjn"; 

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        // Logic thống kê giữ nguyên
        String type = request.getParameter("d"); 
        String start = request.getParameter("s"); 
        String end = request.getParameter("e");   
        
        if (type == null) type = "day";
        if (start == null || start.isEmpty()) start = LocalDate.now().withDayOfMonth(1).toString();
        if (end == null || end.isEmpty()) end = LocalDate.now().toString();

        bookingDAO dao = new bookingDAO();
        ArrayList<booking_report> list = dao.getReport(type, start, end);
        
        int grandTotal = 0;
        for (booking_report br : list) {
            grandTotal += br.getBr_amount();
        }
        
        request.setAttribute("list", list);         
        request.setAttribute("grandTotal", grandTotal);
        request.setAttribute("d", type); 
        request.setAttribute("s", start);
        request.setAttribute("e", end);
        
        request.getRequestDispatcher("/admin/booking_report.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("sendEmail".equals(action)) {
            handleSendEmail(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void handleSendEmail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String recipient = request.getParameter("recipientEmail");
        String subject = request.getParameter("subject");
        String body = request.getParameter("body");
        
        // Lấy file upload
        Part filePart = request.getPart("attachment");
        
        String messageResult = "";

        try {
            // Cấu hình mail server (Gmail)
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");

            Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject(subject);

            // Tạo phần thân email (Body + File đính kèm)
            MimeMultipart multipart = new MimeMultipart();

            // 1. Text body
            MimeBodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setText(body, "UTF-8");
            multipart.addBodyPart(messageBodyPart);

            // 2. File attachment
            if (filePart != null && filePart.getSize() > 0) {
                MimeBodyPart attachPart = new MimeBodyPart();
                // Đọc file từ input stream và đính kèm
                InputStream is = filePart.getInputStream();
                byte[] buffer = new byte[is.available()];
                is.read(buffer);
                
                attachPart.setContent(buffer, filePart.getContentType());
                attachPart.setFileName(filePart.getSubmittedFileName());
                multipart.addBodyPart(attachPart);
            }

            message.setContent(multipart);

            // Gửi mail
            Transport.send(message);
            messageResult = "Gửi email thành công đến " + recipient;

        } catch (Exception e) {
            e.printStackTrace();
            messageResult = "Lỗi khi gửi email: " + e.getMessage();
        }

        // Truyền thông báo và reload lại trang với các tham số lọc cũ
        request.setAttribute("message", messageResult);
        doGet(request, response);
    }
}