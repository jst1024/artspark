package com.kh.artspark.common.model.vo;

import java.sql.Date;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor // 기본생성자보단 모든 것이 다 있어야 하므로.
@ToString
public class ImgFile {
	private String imgFileNo;
	private String boardType;
	private int boardNo;
	private String originName;
	private String changeName;
	private String imgFilePath;
	private Date imgFileDate;
}
