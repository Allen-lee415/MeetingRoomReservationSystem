package com.ssh.hibernate;

import java.util.HashSet;
import java.util.Set;

/**
 * Meetingroominfo entity. @author MyEclipse Persistence Tools
 */

public class Meetingroominfo implements java.io.Serializable {

	// Fields

	private String meetingroomId;
	private String meetingroomName;
	private Integer seatNum;
	private String location;
	private Boolean projector;
	private Set meetinginfos = new HashSet(0);

	// Constructors

	/** default constructor */
	public Meetingroominfo() {
	}

	/** minimal constructor */
	public Meetingroominfo(String meetingroomId) {
		this.meetingroomId = meetingroomId;
	}

	/** full constructor */
	public Meetingroominfo(String meetingroomId, String meetingroomName,
			Integer seatNum, String location, Boolean projector,
			Set meetinginfos) {
		this.meetingroomId = meetingroomId;
		this.meetingroomName = meetingroomName;
		this.seatNum = seatNum;
		this.location = location;
		this.projector = projector;
		this.meetinginfos = meetinginfos;
	}

	// Property accessors

	public String getMeetingroomId() {
		return this.meetingroomId;
	}

	public void setMeetingroomId(String meetingroomId) {
		this.meetingroomId = meetingroomId;
	}

	public String getMeetingroomName() {
		return this.meetingroomName;
	}

	public void setMeetingroomName(String meetingroomName) {
		this.meetingroomName = meetingroomName;
	}

	public Integer getSeatNum() {
		return this.seatNum;
	}

	public void setSeatNum(Integer seatNum) {
		this.seatNum = seatNum;
	}

	public String getLocation() {
		return this.location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Boolean getProjector() {
		return this.projector;
	}

	public void setProjector(Boolean projector) {
		this.projector = projector;
	}

	public Set getMeetinginfos() {
		return this.meetinginfos;
	}

	public void setMeetinginfos(Set meetinginfos) {
		this.meetinginfos = meetinginfos;
	}

}