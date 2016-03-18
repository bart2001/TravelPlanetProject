package travelplanet.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import travelplanet.dao.MemberDAO;
import travelplanet.model.MemberDTO;
import travelplanet.service.MemberService;
@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO memberDAO;

	@Override
	public boolean checkLogin(MemberDTO memberDTO) throws Exception {		
		return memberDAO.checkLogin(memberDTO);
	}	
	
	@Override
	public MemberDTO login(MemberDTO memberDTO) throws Exception {
		return memberDAO.login(memberDTO);
	}

	@Override
	public boolean checkId(String id) throws Exception {
		return memberDAO.checkId(id);
	}
	
	@Override
	public boolean addMember(MemberDTO memberDTO) throws Exception {
		return memberDAO.addMember(memberDTO);
	}
	
	@Override
	public boolean checkPwd(String id, String current_pwd) throws Exception {
		return memberDAO.checkPwd(id, current_pwd);
	}
	
	@Override
	public boolean updateMember(MemberDTO memberDTO) throws Exception {
		return memberDAO.updateMember(memberDTO);
	} 
	
	@Override
	public boolean deleteMember(String id) throws Exception{
		return memberDAO.deleteMember(id);
	}
	
	@Override
	public boolean addImage(MemberDTO memberDTO) throws Exception {
		return memberDAO.addImage(memberDTO);
	}
	
	@Override
	public String getImage(String id) throws Exception {
		return memberDAO.getImage(id);
	}
	
	@Override
	public List<MemberDTO> getMemberList() throws Exception {
		return memberDAO.getMemberList();
	}
	
	@Override
	public int getTotalMemberCount() { 
		return memberDAO.getTotalMemberCount();
	}

	@Override
	public MemberDTO getMemberById(String id) throws Exception {		
		return memberDAO.getMemberById(id);
	}
	
	
}
