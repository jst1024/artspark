package com.kh.artspark.member.model.vo;


import java.sql.Date;


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
	private Date memEnroll;
	private String memCategory;
	private Date memSuspension;
	private int memReportcount;
  
}
