package util; 

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordEncoderUtil {

    private static final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    /**
     * Mã hóa mật khẩu thô
     * @param rawPassword Mật khẩu người dùng nhập
     * @return Chuỗi mật khẩu đã được băm (hash)
     */
    public static String encode(String rawPassword) {
        return encoder.encode(rawPassword);
    }

    /**
     * So sánh mật khẩu thô với mật khẩu đã băm trong DB
     * @param rawPassword Mật khẩu người dùng nhập
     * @param encodedPassword Mật khẩu đã băm lưu trong DB
     * @return true nếu khớp, false nếu không khớp
     */
    public static boolean matches(String rawPassword, String encodedPassword) {
        return encoder.matches(rawPassword, encodedPassword);
    }
}
