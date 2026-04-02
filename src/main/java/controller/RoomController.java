package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.Part;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletOutputStream; // THÊM IMPORT NÀY
import javax.servlet.annotation.MultipartConfig;

import dao.floorDAO;
import dao.roomDAO;
import model.floor;
import model.room;
import model.room_type;
import dao.room_typeDAO;

@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
	    maxFileSize = 1024 * 1024 * 10,      // 10 MB
	    maxRequestSize = 1024 * 1024 * 100   // 100 MB
	)

public class RoomController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		ArrayList<room> list = new ArrayList<>();
		ArrayList<room_type> list2 = new ArrayList<>();
		ArrayList<floor> list3 = new ArrayList<>();
		
		list = roomDAO.getIns().selectAll();
		list2= room_typeDAO.getIns().selectAll();
		list3 = floorDAO.getIns().selectAll();
		
		String floor_id = req.getParameter("floor_id");
		String rt_id = req.getParameter("rt_id");
		String rs_id = req.getParameter("rs_id");
		
		if(floor_id != null) {
			list = getRoomByCondition(list, floor_id, rt_id, rs_id);
		}
		
		String action = req.getParameter("action");
		if ("export_excel".equals(action)) {
			exportRoomsToExcel(req, resp, list, list2); // Truyền danh sách đã lọc
			return; // Dừng xử lý để không forward đến JSP
		}
		
		req.setAttribute("list_room_all", list);
		req.setAttribute("list_room_type", list2);
		req.setAttribute("floor_list", list3);
		req.getRequestDispatcher("/admin/room_management.jsp").forward(req, resp);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		String action = req.getParameter("action");
        String excelAction = req.getParameter("excel_action"); // Dùng để xác định upload

		if("edit".equals(action)){
			editRoom(req, resp);
			return;
		} else if ("upload_excel".equals(excelAction)) {
            addRoomByExcel(req, resp);
            return;
        }
		
		else if ("upload_sheet_link".equals(action)) { // THÊM MỚI
        	addRoomBySheetLink(req, resp);
        	return;
        }
		doGet(req, resp);
	}
	
	private void editRoom(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int kq = 0;
		
		int room_id = Integer.parseInt(req.getParameter("room_id"));
		
		int rt_id = Integer.parseInt(req.getParameter("rt_id"));
		int rs_id = Integer.parseInt(req.getParameter("rs_id"));
		
		room r = roomDAO.getIns().selectById(room_id);
		
		r.setRs_id(rs_id);
		r.setRt_id(rt_id);
		
		kq = roomDAO.getIns().update(r);
		
		String message;
		if (kq > 0) {
		    message = "success";
		} else {
		    message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/rooms?message=" + message);
	}
	
	public ArrayList<room> getRoomByCondition(ArrayList<room> l, String floor_id, String rt_id, String rs_id){		
		return filterByFloor(filterByType(filterByStatus(l, rs_id), rt_id), floor_id);
	}
	
	public ArrayList<room> filterByFloor(ArrayList<room> rooms, String floor_id) {
	    if ("all".equalsIgnoreCase(floor_id)) {
	        return rooms;
	    }

	    int id = Integer.parseInt(floor_id);
	    ArrayList<room> result = new ArrayList<>();
	    for (room room : rooms) {
	        if (room.getFloor_id() == id) {
	            result.add(room);
	        }
	    }
	    return result;
	}

	public ArrayList<room> filterByStatus(ArrayList<room> rooms, String rs_id) {
	    if ("all".equalsIgnoreCase(rs_id)) {
	        return rooms;
	    }

	    int id = Integer.parseInt(rs_id);
	    ArrayList<room> result = new ArrayList<>();
	    for (room room : rooms) {
	        if (room.getRs_id() == id) {
	            result.add(room);
	        }
	    }
	    return result;
	}

	public ArrayList<room> filterByType(ArrayList<room> rooms, String rt_id) {
	    if ("all".equalsIgnoreCase(rt_id)) {
	        return rooms;
	    }

	    int id = Integer.parseInt(rt_id);
	    ArrayList<room> result = new ArrayList<>();
	    for (room room : rooms) {
	        if (room.getRt_id() == id) {
	            result.add(room);
	        }
	    }
	    return result;
	}

	
	private void addRoomByExcel(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int kq = 1;

		ArrayList<room> list = new ArrayList<>();

		Part filePart = req.getPart("excel_file");
		InputStream inputStream = filePart.getInputStream();

		try (Workbook workbook = new XSSFWorkbook(inputStream)) {
			Sheet sheet = workbook.getSheetAt(0);
			for (Row row : sheet) {
				if (row.getRowNum() == 0)
					continue; // Bỏ qua dòng tiêu đề

				String room_name = getCellValueAsString(row.getCell(0));
				String rt_idStr = getCellValueAsString(row.getCell(1));
				String rs_idStr = getCellValueAsString(row.getCell(2));
				String floor_idStr=getCellValueAsString(row.getCell(3));
				String room_booking_timeStr=getCellValueAsString(row.getCell(4));
				

				// Bỏ qua dòng nếu thiếu dữ liệu
				if (room_name.isEmpty() || rt_idStr.isEmpty() || rs_idStr.isEmpty() || floor_idStr.isEmpty() || room_booking_timeStr.isEmpty()) {
					System.out.println("Dòng thiếu dữ liệu, bỏ qua.");
					continue;
				}
				
				int rt_id, rs_id, floor_id, room_booking_time;
				try {
					rt_id = Integer.parseInt(rt_idStr);
				} catch (NumberFormatException e) {
					System.out.println("ID loại phòng không hợp lệ: " + rt_idStr);
					continue;
				}
				
				try {
					rs_id = Integer.parseInt(rs_idStr);
				} catch (NumberFormatException e) {
					System.out.println("ID trạng thái không hợp lệ: " + rs_idStr);
					continue;
				}
				
				try {
					floor_id = Integer.parseInt(floor_idStr);
				} catch (NumberFormatException e) {
					System.out.println("ID loại phòng không hợp lệ: " + floor_idStr);
					continue;
				}
				
				try {
					room_booking_time = Integer.parseInt(room_booking_timeStr);
				} catch (NumberFormatException e) {
					System.out.println("Số lần đặt không hợp lệ: " + room_booking_timeStr);
					continue;
				}

				room r = new room();
				r.setRoom_name(room_name);
				r.setRt_id(rt_id);
				r.setRs_id(rs_id);
				r.setFloor_id(floor_id);
				r.setRoom_booking_time(room_booking_time);
				
				list.add(r);
			}

			kq = roomDAO.getIns().insertIgnore(list);
			System.out.println("Inserted " + kq + " room(s)");

		} catch (Exception e) {
			kq = 0;
			e.printStackTrace();
		}

		String message = (kq > 0) ? "success" : "fail";
		resp.sendRedirect(req.getContextPath() + "/rooms?message=" + message);
	}
	
	
	private void addRoomBySheetLink(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int kq = 1;
		ArrayList<room> list = new ArrayList<>();
		String sheetUrl = req.getParameter("sheet_link");

		// 1. Sử dụng try-with-resources (giống AccountController)
		//    Tự động mở URL và đóng streams khi kết thúc
		try (BufferedReader reader = new BufferedReader(new InputStreamReader(new URL(sheetUrl).openStream(), "UTF-8"))) {

			String line;
			int lineNum = 0;
			while ((line = reader.readLine()) != null) {
				lineNum++;
				// Bỏ qua dòng tiêu đề (dòng 1)
				if (lineNum == 1) continue; 
				
				// 2. Sử dụng try-catch bên trong vòng lặp 
				//    Để nếu 1 dòng bị lỗi, nó sẽ bỏ qua và tiếp tục
				try {
					String[] data = line.split(","); // Tách dữ liệu bằng dấu phẩy
					
					// Yêu cầu 5 cột
					if (data.length < 5) {
						System.out.println("Dòng " + lineNum + " thiếu dữ liệu (cần 5 cột), bỏ qua.");
						continue;
					}

					String room_name = data[0].trim();
					String rt_idStr = data[1].trim();
					String rs_idStr = data[2].trim();
					String floor_idStr = data[3].trim();
					String room_booking_timeStr = data[4].trim();

					// Kiểm tra dữ liệu rỗng
					if (room_name.isEmpty() || rt_idStr.isEmpty() || rs_idStr.isEmpty() || floor_idStr.isEmpty() || room_booking_timeStr.isEmpty()) {
						System.out.println("Dòng " + lineNum + " có dữ liệu rỗng, bỏ qua.");
						continue;
					}

					// Parse số (đặt trong try-catch này)
					int rt_id = Integer.parseInt(rt_idStr);
					int rs_id = Integer.parseInt(rs_idStr);
					int floor_id = Integer.parseInt(floor_idStr);
					int room_booking_time = Integer.parseInt(room_booking_timeStr);

					room r = new room();
					r.setRoom_name(room_name);
					r.setRt_id(rt_id);
					r.setRs_id(rs_id);
					r.setFloor_id(floor_id);
					r.setRoom_booking_time(room_booking_time);
					
					list.add(r);
					
				} catch (Exception e) {
					// Bắt tất cả lỗi (NumberFormat, ArrayIndexOutOfBounds,...)
					System.err.println("Lỗi xử lý dòng " + lineNum + ": " + line);
					System.err.println("Chi tiết: " + e.getMessage());
					// Bỏ qua dòng này và tiếp tục vòng lặp
				}
			}
		} catch (Exception e) {
			// Lỗi này xảy ra nếu không mở được URL (link sai, 404, không mạng,...)
			kq = 0;
			e.printStackTrace();
			// Có thể set message = "fail_invalid_link" ở đây nếu muốn
		}

		// 3. Tách logic insert CSDL ra ngoài 
		try {
			if (!list.isEmpty()) {
				kq = roomDAO.getIns().insertIgnore(list);
				System.out.println("Inserted " + kq + " room(s) from Google Sheet CSV");
			} else {
				// Nếu list rỗng (do file rỗng hoặc lỗi đọc file)
				// thì kq sẽ giữ nguyên giá trị (0 nếu lỗi, 1 nếu không lỗi nhưng file rỗng)
				if (kq != 0) kq = 0; // Đảm bảo kq = 0 nếu không insert gì
			}
		} catch (Exception e) {
			kq = 0; // Lỗi khi insert vào CSDL
			System.err.println("Lỗi CSDL khi insert từ Sheet: " + e.getMessage());
		}

		String message = (kq > 0) ? "success" : "fail";
		resp.sendRedirect(req.getContextPath() + "/rooms?message=" + message);
	}
	
private void exportRoomsToExcel(HttpServletRequest req, HttpServletResponse resp, ArrayList<room> roomList, ArrayList<room_type> roomTypeList) throws IOException {
		
		try (Workbook workbook = new XSSFWorkbook()) {
			Sheet sheet = workbook.createSheet("Danh sách phòng");
			
			// Tạo dòng tiêu đề
			Row headerRow = sheet.createRow(0);
			String[] headers = {"STT", "Tên phòng", "Tầng", "Loại phòng", "Trạng thái", "Số lần đặt"};
			for (int i = 0; i < headers.length; i++) {
				Cell cell = headerRow.createCell(i);
				cell.setCellValue(headers[i]);
			}
			
			// Hàm trợ giúp để lấy tên loại phòng
			java.util.Map<Integer, String> roomTypeMap = new java.util.HashMap<>();
			for(room_type rt : roomTypeList) {
				roomTypeMap.put(rt.getRt_id(), rt.getRt_name());
			}
			
			// Hàm trợ giúp để lấy tên trạng thái
			java.util.Map<Integer, String> statusMap = new java.util.HashMap<>();
			statusMap.put(1, "Đang trống");
			statusMap.put(2, "Đang được đặt");
			statusMap.put(3, "Đang bảo trì");

			// Đổ dữ liệu
			int rowNum = 1;
			for (room r : roomList) {
				Row row = sheet.createRow(rowNum++);
				
				row.createCell(0).setCellValue(rowNum - 1);
				row.createCell(1).setCellValue(r.getRoom_name());
				row.createCell(2).setCellValue(r.getFloor_id());
				
				String roomTypeName = roomTypeMap.getOrDefault(r.getRt_id(), "Không xác định");
				row.createCell(3).setCellValue(roomTypeName);
				
				String statusName = statusMap.getOrDefault(r.getRs_id(), "Không xác định");
				row.createCell(4).setCellValue(statusName);
				
				row.createCell(5).setCellValue(r.getRoom_booking_time());
			}
			
			// Thiết lập response header để tải file
			resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			resp.setHeader("Content-Disposition", "attachment; filename=\"danh_sach_phong.xlsx\"");
			
			// Ghi workbook ra OutputStream
			ServletOutputStream out = resp.getOutputStream();
			workbook.write(out);
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
			resp.getWriter().println("Lỗi khi xuất Excel: " + e.getMessage());
		}
	}
	
	// SỬA: Hàm chuyển Cell về chuỗi an toàn
	private String getCellValueAsString(Cell cell) {
	    if (cell == null)
	        return "";
	    switch (cell.getCellType()) {
	    case STRING:
	        return cell.getStringCellValue().trim();
	    case NUMERIC:
	        // Cải tiến để xử lý số nguyên/số thập phân an toàn
	        if (org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell)) {
	            // Xử lý nếu là ngày (thường không cần thiết cho ID)
	            return new java.text.SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
	        } else {
	            // Lấy giá trị số, làm tròn về số nguyên gần nhất, và chuyển thành chuỗi
	            return String.valueOf((int) Math.round(cell.getNumericCellValue()));
	        }
	    case BOOLEAN:
	        return String.valueOf(cell.getBooleanCellValue());
	    case FORMULA:
	        try {
	            // Cố gắng lấy giá trị chuỗi
	            return cell.getStringCellValue().trim();
	        } catch (IllegalStateException e) {
	            // Nếu không phải chuỗi (ví dụ: công thức trả về số), lấy giá trị số nguyên
	            return String.valueOf((int) Math.round(cell.getNumericCellValue()));
	        }
	    default:
	        return "";
	    }
	}
	

}
