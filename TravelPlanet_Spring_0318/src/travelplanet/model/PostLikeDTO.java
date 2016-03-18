package travelplanet.model;

/*
DROP TABLE POST_LIKES;

CREATE TABLE POST_LIKES (
	POST_SEQ NUMBER(20),
	ID VARCHAR(30)
);

ALTER TABLE POST_LIKES
ADD CONSTRAINT FK_POST_LIKES_POST_SEQ FOREIGN KEY(POST_SEQ)
REFERENCES POSTS(POST_SEQ);

ALTER TABLE POST_LIKES
ADD CONSTRAINT FK_POST_LIKES_ID FOREIGN KEY(ID)
REFERENCES MEMBERS(ID);

SELECT * FROM POST_LIKES;
 */

public class PostLikeDTO {
	private int post_seq;	//포스트 고유번호
	private String id;		//사용자ID

	public PostLikeDTO() {
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
}
