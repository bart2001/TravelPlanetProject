package travelplanet.service;

import java.util.Date;
import java.util.List;

import travelplanet.model.EventDTO;

public interface EventService {

	//<!--IEventService -->
	
//	public boolean deleteEvent(int seq);
//	public boolean addEvent(EventDTO eventDTO);
	
	// travel_seq에 해당하는 모든 eventlist 가져오기
	public List<EventDTO> getEventList(int travel_seq) throws Exception;
	//<!--IEventService -->
	public boolean deleteEvent(int travel_seq) throws Exception;
	public boolean addEvent(EventDTO eventDTO) throws Exception;

}
