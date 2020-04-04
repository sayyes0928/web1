package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	// JSP에서 회원 데이터베이스 테이블에 접근할 수 있도록 생성
// DAO = Data Access Object, 실질적으로 데이터베이스에서 회원정보를 관리 및 처리할 때 사용
	private Connection conn; // mysql 연결을 위한 DB 접근 객체
	private PreparedStatement pstmt;
	// Statement와 비교해 미리 컴파일 되기 때문에, 쿼리를 특정 값만 바꾸어 여러번 실행 할 때 유리.
	private ResultSet rs; // 쿼리 결과가 있다면 re 객체에 결과 저장
	// Ctrl + Shift + O 를 통해 import

	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					return 1;
				} else
					return 0;
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}

	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}
