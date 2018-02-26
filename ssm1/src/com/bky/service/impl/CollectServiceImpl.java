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
	 * �ղ��ļ�
	 */
	@Override
	public void addCollect(Collect collect) {
		collectDao.addCollect(collect);
	}

	/**
	 * ����userid�����û��ղص��ļ�
	 */
	@Override
	public List<Collect> queryCollectByUserId(String userId) {
		return collectDao.queryCollectByUserId(userId);
	}

	/**
	 * ɾ���ļ�
	 */
	@Override
	public AjaxResultDto deleteCollectByFileId(String fileId) {
		AjaxResultDto dto = new AjaxResultDto();
		try {
			Integer result = collectDao.deleteCollectByFileId(fileId);
		} catch (Exception e) {
			dto.setIsError(true);
			dto.setMessage("ɾ��ʧ�ܣ�");
		}
		return dto;
	}

}
