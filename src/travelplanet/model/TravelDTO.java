package travelplanet.model;

/*
DROP TABLE TRAVELS;

CREATE TABLE TRAVELS(
	TRAVEL_SEQ NUMBER(20) PRIMARY KEY,	
	TITLE VARCHAR2(200) NOT NULL,
	CONTENT VARCHAR(4000),
	OPEN NUMBER(1) NOT NULL,
	DONE NUMBER(1) NOT NULL,
	MEMBERS NUMBER(5) NOT NULL,
	REGION VARCHAR(100) NOT NULL,
	WDATE DATE NOT NULL,
	EDATE DATE NOT NULL,
	BUDGET NUMBER(28),
	DEL NUMBER(1) NOT NULL,	
	CUSTOMIZED NUMBER(1) NOT NULL	-- 삭제여부: 삭제안함(0), 삭제함(1)
);

CREATE SEQUENCE SEQ_TRAVELS
START WITH 1 INCREMENT BY 1;

SELECT * FROM TRAVELS;
*/

public class TravelDTO {

	private int travel_seq;	// 여행 고유번호
	private String title;	// 여행이름
	private String content;	// 여행간략설명
	private int open;	// 공개(0)/비공개(1) 
	private int done;	// 여행전(0)/여행후(1)
	private int members;	// 여행인원수
	private String region;	// 여행지역
	private String wdate;	// 최초작성일
	private String edate;	// 최종수정일
	private double budget;	// 여행예산
	private int del;	// 삭제여부: 현존(0)/삭제(1)
	private int customized; //커스터마이징 여부 : 원글(0)/복사(1)
	
	public TravelDTO(){
		
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getOpen() {
		return open;
	}

	public void setOpen(int open) {
		this.open = open;
	}

	public int getDone() {
		return done;
	}

	public void setDone(int done) {
		this.done = done;
	}

	public int getMembers() {
		return members;
	}

	public void setMembers(int members) {
		this.members = members;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
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

	public double getBudget() {
		return budget;
	}

	public void setBudget(double budget) {
		this.budget = budget;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public int getCustomized() {
		return customized;
	}

	public void setCustomized(int customized) {
		this.customized = customized;
	}

}
