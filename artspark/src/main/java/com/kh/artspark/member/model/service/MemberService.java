package com.kh.artspark.member.model.service;

import java.util.List;
import java.util.Map;

import com.kh.artspark.member.model.vo.Artist;
import com.kh.artspark.member.model.vo.Interest;
import com.kh.artspark.member.model.vo.Mail;
import com.kh.artspark.member.model.vo.Member;
import com.kh.artspark.member.model.vo.OrderBuyOption;


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
	int insertArtist(Artist artist);
	int updateMember(Member member);
	int insertOrUpdateArtist(Artist artist);
	Member getMemberById(String memId);
	Artist getArtist(String memId);
	//아이디찾기
	String findId(Map<String,String>params);

	//비밀번호 찾기
	int findPwd(Member member);
	
	//비밀번호 수정
	int changePwd(Member member);
	
	//회원탈퇴
	int delete(String  memId);
	
	//메일인증
	int sendMail(Mail mail);
    void updatePassword(Member member);
	Member getMember(String memId, String memNickname, String memEmail);
	
	


	
	//주문관리
	List<OrderBuyOption> orderBuyOption(String memId);

	//관심 판매자 목록확인
	List<Interest> interest(String memId);
	
	//별점의 평균
	
	
	//
	List<Member> getActiveMembers(int startValue, int endValue);

	//
	int countActiveMembers();



	


}
