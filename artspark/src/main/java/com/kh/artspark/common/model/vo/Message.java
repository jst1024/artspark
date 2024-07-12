package com.kh.artspark.common.model.vo;

import lombok.AllArgsConstructor;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;

@Data
@Builder
@AllArgsConstructor
public class Message {
	
	private String message;
	private Object data;

}
