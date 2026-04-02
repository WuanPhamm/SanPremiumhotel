package controller; // Đặt chung package với controller cũng được

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import tasks.BookingCompletionTask; // Import lớp Task

@WebListener // Đánh dấu đây là một Listener
public class BookingSchedulerListener implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Hàm này chạy KHI ỨNG DỤNG KHỞI ĐỘNG
        System.out.println("==========================================");
        System.out.println("KHỞI TẠO BỘ LẬP LỊCH TÁC VỤ ĐẶT PHÒNG");
        
        scheduler = Executors.newSingleThreadScheduledExecutor();
        
        // Lên lịch: Chạy BookingCompletionTask
        // 0: Bắt đầu chạy ngay sau 0 giây
        // 6: Chạy lại sau mỗi 6 TIẾNG (Bạn có thể đổi thành 24)
        // TimeUnit.HOURS: Đơn vị là TIẾNG
        scheduler.scheduleAtFixedRate(new BookingCompletionTask(), 0, 6, TimeUnit.HOURS);
        
        // Hoặc: Chạy 1 lần/ngày
        // scheduler.scheduleAtFixedRate(new BookingCompletionTask(), 0, 1, TimeUnit.DAYS);
        
        System.out.println("BỘ LẬP LỊCH ĐÃ BẮT ĐẦU.");
        System.out.println("==========================================");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Hàm này chạy KHI ỨNG DỤNG TẮT
        if (scheduler != null) {
            scheduler.shutdownNow();
        }
        System.out.println("==========================================");
        System.out.println("ĐÃ TẮT BỘ LẬP LỊCH TÁC VỤ.");
        System.out.println("==========================================");
    }
}