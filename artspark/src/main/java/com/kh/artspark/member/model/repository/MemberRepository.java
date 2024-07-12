package com.kh.artspark.member.model.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.artspark.member.model.vo.Member;

@Repository
public class MemberRepository {
	
	public List<Member> memberList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("memberMapper.memberList");
	}

	public Member login(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.selectOne("memberMapper.login",member);
	}

	public int delete(SqlSessionTemplate sqlSession, Member memId) {
		return sqlSession.update("memberMapper.delete",memId);
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

}
