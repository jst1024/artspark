package com.kh.artspark.request.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.request.model.vo.Reply;
import com.kh.artspark.request.model.vo.Request;

public interface RequestService {
	//페이징 처리
	int requestCount();
	
	// 목록조회
	List<Request> requestFindAll(Map<String, Integer> map);
	
	// 검색
	int requestSearchCount(Map<String, String> map);
	
	// 검색목록조회
	List<Request> requestFindConditionAndKeyword(Map<String, String> map, RowBounds rowBounds);
	
	//글 등록
	int insertRequest(Request request, ImgFile imgFile);
	
	//상세보기
	Request requestFindById(int reqNo);
	ImgFile findImgFileByReqNo(int reqNo);
	//조회수 증가
	int increaseCount(int reqNo);
	
	//글 수정
	int updateRequest(Request request, ImgFile imgFile);
	
	//글 삭제
	int deleteRequest(int reqNo);
	
	// 댓글 목록 조회
	List<Reply>selectReply(int reqNo);
	
	// 댓글 등록
	int insertReply(Reply reply);
	
	//request와 묶인 Reply랑 같이 조회
	Request requestAndReply(int reqNo);
	
	

	
}
