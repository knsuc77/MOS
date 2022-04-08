package com.mos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mariadb://localhost:3306/bbs?useUnicode=true&characterEncoding=utf8";
			String dbID = "root";
			String dbPW = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getName(String ID) {
		String sql = "select userName from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			return "";
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public boolean isAdmin(String userID) {
		String sql = "select isAdmin from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getBoolean(1);
			}
			return false;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public int joinwait(User user) {
		//id encrytedpw gender name number
		String sql = "insert into userwait values(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, Encryptor.encrypt(user.getUserPassword()));
			pstmt.setString(3, user.getUserGender());
			pstmt.setString(4, user.getUserName());
			pstmt.setString(5, user.getUserNumber());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(Encryptor.encrypt(userPassword))) return 1;
				else return 0;
			}
			return -1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
}
