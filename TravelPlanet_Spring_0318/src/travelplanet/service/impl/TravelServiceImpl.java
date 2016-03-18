package travelplanet.service.impl;


import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import travelplanet.dao.TravelDAO;

import travelplanet.model.TravelAnswerDTO;
import travelplanet.model.TravelDTO;
import travelplanet.model.TravelLikeDTO;
import travelplanet.service.TravelService;
@Service
public class TravelServiceImpl implements TravelService {
    
	@Autowired
	private TravelDAO travelDAO;

	@Override
	public List<TravelDTO> getTravelList() throws Exception{
		return travelDAO.getTravelList();
	}

	@Override
	public List<Map<Object, Object>> getTravelLikeCountMapList() throws Exception {
		return travelDAO.getTravelLikeCountMapList();		
	}	
	
	@Override
	public List<Map<Object, Object>> getTravelAnswerCountMapList() throws Exception {
		return travelDAO.getTravelAnswerCountMapList();
	}

	@Override
	public List<Integer> getTravelLikeListByID(String id) throws Exception {
		// TODO Auto-generated method stub
		return travelDAO.getTravelLikeListByID(id);
	}

	@Override
	public List<TravelDTO> searchTravelListbyId(String query) throws Exception {
		// TODO Auto-generated method stub
		return travelDAO.searchTravelListbyId(query);
	}

	@Override
	public List<TravelDTO> searchTravelListbyTitle(String query) {
		// TODO Auto-generated method stub
		return travelDAO.searchTravelListbyTitle(query);
	}

	@Override
	public List<TravelDTO> searchTravelListbyContent(String query) {
		// TODO Auto-generated method stub
		return travelDAO.searchTravelListbyContent(query);
	}

	@Override
	public List<TravelDTO> searchTravelListbyRegion(String query) {
		// TODO Auto-generated method stub
		return  travelDAO.searchTravelListbyRegion(query);
	}

	@Override
	public TravelDTO getTravel(int travel_seq) throws Exception {
		// TODO Auto-generated method stub
		return travelDAO.getTravel(travel_seq);
	}

	@Override
	public List<TravelAnswerDTO> getAnswerList(int travel_seq) throws Exception{
		// TODO Auto-generated method stub
		return travelDAO.getAnswerList(travel_seq);
	}

	@Override
	public boolean createTravel(TravelDTO travelDTO) throws Exception {
		// TODO Auto-generated method stub
		return travelDAO.createTravel(travelDTO);
	}

	@Override
	public int getLastTravelSeq() throws Exception {
		// TODO Auto-generated method stub
		return travelDAO.getLastTravelSeq();
	}	

	@Override
	public boolean updateTravelDelete(int travel_seq) throws Exception {
		// TODO Auto-generated method stub
		
		return travelDAO.updateTravelDelete(travel_seq);
	}

	@Override
	public boolean updateTravel(TravelDTO travelDTO) throws Exception {
		// TODO Auto-generated method stub
		return travelDAO.updateTravel(travelDTO);
	}

	@Override
	public boolean writeAnswer(TravelAnswerDTO answer) {
		// TODO Auto-generated method stub
		return travelDAO.writeAnswer(answer);
	}

	@Override
	public boolean updateAnswer(TravelAnswerDTO answer) throws Exception {
		// TODO Auto-generated method stub
		return travelDAO.updateAnswer(answer);
	}

	@Override
	public boolean updateTravelAnswerDelete(int travel_answer_seq) {
		// TODO Auto-generated method stub
		return travelDAO.updateTravelAnswerDelete(travel_answer_seq);
	}

	@Override
	public boolean addTravelLike(TravelLikeDTO travellikedto) {
		// TODO Auto-generated method stub
		return travelDAO.addTravelLike(travellikedto);
	}

	@Override
	public boolean deleteTravelLike(TravelLikeDTO travellikedto) {
		// TODO Auto-generated method stub
		return travelDAO.deleteTravelLike(travellikedto);
	}

	@Override
	public boolean openTravel(int travel_seq) {
		// TODO Auto-generated method stub
		return travelDAO.openTravel(travel_seq);
	}

	@Override
	public List<TravelDTO> getMyTravelList(String id) {
		// TODO Auto-generated method stub
		return travelDAO.getMyTravelList(id);
	}

	@Override
	public List<TravelDTO> getTravelListbyId(String parameterID) {
		// TODO Auto-generated method stub
		return travelDAO.getTravelListbyId(parameterID);
	}
	
	@Override
	public int getTotalTravelCount() {
		return travelDAO.getTotalTravelCount();
	}

	@Override
	public boolean deleteTravelLikebyId(String id) throws IOException {
		return travelDAO.deleteTravelLikebyId(id);
	}
	
	@Override
	public boolean deleteTravelAnswerbyId(String id) throws Exception {
		return travelDAO.deleteTravelAnswerbyId(id);
	}
	
	@Override
	public boolean deleteTravelEventbyId(String id) throws IOException {
		return travelDAO.deleteTravelEventbyId(id);
	}
	
	@Override
	public List<Integer> getTravelSeqbyIDandWauth(String id) throws IOException {
		return travelDAO.getTravelSeqbyIDandWauth(id);
	}
	
	@Override
	public boolean deleteTravelbyTravelSeq(int travel_seq) throws IOException {
		return travelDAO.deleteTravelbyTravelSeq(travel_seq);
	}

	@Override
	public boolean copyTravel(TravelDTO travelDTO) throws IOException {	
		return travelDAO.copyTravel(travelDTO);
	}
	
	@Override
	public boolean deleteTravelAnswerbyTravelSeq(int travel_seq) throws Exception {	
		return travelDAO.deleteTravelAnswerbyTravelSeq(travel_seq);		
	}

	@Override
	public List<Map<Object, Object>> getTravelCountAndId() throws Exception {
		return travelDAO.getTravelCountAndId();		
	}
	
	@Override
	public boolean deleteTravelLikebyTravelSeq(int travel_seq) throws Exception {
		return travelDAO.deleteTravelLikebyTravelSeq(travel_seq);
	}
	
	
}
