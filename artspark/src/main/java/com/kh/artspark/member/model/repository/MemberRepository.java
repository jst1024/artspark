package com.kh.artspark.member.model.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.artspark.member.model.vo.Mail;
import com.kh.artspark.member.model.vo.Member;

@Repository
public class MemberRepository {
	
	public List<Member> memberList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("memberMapper.memberList");
	}

	public Member login(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.selectOne("memberMapper.login",member);
	}

	public int insert(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.insert("memberMapper.insert",member);
	}

	public int idcheck(SqlSessionTemplate sqlSession, String memId) {
		return sqlSession.selectOne("memberMapper.idCheck",memId);
	}

	public int update(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.update("memberMapper.update",member);
	}
	
	public String findId(SqlSessionTemplate sqlSession, Map<String,String>params) {
	    return sqlSession.selectOne("memberMapper.findId", params);
	}

	public int delete(SqlSessionTemplate sqlSession, String memId) {
		return sqlSession.update("memberMapper.delete",memId);
	}

	public int findPwd(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.selectOne("memberMapper.findPwd",member);
	}

	public int changePwd(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.update("memberMapper.changePwd",member);
	}
	
	public int sendMail(SqlSessionTemplate sqlSession, Mail mail) {
		return sqlSession.insert("memberMapper.sendMail",mail);
	}

    public int updatePassword(SqlSessionTemplate sqlSession, Member member) {
        return sqlSession.update("memberMapper.updatePassword", member);
    }

	public void delete(SqlSessionTemplate sqlSession, Mail mail) {
		 sqlSession.delete("memberMapper.deleteMail", mail);

	}
	public Member getMember(SqlSessionTemplate sqlSession, String memId, String memNickname, String memEmail) {
	    Map<String, String> params = new HashMap<>();
	    params.put("memId", memId);
	    params.put("memNickname", memNickname);
	    params.put("memEmail", memEmail);
	    return sqlSession.selectOne("memberMapper.getMember", params);
	}
	
	

}
