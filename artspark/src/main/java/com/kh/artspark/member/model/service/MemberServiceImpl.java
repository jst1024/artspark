package com.kh.artspark.member.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.artspark.member.model.repository.MemberRepository;
import com.kh.artspark.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberRepository memberRepository;
	private final SqlSessionTemplate sqlSession;
	@Override
	public List<Member> memberList() {
		return memberRepository.memberList(sqlSession);
	}
	
}
