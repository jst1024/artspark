package com.kh.artspark.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.artspark.member.model.vo.Artist;
import com.kh.artspark.member.model.vo.Interest;
import com.kh.artspark.member.model.vo.Mail;
import com.kh.artspark.member.model.vo.Member;
import com.kh.artspark.member.model.vo.OrderBuyOption;


@Mapper
public interface MemberMapper {

	List<Member> memberList();

	Member login(Member member);

	int insert(Member member);

	int idCheck(String memId);

	int update(Member member);

	int insertArtist(Artist artist);

	int updateMember(Member member);

	int insertOrUpdateArtist(Artist artist);

	Member getMemberById(String memId);

	Artist getArtist(String memId);

	String findId(Map<String, String> params);

	int findPwd(Member member);

	int changePwd(Member member);

	int delete(String memId);

	int sendMail(Mail mail);

	Member getMember(@Param("memId") String memId, 
   		 			 @Param("memNickname") String memNickname, 
   		 			 @Param("memEmail") String memEmail);
	
	int updatePassword(Member member);
	
	List<OrderBuyOption> orderBuyOption(String memId);

	List<Interest> interest(String memId);

	List<Member> getActiveMembers(int startValue, int endValue);

	int countActiveMembers();





}
