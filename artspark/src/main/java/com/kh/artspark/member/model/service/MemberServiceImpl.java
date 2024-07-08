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
	@Override
	public Member login(Member member) {
		return memberRepository.login(sqlSession,member);
	}
	@Override
	public int delete(Member memId) {
		return memberRepository.delete(sqlSession,memId);
	}
	@Override
	public int insert(Member member) {
		return 0;
	}
	@Override
	public int idCheck(String memId) {
		return 0;
	}
	@Override
	public int update(Member member) {
		return 0;
	}
	@Override
	public int findId(Member member) {
		return 0;
	}
	@Override
	public int findPwd(Member member) {
		return 0;
	}

	
}
