package com.kh.artspark.chat.handler;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.kh.artspark.chat.model.vo.Chat;
import com.kh.artspark.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class WebSocketHandler extends TextWebSocketHandler {
	
	private Set<WebSocketSession> users = new CopyOnWriteArraySet<WebSocketSession>();
	private Map<String, WebSocketSession> userMap = new HashMap<String, WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("사용자 접속 !");
		users.add(session);
		log.info("현재 {}명 접속중 입니다.", users.size());
		Member chatMember = (Member) session.getAttributes().get("loginUser");
		String chatUserId = chatMember.getMemId();
		userMap.put(chatUserId, session);
		log.info("채팅멤버 : {}", chatUserId);
		log.info("세션정보 : {}", session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		Gson gson = new Gson();
		Member chatMember = (Member) session.getAttributes().get("loginUser");
		String chatUserId = chatMember.getMemId();
		String payload = message.getPayload();
		Map<String, Object> msgData = gson.fromJson(payload, Map.class);
		
		// System.out.println(msgData.get("chatroomNo"));
		
		String content =(String) msgData.get("content");
		String chatPartner =(String) msgData.get("chatPartner");
		
		Object chatroomNoObj = msgData.get("chatroomNo");
        int chatroomNo = 0;
        if (chatroomNoObj instanceof Double) {
            chatroomNo = ((Double) chatroomNoObj).intValue();
        } else if (chatroomNoObj instanceof String) {
            chatroomNo = Integer.parseInt((String) chatroomNoObj);
        }
		
		log.info("{}와 {}를 전달 받았습니다.", content, chatPartner);
		
		LocalDateTime now = LocalDateTime.now();
		
		 // 원하는 형식 지정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        
        // 형식에 맞춰 시간 문자열로 변환
        String formattedNow = now.format(formatter); 
		
		
		// 채팅내용, 채팅 친 사람, 채팅 시간 저장  
		Chat chat = new Chat();
		chat.setMemId(chatUserId);
		chat.setChatContent(content);
		chat.setChatTime(formattedNow);
		chat.setChatroomNo(chatroomNo);
		
		// chat 객체를 Json 문자열로 반환
		String jsonMessage = gson.toJson(chat);
		
		TextMessage newMessage = new TextMessage(jsonMessage);
		log.info(jsonMessage);
		log.info("{}", userMap);
		log.info("{}", userMap.get(chatPartner));
		
		userMap.get(chatUserId).sendMessage(newMessage);
		if(userMap.get(chatPartner) != null) { 
			userMap.get(chatPartner).sendMessage(newMessage);
		}
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		users.remove(session);
		Member chatMember = (Member) session.getAttributes().get("loginUser");
		String chatUserId = chatMember.getMemId();
		userMap.remove(chatUserId);
		log.info("사용자 접속 종료 ! 현재 {}명 접속중입니다.", users.size());
	}
	
}
