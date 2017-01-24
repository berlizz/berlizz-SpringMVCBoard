package com.berlizz.dto;

public class LoginDTO {

	private String userid;
	private String userpw;
	private boolean useCookie;
	
	@Override
	public String toString() {
		return "LoginDTO : [userid=" + userid + "], [useCookie=" + useCookie + "]";
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserpw() {
		return userpw;
	}

	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}

	public boolean isUseCookie() {
		return useCookie;
	}

	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}
	
	
}
