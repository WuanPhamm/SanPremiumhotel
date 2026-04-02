package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class room {
	private int room_id;
	private String room_name;
	private int room_booking_time;
	private int floor_id;
	private int rt_id;
	private int rs_id;

}
