package com.kh.artspark.qna.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.qna.model.dao.QnaMapper;
import com.kh.artspark.qna.model.vo.Answer;
import com.kh.artspark.qna.model.vo.ProductAnswer;
import com.kh.artspark.qna.model.vo.ProductQna;
import com.kh.artspark.qna.model.vo.Qna;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class QnaServiceImpl implements QnaService {
    
    private final QnaMapper qnaMapper;
    
    // QNA 개수 조회
    @Override 
    public int qnaCount() {
        return qnaMapper.qnaCount();
    }
    // QNA 리스트 조회
    @Override
    public List<Qna> qnaFindAllWithAnswers(Map<String, Integer> map) {
        return qnaMapper.qnaFindAllWithAnswers(map);
    }

    // QNA 검색 개수 조회
    @Override
    public int qnaSearchCount(Map<String, String> map) {
        return qnaMapper.qnaSearchCount(map);
    }
    // QNA 검색 결과 조회
    @Override
    public List<Qna> qnaFindConditionAndKeyword(Map<String, String> map, RowBounds rowBounds) {
        return qnaMapper.qnaFindConditionAndKeyword(map, rowBounds);
    }
    // QNA(관리자) 등록    
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
    public String getArtistMemIdByProductNo(int productNo) {
        return qnaMapper.getArtistMemIdByProductNo(productNo);
    }
    // QNA 상세 조회
    @Override
    public Qna qnaFindById(int qnaNo) {
        return qnaMapper.qnaFindById(qnaNo);
    }

    @Override
    public ImgFile findImgFileByQnaNo(int qnaNo) {
        return qnaMapper.findImgFileByQnaNo(qnaNo);
    }
    // QNA 삭제
    @Override
    public int deleteQna(int qnaNo) {
        return qnaMapper.deleteQna(qnaNo);
    }
    // QNA 수정
    @Transactional
    @Override
    public int updateQna(Qna qna, ImgFile imgFile) {
         int result1 = qnaMapper.updateQna(qna);
         int result2 = 1;
         
         if(imgFile.getOriginName() != null) {
              result2 = qnaMapper.updateImgFile(imgFile);
         }
         
         return result1 * result2;
    }
    
    // 판매자 문의 등록
    @Override
    @Transactional
    public int insertProductQna(ProductQna productQna, ImgFile imgFile) {
        // 1. PRODUCT_QNA 테이블에 데이터 삽입
        int result1 = qnaMapper.insertProductQna(productQna);

        int result2 = 1;
        if (imgFile != null && imgFile.getOriginName() != null && !imgFile.getOriginName().isEmpty()) {
            imgFile.setBoardType("상품문의");
            imgFile.setBoardNo(productQna.getQnaNo());  // 여기서 boardNo를 qnaNo로 설정
            result2 = qnaMapper.insertProductImgFile(imgFile);
        }

        return result1 * result2;
    }

    // 관리자 답변 등록
    @Override
    @Transactional
    public int insertAnswer(Answer answer, ImgFile imgFile) {
        
         int result1 = qnaMapper.insertAnswer(answer);
         int result2 = 1;
         
         if(imgFile.getOriginName() != null) {
              result2 = qnaMapper.insertImgFileForAnswer(imgFile);
         }
        
        return result1 * result2;
    }

    // 판매자 답변 등록
    @Override
    @Transactional
    public int insertProductAnswer(ProductAnswer productAnswer, ImgFile imgFile) {
        int result1 = qnaMapper.insertProductAnswer(productAnswer);
        int result2 = 1;
        if (imgFile != null && imgFile.getOriginName() != null && !imgFile.getOriginName().isEmpty()) {
            imgFile.setBoardType("답변");
            imgFile.setBoardNo(productAnswer.getAnswerNo());  
            result2 = qnaMapper.insertImgFileForProductAnswer(imgFile);
        }
        return result1 * result2;
    }
    
    // 답변 상세보기
    @Override
    public Answer findAnswerById(int answerNo) {
        return qnaMapper.findAnswerById(answerNo);
    }
    @Override
    public ImgFile findImgFileByAnswerNo(int answerNo) {
        return qnaMapper.findImgFileByAnswerNo(answerNo);
    }
    
    // 마이페이지 문의 조회
    @Override
    public List<Qna> qnaForArtist(String memId) {
        return qnaMapper.qnaForArtist(memId);
    }
    @Override
    public List<Qna> getMyQna(String memId) {
        return qnaMapper.getMyQna(memId);
    }
    @Override
    public List<ProductQna> getMyProductQna(String memId) {
        return qnaMapper.getMyProductQna(memId);
    }
    @Override
    public List<ProductQna> getReceivedProductQna(String memId) {
        return qnaMapper.getReceivedProductQna(memId);
    }

}
