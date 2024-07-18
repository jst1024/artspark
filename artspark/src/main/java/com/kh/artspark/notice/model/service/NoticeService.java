package com.kh.artspark.notice.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.notice.model.vo.Notice;

public interface NoticeService {
	// 기능 구현
	//페이징 처리
	int noticeCount();
	// 목록조회
	List<Notice> noticeFindAll(Map<String,Integer> map);
	// 게시글 검색 기능(게시물 개수)
	int noticeSearchCount(Map<String, String> map);
	// 검색 목록 조회
	List<Notice> noticeFindByConditionAndKeyword(Map<String, String> map, RowBounds rowBounds);
	// 게시글 작성
	int insertNotice(Notice notice, ImgFile imgFile);
	/*
	// 조회수 증가
	int noticeIncreaseCount(int noticeNo);
	*/
	// 게시글 상세조회
	Notice noticeFindById(int noticeNo);
	ImgFile findImgFileByNoticeNo(int noticeNo);
	
	// 수정
	int updateNotice(Notice notice, ImgFile imgFile);
	
	//삭제
	int deleteNotice(int noticeNo);
	
	 
	
}