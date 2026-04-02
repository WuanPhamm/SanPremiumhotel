package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import dao.*;
import model.*;
import util.PasswordEncoderUtil;

public class AccountController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ArrayList<account> list, list_acc_admin, list_acc_cus, list_acc_xoa_tam_thoi, list_chua_xoa;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		list = accountDAO.getIns().selectAll();
		list_acc_admin = new ArrayList<>();
		list_acc_cus = new ArrayList<>();
		list_acc_xoa_tam_thoi = new ArrayList<>();
		list_chua_xoa = new ArrayList<>();

		for (account a : list) {
			if (a.getAcc_status() == 1) {
				list_chua_xoa.add(a);
				if (a.getRole_id() == 1) {
					list_acc_admin.add(a);
				} else if (a.getRole_id() == 2) {
					list_acc_cus.add(a);
				}
			} else if (a.getAcc_status() == 0) {
				list_acc_xoa_tam_thoi.add(a);
			}
		}

		String action = req.getParameter("filter");

		if ("cus".equals(action)) {
			list = list_acc_cus;
		} else if ("admin".equals(action)) {
			list = list_acc_admin;
		} else if ("tam".equals(action)) {
			list = list_acc_xoa_tam_thoi;
		} else {
			list = list_chua_xoa;
		}

		req.setAttribute("filter", action == null ? "all" : action);
		req.setAttribute("list_acc", list);

		req.getRequestDispatcher("/admin/acc_management.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");

		if ("".equals(action) || action == null) {
			return;
		}

		switch (action) {
		case "add": {
			addAcc(req, resp);
			break;
		}
		case "delete": {
			delAcc(req, resp);
			break;
		}
		case "delete_tam": {
			delTamAcc(req, resp);
			break;
		}
		case "khoiphuc": {
			KPAcc(req, resp);
			break;
		}
		case "edit": {
			editAcc(req, resp);
			break;
		}
		case "addbyexcel": {
			addAccByExcel(req, resp);
			break;
		}
		case "addbysheet": {
			addAccBySheet(req, resp);
			break;
		}
		}
	}

	private void addAcc(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		int role_id=Integer.parseInt(req.getParameter("role_id"));

		int kq = accountDAO.getIns().findByUsername(username);
		if (kq == 0) {	
			String hashedPassword = PasswordEncoderUtil.encode(password);
			
			
			
			account acc = new account(0, username, hashedPassword, 1, null, null, null, 0, role_id);
			accountDAO.getIns().insert(acc);
			
			acc = accountDAO.getIns().findByUsernameAndPassword(username, password);

			resp.sendRedirect(req.getContextPath() + "/accounts?message=success");
		} else {
			resp.sendRedirect(req.getContextPath() + "/accounts?message=fail");
		}
	}

	

	private void delAcc(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int account_id = Integer.parseInt(req.getParameter("account_id"));

		HttpSession session = req.getSession();
		account acc_main_id = (account) session.getAttribute("account");
		int acc_id = acc_main_id.getAcc_id();

		String message = "";
		int kq = 0;

		if (acc_id == account_id) {
			kq = -1;
		}

		if (kq != -1) {
			account acc = accountDAO.getIns().selectById(account_id);
			
			if(acc.getRole_id() == 2) {
				customer cus = customerDAO.getIns().getCustomerByAccountId(account_id);
				kq = customerDAO.getIns().delete(cus);
			}
			
			if(acc.getRole_id() == 1) {
				user u = userDAO.getInstance().getUserByAccountId(account_id);
				kq = userDAO.getInstance().delete(u);
			}
			
			if (acc.getAcc_status() == 0 || acc.getAcc_status() == 1) {
				kq = accountDAO.getIns().delete(acc);
			}
		}

		if (kq > 0) {
			message = "success";
		} else {
			message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/accounts?message=" + message);
	}

	private void delTamAcc(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int account_id = Integer.parseInt(req.getParameter("account_id"));

		String message = "";
		int kq = 0;

		try {
			kq = accountDAO.getIns().xoa_khoiphuc(account_id, 0);
		} catch (Exception e) {
			System.out.println(e);
		}

		if (kq > 0) {
			message = "success";
		} else {
			message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/accounts?message=" + message);
	}

	private void KPAcc(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int account_id = Integer.parseInt(req.getParameter("account_id"));

		String message = "";
		int kq = 0;

		try {
			kq = accountDAO.getIns().xoa_khoiphuc(account_id, 1);
		} catch (Exception e) {
			System.out.println(e);
		}

		if (kq > 0) {
			message = "success";
		} else {
			message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/accounts?message=" + message);
	}

	
	
	private void editAcc(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int account_id = Integer.parseInt(req.getParameter("account_id"));
		
		String role_id= req.getParameter("role_id");
		int role =Integer.parseInt(role_id);
		account acc = accountDAO.getIns().selectById(account_id);
		acc.setRole_id(role);
		
		int kq = 0;
		kq = accountDAO.getIns().update(acc);

		String message;
		if (kq > 0) {
			message = "success";
		} else {
			message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/accounts?message=" + message);
	}

	private void addAccByExcel(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int kq = 1;

		ArrayList<account> list = new ArrayList<>();

		Part filePart = req.getPart("file");
		InputStream inputStream = filePart.getInputStream();

		try (Workbook workbook = new XSSFWorkbook(inputStream)) {
			Sheet sheet = workbook.getSheetAt(0);
			for (Row row : sheet) {
				if (row.getRowNum() == 0)
					continue; // Bỏ qua dòng tiêu đề

				String account_username = getCellValueAsString(row.getCell(0));
				String account_password = getCellValueAsString(row.getCell(1));
				String roleStr = getCellValueAsString(row.getCell(2));

				// Bỏ qua dòng nếu thiếu dữ liệu
				if (account_username.isEmpty() || account_password.isEmpty() || roleStr.isEmpty()) {
					System.out.println("Dòng thiếu dữ liệu, bỏ qua.");
					continue;
				}

				int role_id;
				try {
					role_id = Integer.parseInt(roleStr);
				} catch (NumberFormatException e) {
					System.out.println("Role ID không hợp lệ: " + roleStr);
					continue;
				}

				account acc = new account();
				acc.setAcc_username(account_username);
				acc.setAcc_password(account_password);
				acc.setRole_id(role_id);
				list.add(acc);
			}

			kq = accountDAO.getIns().insertIgnore(list);
			System.out.println("Inserted " + kq + " account(s)");

		} catch (Exception e) {
			kq = 0;
			e.printStackTrace();
		}

		String message = (kq > 0) ? "success" : "fail";
		resp.sendRedirect(req.getContextPath() + "/accounts?message=" + message);
	}

	private void addAccBySheet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String csv_link = req.getParameter("linksheet");

		ArrayList<account> list = new ArrayList<>();

		try (BufferedReader reader = new BufferedReader(new InputStreamReader(new URL(csv_link).openStream()))) {
			String line;
			int lineNumber = 0;

			while ((line = reader.readLine()) != null) {
				lineNumber++;
				try {
					String[] row = line.split(",");

					if (row.length < 2) {
						throw new IllegalArgumentException("Thiếu cột dữ liệu");
					}

					account acc = new account();
					acc.setAcc_username(row[0].trim());
					acc.setAcc_password(row[1].trim());
					acc.setRole_id(Integer.parseInt(row[2].trim()));

					list.add(acc);
				} catch (Exception e) {
					System.err.println("Lỗi ở dòng " + lineNumber + ": " + line);
					System.err.println("Chi tiết: " + e.getMessage());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		int kq = 1;

		try {
			kq = accountDAO.getIns().insertIgnore(list);
			System.out.println("Inserted " + kq + " account(s)");
		} catch (Exception e) {
			System.err.println("insert sheet " + e);
		}

		String message = (kq > 0) ? "success" : "fail";
		resp.sendRedirect(req.getContextPath() + "/accounts?message=" + message);
	}

	// Hàm chuyển Cell về chuỗi an toàn
	private String getCellValueAsString(Cell cell) {
		if (cell == null)
			return "";
		switch (cell.getCellType()) {
		case STRING:
			return cell.getStringCellValue().trim();
		case NUMERIC:
			// Nếu là số nguyên, không cần hiển thị phần thập phân
			return String.valueOf((int) cell.getNumericCellValue());
		case BOOLEAN:
			return String.valueOf(cell.getBooleanCellValue());
		case FORMULA:
			try {
				return cell.getStringCellValue().trim(); // hoặc xử lý thêm nếu cần
			} catch (IllegalStateException e) {
				return String.valueOf(cell.getNumericCellValue());
			}
		default:
			return "";
		}
	}
}
