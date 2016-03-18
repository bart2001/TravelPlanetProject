package travelplanet.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import travelplanet.model.TravelAnswerDTO;
import travelplanet.model.TravelDTO;
import travelplanet.model.TravelLikeDTO;
import travelplanet.model.TravelSeqAndImgAndIdDTO;


public interface TravelService {
		
	public List<TravelDTO> getTravelList() throws Exception;
	public List<Map<Object, Object>> getTravelLikeCountMapList() throws Exception;
	public List<Map<Object, Object>> getTravelAnswerCountMapList() throws Exception;
	public List<Integer> getTravelLikeListByID(String id) throws Exception;
		
	//검색
	public List<TravelDTO> searchTravelListbyId(String query) throws Exception;
	public List<TravelDTO> searchTravelListbyTitle(String query)throws Exception;
	public List<TravelDTO> searchTravelListbyContent(String query)throws Exception;
	public List<TravelDTO> searchTravelListbyRegion(String query)throws Exception;
	public TravelDTO getTravel(int travel_seq) throws Exception;
	public List<TravelAnswerDTO> getAnswerList(int travel_seq) throws Exception;
	public boolean createTravel(TravelDTO travel) throws Exception;
	public int getLastTravelSeq() throws Exception;
	
	public boolean updateTravelDelete(int travel_seq) throws Exception;
	public boolean updateTravel(TravelDTO travelDTO) throws Exception;
	public boolean writeAnswer(TravelAnswerDTO answer)throws Exception;
	public boolean updateAnswer(TravelAnswerDTO answer)throws Exception;
	public boolean updateTravelAnswerDelete(int travel_answer_seq)throws Exception;
	public boolean addTravelLike(TravelLikeDTO travellikedto);
	public boolean deleteTravelLike(TravelLikeDTO travellikedto);
	public boolean openTravel(int travel_seq);
	public List<TravelDTO> getMyTravelList(String id);
	public List<TravelDTO> getTravelListbyId(String parameterID);
	
	// 회원삭제
	public boolean deleteTravelLikebyId(String id)throws Exception;
	// 댓글 삭제 메소드(회원탈퇴시)
	public boolean deleteTravelAnswerbyId(String id) throws Exception;
	public boolean deleteTravelEventbyId(String id)throws Exception;
	public List<Integer> getTravelSeqbyIDandWauth(String id)throws Exception;
	public boolean deleteTravelbyTravelSeq(int travel_seq)throws Exception;

	// 전체 여행개수를 세기위한 메소드
	public int getTotalTravelCount();
	public boolean copyTravel(TravelDTO travelDTO) throws Exception;
	
	public boolean deleteTravelAnswerbyTravelSeq(int travel_seq) throws Exception;	
	
	public List<Map<Object, Object>> getTravelCountAndId()throws Exception;
	
	public boolean deleteTravelLikebyTravelSeq(int travel_seq)throws Exception;
	
	
	
	public List<TravelSeqAndImgAndIdDTO> getTravelSeqAndImgAndId()throws Exception;
}
