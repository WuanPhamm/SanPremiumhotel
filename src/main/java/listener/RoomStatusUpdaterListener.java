package listener; // Hoặc 'listener', tùy bạn

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import dao.roomDAO; // Import roomDAO của bạn

/**
 * Class này tự động chạy khi server (Tomcat) khởi động.
 * Nó sẽ kích hoạt một tác vụ chạy nền để cập nhật trạng thái phòng
 * theo lịch trình (ví dụ: mỗi 5 phút).
 */
@WebListener // Đánh dấu đây là một Listener, tự động được server nhận diện
public class RoomStatusUpdaterListener implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Tác vụ này được thực thi khi server BẮT ĐẦU
        System.out.println("RoomStatusUpdaterListener is starting...");

        // Tạo một luồng duy nhất để chạy tác vụ
        scheduler = Executors.newSingleThreadScheduledExecutor();

        // Tạo tác vụ (Runnable) để chạy
        Runnable updateTask = new Runnable() {
            @Override
            public void run() {
                try {
                    // Gọi phương thức DAO mà chúng ta đã tạo ở Bước 1
                    roomDAO.getIns().updateAllRoomStatuses();
                } catch (Exception e) {
                    System.out.println("Unhandled exception in updateTask: " + e);
                    e.printStackTrace();
                }
            }
        };

        // Lập lịch cho tác vụ:
        // - Chạy lần đầu tiên sau 0 giây (chạy ngay)
        // - Chạy lặp lại mỗi 5 PHÚT (bạn có thể đổi thành TimeUnit.HOURS, v.v.)
        scheduler.scheduleAtFixedRate(updateTask, 0, 5, TimeUnit.MINUTES);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Tác vụ này được thực thi khi server DỪNG
        // Rất quan trọng phải tắt scheduler đi
        System.out.println("RoomStatusUpdaterListener is shutting down...");
        if (scheduler != null) {
            scheduler.shutdown();
        }
    }
}