package com.kh.artspark.request.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.request.model.dao.RequestMapper;
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
	
}
