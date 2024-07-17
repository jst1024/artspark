package com.kh.artspark.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.artspark.chat.model.dao.ChatMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService {

	private final ChatMapper chatMapper;
	
	@Override
	public List<Map<String, Object>> findByIdChatroom(String loginUserId) {
		return chatMapper.findByIdChatroom(loginUserId);
	}

}
