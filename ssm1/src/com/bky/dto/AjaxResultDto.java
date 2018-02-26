package com.bky.dto;

public class AjaxResultDto {
	private boolean IsError = false;
	private String Message = "";
	private Object Data = null;
	private String status = "";
	
	public boolean isIsError() {
		return IsError;
	}
	public void setIsError(boolean isError) {
		IsError = isError;
	}
	public String getMessage() {
		return Message;
	}
	public void setMessage(String message) {
		Message = message;
	}
	public Object getData() {
		return Data;
	}
	public void setData(Object data) {
		Data = data;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
