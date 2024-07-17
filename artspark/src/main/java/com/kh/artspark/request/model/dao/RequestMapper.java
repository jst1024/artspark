package com.kh.artspark.request.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.request.model.vo.Reply;
import com.kh.artspark.request.model.vo.Request;

@Mapper
public interface RequestMapper {
	
	// 페이징처리
	int requestCount();
	
	// 목록조회
	List<Request> requestFindAll(Map<String, Integer> map);
	
	// 검색
	int requestSearchCount(Map<String, String> map);
	
	// 검색목록조회
	List<Request> requestFindConditionAndKeyword(Map<String, String> map, RowBounds rowBounds);

	// 글 등록
	int insertRequest(Request request);
	int insertImgFile(ImgFile imgFile); // 파일등록
	
	// 상세보기
	Request requestFindById(int reqNo);
	ImgFile findImgFileByReqNo(int reqNo);
	
	// 조회수 증가
	int increaseCount(int reqNo);
	// 수정
	int updateRequest(Request request);
	int updateImgFile(ImgFile imgFile);
	
	// 삭제
	int deleteRequest(int reqNo);
	

	// 댓글 목록
	List<Reply> selectReply(int reqNo);
	
	// 의뢰상세보기와 댓글목록이 같이 나오게
	Request requestAndReply(int reqNo);
	
	// 댓글 등록
	int insertReply(Reply reply);
	
	
	// 댓글 삭제
	int deleteReply(int replyNo);
	


	
	
	
	
	
}
