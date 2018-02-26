package com.bky.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bky.dao.UploadFileMapper;
import com.bky.dto.AjaxResultDto;
import com.bky.model.UploadFile;
import com.bky.model.UserViewCollect;
import com.bky.service.UploadFileService;

@Service("uploadFileService")
public class UploadFileServiceImpl implements UploadFileService {

	@Resource
	private UploadFileMapper fileDao;

	@Override
	public void addFile(UploadFile file) {
		fileDao.addFile(file);
	}

	@Override
	public List<UploadFile> queryUploadFile() {
		return fileDao.queryUploadFile();
	}

	@Override
	public UploadFile queryUploadFileById(String fileId) {
		return fileDao.queryUploadFileById(fileId);
	}

	@Override
	public List<UploadFile> queryMoreUploadFile(Map<String, Object> map) {
		return fileDao.queryMoreUploadFile(map);
	}

	@Override
	public AjaxResultDto deleteFileByFileId(String fileId) {
		AjaxResultDto dto = new AjaxResultDto();
		try {
			fileDao.deleteFileByFileId(fileId);
		} catch (Exception e) {
			dto.setIsError(false);
			dto.setMessage("É¾³ýÊ§°Ü£¡");
		}
		return dto;
	}

	@Override
	public List<UploadFile> queryUploadFileByFileName(String fileName) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("fileName", fileName);
		return fileDao.queryUploadFileByFileName(map);
	}

	@Override
	public List<UploadFile> queryUploadFileByFileNameAndTime(String fileName) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("fileName", fileName);
		return fileDao.queryUploadFileByFileNameAndTime(map);
	}

	@Override
	public List<UploadFile> queryUploadFileByFileNameAndHot(String fileName) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("fileName", fileName);
		return fileDao.queryUploadFileByFileNameAndHot(map);
	}

	@Override
	public int updateFileCollectTimes(UploadFile file) {
		return fileDao.updateFileCollectTimes(file);
	}

	@Override
	public int updateFileViewTimes(UploadFile file) {
		return fileDao.updateFileViewTimes(file);
	}

	@Override
	public int getTimesUserCount(UserViewCollect userViewCollect) {
		return fileDao.getTimesUserCount(userViewCollect);
	}

	@Override
	public UserViewCollect getTimesUser(UserViewCollect userViewCollect) {
		return fileDao.getTimesUser(userViewCollect);
	}

	@Override
	public void insertTimesUser(UserViewCollect userViewCollect) {
		fileDao.insertTimesUser(userViewCollect);
	}

	@Override
	public int updateUserView(UserViewCollect userViewCollect) {
		return fileDao.updateUserView(userViewCollect);
	}

	@Override
	public int updateUserCollect(UserViewCollect userViewCollect) {
		return fileDao.updateUserCollect(userViewCollect);
	}

}
