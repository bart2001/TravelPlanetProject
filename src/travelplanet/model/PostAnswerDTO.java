package travelplanet.model;

/*
DROP TABLE POST_ANSWERS;

CREATE TABLE POST_ANSWERS (
	POST_ANSWER_SEQ NUMBER(20) PRIMARY KEY,
	POST_SEQ NUMBER(20),	
	ID VARCHAR(30),
	CONTENT VARCHAR(4000) NOT NULL,
	WDATE DATE NOT NULL,
	EDATE DATE NOT NULL,
	DEL NUMBER(1) NOT NULL
);

ALTER TABLE POST_ANSWERS
ADD CONSTRAINT FK_POST_ANSWERS_ID FOREIGN KEY(ID)
REFERENCES MEMBERS(ID); 

ALTER TABLE POST_ANSWERS
ADD CONSTRAINT FK_POST_ANSWERS_POST_SEQ FOREIGN KEY(POST_SEQ)
REFERENCES POSTS(POST_SEQ);

CREATE SEQUENCE SEQ_POST_ANSWERS
START WITH 1 INCREMENT BY 1;

SELECT * FROM POST_ANSWERS;
*/

public class PostAnswerDTO {

	private int post_answer_seq;	//	포스트댓글 번호
	private int post_seq;			//	포스트번호
	private String id;				//	작성사 id
	private String content;			//	내용
	private String wdate;			//	최초작성일
	private String edate;			//	최종수정일
	private int del;				//	삭제여부
	
	public PostAnswerDTO(){
	}

	public int getPost_answer_seq() {
		return post_answer_seq;
	}

	public void setPost_answer_seq(int post_answer_seq) {
		this.post_answer_seq = post_answer_seq;
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
