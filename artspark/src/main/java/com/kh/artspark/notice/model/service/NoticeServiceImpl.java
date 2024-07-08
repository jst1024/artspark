package com.kh.artspark.notice.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.artspark.notice.model.dao.NoticeDao;
import com.kh.artspark.notice.model.vo.Notice;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {

	private final SqlSessionTemplate sqlSession;
	private final NoticeDao noticeDao;
	
	@Override
	public int noticeCount() {
		return noticeDao.noticeCount(sqlSession);
	}

	@Override
	public List<Notice> noticeFindAll(Map<String, Integer> map) {
		return noticeDao.noticeFindAll(sqlSession, map);
	}

	@Override
	public int noticeSearchCount(Map<String, String> map) {
		return noticeDao.noticeSearchCount(sqlSession, map);
	}

	@Override
	public List<Notice> noticeFindByConditionAndKeyword(Map<String, String> map, RowBounds rowBounds) {
		return noticeDao.noticeFindByConditionAndKeyword(sqlSession, map, rowBounds);
	}
	
	@Override
	public int insertNotice(Notice notice) {
		return noticeDao.insertNotice(sqlSession, notice);
	}

	@Override
	public int noticeIncreaseCount(int noticeNo) {
		return noticeDao.noticeIncreaseCount(sqlSession, noticeNo);
	}

	@Override
	public Notice noticeFindById(int noticeNo) {
		return noticeDao.noticeFindById(sqlSession, noticeNo);
	}

	@Override
	public int deleteNotice(int noticeNo) {
		return noticeDao.deleteNotice(sqlSession, noticeNo);
	}

	@Override
	public int updateNotice(Notice notice) {
		return noticeDao.updateNotice(sqlSession, notice);
	}
	
	
}
