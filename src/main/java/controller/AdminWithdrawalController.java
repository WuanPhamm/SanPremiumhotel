package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.cus_walletDAO;
import dao.withdrawal_billDAO;
import model.cus_wallet;
import model.withdrawal_bill;

@WebServlet("/withdrawal-management")
public class AdminWithdrawalController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String filterStatus = request.getParameter("filterStatus");

        // ===== 1. Xử lý xác nhận thanh toán =====
        if ("confirm".equals(action)) {
            try {
                int wdbId = Integer.parseInt(request.getParameter("id"));
                boolean isUpdated = withdrawal_billDAO.getInstance().confirmPayment(wdbId);
                withdrawal_bill wdb = withdrawal_billDAO.getInstance().findById(wdbId);
                cus_wallet cw = cus_walletDAO.getInstance().findById(wdb.getCw_id());
                BigDecimal newBalance = cw.getBalance()
                        .subtract(wdb.getWithdrawal_amount());
                cw.setBalance(newBalance);
                cus_walletDAO.getInstance().update(cw);
                String redirectUrl = request.getContextPath()
                        + "/withdrawal-management?filterStatus=all";
                        

                if (isUpdated) {
                    session.setAttribute("successMsg",
                            "Xác nhận thanh toán cho khách thành công!");
                } else {
                    session.setAttribute("errorMsg",
                            "Không thể xác nhận. Đơn này có thể đã được xử lý.");
                }

                response.sendRedirect(redirectUrl);
                return;

            } catch (NumberFormatException e) {
                session.setAttribute("errorMsg", "Lỗi dữ liệu ID!");
                response.sendRedirect(request.getContextPath()
                        + "/withdrawal-management?filterStatus=all");
                return;
            }
        }

        // ===== 2. Load danh sách =====
        List<withdrawal_bill> billList =
                withdrawal_billDAO.getInstance().getAllBills(filterStatus);

        request.setAttribute("billList", billList);
        request.setAttribute("filterStatus", filterStatus);

        request.getRequestDispatcher("/admin/withdrawal_management.jsp")
                .forward(request, response);
    }
}