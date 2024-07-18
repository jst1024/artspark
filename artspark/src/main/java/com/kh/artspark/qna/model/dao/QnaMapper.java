package com.kh.artspark.qna.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.qna.model.vo.Qna;
@Mapper
public interface QnaMapper {

	int qnaCount();

	List<Qna> qnaFindAll(Map<String, Integer> map);

	int qnaSearchCount(Map<String, String> map);

	List<Qna> qnaFindConditionAndKeyword(Map<String, String> map, RowBounds rowBounds);

	int insertQna(Qna qna);
	int insertImgFile(ImgFile imgFile); // 파일등록

	Qna qnaFindById(int qnaNo);

	ImgFile findImgFileByQnaNo(int qnaNo);

}
