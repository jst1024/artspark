package com.kh.artspark.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.artspark.member.model.dao.MemberMapper;
import com.kh.artspark.member.model.vo.Artist;
import com.kh.artspark.member.model.vo.Interest;
import com.kh.artspark.member.model.vo.Mail;
import com.kh.artspark.member.model.vo.Member;
import com.kh.artspark.member.model.vo.OrderBuyOption;


import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private final MemberMapper memberMapper;

	@Override
	public List<Member> memberList(Map<String, Integer> map) {
	    // 디버깅 로그 추가
	    System.out.println("Fetching members with params: " + map);
	    List<Member> members = memberMapper.memberList(map);
	    System.out.println("Fetched members: " + members);
	    return members;
	}

	@Override
	public Member login(Member member) {
		return memberMapper.login(member);
	}

	@Override
	public int insert(Member member) {
		return memberMapper.insert(member);
	}

	@Override
	public int idCheck(String memId) {
		return memberMapper.idCheck(memId);
	}

	@Override
	public int update(Member member) {
		return memberMapper.update(member);
	}

	@Override
	public int insertArtist(Artist artist) {
		return memberMapper.insertArtist(artist);
	}

	@Override
	public int updateMember(Member member) {
		return memberMapper.updateMember(member);
	}

	@Override
	public int insertOrUpdateArtist(Artist artist) {
		return memberMapper.insertOrUpdateArtist(artist);
	}

	@Override
	public Member getMemberById(String memId) {
		return memberMapper.getMemberById(memId);
	}

	@Override
	public Artist getArtist(String memId) {
		return memberMapper.getArtist(memId);
	}

	@Override
	public String findId(Map<String, String> params) {
		return memberMapper.findId(params);
	}

	@Override
	public int findPwd(Member member) {
		return memberMapper.findPwd(member);
	}

	@Override
	public int changePwd(Member member) {
		return memberMapper.changePwd(member);
	}

	@Override
	public int delete(String memId) {
		return memberMapper.delete(memId);
	}

	@Override
	public int sendMail(Mail mail) {
		return memberMapper.sendMail(mail);
	}

	@Override
	public void updatePassword(Member member) {
	}

	@Override
	public Member getMember(String memId, String memNickname, String memEmail) {
		return memberMapper.getMember(memId, memNickname, memEmail);
	}

	@Override
	public List<OrderBuyOption> orderBuyOption(String memId) {
		return memberMapper.orderBuyOption(memId);
	}

	@Override
	public List<Interest> interest(String memId) {
		return memberMapper.interest(memId);
	}

	@Override
	public int memberCount() {
		return memberMapper.memberCount();
	}

	@Override
	public List<Map<String, Object>> suspendedMemberList(Map<String,Integer> map) {
		return memberMapper.suspendedMemberList(map);
	}

	@Override
	public int suspendedMemberCount() {
		return memberMapper.suspendedMemberCount();
	}

	@Override
	public int updateMemberStatus(String memberId, String status) {
		Map<String, Object> params = new HashMap<>();
        params.put("memberId", memberId);
        params.put("status", status);
        return memberMapper.updateMemberStatus(params);
	}



	
	
	
}
