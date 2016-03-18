package travelplanet.service;

import java.util.List;

import travelplanet.model.MemberAndTravelDTO;

public interface MemberAndTravelService {
//<!--IMemberAndTravelService -->
	
	public List<MemberAndTravelDTO> getMemberAndTravelList() throws Exception; 
	public List<MemberAndTravelDTO> getMemberAndTravelListbyTravelSeq(int travel_seq) throws Exception;
	public boolean addMemberAndTravel(MemberAndTravelDTO memberAndTravelDTO) throws Exception; 
	
//	public String  getWriterIdbyTravelSeq(int travel_seq);
	
	// 삭제 메소드(회원탈퇴시)
	public boolean deleteMemberAndTravel(String id) throws Exception;
	public boolean inviteAddMemberAndTravel(MemberAndTravelDTO memberAndTravelDTO);
	
	public boolean deleteMemberAndTravelbyTravelSeqAndWauth(int travel_seq) throws Exception;
	public boolean exitFromMemberAndTravel(MemberAndTravelDTO memberAndTravelDTO) throws Exception;
}

