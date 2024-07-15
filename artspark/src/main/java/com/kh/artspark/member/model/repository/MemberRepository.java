package com.kh.artspark.member.model.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.artspark.member.model.vo.Artist;
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

	public boolean update(SqlSessionTemplate sqlSession, String memPwd) {
		return sqlSession.selectOne("memberMapper.update",memPwd);
	}

	public int insertArtist(SqlSessionTemplate sqlSession, Artist artist) {
		return sqlSession.insert("memberMapper.insertArtist",artist);
	}
	
	public int updateMember(SqlSessionTemplate sqlSession, Member member) {
	    return sqlSession.update("memberMapper.updateMember", member);
	}

	public int insertOrUpdateArtist(SqlSessionTemplate sqlSession, Artist artist) {
	    return sqlSession.update("memberMapper.insertOrUpdateArtist", artist);
	}

	public Member getMemberById(SqlSessionTemplate sqlSession, String memId) {
	    return sqlSession.selectOne("memberMapper.getMemberById", memId);
	}

	public Artist getArtist(SqlSessionTemplate sqlSession, String memId) {
		return sqlSession.selectOne("memberMapper.getArtist",memId);
	}

}
