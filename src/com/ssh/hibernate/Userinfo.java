package com.ssh.hibernate;

import java.util.HashSet;
import java.util.Set;

/**
 * Userinfo entity. @author MyEclipse Persistence Tools
 */

public class Userinfo implements java.io.Serializable {

	// Fields

	private String userId;
	private String userName;
	private String password;
	private String mobile;
	private String email;
	private Set meetinginfos = new HashSet(0);

	// Constructors

	/** default constructor */
	public Userinfo() {
	}

	/** minimal constructor */
	public Userinfo(String userId) {
		this.userId = userId;
	}

	/** full constructor */
	public Userinfo(String userId, String userName, String password,
			String mobile, String email, Set meetinginfos) {
		this.userId = userId;
		this.userName = userName;
		this.password = password;
		this.mobile = mobile;
		this.email = email;
		this.meetinginfos = meetinginfos;
	}

	// Property accessors

	public String getUserId() {
		return this.userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Set getMeetinginfos() {
		return this.meetinginfos;
	}

	public void setMeetinginfos(Set meetinginfos) {
		this.meetinginfos = meetinginfos;
	}

}