package travelplanet.model;

/*

DROP TABLE POSTS;

CREATE TABLE POSTS(
	POST_SEQ NUMBER(20) PRIMARY KEY,
	ID VARCHAR(30),
	TITLE VARCHAR(200) NOT NULL,
	CONTENT BLOB
	WDATE DATE NOT NULL,
	EDATE DATE NOT NULL,
	BUDGET NUMBER(38), 
	DEL NUMBER(1) NOT NULL
);

ALTER TABLE POSTS
ADD CONSTRAINT FK_POSTS_ID FOREIGN KEY(ID)
REFERENCES MEMBERS(ID);

CREATE SEQUENCE SEQ_POSTS
START WITH 1 INCREMENT BY 1;

SELECT * FROM POSTS;

*/

public class PostDTO {

	private int post_seq;		//	포스트 번호
	private String id;			//	작성자 id
	private String title;		//	포스트 제목
	private String content;		//	포스트 내용
	private String wdate;		//	최초장성일
	private String edate;		//	최종수정일
	private int budget;			//	예산
	private int del;			//	삭제여부(0,1)
	
	public PostDTO(){
		
	}

	public int getPost_seq() {
		return post_seq;
	}

	public void setPost_seq(int post_seq) {
		this.post_seq = post_seq;
	}

	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
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


	public int getBudget() {
		return budget;
	}


	public void setBudget(int budget) {
		this.budget = budget;
	}


	public int getDel() {
		return del;
	}


	public void setDel(int del) {
		this.del = del;
	}	
}
