package travelplanet.model;

/*
DROP TABLE EVENTS;

CREATE TABLE EVENTS(	
	EVENT_SEQ NUMBER(20) PRIMARY KEY,
	TRAVEL_SEQ NUMBER(20),
	TYPE NUMBER(1),
	TITLE VARCHAR(200) NOT NULL,	
	START_TIME DATE NOT NULL,
	END_TIME DATE NOT NULL,
	LAT NUMBER(28,20),
	LNG NUMBER(28,20),
	WDATE DATE NOT NULL
);

ALTER TABLE EVENTS
ADD CONSTRAINT FK_TRAVEL_SEQ FOREIGN KEY(TRAVEL_SEQ)
REFERENCES TRAVELS(TRAVEL_SEQ);

CREATE SEQUENCE SEQ_EVENTS
START WITH 1 INCREMENT BY 1;

SELECT * FROM EVENTS;

*/

public class EventDTO {
	private int event_seq; 		// 일정 고유번호
	private int travel_seq; 	// 여행 고유번호(외래키)	
	private String title;		// 일정 제목	
	private String start_time; 	// 일정시작시간 (yyyyMMddHHmm)
	private String end_time; 	// 일정종료시간
	private double lat; 		// 위도
	private double lng; 		// 경도
	private String wdate; 		// 작성일	

	public EventDTO() {

	}

	public int getEvent_seq() {
		return event_seq;
	}

	public void setEvent_seq(int event_seq) {
		this.event_seq = event_seq;
	}

	public int getTravel_seq() {
		return travel_seq;
	}

	public void setTravel_seq(int travel_seq) {
		this.travel_seq = travel_seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	
	
}
