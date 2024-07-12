package com.kh.artspark.request.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class Request {
	private int reqNo; // 의뢰번호
	private String reqPurpose; // 용도 (상업용, 비상업용)
	private String reqTitle; // 제목
	private String reqCategory; // 카테고리
	private String reqContent; // 내용
	private Date reqDate; // 작성일
	private int reqCount; // 조회수
	private String status; // 상태 (y, n)
	private Date reqDeldate; // (삭제일)
	private String memId; //회원아이디
}
