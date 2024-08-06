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
public class Reply {
	private int replyNo; // 답글번호
	private String replyContent; // 내용
	private Date replyDate; // 작성일
	private int reqNo; // 의뢰번호
	private String memId; // 회원아이디
}
