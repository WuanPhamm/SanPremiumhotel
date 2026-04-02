package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class cus_wallet {
	private int cw_id;
	private int acc_id;
	private java.math.BigDecimal balance;
	private int cw_status;
}
