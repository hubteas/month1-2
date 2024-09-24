package com.app.domain;

public class UserDTO {
//	USER_NUMBER NUMBER,
//	USER_ID VARCHAR2(100),
//	USER_PASSWORD VARCHAR2(100),
//	USER_NAME VARCHAR2(100),
//	USER_AGE NUMBER,
//	USER_GENDER CHAR(1) DEFAULT 'M',
//	USER_BIRTH DATE
	
	//필드
	private int userNumber;
	private String userId;
	private String userPassword;
	private String userName;
	private int userAge;
	private String userGender; //char 사용하지 않고 String 으로 사용한다.
	private String userBirth; // String 으로 사용한다.
	
	// DTO는 데이터를 전송하기 위한 목적으로 사용한다.
	// 다른 기능을 넣지 않는다.
	
	//기본생성자
	public UserDTO() {
		super();
	}
	
	// 게터 세터 alt shift s r

	public int getUserNumber() {
		return userNumber;
	}

	public void setUserNumber(int userNumber) {
		this.userNumber = userNumber;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getUserAge() {
		return userAge;
	}

	public void setUserAge(int userAge) {
		this.userAge = userAge;
	}

	public String getUserGender() {
		return userGender;
	}

	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}

	public String getUserBirth() {
		return userBirth;
	}

	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}
	   // toString 오버라이딩 alt shift s s
	   @Override
	   public String toString() {
	      return "UserVO [userNumber = " + userNumber + ", userId = " + userId + ", userPassword = " + userPassword
	            + ", userName = " + userName + ", userAge = " + userAge + ", userGender = " + userGender
	            + ", userBirth = " + userBirth + "]";
	   }
	   
	   

	
}