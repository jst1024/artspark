package com.kh.artspark.notice.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.notice.model.dao.NoticeMapper;
import com.kh.artspark.notice.model.vo.Notice;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {

	private final NoticeMapper noticeMapper;

	@Override
	public int noticeCount() {
		return noticeMapper.noticeCount();
	}

	@Override
	public List<Notice> noticeFindAll(Map<String, Integer> map) {
		return noticeMapper.noticeFindAll(map);
	}

	@Override
	public int noticeSearchCount(Map<String, String> map) {
		return noticeMapper.noticeSearchCount(map);
	}

	@Override
	public List<Notice> noticeFindByConditionAndKeyword(Map<String, String> map, RowBounds rowBounds) {
		return noticeMapper.noticeFindByConditionAndKeyword(map, rowBounds);
	}
	
	@Transactional
	@Override
	public int insertNotice(Notice notice, ImgFile imgFile) {
		 int result1 = noticeMapper.insertNotice(notice);
		 int result2 = 1;
		 
		 if(imgFile.getOriginName() != null) {
			  result2 = noticeMapper.insertImgFile(imgFile);
		 }
		 
		 return result1 * result2;
	}
	/*
	@Override
	public int noticeIncreaseCount(int noticeNo) {
		return noticeMapper.noticeIncreaseCount(noticeNo);
	}
    */
	@Override
	public Notice noticeFindById(int noticeNo) {
		return noticeMapper.noticeFindById(noticeNo);
	}
	@Override
	public ImgFile findImgFileByNoticeNo(int noticeNo) {
		return noticeMapper.findImgFileByNoticeNo(noticeNo);
	}	
	
	@Transactional
	@Override
	public int updateNotice(Notice notice, ImgFile imgFile) {
		 int result1 = noticeMapper.updateNotice(notice);
		 int result2 = 1;
		 
		 if(imgFile.getOriginName() != null) {
			  result2 = noticeMapper.updateImgFile(imgFile);
		 }
		 
		 return result1 * result2;
	}
	@Override
	public int deleteNotice(int noticeNo) {
		return noticeMapper.deleteNotice(noticeNo);
	}
	
	
	
	

	
	
}
