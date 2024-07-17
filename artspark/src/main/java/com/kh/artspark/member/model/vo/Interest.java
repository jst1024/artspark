package com.kh.artspark.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Interest {
	private String artistPath;
	private String memNickname;
	private String filePath;
	private String productTitle;
	private String reviewStar;
	
}
