package model;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class booking {
	private int booking_id;
	private Timestamp booking_time;
	private Date booking_start_date;
	private Date booking_end_date;
	private String booking_requirements;
	private java.math.BigDecimal booking_total;
	private Timestamp payment_time;
	private int room_id;
	private int pay_id;
	private int bs_id;
	private int cus_id;
	private Timestamp booking_updated_at;
}
