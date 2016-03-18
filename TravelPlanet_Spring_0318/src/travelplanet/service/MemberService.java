package travelplanet.service;

import java.util.List;



import travelplanet.model.MemberDTO;

public interface MemberService {
	// logincheck.do
	public boolean checkLogin(MemberDTO memberDTO) throws Exception;
	// login.do
	public MemberDTO login(MemberDTO memberDTO) throws Exception;
	// regicheck.do
	public boolean checkId(String id) throws Exception;
	// regi.do
	public boolean addMember(MemberDTO memberDTO) throws Exception;
	// updatemember.do
	public boolean checkPwd(String id, String current_pwd) throws Exception;
	public boolean updateMember(MemberDTO memberDTO) throws Exception;
	// deletemember.do
	public boolean deleteMember(String id) throws Exception;
	// profileupload.do
	public boolean addImage(MemberDTO memberDTO) throws Exception;
	// mypage.do
	public String getImage(String id) throws Exception;
	// 이미지를 뿌리기 위한 전체 회원정보 가져오기
	public List<MemberDTO> getMemberList() throws Exception;
	
	// 전체 회원수를 세기
	public int getTotalMemberCount();
	
	// 해당 회원의 이메일 가져오기
	public MemberDTO getMemberById(String id) throws Exception;
	
}