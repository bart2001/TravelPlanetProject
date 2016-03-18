package travelplanet.model;

/*
DROP TABLE TRAVEL_LIKES;

CREATE TABLE TRAVEL_LIKES(
	TRAVEL_SEQ NUMBER(20),
	ID VARCHAR(30)
);

ALTER TABLE TRAVEL_LIKES
ADD CONSTRAINT FK_TRAVELS_LIKES_TRAVEL_SEQ FOREIGN KEY(TRAVEL_SEQ)
REFERENCES TRAVELS(TRAVEL_SEQ);

ALTER TABLE TRAVEL_LIKES
ADD CONSTRAINT FK_TRAVELS_LIKES_ID FOREIGN KEY(ID)
REFERENCES MEMBERS(ID);

SELECT * FROM TRAVEL_LIKES;
*/

public class TravelLikeDTO {

	private int travel_seq;		//여행고유번호
	private String id;			//사용자ID
	
	public TravelLikeDTO(){}

	public int getTravels_seq() {
		return travel_seq;
	}

	public void setTravels_seq(int travel_seq) {
		this.travel_seq = travel_seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	

}
