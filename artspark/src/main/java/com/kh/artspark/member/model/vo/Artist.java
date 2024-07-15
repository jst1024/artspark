package com.kh.artspark.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class Artist {
	
	private String memId;
	private String artistIntro;
	private String artistPhone;
	private String artistPath;
	private String artistOriginName;
	private String artistChangeName;
}
