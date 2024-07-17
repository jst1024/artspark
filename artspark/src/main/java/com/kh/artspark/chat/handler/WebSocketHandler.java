package com.kh.artspark.chat.handler;

import java.time.LocalTime;
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
		
		Member chatMember = (Member) session.getAttributes().get("loginUser");
		String chatUserId = chatMember.getMemId();
		
		log.info("{}로 부터 {}를 전달 받았습니다.", chatUserId, message.getPayload());
		
		LocalTime currentTime = LocalTime.now();
		int hour = currentTime.getHour();
		int minute = currentTime.getMinute();
		
		String period = hour < 12 ? "오전" : "오후";
		hour = hour < 12 ? hour : hour % 12;
		String min = minute < 10 ? "0" + minute : "" + minute; 
		
		
		// 채팅내용, 채팅 친 사람, 채팅 시간 저장  
		Chat chat = new Chat();
		chat.setMemId(chatUserId);
		chat.setChatContent(message.getPayload());
		chat.setChatTime(period + " " + hour + ":" + min);
		
		// chat 객체를 Json 문자열로 반환
		Gson gson = new Gson();
		String jsonMessage = gson.toJson(chat);
		
		TextMessage newMessage = new TextMessage(jsonMessage);
		log.info(jsonMessage);
		
		for(WebSocketSession ws : users) {
			ws.sendMessage(newMessage);
		}
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		users.remove(session);
		log.info("사용자 접속 종료 ! 현재 {}명 접속중입니다.", users.size());
	}
	
}
