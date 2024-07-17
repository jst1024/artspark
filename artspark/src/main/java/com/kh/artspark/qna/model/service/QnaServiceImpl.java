package com.kh.artspark.qna.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.artspark.qna.model.dao.QnaMapper;
import com.kh.artspark.qna.model.vo.Qna;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QnaServiceImpl implements QnaService {
	
	public final QnaMapper qnaMapper;
	
	
	@Override
	public int qnaCount() {
		return qnaMapper.qnaCount();
	}

	@Override
	public List<Qna> qnaFindAll(Map<String, Integer> map) {
		return qnaMapper.qnaFindAll(map);
	}

	@Override
	public int qnaSearchCount(Map<String, String> map) {
		return qnaMapper.qnaSearchCount(map);
	}

	@Override
	public List<Qna> qnaFindConditionAndKeyword(Map<String, String> map, RowBounds rowBounds) {
		return qnaMapper.qnaFindConditionAndKeyword(map, rowBounds);
	}
	
}
