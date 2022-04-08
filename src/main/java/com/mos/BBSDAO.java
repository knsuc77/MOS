package com.mos;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BBSDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BBSDAO() {
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
	
	public int postBBS(String table, String author, String title, String context, HttpServletRequest request) {
		String sql = "insert into " + table + " values(?, ?, ?, ?, ?, ?)";
		try {
			int id = getNext(table);
			
			List<String> files = new ArrayList<>();
			
			
			String attached = null;
			if(!files.isEmpty()) {
				attached = files.get(0);
				for(int i = 1; i < files.size(); i ++) {
					attached += ","+files.get(i);
				}
			}
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setString(2, title);
			pstmt.setString(3, author);
			pstmt.setString(4, getDate());
			pstmt.setString(5, context);
			pstmt.setString(6, attached);
			
			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int deleteBBS(String table, String userid, int bbsid) {
		int check = isAuthor(table, userid, bbsid);
		if(check != 0) return check;
		String sql = "delete from " + table + " where ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsid);
			pstmt.executeUpdate();
			return 0;
		} catch(Exception e)
		{
			e.printStackTrace();
		}
		return -1;
	}
	
	public int isAuthor(String table, String userid, int bbsid) {
		if(new UserDAO().isAdmin(userid)) return 0;
		String sql = "select AUTHOR from " + table + " where ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String author = rs.getString(1).split("\\(")[1].replace(")","");
				if(userid.equals(author))
					return 0;
				else return 1;
			} else return -1; //글이 없음
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public String getDate() {
		String sql = "select now()";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getString(1);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext(String table) {
		String sql = "select ID from " + table + " order by ID desc";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public String[] getBBSData(String table, int id) {
		String sql = "select * from " + table + " where ID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			String[] data = new String[5];
			if(rs.next()) {
				for(int i = 2; i <= 6; i ++) {
					data[i-2] = rs.getString(i);
				}
				return data;
			}
			return null;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
		
	public List<String[]> getBBSDatabase(String table){
		String sql = "select * from " + table;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			List<String[]> db = new ArrayList<>();
			while(rs.next()) {
				String[] data = new String[] {
						rs.getString(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6)
				};
				db.add(data);
			}
			return db;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * <!--  -->
            <tr>
              <td>
                1392
              </td>
              <td><a href="#">James Yates</a></td>
              <td>
                Web Designer
              </td>
              <td>+63 983 0962 971</td>
            </tr>
            <!--  -->
            <tr class="spacer"><td colspan="100"></td></tr>
	 */
	
}
