package com.bky.model;

import java.util.Date;

public class UploadFile {
	
	private String fileId;
	
	private String userId;
	
	private String fileName;
	
	private String downloadLink;
	
	private Date uploadTime;
	
	private int downloadTimes;
	
	private int viewTimes;
	
	private int collectTimes;
	
	private String tag;
	
	private int typeId;
	
	private String fileRealName;

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

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getDownloadLink() {
		return downloadLink;
	}

	public void setDownloadLink(String downloadLink) {
		this.downloadLink = downloadLink;
	}

	public Date getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}

	public int getDownloadTimes() {
		return downloadTimes;
	}

	public void setDownloadTimes(int downloadTimes) {
		this.downloadTimes = downloadTimes;
	}

	public int getViewTimes() {
		return viewTimes;
	}

	public void setViewTimes(int viewTimes) {
		this.viewTimes = viewTimes;
	}

	public int getCollectTimes() {
		return collectTimes;
	}

	public void setCollectTimes(int collectTimes) {
		this.collectTimes = collectTimes;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public int getTypeId() {
		return typeId;
	}

	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}

	public String getFileRealName() {
		return fileRealName;
	}

	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
}
