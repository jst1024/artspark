package com.kh.artspark.banner.model.vo;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
public class Banner {

	private int banNo;
	private String banName;
	private String banComent;
	private String banUrl;
	private String banImage;
}
