package com.bky.service;

import java.util.List;
import java.util.Map;

import com.bky.dto.AjaxResultDto;
import com.bky.model.UploadFile;
import com.bky.model.UserViewCollect;

public interface UploadFileService {
	public void addFile(UploadFile file);

	public List<UploadFile> queryUploadFile();

	public UploadFile queryUploadFileById(String fileId);

	public List<UploadFile> queryMoreUploadFile(Map<String, Object> map);

	public AjaxResultDto deleteFileByFileId(String fileId);

	public int updateFileCollectTimes(UploadFile file);

	public int updateFileViewTimes(UploadFile file);

	public List<UploadFile> queryUploadFileByFileName(String fileName);

	public List<UploadFile> queryUploadFileByFileNameAndTime(String fileName);

	List<UploadFile> queryUploadFileByFileNameAndHot(String fileName);

	public int getTimesUserCount(UserViewCollect userViewCollect);

	public UserViewCollect getTimesUser(UserViewCollect userViewCollect);

	public void insertTimesUser(UserViewCollect userViewCollect);

	public int updateUserView(UserViewCollect userViewCollect);

	public int updateUserCollect(UserViewCollect userViewCollect);
}
