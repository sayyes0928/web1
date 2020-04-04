package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn; // mysql 연결을 위한 DB 접근 객체
	private ResultSet rs; // 쿼리 결과가 있다면 re 객체에 결과 저장
	// Ctrl + Shift + O 를 통해 import

	public BbsDAO() {
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

	public String getDate() {// 현재의 시간을 가져오는 함수
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되어있는 객체를 이용해서 이 SQL문장을 실행 준비단계로 만들어준다
			rs = pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과를 가져온다
			if (rs.next()) { // 결과가 있는경우
				return rs.getString(1); // 현재의 그 날짜를 그대로 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";// 데이터베이스 오류
	}

	public int getNext() {// 현재의 시간을 가져오는 함수
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; // 제일 마지막에 쓰인 번호를 가져온다
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되어있는 객체를 이용해서 이 SQL문장을 실행 준비단계로 만들어준다
			rs = pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과를 가져온다
			if (rs.next()) { // 결과가 있는경우
				return rs.getInt(1) + 1; // 나온 번호에 1을 더해 그다음 게시글에 번호가 들어갈 수 있도록 만든다
			}
			return 1; // 첫번째 게시물
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// 데이터베이스 오류
	}

	public int write(String bbsTitle, String userID, String bbsContent) { // 실제로 글을 작성하는 write 라는 함수
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)"; // 실제로 데이터베이스에 글을 작성해서 넣어줄 필요가 있다
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되어있는 객체를 이용해서 이 SQL문장을 실행 준비단계로 만들어준다
			pstmt.setInt(1, getNext()); // 다음번에 쓰여야 할 게시글 번호
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// 데이터베이스 오류
	}
	public ArrayList<Bbs> getList(int pageNumber){ //특정한 리스트를 담아서 반환하도록 만들어준다
		//ArrayList<Bbs> 를 외부 라이브러리로부터 가져올 수 있도록 한다.
		//특정한 페이지에 따른 총 10개의 게시글을 가져올 수 있도록 함수를 만든다.
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list =new ArrayList<Bbs>(); //Bbs라는 클래스에서 나오는 인스턴스를 보관 할 수 있는 리스트를 하나 만들어서 Bbs를 담을 수 있게한다
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되어있는 객체를 이용해서 이 SQL문장을 실행 준비단계로 만들어준다
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과를 가져온다
			while (rs.next()) { // 결과가 있는경우
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;// 데이터베이스 오류
	}
	
	public boolean nextPage(int pageNumber) {//페이징처리를 위해 존재하는 함수
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1"; //삭제가 되지 않아서  Available 이1인 글들만 가져오도록 하고, 아이디에따라 내림차순으로 10개까지만 가져온다
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되어있는 객체를 이용해서 이 SQL문장을 실행 준비단계로 만들어준다
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과를 가져온다
			if (rs.next()) { // 결과가 있는경우
				return true; //다음페이지로 넘어갈 수 있다는걸 알려준다
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public Bbs getBbs(int bbsID) { //하나의 글 내용을 불러오는 함수
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?"; //bbsID가 특정한 숫자인 경우 어떠한 결과를 시행하도록 한다.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되어있는 객체를 이용해서 이 SQL문장을 실행 준비단계로 만들어준다
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과를 가져온다
			if (rs.next()) { // 결과가 있는경우
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs; //결과로 나온 6개의 변수를 모두 받은 다음 그것을 bbs 인스턴스에 넣은다. 그다음 이 함수를 불러내는 대상에게 반환해준다.
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 해당 글이 존재하지 않는 경우 null을 반환
	}
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?"; //bbsID가 특정한 숫자인 경우 어떠한 결과를 시행하도록 한다.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되어있는 객체를 이용해서 이 SQL문장을 실행 준비단계로 만들어준다
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate(); //결과로 나온 6개의 변수를 모두 받은 다음 그것을 bbs 인스턴스에 넣은다. 그다음 이 함수를 불러내는 대상에게 반환해준다.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 해당 글이 존재하지 않는 경우 null을 반환
	}
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?"; //bbsID가 특정한 숫자인 경우 어떠한 결과를 시행하도록 한다.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되어있는 객체를 이용해서 이 SQL문장을 실행 준비단계로 만들어준다
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 해당 글이 존재하지 않는 경우 null을 반환
	}
}
