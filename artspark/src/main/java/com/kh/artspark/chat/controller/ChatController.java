package com.kh.artspark.chat.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.artspark.chat.model.service.ChatService;
import com.kh.artspark.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class ChatController {

	private final ChatService chatService;
	
	@GetMapping("private-chat")
	public String privateChat(HttpSession session, Model model) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		String loginUserId = loginUser.getMemId();
		
		List<Map<String, Object>> chatrooms = chatService.findByIdChatroom(loginUserId);
		
		log.info("채팅방 목록 : {}", chatrooms);
		
		model.addAttribute("chatrooms", chatrooms);
		
		return "chat/privateChat";
	}
	
}

















