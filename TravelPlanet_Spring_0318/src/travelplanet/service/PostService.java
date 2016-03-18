package travelplanet.service;

import java.util.List;
import java.util.Map;

import travelplanet.model.PostAnswerDTO;
import travelplanet.model.PostDTO;
import travelplanet.model.PostLikeDTO;

public interface PostService {
	public boolean writePost(PostDTO postDTO) throws Exception;
	public boolean updatePost(PostDTO postDTO)throws Exception;
	public boolean updatePostDelete(int seq) throws Exception;
	public PostDTO getPost(int seq)throws Exception; 
	public List<PostDTO> getPostList() throws Exception;
	public List<PostDTO> getPostListbyId(String ID) throws Exception;
	
	public List<PostDTO> searchPostListbyId(String id) throws Exception;
	public List<PostDTO> searchPostListbyContent(String id) throws Exception;
	public List<PostDTO> searchPostListbyTitle(String id) throws Exception;

	public boolean writeAnswer(PostAnswerDTO postAnswerDTO)throws Exception;
	public List<PostAnswerDTO> getAnswerList(int seq)throws Exception; 
	public boolean updateAnswer(PostAnswerDTO postAnswerDTO)throws Exception; 
	public boolean updatePostAnswerDelete(int post_answer_seq) throws Exception; 
	
	public List<Map<Object, Object>> getPostAnswerCounMapList()throws Exception;
	public List<Map<Object, Object>> getPostLikeCounMapList()throws Exception;
	
	// 좋아요 추가 메소드
	public boolean addPostLike(PostLikeDTO postLikeDTO)throws Exception;
	
	// 좋아요 삭제 메소드
	public boolean deletePostLike(PostLikeDTO postLikeDTO)throws Exception;
	
	// 본인이 좋아요 누른 게시물 번호 목록 가져오기
	public List<Integer> getPostLikeListByID(String id) throws Exception;
	
	// 좋아요 삭제 메소드(회원탈퇴시)
	public boolean deletePostLikebyId(String id) throws Exception;
	
	// 댓글 삭제 메소드(회원탈퇴시)
	public boolean deletePostAnswerbyId(String id) throws Exception;
	
	// 포스트 삭제 메소드(회원탈퇴시)
	public boolean deletePostbyId(String id) throws Exception;
	
	
	public boolean deleteMember(String id) throws Exception;
	
	public boolean getPostSeqbyID(String id) throws Exception;
	
	public boolean deletePostAnswerbyPostSeq(int post_seq) throws Exception;
	
	public boolean deletePostLikebyPostSeq(int post_seq) throws Exception;
	
	// 좋아요 누른사람 알기
	public List<String> getPostLikeIdBySeq(int seq) throws Exception;
	
	public List<Integer> getPostSeqListbyID(String id) throws Exception;
	
	public List<Map<Object, Object>> getPostAnswerCountAndId()throws Exception;
	
	public int getLastPostSeq() throws Exception;
	
}
