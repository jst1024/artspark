package com.kh.artspark.product.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ProductFile {
	
	private int fileNo;
	private String originName;
	private String changeName;
	private String filePath;
	private String fileDate;
	private int productNo;
	
}
