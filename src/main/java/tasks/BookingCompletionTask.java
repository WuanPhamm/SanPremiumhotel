package tasks; // Bạn có thể đặt tên package là gì tùy ý

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import dao.bookingDAO;
import dao.customerDAO;
import dao.roomDAO;
import dao.unavailable_dateDAO;
import model.booking;
import model.customer;

// Lớp này triển khai 'Runnable' để có thể được lập lịch
public class BookingCompletionTask implements Runnable {

    @Override
    public void run() {
        System.out.println("[BookingScheduler] Bắt đầu quét các đặt phòng đã hết hạn...");

        try {
            // LƯU Ý: Chúng ta tuân theo cấu trúc DAO của bạn, 
            // gọi getIns() cho MỖI thao tác để có connection mới.

            // 1. Lấy danh sách các booking cần hoàn thành
            // (bs_id = 2 là "Đã xác nhận" VÀ ngày trả phòng < ngày hiện tại)
            String condition = "bs_id = 2 AND booking_end_date < CURDATE()";
            ArrayList<booking> bookingsToComplete = bookingDAO.getIns().selectByCondition(condition);

            if (bookingsToComplete == null || bookingsToComplete.isEmpty()) {
                System.out.println("[BookingScheduler] Không tìm thấy đặt phòng nào để hoàn thành.");
                return; // Dừng lại
            }

            System.out.println("[BookingScheduler] Tìm thấy " + bookingsToComplete.size() + " đặt phòng cần hoàn thành.");
            
            // Dùng Set để lưu các ID phòng một cách duy nhất
//            Set<Integer> roomIdsToFree = new HashSet<>();
            
            // 2. Cập nhật trạng thái từng booking thành "Hoàn thành" (bsId=6)
            for (booking b : bookingsToComplete) {
                b.setBs_id(6); // 6 = Đã hoàn thành
                
                // Gọi getIns() LẦN NỮA cho mỗi lần update
                bookingDAO.getIns().update(b);
                customer customer=customerDAO.getIns().selectById(b.getCus_id());
                int k= customer.getCus_booking_time()+1;
                customer.setCus_booking_time(k);
                customerDAO.getIns().update(customer);
                unavailable_dateDAO.getIns().deleteByBookingId(b.getBooking_id());
                // Thêm room_id vào danh sách cần giải phóng
//                roomIdsToFree.add(b.getRoom_id());
            }

            System.out.println("[BookingScheduler] Đã cập nhật " + bookingsToComplete.size() + " booking.");

            // 3. Cập nhật trạng thái các phòng về "Trống"
//            if (!roomIdsToFree.isEmpty()) {
//                roomDAO rDao = roomDAO.getIns();
//                int roomStatusId_Available = 1; // Giả sử 1 = Trống
//
//                for (Integer roomId : roomIdsToFree) {
//                    // Cập nhật trạng thái phòng (bạn cần có hàm này trong roomDAO)
//                    // Giả sử bạn có hàm updateTrangThai giống như trong Controller
//                    rDao.updateTrangThai(roomId, roomStatusId_Available);
//                                    }
//                System.out.println("[BookingScheduler] Đã giải phóng " + roomIdsToFree.size() + " phòng.");
//            }

        } catch (Exception e) {
            System.err.println("[BookingScheduler] LỖI nghiêm trọng khi đang chạy tác vụ tự động:");
            e.printStackTrace();
        }
    }
}