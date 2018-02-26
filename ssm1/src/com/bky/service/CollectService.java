package com.bky.service;

import java.util.List;

import com.bky.dto.AjaxResultDto;
import com.bky.model.Collect;

public interface CollectService {
	
	/**
	 * ����ղ�
	 * @param collect
	 * @return
	 */
	public void addCollect(Collect collect);

	/**
	 * ����userId��ѯ��ǰ�û��ղص��ļ�
	 * @param userId
	 * @return
	 */
	public List<Collect> queryCollectByUserId(String userId);

	/**
	 * �����ļ�IDɾ���ղ�
	 * @param fileId
	 * @return
	 */
	public AjaxResultDto deleteCollectByFileId(String fileId);
}
