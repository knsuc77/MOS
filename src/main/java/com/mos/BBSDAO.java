package com.mos;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

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
	
	public String requestFilePath(String table, int bbsid, String fileName, HttpServletRequest request) {
		String realPath = "";
		String savePath = "attached";
		
		ServletContext context = request.getServletContext();
		realPath = context.getRealPath(savePath);
		System.out.println("request : "+ realPath);
		return realPath + File.separator + table + "_" + bbsid + "_" + fileName;
	}
	
	public String postBBS(String userid, HttpServletRequest request) {
		try {
			
			
			//파일 업로드 -->
			
			String realPath = "";
			String savePath = "attached";
			String type = "utf-8";
			int maxSize = 10*1024*1024;
			
			ServletContext context = request.getServletContext();
			realPath = context.getRealPath(savePath);
			
			File folder = new File(realPath);
			if(!folder.exists()) folder.mkdirs();
			
			
			DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
			diskFileItemFactory.setRepository(new File(realPath));
			diskFileItemFactory.setSizeThreshold(maxSize);
			diskFileItemFactory.setDefaultCharset("utf-8");
			ServletFileUpload fileUpload = new ServletFileUpload(diskFileItemFactory);
			
			List<FileItem> items = fileUpload.parseRequest(request);
			
			//파라미터 분류 -->
			List<FileItem> rawfiles = new ArrayList<>();
			HashMap<String, FileItem> hashmap = new HashMap<>();
			
			
			for(FileItem item : items) {
				if(item.isFormField())
					hashmap.put(item.getFieldName(), item);
				else {
					rawfiles.add(item);
				}
			}
			
			//테이블 종류 구분 -->
			String table = null;
			switch(hashmap.get("bbsType").getString()) {
			case "공지사항":
				table = "notis";
				break;
			case "족보":
				table = "testsolution";
				break;
			case "집행내역":
				table = "receipt";
				break;
			}
			
			//새로운 글 번호 추출 -->
			int id = getNext(table);
			
			//파일 분류 -- >
			List<String> files = new ArrayList<>();
			for(FileItem item : rawfiles) {
				if(item.getSize() > 0) {
					String separator = File.separator;
					int index = item.getName().lastIndexOf(separator);
					String fileName = item.getName().substring(index+1);
					File uploadFile = new File(realPath + separator + table + "_" + id + "_" + fileName);
					files.add(fileName);
					System.out.println("save Path : " + uploadFile.getAbsolutePath());
					item.write(uploadFile);
				}
			}
			
			String attached = null;
			if(!files.isEmpty()) {
				attached = files.get(0);
				for(int i = 1; i < files.size(); i ++) {
					attached += ","+files.get(i);
				}
			}
			
			//작성자 이름 분류 -->
			
			String author = new UserDAO().getName(userid) + "(" + userid + ")";
			
			//SQL 작업 시작 -->
			
			String sql = "insert into " + table + " values(?, ?, ?, ?, ?, ?)";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setString(2, hashmap.get("bbsTitle").getString());
			pstmt.setString(3, author);
			pstmt.setString(4, getDate());
			pstmt.setString(5, hashmap.get("bbsContext").getString());
			pstmt.setString(6, attached);
			
			
			pstmt.executeUpdate();
			return table;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
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
	
}
