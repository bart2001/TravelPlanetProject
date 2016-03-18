package travelplanet.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import travelplanet.dao.EventDAO;
import travelplanet.model.EventDTO;
import travelplanet.service.EventService;
@Service
public class EventServiceImpl implements EventService {
	
	@Autowired
	private EventDAO eventDAO;
	
	@Override
	public List<EventDTO> getEventList(int travel_seq) throws Exception {
		return eventDAO.getEventList(travel_seq);
	}

	@Override
	public boolean deleteEvent(int travel_seq) throws Exception {
		// TODO Auto-generated method stub
		return eventDAO.deleteEvent(travel_seq);
	}
    
	@Override
	public boolean addEvent(EventDTO eventDTO) throws Exception {
		// TODO Auto-generated method stub
		return eventDAO.addEvent(eventDTO);
	}

	
}
