package travelplanet.model;

public class TravelAnswerDTO {

/*
DROP TABLE TRAVEL_ANSWERS;

CREATE TABLE TRAVEL_ANSWERS(
	TRAVEL_ANSWER_SEQ NUMBER(20) PRIMARY KEY,
	TRAVEL_SEQ NUMBER(20),
	ID VARCHAR(30) NOT NULL,
	CONTENT VARCHAR(4000) NOT NULL,
	WDATE DATE NOT NULL,
	EDATE DATE NOT NULL,
	DEL NUMBER(1) NOT NULL
);

ALTER TABLE TRAVEL_ANSWERS
ADD CONSTRAINT FK_TRAVEL_ANSWERS_TRAVEL_SEQ FOREIGN KEY(TRAVEL_SEQ)
REFERENCES TRAVELS(TRAVEL_SEQ);

CREATE SEQUENCE SEQ_TRAVEL_ANSWERS
START WITH 1 INCREMENT BY 1;

SELECT * FROM TRAVEL_ANSWERS;

*/
	
	
	
	
	private int travel_answer_seq;		//여행댓글고유번호
	private int travel_seq;				//여행고유번호
	private String id;					//사용자아이디
	private String content;				//내용
	private String wdate;				//최초작성일
	private String edate;				//최중수정일
	private int del;					//삭제여부(0,1)
	
	
	public TravelAnswerDTO(){
		
	}
	
	
	public int getTravel_answer_seq() {
		return travel_answer_seq;
	}
	public void setTravel_answer_seq(int travel_answer_seq) {
		this.travel_answer_seq = travel_answer_seq;
	}
	public int getTravel_seq() {
		return travel_seq;
	}
	public void setTravel_seq(int travel_seq) {
		this.travel_seq = travel_seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}		 
	
	
	
}
