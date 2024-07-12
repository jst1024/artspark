package com.kh.artspark.member.model.service;

import java.util.List;
import java.util.Map;

import com.kh.artspark.member.model.vo.Member;

public interface MemberService {
	
	List<Member> memberList();
		
	
	// 로그인(SELECT)
	Member login(Member member);
		
	//회원가입
	int insert(Member member);
	
	//id중복체크
	int idCheck(String memId);
	
	//회원 정보수정
	int update(Member member);
	
	//판매자 정보수정
	
	
	//아이디찾기
	String findId(Map<String,String>params);
	
	//비밀번호 찾기
	int findPwd(Member member);
	
	//회원탈퇴
	int delete(Member memId);
}
