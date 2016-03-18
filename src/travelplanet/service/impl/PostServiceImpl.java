package travelplanet.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import travelplanet.dao.PostDAO;
import travelplanet.model.PostAnswerDTO;
import travelplanet.model.PostDTO;
import travelplanet.model.PostLikeDTO;
import travelplanet.service.PostService;
@Service
public class PostServiceImpl implements PostService {

	@Autowired
	private PostDAO postDAO;
	
	@Override	
	public boolean writePost(PostDTO postDTO) throws Exception{
		return postDAO.writePost(postDTO);
	}
	
	@Override
	public List<PostDTO> getPostList() throws Exception {		
		return postDAO.getPostList();
	}
	
	@Override
	public List<Integer> getPostLikeListByID(String id) throws Exception {
		return postDAO.getPostLikeListByID(id);
	}
    
	@Override
	public List<PostDTO> searchPostListbyId(String id) throws Exception {
		return postDAO.searchPostListbyId(id);
	}
	
	@Override
	public List<PostDTO> searchPostListbyContent(String id) throws Exception {
		return postDAO.searchPostListbyContent(id);
	}
	
	@Override
	public List<PostDTO> searchPostListbyTitle(String id) throws Exception {
		return postDAO.searchPostListbyTitle(id);
	}
	
	@Override
	public List<PostDTO> getPostListbyId(String ID) throws Exception {
		return postDAO.getPostListbyId(ID);
	}
	
	@Override
	public List<Map<Object, Object>> getPostAnswerCounMapList() throws Exception {
		return postDAO.getPostAnswerCounMapList();
	}
	
	@Override
	public List<Map<Object, Object>> getPostLikeCounMapList() throws Exception {
		return postDAO.getPostLikeCounMapList();
	}
	
	@Override
	public PostDTO getPost(int seq) throws Exception {
		return postDAO.getPost(seq);
	}
	
	@Override
	public List<PostAnswerDTO> getAnswerList(int seq) throws Exception {
		return postDAO.getAnswerList(seq);
	}
	
	@Override
	public boolean updatePost(PostDTO postDTO) throws Exception {
		return postDAO.updatePost(postDTO);
	}
	
	@Override
	public boolean updatePostDelete(int seq) throws Exception {
		return postDAO.updatePostDelete(seq);
	}
	
	@Override
	public boolean writeAnswer(PostAnswerDTO postAnswerDTO) throws Exception {
		return postDAO.writeAnswer(postAnswerDTO);
	}
	
	@Override
	public boolean updateAnswer(PostAnswerDTO postAnswerDTO) throws Exception {
		return postDAO.updateAnswer(postAnswerDTO);
	}
	
	@Override
	public boolean updatePostAnswerDelete(int post_answer_seq) throws Exception {
		return postDAO.updatePostAnswerDelete(post_answer_seq);
	}
	
	@Override
	public boolean addPostLike(PostLikeDTO postLikeDTO) throws Exception {
		return postDAO.addPostLike(postLikeDTO);
	}
	
	@Override
	public boolean deletePostLike(PostLikeDTO postLikeDTO) throws Exception {
		return postDAO.deletePostLike(postLikeDTO);
	}
	
	@Override
	public boolean deletePostLikebyId(String id) throws Exception {
		return postDAO.deletePostLikebyId(id);
	}
	
	@Override
	public boolean deletePostAnswerbyId(String id) throws Exception {
		return postDAO.deletePostAnswerbyId(id);
	}
	
	@Override
	public boolean deletePostbyId(String id) throws Exception {
		return postDAO.deletePostbyId(id);
	}
	
	//public boolean getPostSeqbyID(String id) throws Exception;
	//	public List<Integer> deletePostAnswerbyPostSeq() throws Exception;
	
	//public List<Integer> deletePostLikebyPostSeq() throws Exception;

	@Override
	public boolean getPostSeqbyID(String id) throws Exception {
		return postDAO.getPostSeqbyID(id);
	}

	
	@Override
	public boolean deletePostAnswerbyPostSeq(int post_seq) throws Exception {
		return postDAO.deletePostAnswerbyPostSeq(post_seq);
	}
	
	@Override
	public boolean deleteMember(String id) throws Exception {
		return postDAO.deleteMember(id);
	}
	
	@Override
	public boolean deletePostLikebyPostSeq(int post_seq) throws Exception {
		return postDAO.deletePostLikebyPostSeq(post_seq);
	}	
	
	@Override
	public List<String> getPostLikeIdBySeq(int seq) throws Exception {
		return postDAO.getPostLikeIdBySeq(seq);
	}
	
	@Override
	public List<Integer> getPostSeqListbyID(String id) throws Exception { 
		return postDAO.getPostSeqListbyID(id);
	}
	
	@Override
	public List<Map<Object, Object>> getPostAnswerCountAndId() throws Exception {
		return postDAO.getPostAnswerCountAndId();
	}
	
	@Override
	public int getLastPostSeq() throws Exception {
		// TODO Auto-generated method stub
		return postDAO.getLastPostSeq();
	}

	
	
}
