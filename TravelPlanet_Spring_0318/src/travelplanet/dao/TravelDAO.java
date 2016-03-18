package travelplanet.dao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import travelplanet.model.EventDTO;
import travelplanet.model.MemberAndTravelDTO;
import travelplanet.model.PostLikeDTO;
import travelplanet.model.TravelAnswerDTO;
import travelplanet.model.TravelDTO;
import travelplanet.model.TravelLikeDTO;

@Repository
public class TravelDAO {

	@Autowired
	private SqlSession sqlSession;
	private String nameSpace = "Travel.";

	@SuppressWarnings("unchecked")
	public List<TravelDTO> getTravelList() throws Exception {
		List<TravelDTO> travelList = null;
		travelList = (List<TravelDTO>) sqlSession.selectList(nameSpace + "getTravelList");
		return travelList;
	}

	@SuppressWarnings("unchecked")
	public List<Map<Object, Object>> getTravelLikeCountMapList() throws Exception {
		List<Map<Object, Object>> travelLikeCountMapList = null;
		travelLikeCountMapList = sqlSession.selectList(nameSpace + "getTravelLikeCountMapList");
		return travelLikeCountMapList;
	}

	@SuppressWarnings("unchecked")
	public List<Map<Object, Object>> getTravelAnswerCountMapList() throws Exception {
		List<Map<Object, Object>> travelAnswerCountMapList = null;
		travelAnswerCountMapList = sqlSession.selectList(nameSpace + "getTravelAnswerCountMapList");
		return travelAnswerCountMapList;
	}

	@SuppressWarnings("unchecked")
	public List<Integer> getTravelLikeListByID(String id) throws Exception {
		List<Integer> travelLikeList = null;
		travelLikeList = sqlSession.selectList(nameSpace + "getTravelLikeListByID", id);
		return travelLikeList;
	}

	@SuppressWarnings("unchecked")
	public List<TravelDTO> searchTravelListbyId(String query) {
		List<TravelDTO> travelList = null;
		travelList = sqlSession.selectList(nameSpace + "searchTravelListbyId", query);
		return travelList;
	}

	@SuppressWarnings("unchecked")
	public List<TravelDTO> searchTravelListbyTitle(String query) {
		List<TravelDTO> travelList = null;
		travelList = sqlSession.selectList(nameSpace + "searchTravelListbyTitle", query);
		return travelList;
	}

	@SuppressWarnings("unchecked")
	public List<TravelDTO> searchTravelListbyContent(String query) {
		List<TravelDTO> travelList = null;
		travelList = sqlSession.selectList(nameSpace + "searchTravelListbyContent", query);
		return travelList;
	}

	@SuppressWarnings("unchecked")
	public List<TravelDTO> searchTravelListbyRegion(String query) {
		List<TravelDTO> travelList = null;
		travelList = sqlSession.selectList(nameSpace + "searchTravelListbyRegion", query);
		return travelList;
	}

	public TravelDTO getTravel(int travel_seq) {
		TravelDTO travel = null;		
		travel = (TravelDTO) sqlSession.selectOne(nameSpace + "getTravel", travel_seq);	
		return travel;
	}

	@SuppressWarnings("unchecked")
	public List<TravelAnswerDTO> getAnswerList(int travel_seq) {
		List<TravelAnswerDTO> list = null;
		list = sqlSession.selectList(nameSpace + "getAnswerList", travel_seq);
		return list;
	}

	public boolean createTravel(TravelDTO travel) {
		sqlSession.insert(nameSpace + "createTravel", travel);
		System.out.println("travel.getTravel_seq=" + travel.getTravel_seq() + " travel.getTitle=" + travel.getTitle()
				+ " travel.getContent=" + travel.getContent() + " travel.getOpen=" + travel.getOpen()
				+ " travel.getDone=" + travel.getDone() + " travel.getMembers=" + travel.getMembers()
				+ " travel.getRegion=" + travel.getRegion() + " travel.wDate=" + travel.getWdate() + " travel.getEdate="
				+ travel.getEdate() + " travel.getDel=" + travel.getDel() + " travel.getBudget=" + travel.getBudget());
		return true;
	}

	public int getLastTravelSeq() {
		int lastTravelSeq = 0;
		lastTravelSeq = Integer.parseInt(sqlSession.selectOne(nameSpace + "getLastTravelSeq").toString());
		return lastTravelSeq;
	}
	
	
	public int addMemberAndTravel(String id, int lastSeq) {
		// TODO Auto-generated method stub
		int count = 0;
		MemberAndTravelDTO memberandtravelDTO = new MemberAndTravelDTO();
		memberandtravelDTO.setId(id);
		memberandtravelDTO.setTravel_seq(lastSeq);
		memberandtravelDTO.setWauth(0);

		count = sqlSession.insert(nameSpace + "addMemberAndTravel", memberandtravelDTO);
		return count;
	}

	public boolean updateTravelDelete(int travel_seq) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(nameSpace + "updateTravelDelete", travel_seq);
		return true;

	}

	public boolean updateTravel(TravelDTO travelDTO) {
		// TODO Auto-generated method stub
		sqlSession.update(nameSpace + "updateTravel", travelDTO);
		return true;
	}

	public boolean writeAnswer(TravelAnswerDTO answer) {
		// TODO Auto-generated method stub;
		sqlSession.insert(nameSpace + "writeAnswer", answer);
		return true;
	}

	public boolean updateAnswer(TravelAnswerDTO answer) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(nameSpace + "updateAnswer", answer);
		return true;
	}

	public boolean updateTravelAnswerDelete(int travel_answer_seq) {
		// TODO Auto-generated method stub
		sqlSession.update(nameSpace + "updateTravelAnswerDelete", travel_answer_seq);
		return true;
	}

	public boolean addTravelLike(TravelLikeDTO travellikedto) {
		// TODO Auto-generated method stub
		sqlSession.insert(nameSpace + "addTravelLike", travellikedto);
		return true;
	}

	public boolean deleteTravelLike(TravelLikeDTO travellikedto) {
		// TODO Auto-generated method stub
		sqlSession.delete(nameSpace + "deleteTravelLike", travellikedto);
		return true;
	}

	@SuppressWarnings("unchecked")
	public boolean deleteTravelAnswerbyId(String id) throws Exception {
		sqlSession.delete(nameSpace + "deleteTravelAnswerbyId", id);
		return true;
	}
	
	
	public boolean openTravel(int travel_seq) {
		sqlSession.update(nameSpace + "openTravel", travel_seq);
		return true;
	}

	@SuppressWarnings("unchecked")
	public List<TravelDTO> getMyTravelList(String id) {
		List<TravelDTO> myTravelList = null;
		myTravelList = sqlSession.selectList(nameSpace + "getMyTravelList", id);
		return myTravelList;
	}

	@SuppressWarnings("unchecked")
	public List<TravelDTO> getTravelListbyId(String parameterID) {
		// TODO Auto-generated method stub
		List<TravelDTO> list = null;
		list = sqlSession.selectList(nameSpace + "getTravelListbyId", parameterID);
		return list;
	}

	@SuppressWarnings("unchecked")
	public int getTotalTravelCount() {
		int count = 0; 
		count = Integer.parseInt(sqlSession.selectOne(nameSpace + "getTotalTravelCount").toString());
		return count;		
	}	
	
	

	
	@SuppressWarnings("unchecked")
	public boolean deleteTravelLikebyId(String id) throws IOException {
		sqlSession.delete(nameSpace + "deleteTravelLikebyId", id);
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public boolean deleteTravelEventbyId(String id) throws IOException {
		sqlSession.delete(nameSpace + "deleteTravelEventbyId", id);
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public List<Integer> getTravelSeqbyIDandWauth(String id) throws IOException{
		List<Integer> travelDTOlist = null;		
		travelDTOlist = (List<Integer>) sqlSession.selectList(nameSpace + "getTravelSeqbyIDandWauth", id);		
		return travelDTOlist;
	}
	
	@SuppressWarnings("unchecked")
	public boolean deleteTravelbyTravelSeq(int travel_seq) throws IOException {		
		sqlSession.delete(nameSpace + "deleteTravelbyTravelSeq", travel_seq);
		return true;
	}
			
	@SuppressWarnings("unchecked")
	public boolean copyTravel(TravelDTO travelDTO) throws IOException {		
		sqlSession.insert(nameSpace + "copyTravel", travelDTO);
		
		return true;
	}		
			
	public boolean deleteTravelAnswerbyTravelSeq(int travel_seq) throws Exception {
		sqlSession.delete(nameSpace + "deleteTravelAnswerbyTravelSeq", travel_seq);
		return true;
	}			
	
	@SuppressWarnings("unchecked")
	public List<Map<Object, Object>> getTravelCountAndId() throws Exception {
		List<Map<Object, Object>> travelCountMapList = null;
		travelCountMapList = sqlSession.selectList(nameSpace + "getTravelCountAndId");	
		return travelCountMapList;
	}
	
	/*@Override
	public boolean deleteTravelLikebyTravelSeq(int travel_seq) throws Exception {
		return travelDAO.deleteTravelLikebyTravelSeq(travel_seq);
	}*/
	
	public boolean deleteTravelLikebyTravelSeq(int travel_seq) throws Exception {
		sqlSession.delete(nameSpace + "deleteTravelLikebyTravelSeq", travel_seq);
		return true;
	}
}
