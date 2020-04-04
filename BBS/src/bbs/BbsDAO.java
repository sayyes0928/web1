package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn; // mysql ������ ���� DB ���� ��ü
	private ResultSet rs; // ���� ����� �ִٸ� re ��ü�� ��� ����
	// Ctrl + Shift + O �� ���� import

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

	public String getDate() {// ������ �ð��� �������� �Լ�
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // ���� ����Ǿ��ִ� ��ü�� �̿��ؼ� �� SQL������ ���� �غ�ܰ�� ������ش�
			rs = pstmt.executeQuery(); // ������ ���������� ������ ����� �����´�
			if (rs.next()) { // ����� �ִ°��
				return rs.getString(1); // ������ �� ��¥�� �״�� ��ȯ
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";// �����ͺ��̽� ����
	}

	public int getNext() {// ������ �ð��� �������� �Լ�
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; // ���� �������� ���� ��ȣ�� �����´�
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // ���� ����Ǿ��ִ� ��ü�� �̿��ؼ� �� SQL������ ���� �غ�ܰ�� ������ش�
			rs = pstmt.executeQuery(); // ������ ���������� ������ ����� �����´�
			if (rs.next()) { // ����� �ִ°��
				return rs.getInt(1) + 1; // ���� ��ȣ�� 1�� ���� �״��� �Խñۿ� ��ȣ�� �� �� �ֵ��� �����
			}
			return 1; // ù��° �Խù�
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// �����ͺ��̽� ����
	}

	public int write(String bbsTitle, String userID, String bbsContent) { // ������ ���� �ۼ��ϴ� write ��� �Լ�
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)"; // ������ �����ͺ��̽��� ���� �ۼ��ؼ� �־��� �ʿ䰡 �ִ�
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // ���� ����Ǿ��ִ� ��ü�� �̿��ؼ� �� SQL������ ���� �غ�ܰ�� ������ش�
			pstmt.setInt(1, getNext()); // �������� ������ �� �Խñ� ��ȣ
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// �����ͺ��̽� ����
	}
	public ArrayList<Bbs> getList(int pageNumber){ //Ư���� ����Ʈ�� ��Ƽ� ��ȯ�ϵ��� ������ش�
		//ArrayList<Bbs> �� �ܺ� ���̺귯���κ��� ������ �� �ֵ��� �Ѵ�.
		//Ư���� �������� ���� �� 10���� �Խñ��� ������ �� �ֵ��� �Լ��� �����.
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list =new ArrayList<Bbs>(); //Bbs��� Ŭ�������� ������ �ν��Ͻ��� ���� �� �� �ִ� ����Ʈ�� �ϳ� ���� Bbs�� ���� �� �ְ��Ѵ�
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // ���� ����Ǿ��ִ� ��ü�� �̿��ؼ� �� SQL������ ���� �غ�ܰ�� ������ش�
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery(); // ������ ���������� ������ ����� �����´�
			while (rs.next()) { // ����� �ִ°��
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
		return list;// �����ͺ��̽� ����
	}
	
	public boolean nextPage(int pageNumber) {//����¡ó���� ���� �����ϴ� �Լ�
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1"; //������ ���� �ʾƼ�  Available ��1�� �۵鸸 ���������� �ϰ�, ���̵𿡵��� ������������ 10�������� �����´�
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // ���� ����Ǿ��ִ� ��ü�� �̿��ؼ� �� SQL������ ���� �غ�ܰ�� ������ش�
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery(); // ������ ���������� ������ ����� �����´�
			if (rs.next()) { // ����� �ִ°��
				return true; //������������ �Ѿ �� �ִٴ°� �˷��ش�
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public Bbs getBbs(int bbsID) { //�ϳ��� �� ������ �ҷ����� �Լ�
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?"; //bbsID�� Ư���� ������ ��� ��� ����� �����ϵ��� �Ѵ�.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // ���� ����Ǿ��ִ� ��ü�� �̿��ؼ� �� SQL������ ���� �غ�ܰ�� ������ش�
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery(); // ������ ���������� ������ ����� �����´�
			if (rs.next()) { // ����� �ִ°��
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs; //����� ���� 6���� ������ ��� ���� ���� �װ��� bbs �ν��Ͻ��� ������. �״��� �� �Լ��� �ҷ����� ��󿡰� ��ȯ���ش�.
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // �ش� ���� �������� �ʴ� ��� null�� ��ȯ
	}
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?"; //bbsID�� Ư���� ������ ��� ��� ����� �����ϵ��� �Ѵ�.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // ���� ����Ǿ��ִ� ��ü�� �̿��ؼ� �� SQL������ ���� �غ�ܰ�� ������ش�
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate(); //����� ���� 6���� ������ ��� ���� ���� �װ��� bbs �ν��Ͻ��� ������. �״��� �� �Լ��� �ҷ����� ��󿡰� ��ȯ���ش�.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �ش� ���� �������� �ʴ� ��� null�� ��ȯ
	}
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?"; //bbsID�� Ư���� ������ ��� ��� ����� �����ϵ��� �Ѵ�.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // ���� ����Ǿ��ִ� ��ü�� �̿��ؼ� �� SQL������ ���� �غ�ܰ�� ������ش�
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �ش� ���� �������� �ʴ� ��� null�� ��ȯ
	}
}
