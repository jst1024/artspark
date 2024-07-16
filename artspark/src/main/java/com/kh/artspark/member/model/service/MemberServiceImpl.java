package com.kh.artspark.member.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.artspark.member.model.repository.MemberRepository;

import com.kh.artspark.member.model.vo.Artist;
import com.kh.artspark.member.model.vo.BuyOption;
import com.kh.artspark.member.model.vo.Mail;

import com.kh.artspark.member.model.vo.Member;
import com.kh.artspark.member.model.vo.OrderBuyOption;

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
	public int insert(Member member) {
		return memberRepository.insert(sqlSession,member);
	}
	@Override
	public int idCheck(String memId) {
		return memberRepository.idcheck(sqlSession,memId);
	}
	@Override
	public int update(Member member) {
		return memberRepository.update(sqlSession,member);
	}
	@Override
	public String findId(Map<String,String>params) {
		return memberRepository.findId(sqlSession,params);
	}	

	@Override
	public int findPwd(Member member) {
		return memberRepository.findPwd(sqlSession,member);
	}
	@Override
	public int delete(String memId) {
		return memberRepository.delete(sqlSession,memId);
	}
	@Override
	public List<Member> getActiveMembers(int startValue, int endValue) {
		return null;
	}
	@Override
	public int countActiveMembers() {
		return 0;
	}
	@Override

	public int insertArtist(Artist artist) {
		return memberRepository.insertArtist(sqlSession, artist);
	}
	
	@Override
	public int updateMember(Member member) {
	    return memberRepository.updateMember(sqlSession, member);
	}

	@Override
	public int insertOrUpdateArtist(Artist artist) {
	    return memberRepository.insertOrUpdateArtist(sqlSession, artist);
	}

	@Override
	public Member getMemberById(String memId) {
	    return memberRepository.getMemberById(sqlSession, memId);
	}
	@Override
	public Artist getArtist(String memId) {
		return memberRepository.getArtist(sqlSession,memId);
	}
  @Override
	public int changePwd(Member member) {
		return memberRepository.changePwd(sqlSession,member);
	}
	@Override
	public int sendMail(Mail mail) {
		return memberRepository.sendMail(sqlSession,mail);
	}

    @Override
    public void updatePassword(Member member) {
        memberRepository.updatePassword(sqlSession, member);
    }
    
    @Override
    public Member getMember(String memId, String memNickname, String memEmail) {
        return memberRepository.getMember(sqlSession, memId, memNickname, memEmail);
    }


	@Override
	public List<OrderBuyOption> orderBuyOption(String memId) {
		return memberRepository.orderBuyOption(sqlSession,memId);
	}

	
}
