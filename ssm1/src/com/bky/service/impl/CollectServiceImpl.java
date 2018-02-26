package com.bky.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bky.dao.CollectMapper;
import com.bky.dto.AjaxResultDto;
import com.bky.model.Collect;
import com.bky.service.CollectService;

@Service("collectService")
public class CollectServiceImpl implements CollectService {

	@Resource
	private CollectMapper collectDao;
	/**
	 * 收藏文件
	 */
	@Override
	public void addCollect(Collect collect) {
		collectDao.addCollect(collect);
	}

	/**
	 * 根据userid查找用户收藏的文件
	 */
	@Override
	public List<Collect> queryCollectByUserId(String userId) {
		return collectDao.queryCollectByUserId(userId);
	}

	/**
	 * 删除文件
	 */
	@Override
	public AjaxResultDto deleteCollectByFileId(String fileId) {
		AjaxResultDto dto = new AjaxResultDto();
		try {
			Integer result = collectDao.deleteCollectByFileId(fileId);
		} catch (Exception e) {
			dto.setIsError(true);
			dto.setMessage("删除失败！");
		}
		return dto;
	}

}
