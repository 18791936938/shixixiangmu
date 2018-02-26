package com.bky.dao;

import java.util.List;
import java.util.Map;

import com.bky.model.UploadFile;
import com.bky.model.UserViewCollect;

public interface UploadFileMapper {
	
	public void addFile(UploadFile file);
	
	public List<UploadFile> queryUploadFile();
	
	public UploadFile queryUploadFileById(String fileId);
	
	public List<UploadFile> queryMoreUploadFile(Map<String,Object> map);
	
	public List<UploadFile> queryUploadFileByFileName(Map<String ,String> map);

	public void deleteFileByFileId(String fileId);
	
	public int  updateFileCollectTimes(UploadFile file);
	
	public int  updateFileViewTimes(UploadFile file);
	
	public List<UploadFile> queryUploadFileByFileNameAndTime(Map<String ,String> map);
	
	public List<UploadFile> queryUploadFileByFileNameAndHot(Map<String ,String> map);
	
	public int getTimesUserCount(UserViewCollect userViewCollect);
	
	public UserViewCollect getTimesUser(UserViewCollect userViewCollect);
	
	public void insertTimesUser(UserViewCollect userViewCollect);
	
	public int updateUserView(UserViewCollect userViewCollect);
	
	public int updateUserCollect(UserViewCollect userViewCollect);
}
