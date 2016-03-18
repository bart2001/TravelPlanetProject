package travelplanet.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import travelplanet.model.EventDTO;

@Repository
public class EventDAO {

	@Autowired
	private SqlSession sqlSession;
	
	private String ns = "Event.";

	public boolean deleteEvent(int seq) {
		sqlSession.update(ns + "deleteEvent", seq);
		return true;
	}
	
	public boolean addEvent(EventDTO eventDTO){
		System.out.println("이벤트 1개 넣어보자");
		sqlSession.insert(ns + "addEvent", eventDTO);
		System.out.println("이벤트 1개 잘 들어감");
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public List<EventDTO> getEventList(int travel_seq) throws Exception{
		List<EventDTO> list = new ArrayList<EventDTO>();
		list= sqlSession.selectList(ns + "getEventList", travel_seq);
		System.out.println(travel_seq);
		System.out.println("EventDAO getEventList");
		System.out.println(sqlSession.selectList(ns + "getEventList", travel_seq).size());
		return list;
	}


	
}