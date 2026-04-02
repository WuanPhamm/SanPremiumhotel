package controller;

import java.io.IOException;
import java.math.BigDecimal;

import com.google.gson.Gson; // Cần thêm thư viện GSON vào dự án

import dao.DashboardDAO;
import dao.bookingDAO;
import model.BookingActivityDTO;
import model.BookingReport;
import model.BookingStatistic;

import java.util.*;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HomeController extends HttpServlet{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		
		//thong ke khach hang, doanh thu, don dat
		
		DashboardDAO dao1 = new DashboardDAO();

	    // 1. Lấy dữ liệu Đơn đặt phòng (Mặc định hiển thị Hôm nay như trong HTML)
	    int bookingToday = dao1.getBookingCount("day");
	    int bookingMonth = dao1.getBookingCount("month");
	    int bookingYear = dao1.getBookingCount("year");
	    // 2. Lấy dữ liệu Khách hàng (Mặc định hiển thị Năm nay như trong HTML)
	    int customerToday = dao1.getCustomerCount("day");
	    int customerMonth = dao1.getCustomerCount("month");
	    int customerYear = dao1.getCustomerCount("year");
	    // 3. Lấy dữ liệu Doanh thu (Mặc định hiển thị Tháng này như trong HTML)
	    BigDecimal revenueToday = dao1.getRevenue("day");
	    BigDecimal revenueMonth = dao1.getRevenue("month");
	    BigDecimal revenueYear = dao1.getRevenue("year");

	    
	    
	    // Gửi dữ liệu sang JSP
	    req.setAttribute("bookingToday", bookingToday);
	    req.setAttribute("bookingMonth", bookingMonth);
	    req.setAttribute("bookingYear", bookingYear);
	    
	    req.setAttribute("customerToday", customerToday);
	    req.setAttribute("customerMonth", customerMonth);
	    req.setAttribute("customerYear", customerYear);
	    
	    req.setAttribute("revenueToday", revenueToday);
	    req.setAttribute("revenueMonth", revenueMonth);
	    req.setAttribute("revenueYear", revenueYear);
		//ket thuc thong ke
		
		
		bookingDAO dao = new bookingDAO();
		ArrayList<BookingStatistic> rawData = dao.getBookingStatistics();

		// 2. Lấy danh sách TẤT CẢ các ngày duy nhất xuất hiện (để làm trục X)
		Set<String> uniqueDates = new LinkedHashSet<>(); // Dùng LinkedHashSet để giữ thứ tự
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		for (BookingStatistic item : rawData) {
		    if(item.getBookingDate() != null) {
		        uniqueDates.add(sdf.format(item.getBookingDate()));
		    }
		}
		List<String> listDates = new ArrayList<>(uniqueDates); // Trục X: ["2023-11-01", "2023-11-02", ...]

		// 3. Chuẩn bị dữ liệu cho từng Series (Từng trạng thái bs_id)
		// Map: Key là bs_id, Value là Map<Ngày, Số lượng> để tra cứu nhanh
		Map<Integer, Map<String, Integer>> dataMap = new HashMap<>();

		for (BookingStatistic item : rawData) {
		    int id = item.getBsId();
		    String date = sdf.format(item.getBookingDate());
		    
		    dataMap.putIfAbsent(id, new HashMap<>());
		    dataMap.get(id).put(date, item.getQuantity());
		}

		// 4. Tạo cấu trúc dữ liệu cuối cùng cho ApexCharts
		// Chúng ta sẽ tạo ra một List các Object chứa {name: "Tên Status", data: [mảng số lượng]}
		List<Map<String, Object>> seriesList = new ArrayList<>();
		int[] statusIds = {4, 6, 7}; 

		for (int statusId : statusIds) {
		    Map<String, Object> seriesItem = new HashMap<>();
		    
		    // Đặt tên hiển thị cho Status dựa trên hình ảnh bạn cung cấp
		    String statusName = "Khác"; // Tên mặc định
		    if(statusId == 4) statusName = "Đã hủy";
		    else if(statusId == 6) statusName = "Đã hoàn thành";
		    else if(statusId == 7) statusName = "Đã đánh giá";
		    
		    seriesItem.put("name", statusName);
		    
		    // Tạo mảng data lấp đầy số 0 nếu ngày đó không có đơn
		    List<Integer> dataPoints = new ArrayList<>();
		    
		    // Lưu ý: dataMap phải chứa dữ liệu của tất cả bs_id được lấy từ SQL
		    Map<String, Integer> statusData = dataMap.getOrDefault(statusId, new HashMap<>());
		    
		    if(statusId ==6 ) {
		    	Map<String, Integer> status6Data = dataMap.getOrDefault(6, new HashMap<>());
		    	Map<String, Integer> status7Data = dataMap.getOrDefault(7, new HashMap<>());
		    	for (String date : listDates) {
			        // Nếu ngày đó có dữ liệu thì lấy, không thì điền 0
			       
			        int count6 = status6Data.getOrDefault(date, 0);
				    int count7 = status7Data.getOrDefault(date, 0);
				    dataPoints.add(count6+count7);
			        
			    }
			    
			    seriesItem.put("data", dataPoints);
			    seriesList.add(seriesItem);
		    }
		    else {
		    	for (String date : listDates) {
			        // Nếu ngày đó có dữ liệu thì lấy, không thì điền 0
			        dataPoints.add(statusData.getOrDefault(date, 0));
			        
			    }
			    
			    seriesItem.put("data", dataPoints);
			    seriesList.add(seriesItem);
		    }
		}
		
		
		// 5. Chuyển sang JSON để gửi về JSP
		Gson gson = new Gson();
		String jsonDates = gson.toJson(listDates); // Trục X
		String jsonSeries = gson.toJson(seriesList); // Dữ liệu Series

		req.setAttribute("chartCategories", jsonDates);
		req.setAttribute("chartSeries", jsonSeries);
		
		
		//thongke theo thang
		bookingDAO dao2 = new bookingDAO();
		ArrayList<BookingStatistic> rawData2 = dao2.getBookingStatisticsByMonth();

		// 2. Lấy danh sách TẤT CẢ các ngày duy nhất xuất hiện (để làm trục X)
		Set<String> uniqueDates2 = new LinkedHashSet<>(); // Dùng LinkedHashSet để giữ thứ tự
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");

		for (BookingStatistic item : rawData2) {
		    if(item.getBookingDate() != null) {
		        uniqueDates2.add(sdf.format(item.getBookingDate()));
		    }
		}
		List<String> listDates2 = new ArrayList<>(uniqueDates2); // Trục X: ["2023-11-01", "2023-11-02", ...]

		// 3. Chuẩn bị dữ liệu cho từng Series (Từng trạng thái bs_id)
		// Map: Key là bs_id, Value là Map<Ngày, Số lượng> để tra cứu nhanh
		Map<Integer, Map<String, Integer>> dataMap2 = new HashMap<>();

		for (BookingStatistic item : rawData2) {
		    int id = item.getBsId();
		    String date = sdf2.format(item.getBookingDate());
		    
		    dataMap2.putIfAbsent(id, new HashMap<>());
		    dataMap2.get(id).put(date, item.getQuantity());
		}

		// 4. Tạo cấu trúc dữ liệu cuối cùng cho ApexCharts
		// Chúng ta sẽ tạo ra một List các Object chứa {name: "Tên Status", data: [mảng số lượng]}
		List<Map<String, Object>> seriesList2 = new ArrayList<>();
		int[] statusIds2 = {4, 6, 7}; 

		for (int statusId : statusIds2) {
		    Map<String, Object> seriesItem2 = new HashMap<>();
		    
		    // Đặt tên hiển thị cho Status dựa trên hình ảnh bạn cung cấp
		    String statusName = "Khác"; // Tên mặc định
		    if(statusId == 4) statusName = "Đã hủy";
		    else if(statusId == 6) statusName = "Đã hoàn thành";
		    else if(statusId == 7) statusName = "Đã đánh giá";
		    
		    seriesItem2.put("name", statusName);
		    
		    // Tạo mảng data lấp đầy số 0 nếu ngày đó không có đơn
		    List<Integer> dataPoints2 = new ArrayList<>();
		    
		    // Lưu ý: dataMap phải chứa dữ liệu của tất cả bs_id được lấy từ SQL
		    Map<String, Integer> statusData2 = dataMap2.getOrDefault(statusId, new HashMap<>());
		    
		    if(statusId ==6 ) {
		    	Map<String, Integer> status6Data2 = dataMap2.getOrDefault(6, new HashMap<>());
		    	Map<String, Integer> status7Data2 = dataMap2.getOrDefault(7, new HashMap<>());
		    	for (String date : listDates2) {
			        // Nếu ngày đó có dữ liệu thì lấy, không thì điền 0
			       
			        int count62 = status6Data2.getOrDefault(date, 0);
				    int count72 = status7Data2.getOrDefault(date, 0);
				    dataPoints2.add(count62+count72);
			        
			    }
			    
			    seriesItem2.put("data", dataPoints2);
			    seriesList2.add(seriesItem2);
		    }
		    else {
		    	for (String date : listDates2) {
			        // Nếu ngày đó có dữ liệu thì lấy, không thì điền 0
			        dataPoints2.add(statusData2.getOrDefault(date, 0));
			        
			    }
			    
			    seriesItem2.put("data", dataPoints2);
			    seriesList2.add(seriesItem2);
		    }
		}
		
		
		// 5. Chuyển sang JSON để gửi về JSP
		Gson gson2 = new Gson();
		String jsonDates2 = gson2.toJson(listDates2); // Trục X
		String jsonSeries2 = gson2.toJson(seriesList2); // Dữ liệu Series

		req.setAttribute("chartCategoriesMonth", jsonDates2);
		req.setAttribute("chartSeriesMonth", jsonSeries2);
		
		
		//Hoat dong gan day
		
		bookingDAO dao3 = new bookingDAO();
		List<BookingActivityDTO> recentActivities = dao3.getRecentActivities();
		req.setAttribute("recentActivityList", recentActivities);
		
		
		//thong ke tang
		
		

		// Gọi DAO lấy dữ liệu theo tầng với bộ lọc
		bookingDAO dao4 = new bookingDAO();
		List<BookingReport> floorStatsDay = dao4.getBookingCountByFloor("today");
		List<BookingReport> floorStatsMonth = dao4.getBookingCountByFloor("month");
		List<BookingReport> floorStatsYear = dao4.getBookingCountByFloor("year");
		
		Gson gson3 = new Gson();

		req.setAttribute("floorStatsDay", gson3.toJson(floorStatsDay));
		req.setAttribute("floorStatsMonth", gson3.toJson(floorStatsMonth));
		req.setAttribute("floorStatsYear", gson3.toJson(floorStatsYear));
		// Đẩy dữ liệu ra JSP
		

		// Hàm phụ để hiển thị tên đẹp trên giao diện
		
		
		
		req.getRequestDispatcher("admin/index.jsp").forward(req, resp);
	}
	
	
	
}
