package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RoomTypeStat {
    private String rtName;      // Tên loại phòng
    private int totalBookings;  // Tổng số lượt đặt
    private double totalRevenue; // Tổng doanh thu (nếu cần)
}