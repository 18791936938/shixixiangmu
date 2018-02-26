package com.bky.model;

import java.util.Date;

public class Collect {
	
	private String fileId;
	
	private String userId;
	
	private Date coll_time;

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId; 
	}

	public Date getColl_time() {
		return coll_time;
	}

	public void setColl_time(Date coll_time) {
		this.coll_time = coll_time;
	}
}
