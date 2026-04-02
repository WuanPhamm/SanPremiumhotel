package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class customer {
	private int cus_id;
	private String cus_firstname;
	private String cus_lastname;
	private java.sql.Date cus_dob;
	private int cus_gender;
	private String cus_phone;
	private String cus_email;
	private String cus_address;
	private String cus_cccd;
	private int cus_booking_time;
	private String cus_avt_url;
	private int acc_id;

}
