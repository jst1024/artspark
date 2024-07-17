package com.kh.artspark.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.artspark.chat.model.dao.ChatMapper;
import com.kh.artspark.chat.model.vo.Chat;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService {

	private final ChatMapper chatMapper;
	
	@Override
	public List<Map<String, Object>> findByIdChatroom(String loginUserId) {
		return chatMapper.findByIdChatroom(loginUserId);
	}

	@Override
	public List<Chat> findChatings(int chatroomNo) {
		return chatMapper.findChatings(chatroomNo);
	}

	@Override
	public int insertChat(Map<String, Object> map) {
		return chatMapper.insertChat(map);
	}

}
