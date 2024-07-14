package com.kh.artspark.request.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.request.model.vo.Request;

@Mapper
public interface RequestMapper {
	
	// 페이징처리
	int requestCount();
	
	// 목록조회
	List<Request> requestFindAll(Map<String, Integer> map);
	
	//검색
	int requestSearchCount(Map<String, String> map);
	
	// 검색목록조회
	List<Request> requestFindConditionAndKeyword(Map<String, String> map, RowBounds rowBounds);

	// 글 등록
	int insertRequest(Request request);
	int insertImgFile(ImgFile imgFile); // 파일등록

	
	
	
}