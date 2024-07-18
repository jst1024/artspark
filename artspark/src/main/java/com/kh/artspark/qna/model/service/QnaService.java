package com.kh.artspark.qna.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.qna.model.vo.Qna;

public interface QnaService {

	int qnaCount();

	List<Qna> qnaFindAll(Map<String, Integer> map);

	int qnaSearchCount(Map<String, String> map);

	List<Qna> qnaFindConditionAndKeyword(Map<String, String> map, RowBounds rowBounds);

	int insertQna(Qna qna, ImgFile imgFile);
	

	Qna qnaFindById(int qnaNo);

	ImgFile findImgFileByQnaNo(int qnaNo);

}
