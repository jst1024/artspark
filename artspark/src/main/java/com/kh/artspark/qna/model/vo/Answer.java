package com.kh.artspark.qna.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class Answer {
	private int answerNo; // 답변번호
    private int qnaNo; // 문의번호
	private String answerTitle; // 제목
	private String answerContent; // 내용
	private Date answerDate; // 작성일
	private String memId; // 회원아이디
	private String status; // 삭제여부
}
