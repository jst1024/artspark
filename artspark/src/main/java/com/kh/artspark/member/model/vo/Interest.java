package com.kh.artspark.member.model.vo;

import java.util.List;

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
	private String artistPath;   //작가 이미지 경로
	private String memNickname;  // 사용자 닉네임
	private List<String> filePaths;		//파일 경로
	private String productTitle;  // 상품 제목
	private double avgStar;   //평점
	private int productNo;
	
	

	
}
