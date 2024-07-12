package com.kh.artspark.product.model.vo;

import java.sql.Date;

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
	private Date fileDate;
	private int productNo;
	
}
