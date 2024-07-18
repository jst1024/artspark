package com.kh.artspark.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.artspark.chat.model.service.ChatService;
import com.kh.artspark.chat.model.vo.Chat;
import com.kh.artspark.common.model.vo.Message;
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
	
	@ResponseBody
	@GetMapping("chat-info")
	public ResponseEntity<Message> chatInfo(int chatroomNo, HttpSession session) {
		
		List<Chat> chatList = chatService.findChatings(chatroomNo);
		
		if(chatList.isEmpty()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Message.builder()
																		   .message("채팅 내역이 없습니다.")
																		   .build());	
		}
		
		Message responseMsg = Message.builder() 
									 .data(chatList)
									 .message("채팅 내역 조회 성공")
									 .build();
		log.info("{}", chatList);
		return ResponseEntity.status(HttpStatus.OK).body(responseMsg);
	}
	
	@ResponseBody
	@PostMapping("insert-chat")
	public ResponseEntity<Message> insertChat(String message, int chatroomNo, HttpSession session) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		String loginUserId = loginUser.getMemId();
		
//		log.info("{}", chatroomNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("message", message);
		map.put("chatroomNo", chatroomNo);
		map.put("loginUserId", loginUserId);
		
		int result = chatService.insertChat(map);
		
		if(result == 0) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
																			 .message("채팅 테이블 등록 실패")
																			 .build());
		}
		
		Map<String, Object> responseMap = new HashMap<String, Object>();
		
		Message responseMsg = Message.builder().data(message)
											   .message("채팅 테이블 등록 성공")
											   .build();
		
		return ResponseEntity.status(HttpStatus.OK).body(responseMsg);
	}
	
}

















