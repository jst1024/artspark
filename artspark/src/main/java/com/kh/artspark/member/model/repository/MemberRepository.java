package com.kh.artspark.member.model.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.artspark.member.model.vo.Member;

@Repository
public class MemberRepository {
	
	public List<Member> memberList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("memberMapper.memberList");
	}
}
