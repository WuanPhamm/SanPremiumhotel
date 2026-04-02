package model;

import java.security.KeyStore.PrivateKeyEntry;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class room_rating {
	private int rate_id;
	private int rate_star;
	private String rate_description;
	private int booking_id;
	private int rate_type;
	private Timestamp rate_time;
	
}
