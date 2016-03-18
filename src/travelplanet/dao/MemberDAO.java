package travelplanet.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import travelplanet.model.MemberDTO;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private String nameSpace = "Member.";

	public boolean checkLogin(MemberDTO memberDTO) throws Exception {
		MemberDTO memberDTO2 = null;
		memberDTO2 = (MemberDTO) sqlSession.selectOne(nameSpace + "loginCheck", memberDTO);
		return memberDTO2 != null? true : false;
	}
	
	public MemberDTO login(MemberDTO memberDTO) throws Exception {
		MemberDTO memberDTO2 = null;
		memberDTO2 = (MemberDTO) sqlSession.selectOne(nameSpace + "login", memberDTO);
		return memberDTO2;
	}
	
	public boolean checkId(String id) throws Exception {		
		Object object = null;
		object = sqlSession.selectOne(nameSpace + "checkId", id);
		return object != null? true : false;
	}
	
	public boolean addMember(MemberDTO memberDTO) throws Exception {
		sqlSession.insert(nameSpace + "addMember", memberDTO);
		return true;
	}
	
	public boolean checkPwd(String id, String current_pwd) throws Exception {		
		String pwd = "";
		pwd = sqlSession.selectOne(nameSpace + "checkPwd", id).toString();		
		return pwd.equals(current_pwd)? true : false;
	}
	
	public boolean updateMember(MemberDTO memberDTO) throws Exception {
		sqlSession.update(nameSpace + "updateMember", memberDTO);
		return true;
	} 
	
	public boolean deleteMember(String id) throws Exception {
		sqlSession.delete(nameSpace + "deleteMember", id);
		return true;
	} 
	
	public boolean addImage(MemberDTO memberDTO) throws Exception {
		sqlSession.update(nameSpace + "addImage", memberDTO);
		return true;
	} 
	
	public String getImage(String id) throws Exception {
		String img = "";
		img = (String) sqlSession.selectOne(nameSpace + "getImage", id);
		return img;
	}
	
	@SuppressWarnings("unchecked")
	public List<MemberDTO> getMemberList() {
		List<MemberDTO> memberList = null;
		memberList = sqlSession.selectList(nameSpace + "getMemberList");
		return memberList;
	}
	
	public int getTotalMemberCount() {
		int count = 0; 
		count = Integer.parseInt(sqlSession.selectOne(nameSpace + "getTotalMemberCount").toString());
		return count;
	}
	
	public MemberDTO getMemberById(String id) {
		MemberDTO memberDTO = null;
		memberDTO = (MemberDTO) sqlSession.selectOne(nameSpace + "getMemberById", id);		
		return memberDTO;	
	}	
}

