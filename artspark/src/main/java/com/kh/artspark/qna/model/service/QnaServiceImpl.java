package com.kh.artspark.qna.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.qna.model.dao.QnaMapper;
import com.kh.artspark.qna.model.vo.Qna;
import com.kh.artspark.request.model.vo.Request;

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

	@Transactional
	@Override
	public int insertQna(Qna qna, ImgFile imgFile) {
		
		 int result1 = qnaMapper.insertQna(qna);
		 int result2 = 1;
		 
		 if(imgFile.getOriginName() != null) {
			  result2 = qnaMapper.insertImgFile(imgFile);
		 }
		
		
		return result1 * result2;
	}


	@Override
	public Qna qnaFindById(int qnaNo) {
		return qnaMapper.qnaFindById(qnaNo);
	}

	@Override
	public ImgFile findImgFileByQnaNo(int qnaNo) {
		return qnaMapper.findImgFileByQnaNo(qnaNo);
	}

	
}
