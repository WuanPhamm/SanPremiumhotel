package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BookingReport {
    private String label; // Dùng để lưu Tên tầng, hoặc Ngày/Tháng/Năm
    private int quantity; // Số lượng đơn đặt phòng
}