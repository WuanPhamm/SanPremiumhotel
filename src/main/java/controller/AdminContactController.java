package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ContactMessageDAO;
import model.ContactMessage;

@WebServlet("/ad_contacts")
public class AdminContactController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // Gọi DAO lấy toàn bộ tin nhắn
        ContactMessageDAO dao = ContactMessageDAO.getIns();
        ArrayList<ContactMessage> list = dao.selectAll();

        // Đẩy dữ liệu sang JSP
        req.setAttribute("list_msg", list);
        req.getRequestDispatcher("/admin/contact_management.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        String action = req.getParameter("action");
        String messageStatus = "fail";

        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                ContactMessage msg = new ContactMessage();
                msg.setId(id);
                
                ContactMessageDAO dao = ContactMessageDAO.getIns();
                if (dao.delete(msg) > 0) {
                    messageStatus = "success";
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Redirect lại trang danh sách kèm thông báo
        resp.sendRedirect(req.getContextPath() + "/ad_contacts?message=" + messageStatus);
    }
}