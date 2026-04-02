package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class withdrawal_bill {
	private int wdb_id;
	private int cw_id;
	private java.math.BigDecimal withdrawal_amount;
	private String bank_name;
	private String bank_id;
	private int wdb_status;
}
