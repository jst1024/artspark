package com.kh.artspark.request.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.notice.model.vo.Notice;
import com.kh.artspark.request.model.dao.RequestMapper;
import com.kh.artspark.request.model.vo.Reply;
import com.kh.artspark.request.model.vo.Request;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RequestServiceImpl implements RequestService {
	
	private final RequestMapper requestMapper;
	
	@Override
	public int requestCount() {
		return requestMapper.requestCount();
	}

	@Override
	public List<Request> requestFindAll(Map<String, Integer> map) {
		return requestMapper.requestFindAll(map);
	}

	@Override
	public int requestSearchCount(Map<String, String> map) {
		return requestMapper.requestSearchCount(map);
	}

	@Override
	public List<Request> requestFindConditionAndKeyword(Map<String, String> map, RowBounds rowBounds) {
		return requestMapper.requestFindConditionAndKeyword(map, rowBounds);
	}
	@Transactional
	@Override
	public int insertRequest(Request request, ImgFile imgFile) {
		
		 int result1 = requestMapper.insertRequest(request);
		 int result2 = 1;
		 
		 if(imgFile.getOriginName() != null) {
			  result2 = requestMapper.insertImgFile(imgFile);
		 }
		
		
		return result1 * result2;
	}

	@Override
	public Request requestFindById(int reqNo) {
		return requestMapper.requestFindById(reqNo);
	}

	@Override
	public ImgFile findImgFileByReqNo(int reqNo) {
		return requestMapper.findImgFileByReqNo(reqNo);
	}

	@Override
	public int increaseCount(int reqNo) {
		return requestMapper.increaseCount(reqNo);
	}

	@Override
	public int deleteRequest(int reqNo) {
		return requestMapper.deleteRequest(reqNo);
	}

	@Transactional
	@Override
	public int updateRequest(Request request, ImgFile imgFile) {
		 int result1 = requestMapper.updateRequest(request);
		 int result2 = 1;
		 
		 if(imgFile.getOriginName() != null) {
			  result2 = requestMapper.updateImgFile(imgFile);
		 }
		 
		 return result1 * result2;
	}

	@Override
	public List<Reply> selectReply(int reqNo) {
		return requestMapper.selectReply(reqNo);
	}

	@Override
	public int insertReply(Reply reply) {
		return requestMapper.insertReply(reply);
	}

	@Override
	public Request requestAndReply(int reqNo) {
		return requestMapper.requestAndReply(reqNo);
	}
	
	@Override
	public int deleteReply(int replyNo) {
		return requestMapper.deleteReply(replyNo);
	}
	
}
