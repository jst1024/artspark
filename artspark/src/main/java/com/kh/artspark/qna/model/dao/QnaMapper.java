package com.kh.artspark.qna.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.qna.model.vo.Answer;
import com.kh.artspark.qna.model.vo.Qna;
@Mapper
public interface QnaMapper {

	int qnaCount();
	
	List<Qna> qnaFindAllWithAnswers(Map<String, Integer> map);
	//memberController에 추가 (판매자 마이페이지에 보이게끔)
	List<Qna> qnaForArtist(String memId);
	
	
	int qnaSearchCount(Map<String, String> map);

	List<Qna> qnaFindConditionAndKeyword(Map<String, String> map, RowBounds rowBounds);

	int insertQna(Qna qna);
	int insertImgFile(ImgFile imgFile); // 파일등록
	String getArtistMemIdByProductNo(int productNo);
	
	Qna qnaFindById(int qnaNo);

	ImgFile findImgFileByQnaNo(int qnaNo);

	int deleteQna(int qnaNo);

	int updateQna(Qna qna);

	int updateImgFile(ImgFile imgFile);

	int insertAnswer(Answer answer);



	



	

}
