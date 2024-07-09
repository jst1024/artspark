package com.kh.artspark.qna.model.vo;

import java.sql.Date;

import com.kh.artspark.member.model.vo.Member;

public class Answer {
	private int answerNo; // 답변번호
	private String answerTitle; // 제목
	private String answerContent; // 내용
	private Date answerDate; // 작성일
	private Member memId; // 회원아이디
}
