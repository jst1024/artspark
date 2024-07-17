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
public class Qna {
	private int qnaNo; // 문의번호
	private String qnaTitle; // 제목
	private String qnaContent; // 내용
	private Date qnaDate; // 작성일
	private String memId; // 회원아이디
	private String secret; // 비밀글여부 (Y, N)
	private String status; // 삭제여부 (Y(default), N(삭제))
	
}
