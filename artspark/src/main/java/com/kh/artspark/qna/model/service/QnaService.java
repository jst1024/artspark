package com.kh.artspark.qna.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.qna.model.vo.Answer;
import com.kh.artspark.qna.model.vo.ProductAnswer;
import com.kh.artspark.qna.model.vo.ProductQna;
import com.kh.artspark.qna.model.vo.Qna;

public interface QnaService {

    int qnaCount();

    List<Qna> qnaFindAllWithAnswers(Map<String, Integer> map);

    int qnaSearchCount(Map<String, String> map);

    List<Qna> qnaFindConditionAndKeyword(Map<String, String> map, RowBounds rowBounds);

    int insertQna(Qna qna, ImgFile imgFile);
    String getArtistMemIdByProductNo(int productNo);

    // 판매자페이지에서 문의등록
	int insertProductQna(ProductQna productQna);
    
    //관리자 문의 페이지 상세보기
    Qna qnaFindById(int qnaNo);
    ImgFile findImgFileByQnaNo(int qnaNo);

    int deleteQna(int qnaNo);

    int updateQna(Qna qna, ImgFile imgFile);

    

    // 답변 등록
    int insertAnswer(Answer answer, ImgFile imgFile); // 관리자답변
    int insertProductAnswer(ProductAnswer productAnswer); // 판매자답변

    // 관리자 답변 상세보기
    ImgFile findImgFileByAnswerNo(int answerNo);
    Answer findAnswerById(int answerNo);
 
    // memberController에 추가
    // 마이페이지 문의 상세보기
    List<Qna> getMyQna(String memId); // 관리자에게
    List<ProductQna> getMyProductQna(String memId); // 판매자에게
    List<ProductQna> getReceivedProductQna(String memId); // 판매자로서 받은



}
