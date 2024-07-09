package com.kh.artspark.notice.model.vo;

import java.sql.Date;

import com.kh.artspark.member.model.vo.Member;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class Notice {
	private int noticeNo; // 공지사항번호
	private String noticeTitle; // 제목
	private String noticeContent; // 내용
	private Date noticeDate; // 작성일
	private Member memId; // 회원아이디
}
