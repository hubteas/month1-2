package com.app.test;

import java.sql.Connection;
import java.sql.SQLException;
import com.app.dao.DBConnecter;

public class Test {

	public static void main(String[] args) {
		//연결테스트
		try {
			Connection conn = DBConnecter.getConnection();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
