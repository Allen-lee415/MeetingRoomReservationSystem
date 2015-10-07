package com.ssh.hibernate;

/**
 * Meetinginfo entity. @author MyEclipse Persistence Tools
 */

public class Meetinginfo implements java.io.Serializable {

	// Fields

	private String meetingId;
	private Userinfo userinfo;
	private Meetingroominfo meetingroominfo;
	private String date;
	private String startTime;
	private String endTime;
	private String topic;

	// Constructors

	/** default constructor */
	public Meetinginfo() {
	}

	/** minimal constructor */
	public Meetinginfo(String meetingId) {
		this.meetingId = meetingId;
	}

	/** full constructor */
	public Meetinginfo(String meetingId, Userinfo userinfo,
			Meetingroominfo meetingroominfo, String date, String startTime,
			String endTime, String topic) {
		this.meetingId = meetingId;
		this.userinfo = userinfo;
		this.meetingroominfo = meetingroominfo;
		this.date = date;
		this.startTime = startTime;
		this.endTime = endTime;
		this.topic = topic;
	}

	// Property accessors

	public String getMeetingId() {
		return this.meetingId;
	}

	public void setMeetingId(String meetingId) {
		this.meetingId = meetingId;
	}

	public Userinfo getUserinfo() {
		return this.userinfo;
	}

	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}

	public Meetingroominfo getMeetingroominfo() {
		return this.meetingroominfo;
	}

	public void setMeetingroominfo(Meetingroominfo meetingroominfo) {
		this.meetingroominfo = meetingroominfo;
	}

	public String getDate() {
		return this.date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getStartTime() {
		return this.startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getTopic() {
		return this.topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

}