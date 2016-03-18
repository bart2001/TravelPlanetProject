package travelplanet.model;

/*
DROP TABLE MEMBERS_AND_TRAVELS;

CREATE TABLE MEMBERS_AND_TRAVELS (
	ID VARCHAR(30) ,
	TRAVEL_SEQ NUMBER(20),
	WAUTH NUMBER(1)
);

ALTER TABLE MEMBERS_AND_TRAVELS
ADD CONSTRAINT FK_MEMBERS_AND_TRAVELS_ID FOREIGN KEY(ID)
REFERENCES MEMBERS(ID); 

ALTER TABLE MEMBERS_AND_TRAVELS
ADD CONSTRAINT FK_MEMBERS_AND_TRAVELS_SEQ FOREIGN KEY(TRAVEL_SEQ)
REFERENCES TRAVELS(TRAVEL_SEQ); 

SELECT * FROM MEMBERS_AND_TRAVELS;
*/

public class MemberAndTravelDTO {

	private String id;
	private int travel_seq;
	private int wauth;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getTravel_seq() {
		return travel_seq;
	}

	public void setTravel_seq(int travel_seq) {
		this.travel_seq = travel_seq;
	}

	public int getWauth() {
		return wauth;
	}

	public void setWauth(int wauth) {
		this.wauth = wauth;
	};
	
	
	
	
}
