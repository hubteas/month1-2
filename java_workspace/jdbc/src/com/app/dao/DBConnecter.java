package com.app.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnecter {
   public static Connection getConnection() {
      Connection conn = null;

      // 연결에 필요한 정보
      String userName = "test";
      String userPassword = "1234";
      String url = "jdbc:oracle:thin:@localhost:1521:xe";

      // 드라이버를 메모리에 할당
      // alt shift z try catch
      try {
    	// 1. Driver 클래스 로드
         Class.forName("oracle.jdbc.driver.OracleDriver");
        // 2. DB 연결을 위한 Connection 객체생성
         conn = DriverManager.getConnection(url, userName, userPassword);

         System.out.println("연결 성공");
      } catch (ClassNotFoundException e) {
         System.out.println("드라이버 로딩 실패!");
         e.printStackTrace();
      } catch (SQLException e) { 
         System.out.println("연결 정보 오류");
         e.printStackTrace();
      }
      return conn;

   }
}
