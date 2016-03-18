package travelplanet.model;

import org.springframework.web.multipart.MultipartFile;

/*
DROP TABLE MEMBERS;

CREATE TABLE MEMBERS(

	ID VARCHAR2(30) primary key,
	PWD VARCHAR2(30) NOT NULL,
	EMAIL VARCHAR2(30) NOT NULL,
	BIRTH NUMBER(4) NOT NULL,
	SEX NUMBER(1) NOT NULL,
	AUTH NUMBER(1) NOT NULL,
	IMG VARCHAR2(200) 
);

SELECT * FROM MEMBERS;

*/

public class MemberDTO {

	private String id;		//사용자ID
	private String pwd;		//비밀번호
	private String email;	//사용자이름
	private int birth;		//출생연도
	private int sex;		//성별
	private int auth;		//관리자여부
	private String img;		//사용자사진
	
	public MemberDTO(){
		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getBirth() {
		return birth;
	}

	public void setBirth(int birth) {
		this.birth = birth;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	
}
