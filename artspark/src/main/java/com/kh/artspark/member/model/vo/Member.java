package com.kh.artspark.member.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
public class Member {
	
	private String memId;
	private String memPwd;
	private String memNickname;
	private String status;
	private String memEmail;
	private String memEnroll;
	private String memCategory;
	private String memId2;
}
