package com.app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.app.domain.UserDTO;

public class UserDAO {
   public Connection connection;
   public PreparedStatement preparedStatement;
   public ResultSet resultSet;

   // 아이디 중복 검사
   public boolean checkId(String userId) {
      String query = "SELECT user_number " + "FROM tbl_user " + "WHERE user_id = ?";

      try {
         // 우리가 만든 DBConnecter에서 커넥션 객체를 얻어온다(DB와 연결완료)
         connection = DBConnecter.getConnection();
         // 쿼리를 보내기 위한 preparedStatement 객체를 커넥션 객체에서 가져온다
         preparedStatement = connection.prepareStatement(query);

         // 문자열로 작성한 쿼리가 preparedStatement에 들어가서 sql명령어로 사용된다
         // 쿼리에 ?가 있다(미완성된 상태)
         // preparedStatement의 기능으로 쿼리를 완성시켜준다
         // ?를 매개변수로 받은 userId로 바꿔야한다
         // set자료형(물음표의 순서, 넣을 값);
         preparedStatement.setString(1, userId);

         // 완성된 쿼리를 실행시키는 방법
         // 1) executeQuery()
         // SELECT할 때 반환되는 결과값을 받기 위해 사용

         // 2) executeUpdate()
         // SELECT를 제외하고 반환되는 값이 없으면 사용
         // 쿼리가 반영된 행이 몇 개인지 리턴

         // executeQuery()의 반환타입은 ResultSet이다
         resultSet = preparedStatement.executeQuery();

         // resultSet은 쿼리의 결과(테이블)을 저장하고 있다
         // 각 데이터에 접근하는 방식은 Iterator와 동일하게 커서를 사용한다
         // next() : 현재 커서 다음에 데이터가 존재하는지를 true/false로 반환한다
         // get자료형(컬럼번호) : 커서를 다음행으로 옮기고 해당 컬럼의 값을 자료형에 맞게 가져온다

         if (resultSet.next()) {
            return false;
         }
      } catch (SQLException e) {
         System.out.println("checkId() sql 오류!!");
         e.printStackTrace();
      } finally {
         // jdbc에서 제공하는 객체들은 사용후 닫아줘야한다
         // 오류 여부와 상관없이 반드시 닫아야하므로 finally에 작성한다
         // 닫을 때는 여는 순서와 반대로 닫는다

         try {
            if (resultSet != null) {
               resultSet.close();
            }

            if (preparedStatement != null) {
               preparedStatement.close();
            }

            if (connection != null) {
               connection.close();
            }
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      }

      return true;

   }

   // 회원가입 메소드
   public void join(UserDTO userDTO) {
      String query = "INSERT INTO tbl_user(user_number, user_id, USER_PASSWORD, user_name, "
            + "user_age, USER_GENDER, USER_BIRTH) " + "VALUES(SEQ_USER.NEXTVAL, ?, ?, ?, ?, ?, ?)";

      try {
         connection = DBConnecter.getConnection();
         preparedStatement = connection.prepareStatement(query);
         preparedStatement.setString(1, userDTO.getUserId());
         preparedStatement.setString(2, userDTO.getUserPassword());
         preparedStatement.setString(3, userDTO.getUserName());
         preparedStatement.setInt(4, userDTO.getUserAge());
         preparedStatement.setString(5, userDTO.getUserGender());
         preparedStatement.setString(6, userDTO.getUserBirth());

         preparedStatement.executeUpdate();
      } catch (SQLException e) {
         System.out.println("join() SQL오류!!");
         e.printStackTrace();
      } finally {
         try {
            if (preparedStatement != null) {
               preparedStatement.close();
            }
            if (connection != null) {
               connection.close();
            }
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      }
   }

   // 로그인메소드
   public int login(String userId, String userPassword) {
      String query = "SELECT user_number " + "FROM tbl_user " + "WHERE user_id = ? AND USER_PASSWORD = ?";
      int userNumber = -1;

      try {
         connection = DBConnecter.getConnection();
         preparedStatement = connection.prepareStatement(query);
         preparedStatement.setString(1, userId);
         preparedStatement.setString(2, userPassword);
         resultSet = preparedStatement.executeQuery();
         if (resultSet.next()) {
            userNumber = resultSet.getInt(1);
         }

      } catch (SQLException e) {
         System.out.println("login() sql오류!!");
         e.printStackTrace();
      } finally {
         try {
            if (resultSet != null) {
               resultSet.close();
            }
            if (preparedStatement != null) {
               preparedStatement.close();
            }
            if (connection != null) {
               connection.close();
            }
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      }

      return userNumber;

   }
   public List<String> selectId(String userName, String userBirth) {
	   String query = "SELECT user_id "
	   		+ "FROM TBL_USER "
	   		+ "WHERE USER_NAME = ? AND USER_BIRTH = ?";
	   
	   String userId = null;
	   List<String> userIds = new ArrayList<>();
	   
	   
	   try {
		connection = DBConnecter.getConnection();
		   preparedStatement = connection.prepareStatement(query);
		   preparedStatement.setString(1, userName);
		   preparedStatement.setString(2, userBirth);
		   resultSet = preparedStatement.executeQuery();
		   
		   while(resultSet.next()) {
			   userId = resultSet.getString(1);
			   userIds.add(userId);
		   }
		   
	} catch (SQLException e) {
		System.out.println("selectId() sql오류");
		e.printStackTrace();
	} finally {
         try {
            if (resultSet != null) {
               resultSet.close();
            }
            if (preparedStatement != null) {
               preparedStatement.close();
            }
            if (connection != null) {
               connection.close();
            }
         } catch (SQLException e) {
            e.printStackTrace();
         }
      }
		return userIds;
   }
   
   // 회원 전체정보 수정
   public void update(UserDTO userDTO) {
      String query = "UPDATE tbl_user "
            + "SET user_id = ?, USER_PASSWORD = ?, user_name = ?, USER_AGE = ?, USER_GENDER = ?, "
            + "USER_BIRTH = ? " + "WHERE USER_number= ?";

      try {
         connection = DBConnecter.getConnection();
         preparedStatement = connection.prepareStatement(query);
         preparedStatement.setString(1, userDTO.getUserId());
         preparedStatement.setString(2, userDTO.getUserPassword());
         preparedStatement.setString(3, userDTO.getUserName());
         preparedStatement.setInt(4, userDTO.getUserAge());
         preparedStatement.setString(5, userDTO.getUserGender());
         preparedStatement.setString(6, userDTO.getUserBirth());
         preparedStatement.setInt(7, userDTO.getUserNumber());
         preparedStatement.executeUpdate();
         
      } catch (SQLException e) {
         System.out.println("update() sql 오류!!");
         e.printStackTrace();
      } finally {
         try {
            if (preparedStatement != null) {
               preparedStatement.close();
            }
            if (connection != null) {
               connection.close();
            }
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      }

   }
   
   //회원 1명 전체 정보조회
   // 단, 쿼리문을 사용할 때 *를 가능하면 사용하지 않는다. 속도가 저하된다.
   public UserDTO findUser(int userNumber) {
      String query = "SELECT user_id, user_password, user_name, user_age, user_gender, user_birth "
            + "FROM tbl_user "
            + "WHERE user_number = ?";
      UserDTO userDTO = null;
      
      try {
         connection = DBConnecter.getConnection();
         preparedStatement = connection.prepareStatement(query);
         preparedStatement.setInt(1, userNumber);
         resultSet = preparedStatement.executeQuery();
         
         if(resultSet.next()) {
            userDTO = new UserDTO();
            
            userDTO.setUserNumber(userNumber);
            userDTO.setUserId(resultSet.getString("user_id"));
            userDTO.setUserPassword(resultSet.getString("user_password"));
            userDTO.setUserName(resultSet.getString("user_name"));
            userDTO.setUserAge(resultSet.getInt("user_age"));
            userDTO.setUserGender(resultSet.getString("user_gender"));
            userDTO.setUserBirth(resultSet.getString("user_birth"));      
         }
         
      } catch (SQLException e) {
         System.out.println("findUser() SQL 오류!");
         e.printStackTrace();
      } finally {
         try {
            if(resultSet != null) {
               resultSet.close();
            }
            if(preparedStatement != null) {
               preparedStatement.close();
            }
            if(connection != null) {
               connection.close();
            }
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      }
      
      return userDTO;
   }
 //회원탈퇴
   public boolean delete(int userNumber) {
      String query = "DELETE FROM TBL_USER "
            + "WHERE user_number = ?";
      int result = 0;
      
      try {
         connection = DBConnecter.getConnection();
         preparedStatement = connection.prepareStatement(query);
         preparedStatement.setInt(1, userNumber);
         result = preparedStatement.executeUpdate();
      } catch (SQLException e) {
         System.out.println("delete() SQL오류!");
         e.printStackTrace();
      } finally {
         try {
            if(preparedStatement != null) {
               preparedStatement.close();
            }
            if(connection != null) {
               connection.close();
            }
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      }
      return result > 0;   
   }

   //생일로 회원 조회하기
   //user_number, user_id, user_password, user_name, user_age, user_gender, user_birth
   
   public List<UserDTO> findBirth(String userBirth){
      String query = "SELECT user_number, user_id, user_password, user_name, user_age, user_gender, user_birth "
            + "FROM tbl_user "
            + "WHERE user_birth = ?";
      List<UserDTO> users = new ArrayList<>();
      
      try {
         connection = DBConnecter.getConnection();
         preparedStatement = connection.prepareStatement(query);
         preparedStatement.setString(1, userBirth);
         resultSet = preparedStatement.executeQuery();
         
         while(resultSet.next()) {
            UserDTO user = new UserDTO();
            
            user.setUserNumber(resultSet.getInt(1));
            user.setUserId(resultSet.getString(2));
            user.setUserPassword(resultSet.getString(3));
            user.setUserName(resultSet.getString(4));
            user.setUserAge(resultSet.getInt(5));
            user.setUserGender(resultSet.getString(6));
            user.setUserBirth(resultSet.getString(7));
            
            users.add(user);
                     
         }
      } catch (SQLException e) {
         System.out.println("findBirth() SQL 오류!");
         e.printStackTrace();
      } finally {
         try {
            if(resultSet != null) {
               resultSet.close();
            }
            if(preparedStatement != null) {
               preparedStatement.close();
            }
            if(connection != null) {
               connection.close();
            }
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      }
      
      return users;
      
   }
 
		   
		   

}


   



