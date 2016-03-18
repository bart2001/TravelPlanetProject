package travelplanet.controller;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import travelplanet.model.MemberDTO;
import travelplanet.model.PostAnswerDTO;
import travelplanet.model.PostDTO;
import travelplanet.model.PostLikeDTO;
import travelplanet.service.MemberService;
import travelplanet.service.PostService;

@Controller
public class PostController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private PostService postService;

	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "newsfeed.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String newsfeed(Model model, String options, String query, HttpSession session) throws Exception {
		logger.info("Welcome PostController newsfeed.do! " + new Date());

		// -------------------NewsfeedController 시작-------------------------
		List<PostDTO> postList = null;
		postList = postService.getPostList();
		System.out.println("newsfeed.do getPostList.size() = " + postList.size());

		// map 준비
		List<Map<Object, Object>> postLikeCountMapList = null;
		List<Map<Object, Object>> postAnswerCountMapList = null;
		postLikeCountMapList = postService.getPostLikeCounMapList();
		postAnswerCountMapList = postService.getPostAnswerCounMapList();

		MemberDTO memberDTO = null;

		// 로그인 했을 경우에만 좋아요 누른 포스트 번호 목록 가져오기
		if (session.getAttribute("login") != null) {
			// 로그인한 회원이 좋아요를 누른 포스트 번호 목록 가져오기
			List<Integer> postLikeList = null;
			memberDTO = (MemberDTO) session.getAttribute("login");
			String id = memberDTO.getId();
			postLikeList = postService.getPostLikeListByID(id);
			System.out.println("newsfeed.do postLikeList.size() = " + postLikeList.size());
			model.addAttribute("postLikeList", postLikeList);
			System.out.println("newsfeed.do loginLikeList.size() = " + postLikeList.size());
		}

		model.addAttribute("postLikeCountMapList", postLikeCountMapList);
		model.addAttribute("postAnswerCountMapList", postAnswerCountMapList);
		System.out.println("newsfeed.do postLikeCountMapList size = " + postLikeCountMapList.size());
		System.out.println("newsfeed.do postAnswerCountMapList size = " + postAnswerCountMapList.size());

		// 검색조건과 검색어가 들어왔을때
		String soptions = "";
		if (options != null && !options.equals("")) {
			soptions = options;
		}
		String squery = "";
		if (query != null && !query.equals("")) {
			squery = query;
		}

		System.out.println("newsfeed.do soptions= " + soptions);
		System.out.println("newsfeed.do squery= " + squery);

		if (soptions.equals("0")) {
			System.out.println("0입니다");
			postList = postService.searchPostListbyId(squery);
		} else if (soptions.equals("1")) {
			postList = postService.searchPostListbyTitle(squery);
		} else if (soptions.equals("2")) {
			postList = postService.searchPostListbyContent(squery);
		}

		model.addAttribute("postList", postList);
		System.out.println("newsfeed.do plist.size = " + postList.size());

		// 이미지를 뿌릴 memberList 가져오기
		List<MemberDTO> memberList = null;
		memberList = memberService.getMemberList();
		System.out.println("newsfeed.do memberList.size() = " + memberList.size());
		model.addAttribute("memberList", memberList);
		
		return "newsfeed/newsfeed";
	}
	// -------------------NewsfeedController 끝-------------------------

	// -------------------PostWriteController 시작-------------------------
	@RequestMapping(value = "postwrite.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String postwrite(Model model, HttpServletRequest request, HttpServletResponse response, String title,
			String content, String budget, HttpSession session) throws Exception {
		logger.info("Welcome PostController postwrite.do! " + new Date());

		MemberDTO memberDTO = null;

		System.out.println("postwrite.do title = " + title);
		System.out.println("postwrite.do content = " + content);
		System.out.println("postwrite.do budget = " + budget);

		memberDTO = (MemberDTO) session.getAttribute("login");
		String id = memberDTO.getId();

		int ibudget = 0;
		if (budget != null && !budget.equals("")) {
			ibudget = Integer.parseInt(budget);
		}

		PostDTO post = new PostDTO();
		post.setId(id);
		post.setTitle(title);
		post.setContent(content);
		post.setBudget(ibudget);
		System.out.println("budget" + budget);

		boolean isS = postService.writePost(post);

		int seq = postService.getLastPostSeq();
		
		if (isS) {
			System.out.println("포스트작성 성공");
		} else {
			System.out.println("포스트작성 실패");
		}
		return "redirect:/postdetail.do?post_seq="+seq; // url을 위에 띄워야 할겅우
	}
	// -------------------PostWriteController 끝-------------------------

	// -------------------PostDetailController 시작-------------------------
	@RequestMapping(value = "postdetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String postdetail(Model model, int post_seq, HttpSession session) throws Exception {
		logger.info("Welcome PostController postdetail.do! " + new Date());

		PostDTO post = null;
		post = postService.getPost(post_seq);

		List<PostAnswerDTO> postAnswerList = null;
		postAnswerList = postService.getAnswerList(post_seq);

		model.addAttribute("post", post);
		model.addAttribute("postAnswerList", postAnswerList);

		List<MemberDTO> memberList = null;
		memberList = memberService.getMemberList();
		model.addAttribute("memberList", memberList);
		
		// map 준비

		List<Map<Object, Object>> postLikeCountMapList = null;
		postLikeCountMapList = postService.getPostLikeCounMapList();
		model.addAttribute("postLikeCountMapList", postLikeCountMapList);
		
		// 로그인 되었을 경우 자기가 좋아요 누른 게시물 리스트 가져오기
		if (session.getAttribute("login") != null) {		
			MemberDTO memberDTO = null;
			memberDTO = (MemberDTO) session.getAttribute("login");
			String id = memberDTO.getId();
			List<Integer> postLikeList = null;
			postLikeList = postService.getPostLikeListByID(id);			
			System.out.println("postdeatil.do postLikeList.size() = " + postLikeList.size());
			model.addAttribute("postLikeList", postLikeList);
		}

		if (post != null) {
			System.out.println("상세 불러오기 성공");
			return "newsfeed/postdetail";
		} else {
			System.out.println("상세 불러오기 실패");
		}
		return "newsfeed/newsfeed";
	}
	// -------------------PostDetailController 끝-------------------------

	// -------------------PostUpdateController 시작-------------------------
	@RequestMapping(value = "postupdate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void postupdate(HttpServletResponse response, int post_seq, String title, String content, String budget,
			HttpSession session) throws Exception {

		logger.info("Welcome PostController postupdate.do! " + new Date());

		System.out.println("postupdate.do 수정중 post_seq" + post_seq);

		
		
		System.out.println("postupdate.do budget = " + budget);

		int ibudget = 0;
		if (budget != null && !budget.equals("")) {
			ibudget = Integer.parseInt(budget);
		}		
		
		PostDTO post = new PostDTO();
		post.setTitle(title);
		post.setContent(content);
		post.setPost_seq(post_seq);
		post.setBudget(ibudget);

		System.out.println("postupdate.do title = " + title);
		System.out.println("postupdate.do content = " + content);
		System.out.println("postupdate.do post_seq = " + post_seq);
		System.out.println("postupdate.do  budget" + budget);

		boolean isS = postService.updatePost(post);
		System.out.println("postupdate.do isS = " + isS);

		if (isS) {
			System.out.println("포스트수정 성공");
			response.sendRedirect("postdetail.do?post_seq=" + post_seq);
		} else {
			System.out.println("포스트수정 실패");
			response.sendRedirect("postdetail.do?post_seq=" + post_seq);
		}

	}
	// -------------------PostUpdateController 끝-------------------------

	// -------------------PostDeleteController 시작-------------------------
	@RequestMapping(value = "postdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void postdelete(Model model, HttpServletRequest request, HttpServletResponse response, int post_seq,
			HttpSession session) throws Exception {
		logger.info("Welcome PostController postdelete.do! " + new Date());

		boolean isS = postService.updatePostDelete(post_seq);

		String url = request.getHeader("referer");
		System.out.println("postdelete.do request.getHeader referer = " + url);

		if (isS) {
			/*
			 * dispatcher = request.getRequestDispatcher("newsfeed.do");
			 * dispatcher.forward(request, response);
			 */
			System.out.println("포스트 삭제성공");

			if (url.contains("postdetail.do")) {
				// response.sendRedirect("newsfeed.do");
				response.sendRedirect("newsfeed.do");
			} else {
				response.sendRedirect(url);
				// response.sendRedirect(url);
			}

		} else {
			System.out.println("포스트삭제 실패");
			// response.sendRedirect("main.do");
			response.sendRedirect("main.do");
		}
	}
	// -------------------PostDeleteController 끝-------------------------

	// -------------------PostAnswerWriteController 시작-------------------------
	@RequestMapping(value = "postanswerwrite.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String postanswerwrite(Model model, HttpServletRequest request, int post_seq, String id, String content,
			HttpSession session) throws Exception {
		logger.info("Welcome PostController postanswerwrite.do! " + new Date());

		System.out.println("post_seq : " + post_seq + " id : " + id + " content : " + content);

		PostAnswerDTO answer = new PostAnswerDTO();
		answer.setPost_seq(post_seq);
		answer.setId(id);
		answer.setContent(content);

		List<PostAnswerDTO> answerlist = null;
		answerlist = postService.getAnswerList(post_seq);

		boolean isS = postService.writeAnswer(answer);
		PostDTO post = null;
		post = postService.getPost(post_seq);

		model.addAttribute("post", post);
		model.addAttribute("answer", answerlist);

		// String url = request.getHeader("referer");
		// System.out.println("postanswerwrite.do request.getHeader referer = "
		// + url);

		if (isS) {
			System.out.println("댓글작성 성공");
			return "redirect:/postdetail.do?post_seq=" + post_seq;
			// dispatcher = request.getRequestDispatcher("postdetail.do");
			// dispatcher = request.getRequestDispatcher("newsfeed.do");
			// dispatcher.forward(request, response);
		} else {
			System.out.println("댓글작성 실패");
			// dispatcher = request.getRequestDispatcher("postdetail.do");
			return "redirect:/postdetail.do?post_seq=" + post_seq;
			// dispatcher = request.getRequestDispatcher("newsfeed.do");
			// dispatcher.forward(request, response);
		}
	}
	// -------------------PostAnswerWriteController 끝-------------------------

	// -------------------PostAnswerUpdateController 시작-------------------------
	@RequestMapping(value = "postanswerupdate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String postanswerupdate(Model model, HttpServletRequest request, int post_answer_seq, int post_seq,
			String content, HttpSession session) throws Exception {
		logger.info("Welcome PostController postanswerupdate.do! " + new Date());

		System.out.println("post_answer_seq" + post_answer_seq + "post_seq" + post_seq + "content" + content);

		PostAnswerDTO answer = new PostAnswerDTO();
		answer.setPost_answer_seq(post_answer_seq);
		answer.setContent(content);

		boolean isS = postService.updateAnswer(answer);

		PostDTO post = null;
		post = postService.getPost(post_seq);

		model.addAttribute("post", post);

		if (isS) {
			System.out.println("댓굴수정 성공");
			return "redirect:/postdetail.do?post_seq=" + post_seq;
		} else {
			System.out.println("댓글수정 실패");
			return "redirect:/postdetail.do?post_seq=" + post_seq;
		}
	}
	// -------------------PostAnswerUpdateController 끝-------------------------

	// -------------------PostAnswerDeleteController 시작-------------------------
	@RequestMapping(value = "postanswerdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String postanswerdelete(Model model, HttpServletRequest request, int post_answer_seq, int post_seq,
			HttpSession session) throws Exception {
		logger.info("Welcome PostController postanswerdelete.do! " + new Date());

		boolean isS = postService.updatePostAnswerDelete(post_answer_seq);

		if (isS) {
			System.out.println("댓굴삭제 성공");
			return "redirect:/postdetail.do?post_seq=" + post_seq;
		} else {
			System.out.println("댓글삭제 실패");
			return "redirect:/postdetail.do?post_seq=" + post_seq;
		}
	}
	// -------------------PostAnswerDeleteController 끝-------------------------

	// -------------------PostLikeDownController 시작-------------------------
	@RequestMapping(value = "postlikedown.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void postlikedown(Model model, HttpServletRequest request, HttpServletResponse response, int post_seq,
			HttpSession session) throws Exception {
		logger.info("Welcome PostController postlikedown.do! " + new Date());

		MemberDTO memberDTO = (MemberDTO) session.getAttribute("login");
		String id = memberDTO.getId();

		System.out.println("PostLikeDeleteController postlikedelete.do id = " + id);
		System.out.println("PostLikeDeleteController postlikedelete.do post_seq = " + post_seq);

		PostLikeDTO postLikeDTO = new PostLikeDTO();
		postLikeDTO.setId(id);
		postLikeDTO.setPost_seq(post_seq);

		System.out.println("postLikeDTO " + postLikeDTO);
		// 좋아요 1 감소
		boolean isS = postService.deletePostLike(postLikeDTO);
		
		String url = "";
		url = request.getHeader("referer");
					
		// postdetail 내에서 좋아요 감소시키는 경우 -> postdetail로 돌아가야함
		if (url.contains("postdetail")) {
			response.sendRedirect("postdetail.do?post_seq=" + post_seq);
		
		// postdetail 밖에서 좋아요 감소시키는 경우 -> ajax이기 때문에 성공/실패 여부만 알려주기
		} else {
			if (isS) {
				response.getWriter().print(1);
			} else {
				response.getWriter().print(2);
			}
		}
		
		
	}
	// -------------------PostLikeDownController 끝-------------------------

	// -------------------PostLikeUpController 시작-------------------------
	@RequestMapping(value = "postlikeup.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void postlikeup(Model model, HttpServletRequest request, HttpServletResponse response, int post_seq,
			HttpSession session) throws Exception {
		logger.info("Welcome PostController postlikeup.do! " + new Date());

		MemberDTO memberDTO = null;
		memberDTO = (MemberDTO) session.getAttribute("login");
		String id = memberDTO.getId();

		// int post_seq = Integer.parseInt(request.getParameter("post_seq"));

		System.out.println("PostLikeAddController postlikeadd.do id = " + id);
		System.out.println("PostLikeAddController postlikeadd.do post_seq = " + post_seq);

		PostLikeDTO postLikeDTO = new PostLikeDTO();
		postLikeDTO.setId(id);
		postLikeDTO.setPost_seq(post_seq);

		System.out.println("postLikeDTO " + postLikeDTO);

		// 좋아요 1 증가
		boolean isS = postService.addPostLike(postLikeDTO);
		System.out.println("isS " + isS);
		
		String url = "";
		url = request.getHeader("referer");
					
		// postdetail 내에서 좋아요 감소시키는 경우 -> postdetail로 돌아가야함
		if (url.contains("postdetail")) {
			response.sendRedirect("postdetail.do?post_seq=" + post_seq);
		
			// postdetail 밖에서 좋아요 감소시키는 경우 -> ajax이기 때문에 성공/실패 여부만 알려주기
		} else {
			if (isS) {
				response.getWriter().print(1);
			} else {
				response.getWriter().print(2);
			}		
		}

		
	}
	// -------------------PostLikeUpController 끝-------------------------

	@RequestMapping(value = "postlikelist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void postlikelist(Model model, HttpServletRequest request, HttpServletResponse response, int post_seq,
			HttpSession session) throws Exception {
		logger.info("Welcome PostController postlikelost.do! " + new Date());
		
		List<String> likeList = null;
		likeList = postService.getPostLikeIdBySeq(post_seq);
		
		String arr = "";
		System.out.println("like 수: "+likeList.size());
		for(int i=0; i<likeList.size();i++){
			arr += (likeList.get(i))+",";
		}
		
		
		System.out.println("arr "+arr);
		
		response.getWriter().print(arr);
	}
}
