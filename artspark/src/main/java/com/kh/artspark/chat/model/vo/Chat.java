package com.kh.artspark.chat.model.vo;

import lombok.NoArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
public class Chat {
	
	private int chatNo;
	private String chatContent;
	private String memId;
	private int chatroomNo;
	private String chatTime;
	
}
