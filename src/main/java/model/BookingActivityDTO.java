package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BookingActivityDTO {
    private String customerName;    // Từ table Customer
    private String roomName;        // Từ table Room
    private String statusName;      // Từ table BookingStatus
    private int statusId;           // Để đổi màu icon (bs_id)
    private String timeAgo;         // Chuỗi hiển thị thời gian (vd: "3 phút trước")
    private Timestamp actualTime;   // Thời gian thực (booking_updated_at hoặc booking_time)
}