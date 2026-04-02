package model;


import java.sql.Date;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class unavailable_date {
	private int ud_id;
	private Date ud_start;
	private Date ud_end;
	private int room_id;
	private int booking_id;
}
