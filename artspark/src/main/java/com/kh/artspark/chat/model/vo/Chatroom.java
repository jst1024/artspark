package com.kh.artspark.chat.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
public class Chatroom {

	private int chatroomNo;
	private String chatroomActive;
	private String workStatus;
	private String myReadStatus;
	private String yourReadStatus;
	private String memId;
	private String memId2;
	
}
