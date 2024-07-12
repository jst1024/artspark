package com.kh.artspark.request.model.vo;

import java.util.Date;

public class Reply {
	private int replyNo; // 댓글번호
	private String replyContent; // 내용
	private Date replyDate; // 작성일
	private Request reqNo; // 의뢰번호
	private String memId; // 회원아이디
}
