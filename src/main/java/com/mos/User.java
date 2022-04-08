package com.mos;

public class User {
	private String userID;
	private String userPassword;
	private String userPasswordcheck;
	private String userName;
	private String userGender;
	private String userNumber;
	
	public String getUserID() {
		return userID;
	}
	
	public String getUserPassword() {
		return userPassword;
	}
	
	public String getUserName() {
		return userName;
	}
	
	public String getUserGender() {
		return userGender;
	}
	
	public String getUserNumber() {
		return userNumber;
	}
	
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	
	public void getUserNumber(String userNumber) {
		this.userNumber = userNumber;
	}
	public String getUserPasswordcheck() {
		return userPasswordcheck;
	}

	public void setUserPasswordcheck(String userPasswordcheck) {
		this.userPasswordcheck = userPasswordcheck;
	}

	public void setUserNumber(String userNumber) {
		this.userNumber = userNumber;
	}
}
