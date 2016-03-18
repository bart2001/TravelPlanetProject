package travelplanet.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import travelplanet.dao.MemberAndTravelDAO;
import travelplanet.dao.TravelDAO;
import travelplanet.model.MemberAndTravelDTO;
import travelplanet.service.MemberAndTravelService;
@Service
public class MemberAndTravelServiceImpl implements MemberAndTravelService {

	@Autowired
	private MemberAndTravelDAO memberAndTravelDAO; 
	
	@Override
	public List<MemberAndTravelDTO> getMemberAndTravelList() throws Exception {
		return memberAndTravelDAO.getMemberAndTravelList();
	}

	@Override
	public List<MemberAndTravelDTO> getMemberAndTravelListbyTravelSeq(int travel_seq) throws Exception {
		return memberAndTravelDAO.getMemberAndTravelListbyTravelSeq(travel_seq);
	}
	
	@Override
	public boolean addMemberAndTravel(MemberAndTravelDTO memberAndTravelDTO) throws Exception {
		return memberAndTravelDAO.addMemberAndTravel(memberAndTravelDTO);
	}
    
	@Override
	public boolean deleteMemberAndTravel(String id) throws Exception{
		return memberAndTravelDAO.deleteMemberAndTravel(id);
	}

	@Override
	public boolean inviteAddMemberAndTravel(MemberAndTravelDTO memberAndTravelDTO) {
		return memberAndTravelDAO.inviteAddMemberAndTravel(memberAndTravelDTO);
	}
	
	@Override
	public boolean deleteMemberAndTravelbyTravelSeqAndWauth(int travel_seq) throws Exception {
		return memberAndTravelDAO.deleteMemberAndTravelbyTravelSeqAndWauth(travel_seq);
	}

	@Override
	public boolean exitFromMemberAndTravel(MemberAndTravelDTO memberAndTravelDTO) throws Exception {
		return memberAndTravelDAO.exitFromMemberAndTravel(memberAndTravelDTO);		
	}

	
}
