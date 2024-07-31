package com.kh.artspark.qna.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.qna.controller.QnaController;
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
	
	public final QnaMapper qnaMapper;
	
	
	@Override 
	public int qnaCount() {
		return qnaMapper.qnaCount();
	}

    @Override
    public List<Qna> qnaFindAllWithAnswers(Map<String, Integer> map) {
        return qnaMapper.qnaFindAllWithAnswers(map);
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
	public String getArtistMemIdByProductNo(int productNo) {
		return qnaMapper.getArtistMemIdByProductNo(productNo);
	}
	
	@Override
	public Qna qnaFindById(int qnaNo) {
		return qnaMapper.qnaFindById(qnaNo);
	}

	@Override
	public ImgFile findImgFileByQnaNo(int qnaNo) {
		return qnaMapper.findImgFileByQnaNo(qnaNo);
	}

	@Override
	public int deleteQna(int qnaNo) {
		return qnaMapper.deleteQna(qnaNo);
	}
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
	
    @Override
    @Transactional
    public int insertProductQna(ProductQna productQna, ImgFile imgFile) {
        // 1. PRODUCT_QNA 테이블에 데이터 삽입
        int result1 = qnaMapper.insertProductQna(productQna);

        int result2 = 1;
        if (imgFile != null && imgFile.getOriginName() != null && !imgFile.getOriginName().isEmpty()) {
            imgFile.setBoardType("상품문의");
            imgFile.setBoardNo(productQna.getQnaNo());  // 여기서 boardNo를 qnaNo로 설정
            result2 = qnaMapper.insertImgFile(imgFile);
        }

        return result1 * result2;
    }

	
	// 관리자 답변
	@Override
	@Transactional
	public int insertAnswer(Answer answer, ImgFile imgFile) {
		
		 int result1 = qnaMapper.insertAnswer(answer);
		 int result2 = 1;
		 
		 if(imgFile.getOriginName() != null) {
			  result2 = qnaMapper.insertImgFile(imgFile);
		 }
		
		return result1 * result2;
	}
	// 판매자 답변
    @Override
    @Transactional
    public int insertProductAnswer(ProductAnswer productAnswer, ImgFile imgFile) {
        int result1 = qnaMapper.insertProductAnswer(productAnswer);
        int result2 = 1;
        if (imgFile != null && imgFile.getOriginName() != null && !imgFile.getOriginName().isEmpty()) {
            imgFile.setBoardType("답변");
            imgFile.setBoardNo(productAnswer.getAnswerNo());  // 여기서 boardNo를 answerNo로 설정
            result2 = qnaMapper.insertImgFile(imgFile);
        }
        return result1 * result2;
    }
	@Override
	public ImgFile findImgFileByAnswerNo(int answerNo) {
		return qnaMapper.findImgFileByAnswerNo(answerNo);
	}
	
	// 마이페이지
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

	@Override
	public Answer findAnswerById(int answerNo) {
		return qnaMapper.findAnswerById(answerNo);
	}











}