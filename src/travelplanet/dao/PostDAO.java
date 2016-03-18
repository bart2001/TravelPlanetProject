package travelplanet.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import travelplanet.model.PostAnswerDTO;
import travelplanet.model.PostDTO;
import travelplanet.model.PostLikeDTO;

@Repository
public class PostDAO {

	@Autowired
	private SqlSession sqlSession;	
	private String nameSpace = "Post.";

	@SuppressWarnings("unchecked")
	public boolean writePost(PostDTO postDTO) throws Exception{   
	      sqlSession.insert(nameSpace + "writePost", postDTO);      
	      return true;
	   } 
	
	@SuppressWarnings("unchecked")
	public List<PostDTO> getPostList() throws Exception {		
		List<PostDTO> postDTOlist = null;		
		postDTOlist = (List<PostDTO>) sqlSession.selectList(nameSpace + "getPostList");		
		return postDTOlist;
	}	
	
	@SuppressWarnings("unchecked")
	public List<Integer> getPostLikeListByID(String id) throws Exception {		
		List<Integer> postDTOlist = null;		
		postDTOlist = (List<Integer>) sqlSession.selectList(nameSpace + "getPostLikeListByID", id);		
		return postDTOlist;
	}
	
	@SuppressWarnings("unchecked")
	public List<PostDTO> searchPostListbyId(String id) throws Exception {		
		List<PostDTO> postDTOlist = null;		
		postDTOlist = (List<PostDTO>) sqlSession.selectList(nameSpace + "searchPostListbyId", id);		
		return postDTOlist;
	}
	
	@SuppressWarnings("unchecked")
	public List<PostDTO> searchPostListbyContent(String id) throws Exception {		
		List<PostDTO> postDTOlist = null;		
		postDTOlist = (List<PostDTO>) sqlSession.selectList(nameSpace + "searchPostListbyContent", id);		
		return postDTOlist;
	}
	
	@SuppressWarnings("unchecked")
	public List<PostDTO> searchPostListbyTitle(String id) throws Exception {		
		List<PostDTO> postDTOlist = null;		
		postDTOlist = (List<PostDTO>) sqlSession.selectList(nameSpace + "searchPostListbyTitle", id);		
		return postDTOlist;
	}
	
	@SuppressWarnings("unchecked")
	public List<PostDTO> getPostListbyId(String id) throws Exception {		
		List<PostDTO> postDTOlist = null;		
		postDTOlist = (List<PostDTO>) sqlSession.selectList(nameSpace + "getPostListbyId", id);		
		return postDTOlist;
	}

	@SuppressWarnings("unchecked")
	public List<Map<Object, Object>> getPostAnswerCounMapList() throws Exception {
		List<Map<Object, Object>> postLikeCountMapList = null;
		postLikeCountMapList = sqlSession.selectList(nameSpace + "getPostAnswerCounMapList");	
		return postLikeCountMapList;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<Object, Object>> getPostLikeCounMapList() throws Exception {
		List<Map<Object, Object>> postLikeCountMapList = null;
		postLikeCountMapList = sqlSession.selectList(nameSpace + "getPostLikeCounMapList");
		return postLikeCountMapList;
	}	
			
	public PostDTO getPost(int seq) throws Exception {
		PostDTO post = null;
		post = (PostDTO) sqlSession.selectOne(nameSpace + "getPost" , seq); 
		return post;
	}
		
	@SuppressWarnings("unchecked")
	public List<PostAnswerDTO> getAnswerList(int seq) throws Exception {
		List<PostAnswerDTO> answerlist = null;
		answerlist = sqlSession.selectList(nameSpace + "getAnswerList", seq);
		return answerlist;
	}
		
	public boolean updatePost(PostDTO postDTO) throws Exception {
		 sqlSession.update(nameSpace + "updatePost", postDTO);      
	     return true;
	} 
		
	
	public boolean updatePostDelete(int seq) throws Exception {
		 sqlSession.update(nameSpace + "updatePostDelete", seq);      
	     return true;
	} 
	
	
	public boolean writeAnswer(PostAnswerDTO postAnswerDTO) throws Exception {
		 sqlSession.insert(nameSpace + "writeAnswer", postAnswerDTO);      
	     return true;
	} 	
	
	
	public boolean updateAnswer(PostAnswerDTO postAnswerDTO) throws Exception {
		 sqlSession.update(nameSpace + "updateAnswer", postAnswerDTO);      
	     return true;
	} 	
	
	
	public boolean updatePostAnswerDelete(int post_answer_seq) throws Exception {
		 sqlSession.update(nameSpace + "updatePostAnswerDelete", post_answer_seq);      
	     return true;
	} 	
	
	
	public boolean addPostLike(PostLikeDTO postLikeDTO) throws Exception {
		 sqlSession.insert(nameSpace + "addPostLike", postLikeDTO);      
	     return true;
	} 	

	
	public boolean deletePostLike(PostLikeDTO postLikeDTO) throws Exception {
		 sqlSession.delete(nameSpace + "deletePostLike", postLikeDTO);      
	     return true;
	} 
	
	
	public boolean deletePostLikebyId(String id) throws Exception {
		sqlSession.delete(nameSpace + "deletePostLikebyId", id);
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public boolean deletePostAnswerbyId(String id) throws Exception {
		sqlSession.delete(nameSpace + "deletePostAnswerbyId", id);
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public boolean deletePostbyId(String id) throws Exception {
		sqlSession.delete(nameSpace + "deletePostbyId", id);
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public boolean getPostSeqbyID(String id) throws Exception {
		sqlSession.delete(nameSpace + "getPostSeqbyID", id);
		return true;
	}

	public boolean deletePostAnswerbyPostSeq(int post_seq) throws Exception {			
		sqlSession.delete(nameSpace + "deletePostAnswerbyPostSeq", post_seq);		
		return true;
	}	

	public boolean deleteMember(String id) throws Exception {			
		sqlSession.delete(nameSpace + "deleteMember",id);		
		return true;
	}
	
	public boolean deletePostLikebyPostSeq(int post_seq) throws Exception {		
		sqlSession.delete(nameSpace + "deletePostLikebyPostSeq", post_seq);		
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public List<String> getPostLikeIdBySeq(int seq) throws Exception {
		List<String> likeList = null;
		likeList = sqlSession.selectList(nameSpace + "getPostLikeIdBySeq",seq);
		return likeList;
	}	
	
	@SuppressWarnings("unchecked")
	public List<Integer> getPostSeqListbyID(String id) throws Exception {
		List<Integer> postSeqList = null;
		postSeqList = sqlSession.selectList(nameSpace + "getPostSeqListbyID", id);
		return postSeqList;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<Object, Object>> getPostAnswerCountAndId() throws Exception {
		List<Map<Object, Object>> postCountMapList = null;
		postCountMapList = sqlSession.selectList(nameSpace + "getPostAnswerCountAndId");	
		return postCountMapList;
	}
	
	public int getLastPostSeq() {
		int lastPostSeq = 0;
		lastPostSeq = Integer.parseInt(sqlSession.selectOne(nameSpace + "getLastPostSeq").toString());
		return lastPostSeq;
	}
}
