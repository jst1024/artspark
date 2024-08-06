package com.kh.artspark.qna.model.vo;

import java.sql.Date;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Qna {
	private int qnaNo; // 문의번호
	private String qnaTitle; // 제목
	private String qnaContent; // 내용
	private Date qnaDate; // 작성일
	private String memId; // 회원아이디
	private String secret; // 비밀글여부 (Y, N)
	private String status; // 삭제여부 (Y(default), N(삭제))
	private Date qnaDelDate; // 삭제일
	private String qnaCategory; // 관리자, 판매자
	private int answerNo; // 답변번호
	private String answerTitle; // 답변제목
	private String answerContent; // 답변내용
	private Date answerDate; // 답변작성일
	private String answerMemId; // 조회용 아이디
    
}
