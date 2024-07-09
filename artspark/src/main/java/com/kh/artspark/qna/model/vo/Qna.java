package com.kh.artspark.qna.model.vo;

import java.sql.Date;

import com.kh.artspark.member.model.vo.Member;

public class Qna {
	private int qnaNo; // 문의번호
	private String qnaTitle; // 제목
	private String qnaContent; // 내용
	private Date qnaDate; // 작성일
	private Member memId; // 회원아이디
	private String secret; // 비밀글여부 (Y, N)
	
}
