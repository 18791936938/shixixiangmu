package com.bky.service;

import java.util.List;

import com.bky.dto.AjaxResultDto;
import com.bky.model.Collect;

public interface CollectService {
	
	/**
	 * 添加收藏
	 * @param collect
	 * @return
	 */
	public void addCollect(Collect collect);

	/**
	 * 根据userId查询当前用户收藏的文件
	 * @param userId
	 * @return
	 */
	public List<Collect> queryCollectByUserId(String userId);

	/**
	 * 根据文件ID删除收藏
	 * @param fileId
	 * @return
	 */
	public AjaxResultDto deleteCollectByFileId(String fileId);
}
