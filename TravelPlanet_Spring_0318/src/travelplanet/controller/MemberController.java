package travelplanet.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.jrockit.jfr.RequestableEvent;

import travelplanet.controller.MemberAndTravelController.SMTPAuthenticator;
import travelplanet.dao.MemberAndTravelDAO;
import travelplanet.dao.PostDAO;
import travelplanet.dao.TravelDAO;
import travelplanet.model.MemberAndTravelDTO;
import travelplanet.model.MemberDTO;
import travelplanet.model.PostDTO;
import travelplanet.model.TravelDTO;
import travelplanet.service.MemberAndTravelService;
import travelplanet.service.MemberService;
import travelplanet.service.PostService;
import travelplanet.service.TravelService;

@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	@Autowired
	private TravelService travelService;

	@Autowired
	private PostService postService;

	@Autowired
	private MemberAndTravelService memberAndTravelService;

	@RequestMapping(value = "main.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String main(Model model, String invite_seq, HttpServletRequest request) throws Exception {
		logger.info("Welcome MemberController main.do! " + new Date());

		// map 준비
		// travel 좋아요 갯수
		List<Map<Object, Object>> travelLikeCountMapList = null;
		// travel 댓글 갯수
		List<Map<Object, Object>> travelAnswerCountMapList = null;
		// post 좋아요 갯수
		List<Map<Object, Object>> postLikeCountMapList = null;
		// post 댓글 갯수
		List<Map<Object, Object>> postAnswerCountMapList = null;

		// 총 x명이
		int totalMemberCount = 0;
		// 총 x번의 여행을 떠났습니다
		int totalTravelCount = 0;

		List<TravelDTO> travelList = null;
		List<MemberAndTravelDTO> memberAndTravelList = null;
		List<PostDTO> postList = null;
		List<MemberDTO> memberList = null;
		
		postList = postService.getPostList();
		travelList = travelService.getTravelList();		
		memberAndTravelList = memberAndTravelService.getMemberAndTravelList();
		memberList = memberService.getMemberList();

		travelLikeCountMapList = travelService.getTravelLikeCountMapList();
		travelAnswerCountMapList = travelService.getTravelAnswerCountMapList();		
		postLikeCountMapList = postService.getPostLikeCounMapList();
		postAnswerCountMapList = postService.getPostAnswerCounMapList();

		totalMemberCount = memberService.getTotalMemberCount();
		totalTravelCount = travelService.getTotalTravelCount();

		request.setAttribute("totalMemberCount", totalMemberCount);
		request.setAttribute("totalTravelCount", totalTravelCount);
		
		request.setAttribute("travelList", travelList);
		request.setAttribute("postList", postList);
		request.setAttribute("memberAndTravelList", memberAndTravelList);
		request.setAttribute("memberList", memberList);

		request.setAttribute("travelLikeCountMapList", travelLikeCountMapList);
		request.setAttribute("travelAnswerCountMapList", travelAnswerCountMapList);
		request.setAttribute("postLikeCountMapList", postLikeCountMapList);
		request.setAttribute("postAnswerCountMapList", postAnswerCountMapList);

		System.out.println("main.do travelLikeCountMapList.size() = " + travelLikeCountMapList.size());
		System.out.println("main.do travelAnswerCountMapList.size() = " + travelAnswerCountMapList.size());
		System.out.println("main.do postLikeCountMapList.size() = " + postLikeCountMapList.size());
		System.out.println("main.do postAnswerCountMapList.size() = " + postAnswerCountMapList.size());

		HttpSession session = request.getSession();
		// 로그인 했을 경우에만 좋아요 누른 포스트 번호 목록 가져오기
		if (session.getAttribute("login") != null) {
			MemberDTO memberDTO = (MemberDTO) session.getAttribute("login");
			String id = memberDTO.getId();

			// 로그인한 본인이 좋아요한 여행 목록의 번호
			List<Integer> travelLikeList = travelService.getTravelLikeListByID(id);
			request.setAttribute("travelLikeList", travelLikeList);

			// 로그인한 본인이 좋아요한 포스트 목록의 번호
			List<Integer> postLikeList = postService.getPostLikeListByID(id);
			request.setAttribute("postLikeList", postLikeList);

			System.out.println("mainController travelLikeList.size() = " + travelLikeList.size());
			System.out.println("mainController postLikeList.size() = " + postLikeList.size());
		}

		if (invite_seq != null && !invite_seq.equals("")) {
			model.addAttribute("invite_seq", invite_seq);
		}		

		return "main/main";
	}

	@RequestMapping(value = "logincheck.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void loginCheck(String id, String pwd, Model model, HttpServletResponse response) throws Exception {
		logger.info("Welcome MemberController logincheck.do! " + new Date());

		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setId(id);
		memberDTO.setPwd(pwd);

		boolean isS = memberService.checkLogin(memberDTO);		
		if (isS) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}
	}

	@RequestMapping(value = "login.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void login(String id, String pwd, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("Welcome MemberController login.do! " + new Date());

		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setId(id);
		memberDTO.setPwd(pwd);

		MemberDTO mem = memberService.login(memberDTO);
		HttpSession session = request.getSession();
		
		String url = request.getHeader("referer");
		System.out.println("login.do url = " + url);
		
		
		// 로그인 성공
		if (mem != null && !mem.getId().equals("")) {
			System.out.println("로그인 성공");
			session.setAttribute("login", mem);

			// 로그인한 회원이 좋아하는 포스트 번호 목록 가져오기
			List<Integer> postLikeList = postService.getPostLikeListByID(mem.getId());
			List<Integer> travelLikeList = travelService.getTravelLikeListByID(mem.getId());

			model.addAttribute("postLikeList", postLikeList);
			model.addAttribute("travelLikeList", travelLikeList);
			
			
			response.sendRedirect(url);	
			
					
			// 로그인 실패		
		} else {			
			System.out.println("로그인 실패");
			response.sendRedirect("main.do");
		}

	}

	@RequestMapping(value = "logout.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(Model model, HttpServletRequest request) throws Exception {
		logger.info("Welcome MemberController logout.do! " + new Date());

		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/main.do";
	}

	@RequestMapping(value = "regicheck.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void regicheck(String regi_id, String pwd_find, HttpServletResponse response, HttpServletRequest request) throws Exception {
		logger.info("Welcome MemberController regicheck.do! " + new Date());
		
		System.out.println("regicheck.do regi_id = " + regi_id);
		boolean isS = memberService.checkId(regi_id);
		System.out.println("regicheck.do isS = " + isS);
				
		// 비밀번호 찾기시 존재하는 아이디가 있는 경우 true
		if (pwd_find != null && !pwd_find.equals("")) {
			response.getWriter().print(isS);		
		// 다른 경우 반대로 보내주어야함 false
		} else {
			response.getWriter().print(!isS);		
		}		
	
	}

	@RequestMapping(value = "regi.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String regi(String regi_id, String regi_pwd, String regi_email, int regi_birth, int regi_sex, Model model)
			throws Exception {
		logger.info("Welcome MemberController regi.do! " + new Date());
		
		System.out.println("regi.do regi_id = " + regi_id);
		System.out.println("regi.do regi_pwd = " + regi_pwd);

		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setId(regi_id);
		memberDTO.setPwd(regi_pwd);
		memberDTO.setEmail(regi_email);
		memberDTO.setBirth(regi_birth);
		memberDTO.setSex(regi_sex);

		boolean isS = memberService.addMember(memberDTO);
		if (isS) {
			System.out.println("회원가입 성공");
			return "redirect:/login.do?id=" + regi_id + "&pwd=" + regi_pwd;
		} else {
			System.out.println("회원가입 실패");
			return "redirect:/main.do";
		}
		
	}

	@RequestMapping(value = "mypage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String mypage(Model model, HttpServletRequest request) throws Exception {
		logger.info("Welcome MemberController mypage.do! " + new Date());

		String defaultImage = "../image/default-user-icon-profile.png";

		// map 준비
		List<Map<Object, Object>> travelLikeMapList = null;
		List<Map<Object, Object>> travelAnswerMapList = null;
		List<Map<Object, Object>> postLikeMapList = null;
		List<Map<Object, Object>> postAnswerMapList = null;

		System.out.println("MyPageController mypage.do");

		// list 준비
		List<TravelDTO> travelDTOlist = null;
		List<PostDTO> postDTOlist = null;
		List<Integer> travelLikeList = null;
		List<Integer> postLikeList = null;
		List<MemberDTO> memberList = null;

		String parameterID = "";
		String sessionID = "";
		String profileImg = "";

		// 파라미터 아이디 받아오기
		if (request.getParameter("id") != null && !request.getParameter("id").equals("")) {
			parameterID = request.getParameter("id");
			profileImg = memberService.getImage(parameterID);
		}

		// 세션 아이디 받아오기
		if (request.getSession().getAttribute("login") != null) {
			MemberDTO memberDTO = (MemberDTO) request.getSession().getAttribute("login");
			sessionID = memberDTO.getId();

			travelLikeList = travelService.getTravelLikeListByID(sessionID);
			postLikeList = postService.getPostLikeListByID(sessionID);
			profileImg = memberService.getImage(sessionID);
			model.addAttribute("travelLikeList", travelLikeList);
			model.addAttribute("postLikeList", postLikeList);
		}

		// 파라미터 아이디가 들어오고 세션 아이디와 일치할 경우 -> 본인의 비공개 게시물까지 가져오기
		if (!parameterID.equals("") && parameterID.equals(sessionID)) {
			travelDTOlist = travelService.getMyTravelList(sessionID);
			postDTOlist = postService.getPostListbyId(sessionID);
			model.addAttribute("id", sessionID);
			// 파라미터 아이디가 들어오고 세션 아이디와 불일치할 경우 -> 타인의 공개 게시물만 가져오기
		} else if (!parameterID.equals("") && !parameterID.equals(sessionID)) {
			travelDTOlist = travelService.getTravelListbyId(parameterID);
			postDTOlist = postService.getPostListbyId(parameterID);
			model.addAttribute("id", parameterID);
			// 파라미터 아이디가 들어오지 않을 경우 (헤더의 마이페이지 버튼을 통해서 접근한 경우) -> 타인의 공개 게시물만
			// 가져오기
		} else if (parameterID.equals("")) {
			travelDTOlist = travelService.getMyTravelList(sessionID);
			postDTOlist = postService.getPostListbyId(sessionID);
			model.addAttribute("id", sessionID);
		}

		// 마이페이지에 뜨는 포스트/여행일정
		travelLikeMapList = travelService.getTravelLikeCountMapList();
		travelAnswerMapList = travelService.getTravelAnswerCountMapList();
		postLikeMapList = postService.getPostLikeCounMapList();
		postAnswerMapList = postService.getPostAnswerCounMapList();

		request.setAttribute("travelDTOlist", travelDTOlist);
		model.addAttribute("postDTOlist", postDTOlist);

		model.addAttribute("travelLikeMapList", travelLikeMapList);
		model.addAttribute("travelAnswerMapList", travelAnswerMapList);
		model.addAttribute("postLikeMapList", postLikeMapList);
		model.addAttribute("postAnswerMapList", postAnswerMapList);

		// 프로밀 이미지 src
		if (profileImg == null) {
			model.addAttribute("profileImg", defaultImage);
		} else {
			model.addAttribute("profileImg", profileImg);
		}

		memberList = memberService.getMemberList();
		model.addAttribute("memberList", memberList);

		return "mypage/mypage";
	}

	@RequestMapping(value = "profileupload.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String profileupload(@RequestParam("file") MultipartFile uploadfile, String id, Model model,
			HttpServletRequest request) throws Exception {
		logger.info("Welcome MemberController profileupload.do! " + new Date());
		String savePath = request.getSession().getServletContext().getRealPath("/profileImage");

		if (uploadfile != null) {
			String fileName = uploadfile.getOriginalFilename();
			try {
				SimpleDateFormat sd = new SimpleDateFormat("yyyyMMdd_HHmmss");
				String date_form = sd.format(new Date()); // O년 0월 0 일 00:00:00
															// 형식
				String fileEx = id + "_" + date_form + "_" + fileName;

				File file = new File(savePath + "/" + fileEx);
				uploadfile.transferTo(file);

				MemberDTO member = new MemberDTO();
				member.setId(id);
				member.setImg(fileEx);
				memberService.addImage(member);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return "redirect:/mypage.do";
	}

	@RequestMapping(value = "pwdcheck.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void pwdcheck(String current_pwd, Model model, HttpServletResponse response, HttpServletRequest request)
			throws Exception {
		logger.info("Welcome MemberController pwdcheck.do! " + new Date());

		MemberDTO mem = (MemberDTO) request.getSession().getAttribute("login");
		String id = mem.getId();

		boolean checked = memberService.checkPwd(id, current_pwd);
		
		if (checked) {
			response.getWriter().print(true);
			System.out.println("비밀번호 일치");
		} else {
			response.getWriter().print(false);
			System.out.println("비밀번호 불일치");
		}
	}

	@RequestMapping(value = "updatemember.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String updatemember(String id, String new_pwd, String email, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("Welcome MemberController updatemember.do! " + new Date());

		MemberDTO member = new MemberDTO();
		member.setId(id);
		member.setPwd(new_pwd);
		member.setEmail(email);
		
		boolean isS = memberService.updateMember(member);
		
		if (isS) {
			System.out.println("비밀번호수정 성공");
			return "redirect:/mypage.do";
		} else {
			System.out.println("비밀번호수정 실패");
			return "redirect:/main.do";
		}
		
		
	}

	@RequestMapping(value = "memberdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void deletemember(String id, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("Welcome MemberController deletemember.do! " + new Date());

		// 회원삭제
		// 1. postlike, travellike 지우기
		// delete post_likes where id = ?;
		boolean postlike = postService.deletePostLikebyId(id);
		System.out.println("1.memberdelete.do postlike = " + postlike);

		// delete travel_likes where id = ?;
		boolean travellike = travelService.deleteTravelLikebyId(id);
		System.out.println("2.memberdelete.do travellike = " + travellike);			
				
		// 2. post_answer, travel_answer 지우기
		// delete post_answers where id = ?;
		boolean post_answer = postService.deletePostAnswerbyId(id);
		System.out.println("3.memberdelete.do post_answer = " + post_answer);
				
		// delete travel_answers where id = ?;
		boolean travel_answer = travelService.deleteTravelAnswerbyId(id);
		System.out.println("4.memberdelete.do travel_answer = " + travel_answer);
		
		List<Integer> myTravelSeqList = null;
		List<Integer> myPostSeqList = null;
		
		myTravelSeqList = travelService.getTravelSeqbyIDandWauth(id);
		System.out.println("4-1.memberdelete.do  travelService.getTravelSeqbyIDandWauth myTravelSeqList.size() = " + myTravelSeqList.size());

		myPostSeqList = postService.getPostSeqListbyID(id);
		System.out.println("4-1.memberdelete.do postService.getPostSeqListbyID myPostSeqList.size() = " + myPostSeqList.size());
	
		// 댓글삭제(반복문)
				for (int travel_seq : myTravelSeqList) {
					travelService.deleteTravelAnswerbyTravelSeq(travel_seq);
				}
				System.out.println("4-2.memberdelete.do travelService.deleteTravelAnswerbyTravelSeq(travel_seq) 완료");
				
				for (int post_seq : myPostSeqList) {
					postService.deletePostAnswerbyPostSeq(post_seq);
				}
				System.out.println("4-2.memberdelete.do postService.deletePostAnswerbyPostSeq(post_seq) 완료");
		
		// 여행일정 좋아요 삭제
		for (int travel_seq : myTravelSeqList) {
			travelService.deleteTravelLikebyTravelSeq(travel_seq);
		}
		System.out.println("4-2.memberdelete.do travelService.deleteTravelLikebyTravelSeq(travel_seq) 완료");

	/*	for (int travel_seq : myTravelSeqList) {
			travelService.deleteTravelbyTravelSeq(travel_seq);
		}
		System.out.println("4-2.memberdelete.do travelService.deleteTravelbyTravelSeq(travel_seq) 완료");*/
		// 포스트 좋아요 삭제	
		for (int post_seq : myPostSeqList) {
			postService.deletePostLikebyPostSeq(post_seq);
		}
		System.out.println("4-2.memberdelete.do postService.deletePostLikebyPostSeq(post_seq) 완료");
		
		

		// 3. post 지우기
		// delete posts where id = ?;
		boolean posts = postService.deletePostbyId(id);
		System.out.println("5.memberdelete.do posts = " + posts);

		// 4. event 지우기
		//delete events where travel_seq in (select travel_seq from
		//members_and_travels where id = ? and wauth = 0);
		boolean events = travelService.deleteTravelEventbyId(id);
		System.out.println("6.memberdelete.do events = " + events);

		// 5. travel 지우기 / member_and_travel 지우기
		// 이것은 안됨: delete travels where travel_seq in (select travel_seq from
		// members_and_travels where id = ? and wauth = 0)
		
		// (1) select travel_seq from members_and_travels where id = ? and wauth
		// = 0 -> List<Integer>로 받아오고
	//	List<Integer> travelLikeList = travelService.getTravelSeqbyIDandWauth(id);
		System.out.println("7.memberdelete.do travelLikeList = " + myTravelSeqList.size());
		
		// (2) delete members_and_travels where id = ?
		boolean members_and_travels = memberAndTravelService.deleteMemberAndTravel(id);
		System.out.println("8.memberdelete.do members_and_travels = " + members_and_travels);
		
		boolean members_and_travels2 = false;
		for (int travel_seq : myTravelSeqList) {
			members_and_travels2 = memberAndTravelService.deleteMemberAndTravelbyTravelSeqAndWauth(travel_seq);
			//  delete members_and_travels where travel_seq = #{travel_seq} and wauth = 0;
		}
		System.out.println("9-1.memberdelete.do members_and_travels = " + members_and_travels2);
		
		
		
		boolean travel_delete = false;
		// (3) delete travels where travel_seq = ?; 한번이 아니라 여러번 수행
		for (int i = 0; i < myTravelSeqList.size(); i++) {
			travel_delete = travelService.deleteTravelbyTravelSeq(myTravelSeqList.get(i));
		
			//List<Integer> -> delete travels where travel_seq = 1 || travel_seq = 3 || (여러개 한꺼번에 삭제 쿼리)
		}
		System.out.println("9-2.memberdelete.do travel_delete = " + travel_delete);
		
		// 6. member 지우기
		// delete members where id =?;
		boolean member = memberService.deleteMember(id);
		System.out.println("10.memberdelete.do member = " + member);

		
		MemberDTO memberDTO = null;
		if (request.getSession() != null) {		
			memberDTO = (MemberDTO) request.getSession().getAttribute("login");
			System.out.println(memberDTO.getId());
		}		

		// 관리자인 경우
		if (memberDTO != null && memberDTO.getAuth() == 1) {			
			String url = request.getHeader("referer");
			System.out.println("11.memberdelete.do memberdelete.do url = " + url);
			response.sendRedirect(url);
		// 관리자가 아닌경우
		} else {			
			request.getSession().invalidate();
			response.sendRedirect("main.do");	
		}	
		
	}
	
	
	@RequestMapping(value = "admin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String admin(Model model, HttpServletRequest request) throws Exception {
		logger.info("Welcome adminController admin.do! " + new Date());

		List<MemberDTO> memberList = null;
//
		List<PostDTO> postList = null;
		
		String parameterID = "";
		String sessionID = "";
//
//		 파라미터 아이디 받아오기
		if (request.getParameter("id") != null && !request.getParameter("id").equals("")) {
		parameterID = request.getParameter("id");
			
		}
//
		// 세션 아이디 받아오기
		if (request.getSession().getAttribute("login") != null) {
			MemberDTO memberDTO = (MemberDTO) request.getSession().getAttribute("login");
			sessionID = memberDTO.getId();
		}
//
//		// 파라미터 아이디가 들어오고 세션 아이디와 일치할 경우 -> 본인의 비공개 게시물까지 가져오기
//		if (!parameterID.equals("") && parameterID.equals(sessionID)) {
//			travelDTOlist = travelService.getMyTravelList(sessionID);
//			postDTOlist = postService.getPostListbyId(sessionID);
//			model.addAttribute("id", sessionID);
//			// 파라미터 아이디가 들어오고 세션 아이디와 불일치할 경우 -> 타인의 공개 게시물만 가져오기
//		} else if (!parameterID.equals("") && !parameterID.equals(sessionID)) {
//			travelDTOlist = travelService.getTravelListbyId(parameterID);
//			postDTOlist = postService.getPostListbyId(parameterID);
//			model.addAttribute("id", parameterID);
//			// 파라미터 아이디가 들어오지 않을 경우 (헤더의 마이페이지 버튼을 통해서 접근한 경우) -> 타인의 공개 게시물만
//			// 가져오기
//		} else if (parameterID.equals("")) {
//			travelDTOlist = travelService.getMyTravelList(sessionID);
//			postDTOlist = postService.getPostListbyId(sessionID);
//			model.addAttribute("id", sessionID);
//		}

//		request.setAttribute("travelDTOlist", travelDTOlist);
//		model.addAttribute("postDTOlist", postDTOlist);

		memberList = memberService.getMemberList();
		System.out.println("1. admin.do memberList.size() = "  + memberList.size());
		model.addAttribute("memberList", memberList);
		
		/// 관리자모드 일
		postList = postService.getPostList();
		System.out.println("2. admin.do postList.size() = "  + postList.size());
		model.addAttribute("postList", postList);
		
		
		//여행일정 갯수 가져오기(id, count)
		List<Map<Object, Object>> travelCountMapList = null;

		travelCountMapList = travelService.getTravelCountAndId();
		System.out.println("3. admin.do travelCountMapList.size() = "  + travelCountMapList.size());
		model.addAttribute("travelCountMapList", travelCountMapList);
		
		//포스트 갯수 가져오기(id, count)
		List<Map<Object, Object>> postCountMapList = null;
		postCountMapList = postService.getPostAnswerCountAndId();
		System.out.println("4.admin.do postCountMapList.size() = "  + postCountMapList.size());
		model.addAttribute("postCountMapList", postCountMapList);		
		
		return "admin/admin";
	}
	
	@RequestMapping(value = "pwdmailsend.do", method = {RequestMethod.GET, RequestMethod.POST })
	public void pwdmailsend(String id, HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("Welcome MemberController pwdmailsend.do! " + new Date());
		
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			response.setCharacterEncoding("UTF-8");
						
			String url = "";			
			url = request.getHeader("referer");
			
			String email = "";
			MemberDTO memberDTO = null;			
			memberDTO = memberService.getMemberById(id);			
			email = memberDTO.getEmail();
		
			String mail_from = "ssittravelmate@gmail.com";
			String mail_to = email;
			String title = id + "님의 TravelPlanet 임시 비밀번호입니다";
			String contents = "";
			contents += id + "님의 임시 비밀 번호는 1234입니다";
			contents += "<br>";
			contents += "<a href='" + url + "'>" + "Travel Planet으로 이동" + "</a>";

			mail_from = new String(mail_from.getBytes("UTF-8"), "UTF-8");
			mail_to = new String(mail_to.getBytes("UTF-8"), "UTF-8");

			Properties properties = new Properties();
			properties.put("mail.transport.protocol", "smtp");
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.smtp.port", "465");
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.socketFactory.port", "465");
			properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			properties.put("mail.smtp.socketFactory.fallback", "false");
			properties.put("mail.smtp.auth", "true");

			Authenticator authenticator = new SMTPAuthenticator();

			Session session = Session.getDefaultInstance(properties, authenticator);

			MimeMessage mimeMessage = new MimeMessage(session);

			mimeMessage.setFrom(new InternetAddress(mail_from));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(mail_to));
			mimeMessage.setSubject(title, "UTF-8");
			mimeMessage.setContent(contents, "text/html; charset=UTF-8");
			mimeMessage.setHeader("Content-type", "text/html; charset=UTF-8");

			Transport.send(mimeMessage);
			
			// 비밀번호 임시비밀번호(1234)로 바꿔주기
			boolean isS = false;
			memberDTO.setPwd("1234");
			isS = memberService.updateMember(memberDTO);			
			
			response.sendRedirect("main.do");

		} catch (Exception e) {
			System.out.println("메일발송 실패");			
		}
		
	}
	
	public class SMTPAuthenticator extends Authenticator {
		public SMTPAuthenticator() {
			super();
		}

		public PasswordAuthentication getPasswordAuthentication() {
			String username = "ssittravelmate@gmail.com";
			String password = "ehrwowkquddn"; // 독재자병우
			return new PasswordAuthentication(username, password);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}