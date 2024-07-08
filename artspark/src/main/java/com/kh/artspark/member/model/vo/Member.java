package com.kh.artspark.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
@Builder
@AllArgsConstructor
public class Member {
	
	private String memId;
	private String memPwd;
	private String memNickname;
	private String status;
	private String memEmail;
	private String memEnroll;
	private String memCategory;
}
