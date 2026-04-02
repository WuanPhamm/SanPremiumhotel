package controller;

import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.cus_walletDAO;
import dao.withdrawal_billDAO;
import model.account;
import model.cus_wallet;
import model.withdrawal_bill;

@WebServlet("/wallet")
public class WalletController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Hàm GET để hiển thị trang Ví (truyền thông tin ví lên JSP)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        account loggedInAccount = (account) session.getAttribute("account"); // Giả sử bạn lưu account đăng nhập vào session key là "account"

        if (loggedInAccount == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        cus_wallet wallet = cus_walletDAO.getInstance().getWalletByAccountId(loggedInAccount.getAcc_id());
        
        request.setAttribute("wallet", wallet);
        request.getRequestDispatcher("/customer/wallet.jsp").forward(request, response);
    }

    // Hàm POST để xử lý yêu cầu rút tiền
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        account loggedInAccount = (account) session.getAttribute("account");

        if (loggedInAccount == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Lấy thông tin từ Form
            String amountStr = request.getParameter("withdrawAmount");
            String bankName = request.getParameter("bankName");
            String bankId = request.getParameter("bankId");

            BigDecimal withdrawAmount = new BigDecimal(amountStr);

            // Kiểm tra đầu vào cơ bản
            if (withdrawAmount.compareTo(new BigDecimal("10000")) < 0) {
                session.setAttribute("error", "Số tiền rút tối thiểu là 10,000 VNĐ.");
                response.sendRedirect(request.getContextPath() + "/wallet");
                return;
            }

            // Lấy ví của người dùng
            cus_wallet wallet = cus_walletDAO.getInstance().getWalletByAccountId(loggedInAccount.getAcc_id());

            if (wallet != null) {
                // Kiểm tra số dư ở Controller (Dù DAO đã có check, nhưng check ở đây để báo lỗi rõ ràng)
                if (wallet.getBalance().compareTo(withdrawAmount) >= 0) {
                    
                    // Gọi DAO xử lý Transaction
						withdrawal_bill wdb= new withdrawal_bill();
						wdb.setCw_id(wallet.getCw_id());
						wdb.setBank_name(bankName);
						wdb.setBank_id(bankId);
						wdb.setWdb_status(0);
						wdb.setWithdrawal_amount(withdrawAmount);
						int success=withdrawal_billDAO.getInstance().insert(wdb);
					  
					  if (success==1) { session.setAttribute("message",
					  "Tạo yêu cầu rút tiền thành công!"); } else { session.setAttribute("error",
					  "Có lỗi xảy ra hoặc số dư không đủ. Vui lòng thử lại."); }
					 
                } else {
                    session.setAttribute("error", "Số dư trong ví không đủ để thực hiện giao dịch.");
                }
            } else {
                session.setAttribute("error", "Không tìm thấy thông tin ví của bạn.");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Dữ liệu nhập vào không hợp lệ.");
        } catch (Exception e) {
            session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

        // Quay lại trang ví
        response.sendRedirect(request.getContextPath() + "/wallet");
    }
}