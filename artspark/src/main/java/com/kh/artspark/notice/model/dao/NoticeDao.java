package com.kh.artspark.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.artspark.notice.model.vo.Notice;

@Repository
public class NoticeDao {
	
	public int noticeCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("noticeMapper.noticeCount");
	}

	public List<Notice> noticeFindAll(SqlSessionTemplate sqlSession, Map<String, Integer> map) {
		return sqlSession.selectList("noticeMapper.noticeFindAll", map);
	}

	public int noticeSearchCount(SqlSessionTemplate sqlSession, Map<String, String> map) {
		return sqlSession.selectOne("noticeMapper.noticeSearchCount", map);
		
	}
	public List<Notice> noticeFindByConditionAndKeyword(SqlSessionTemplate sqlSession, Map<String, String> map, RowBounds rowBounds) {
		return sqlSession.selectList("boardMapper.noticeFindByConditionAndKeyword", map, rowBounds);
		//RowBounds객체를 넘겨야 할 경우
		// sqlSession.selectList("boardMapper.findAll", null, rowBounds);
		// selectList()의 오버로딩된 형태중 매개변수가 3개인 메소드로 ★반드시 무조건 이걸로★ 호출해야함.
		// 두번째 인자값으로 전달할 값이 없다면 null값을 넘기면 된다.!!
}

	public int insertNotice(SqlSessionTemplate sqlSession, Notice notice) {
		return sqlSession.insert("noticeMapper.insertNotice", notice);
	}
	
	public int noticeIncreaseCount(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.update("noticeMapper.noticeIncreaseCount", noticeNo);
	}

	public Notice noticeFindById(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.selectOne("noticeMapper.noticeFindById", noticeNo); // 하나(selectOne)의 게시글 정보만 가져옴.
	}

	public int deleteNotice(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.update("noticeMapper.deleteNotice", noticeNo);
	}

	public int updateNotice(SqlSessionTemplate sqlSession, Notice notice) {
		return sqlSession.update("noticeMapper.updateNotice", notice);
	}
	
}
