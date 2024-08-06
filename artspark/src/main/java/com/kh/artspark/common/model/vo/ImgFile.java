package com.kh.artspark.common.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ImgFile {
	private int imgFileNo;
	private String boardType;
	private int boardNo;
	private String originName;
	private String changeName;
	private String imgFilePath;
	private Date imgFileDate;
}
