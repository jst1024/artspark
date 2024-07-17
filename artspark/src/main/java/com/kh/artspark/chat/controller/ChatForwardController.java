package com.kh.artspark.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChatForwardController {

	@GetMapping("private-chat")
	public String privateChat() {
		return "chat/privateChat";
	}
	
}
