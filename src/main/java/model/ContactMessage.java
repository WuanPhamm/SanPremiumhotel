 package model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class ContactMessage {
    private int id;
    private String fullName;
    private String email;
    private String subject;
    private String message;
    private Timestamp createdAt;

}