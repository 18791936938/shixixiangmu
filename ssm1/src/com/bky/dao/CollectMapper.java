package com.bky.dao;

import java.util.List;

import com.bky.model.Collect;

public interface CollectMapper {
	
	public void addCollect(Collect collect);

	public List<Collect> queryCollectByUserId(String userId);

	public Integer deleteCollectByFileId(String fileId);
}
