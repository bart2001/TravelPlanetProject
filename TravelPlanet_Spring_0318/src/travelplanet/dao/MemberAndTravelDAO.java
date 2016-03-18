package travelplanet.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import travelplanet.model.MemberAndTravelDTO;

@Repository
public class MemberAndTravelDAO {

	@Autowired
	private SqlSession sqlSession;
	
	private String nameSpace = "MemberAndTravel.";
	
	@SuppressWarnings("unchecked")
	public List<MemberAndTravelDTO> getMemberAndTravelList() {		
		List<MemberAndTravelDTO> list = null;
		list = (List<MemberAndTravelDTO>) sqlSession.selectList(nameSpace + "getMemberAndTravelList");
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<MemberAndTravelDTO> getMemberAndTravelListbyTravelSeq(int travel_seq) {
		List<MemberAndTravelDTO> list = null;
		list = (List<MemberAndTravelDTO>) sqlSession.selectList(nameSpace + "getMemberAndTravelListbyTravelSeq", travel_seq);
		return list;
	}
	
	public boolean addMemberAndTravel(MemberAndTravelDTO memberAndTravelDTO) {	
		System.out.println("addMemberAndTravel getId="+ memberAndTravelDTO.getId());
		System.out.println("addMemberAndTravel getTravel_seq="+ memberAndTravelDTO.getTravel_seq());
		System.out.println("addMemberAndTravel getWauth="+ memberAndTravelDTO.getWauth());
		
		sqlSession.insert(nameSpace + "addMemberAndTravel", memberAndTravelDTO);
		return true;		
	}
		
	public boolean deleteMemberAndTravel(String id){
		sqlSession.delete(nameSpace + "deleteMemberAndTravel", id);
		return true;
	}

	public boolean inviteAddMemberAndTravel(MemberAndTravelDTO memberAndTravelDTO) {
		sqlSession.insert(nameSpace + "inviteAddMemberAndTravel", memberAndTravelDTO);
		System.out.println("inviteAddMemberAndTravel memberAndTravelDTO="+ memberAndTravelDTO.getId() + memberAndTravelDTO.getTravel_seq() + memberAndTravelDTO.getWauth());
		return true;		
	}
	
	public boolean deleteMemberAndTravelbyTravelSeqAndWauth(int travel_seq){
		sqlSession.delete(nameSpace + "deleteMemberAndTravelbyTravelSeqAndWauth", travel_seq);
		return true;
	}

	public boolean exitFromMemberAndTravel(MemberAndTravelDTO memberAndTravelDTO) {
		sqlSession.delete(nameSpace + "exitFromMemberAndTravel", memberAndTravelDTO);
		return true;
	}
	
}
