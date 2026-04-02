package model;


import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class account {
	private int acc_id;
	private String acc_username;
	private String acc_password;
	private int acc_status;
	private Timestamp acc_created_at;
    private Timestamp acc_updated_at;
    private Timestamp acc_last_login_at;
    private int acc_login_time;
	private int role_id;
}
