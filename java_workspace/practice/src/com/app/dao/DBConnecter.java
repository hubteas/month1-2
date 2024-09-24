package com.app.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnecter {
	public static Connection getConnection() {
		Connection conn = null;
		
		//연결에 필요한 정보
		String UserName = "test";
		String UserPassword = "1234";
		String Url = "jdbc:oracle:thin:@localhost:1521:xe";
		
	      // 드라이버를 메모리에 할당
	      // alt shift z try catch
    	// 1. Driver 클래스 로드
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
      // 2. DB 연결을 위한 Connection 객체생성
			conn = DriverManager.getConnection(UserName, UserPassword, Url);
			
			System.out.println("연결성공");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버로딩실패");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("연결정보오류");
			e.printStackTrace();
		}
		return conn;	
	}
}
