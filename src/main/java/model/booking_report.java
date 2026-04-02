package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class booking_report {
    private String br_id;     // Lưu chuỗi thời gian (Ngày/Tháng/Năm)
    private int br_amount;    // Tổng số lượng đơn đặt phòng
}