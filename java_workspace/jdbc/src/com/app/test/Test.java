package com.app.test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.app.dao.DBConnecter;
import com.app.dao.UserDAO;
import com.app.domain.UserDTO;

public class Test {
   public static void main(String[] args) {

      // 연결테스트
      try {
         Connection conn = DBConnecter.getConnection();
         conn.close();
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }

      UserDTO userDTO = new UserDTO();
      UserDAO userDAO = new UserDAO();

//      userDTO.setUserId("abc");
//      userDTO.setUserPassword("1234");
//      userDTO.setUserName("짱구");
//      userDTO.setUserAge(5);
//      userDTO.setUserGender("M");
//      userDTO.setUserBirth("20001231");
//      
//      System.out.println(userDAO.checkId(userDTO.getUserId()));
//      
//      userDAO.join(userDTO);

      // 로그인 메소드
      System.out.println(userDAO.login("abc", "1234"));

      // 이름과 생일로 아이디 찾기 메소드
      List<String> userIds = userDAO.selectId("짱구", "20200101");

      System.out.println(userIds);

//      for(String id : userIds) {
//         System.out.println(id);
//      }

//      userIds.forEach(System.out::println); //스트림API이용

      // 회원정보 전체수정
//      userDTO.setUserId("updateTest");
//      userDTO.setUserPassword("aaa123");
//      userDTO.setUserName("TEST");
//      userDTO.setUserAge(10);
//      userDTO.setUserGender("F");
//      userDTO.setUserBirth("20240723");
//      userDTO.setUserNumber(1);
//
//      userDAO.update(userDTO);

      // 회원번호로 회원 1명의 정보 조회
      UserDTO user = userDAO.findUser(21);
      System.out.println(user);

      // 회원탈퇴
      if (userDAO.delete(22)) {
         System.out.println("탈퇴완료");
      } else {
         System.out.println("탈퇴실패");
      }
      
      // 생일로 회원조회하기
      userDAO.findBirth("20200101").forEach(System.out::println);

   }
}
