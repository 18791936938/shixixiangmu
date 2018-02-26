package com.bky.service.impl;

import java.util.List;

import javax.annotation.Resource;





import org.springframework.stereotype.Service;

import com.bky.dao.CommentMapper;
import com.bky.model.Comment;
import com.bky.service.CommentService;

@Service("commentService")
public class CommentServiceImpl implements CommentService {

	@Resource
	private CommentMapper commentDao;
	
	@Override
	public void addCommet(Comment comment) {
		commentDao.addComment(comment);
	}

	@Override
	public List<Comment> queryHistoryComment(String fileId) {
		return commentDao.queryHistoryComment(fileId);
	}

}
