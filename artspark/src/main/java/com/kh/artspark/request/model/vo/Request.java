package com.kh.artspark.request.model.vo;

import java.sql.Date;

import com.kh.artspark.member.model.vo.Member;

public class Request {
	private int reqNo; // 의뢰번호
	private String reqPurpose; // 용도 (상업용, 비상업용)
	private String reqTitle; // 제목
	private String reqContent; // 내용
	private Date reqDate; // 작성일
	private int reqCount; // 조회수
	private Member memId; //회원아이디
}
