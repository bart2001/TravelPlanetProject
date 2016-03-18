package travelplanet.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import travelplanet.model.EventDTO;
import travelplanet.model.MemberAndTravelDTO;
import travelplanet.model.MemberDTO;
import travelplanet.model.TravelAnswerDTO;
import travelplanet.model.TravelDTO;
import travelplanet.model.TravelLikeDTO;
import travelplanet.service.EventService;
import travelplanet.service.MemberAndTravelService;
import travelplanet.service.MemberService;
import travelplanet.service.TravelService;

@Controller
public class TravelController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private TravelService travelService;

	@Autowired
	private EventService eventService;

	@Autowired
	private MemberAndTravelService memberAndTravelService;

	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "travelsearch.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String travelsearch(Model model, HttpSession session, String options, String query) throws Exception {
		logger.info("Welcome TravelController travelsearch.do! " + new Date());

		List<MemberDTO> memberList = null;
		List<TravelDTO> travelList = null;
		List<MemberAndTravelDTO> memberAndTravelList = null;		
		List<Map<Object, Object>> travelLikeCountMapList = null;
		List<Map<Object, Object>> travelAnswerCountMapList = null;
		List<Integer> travelLikeList = null;		

		travelList = travelService.getTravelList();
		memberAndTravelList = memberAndTravelService.getMemberAndTravelList();
		memberList = memberService.getMemberList();
		travelLikeCountMapList = travelService.getTravelLikeCountMapList();
		travelAnswerCountMapList = travelService.getTravelAnswerCountMapList();

		// 뷰에 넘겨주기
		model.addAttribute("memberList", memberList);
		model.addAttribute("travelList", travelList);
		model.addAttribute("memberAndTravelList", memberAndTravelList);		
		model.addAttribute("travelLikeCountMapList", travelLikeCountMapList);
		model.addAttribute("travelAnswerCountMapList", travelAnswerCountMapList);

		if (session.getAttribute("login") != null) {
			String id = "";
			MemberDTO memberDTO = (MemberDTO) session.getAttribute("login");
			id = memberDTO.getId();
			travelLikeList = travelService.getTravelLikeListByID(id);
			model.addAttribute("travelLikeList", travelLikeList);
		}

		// 검색어가 들어왔을 경우
		String soptions = "";
		if (options != null && !options.equals("")) {
			soptions = options;
		}
		String squery = "";
		if (query != null && !query.equals("")) {
			squery = query;
		}

		if (soptions.equals("0")) {
			travelList = travelService.searchTravelListbyId(squery);
			System.out.println("travelList" + travelList.size());
		} else if (soptions.equals("1")) {
			travelList = travelService.searchTravelListbyTitle(squery);
		} else if (soptions.equals("2")) {
			travelList = travelService.searchTravelListbyContent(squery);
		} else if (soptions.equals("3")) {
			if (squery.equals("글로벌")) {
				squery = "gl";
			} else if (squery.equals("한국")) {
				squery = "kr";
			} else if (squery.equals("아시아")) {
				squery = "as";
			} else if (squery.equals("유럽")) {
				squery = "eu";
			} else if (squery.equals("북미")) {
				squery = "na";
			} else if (squery.equals("남미")) {
				squery = "sa";
			} else if (squery.equals("아프리카")) {
				squery = "af";
			}
			travelList = travelService.searchTravelListbyRegion(squery);
		}
		model.addAttribute("travelList", travelList);

		// 확인작업
		System.out.println("travelsearch.do travelList.size() = " + travelList.size());
		System.out.println("travelsearch.do memberAndTravelList.size() = " + memberAndTravelList.size());
		System.out.println("travelsearch.do travelLikeCountMapList.size() = " + travelLikeCountMapList.size());
		System.out.println("travelsearch.do travelAnswerCountMapList.size() = " + travelAnswerCountMapList.size());

		return "travel/travelsearch";
	}

	@RequestMapping(value = "travelanswerdelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void travelsearch(Model model, HttpServletResponse response, int travel_answer_seq, int travel_seq)
			throws Exception {
		logger.info("Welcome TravelController travelanswerdelete.do! " + new Date());

		boolean isS = travelService.updateTravelAnswerDelete(travel_answer_seq);

		if (isS) {
			System.out.println("댓글작성 성공");
			response.sendRedirect("traveldetail.do?travel_seq=" + travel_seq);
		} else {
			System.out.println("댓글작성 실패");
			response.sendRedirect("traveldetail.do?travel_seq=" + travel_seq);
		}
	}

	@RequestMapping(value = "travelanswerupdate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void travelanswerupdate(Model model, HttpServletResponse response, int travel_answer_seq, int travel_seq,
			String content) throws Exception {
		logger.info("Welcome TravelController travelanswerupdate.do! " + new Date());

		TravelAnswerDTO answer = new TravelAnswerDTO();
		answer.setTravel_answer_seq(travel_answer_seq);
		answer.setContent(content);

		boolean isS = travelService.updateAnswer(answer);

		if (isS) {
			System.out.println("댓글작성 성공");
			response.sendRedirect("traveldetail.do?travel_seq=" + travel_seq);
		} else {
			System.out.println("댓글작성 실패");
			response.sendRedirect("traveldetail.do?travel_seq=" + travel_seq);
		}
	}

	@RequestMapping(value = "travelanswerwrite.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void travelanswerwrite(Model model, HttpServletRequest request, HttpServletResponse response, String id,
			String content, int travel_seq) throws Exception {
		logger.info("Welcome MemberController travelanswerwrite.do! " + new Date());
		;

		TravelAnswerDTO answer = new TravelAnswerDTO();
		answer.setTravel_seq(travel_seq);
		answer.setId(id);
		answer.setContent(content);

		List<TravelAnswerDTO> answerlist = null;
		answerlist = travelService.getAnswerList(travel_seq);

		boolean isS = travelService.writeAnswer(answer);
		// PostDTO post = null;
		// post = dao.getPost(post_seq);

		// request.setAttribute("post", post);
		request.setAttribute("answer", answerlist);

		if (isS) {
			System.out.println("댓글작성 성공");
			response.sendRedirect("traveldetail.do?travel_seq=" + travel_seq);
		} else {
			System.out.println("댓글작성 실패");
			response.sendRedirect("traveldetail.do?travel_seq=" + travel_seq);
		}
	}

	@RequestMapping(value = "travelcreate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String travelcreate(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response ,
		String title, String content, int done, String defaultDate, int members, String region)
		throws Exception {
		
		logger.info("Welcome TravelController travelcreate.do! " + new Date());

		String id = "";
		if (session.getAttribute("login") != null) {
			MemberDTO memberDTO = null;
			memberDTO = (MemberDTO) session.getAttribute("login");			
			id = memberDTO.getId();
			System.out.println("id" + id);
			
		} else {
			return "redirect:/main.do";
		}
		
		
		
		String sContent = "";
		if (content != null && !content.equals("")) {
			sContent = content; 
		}

		// 초기화
		TravelDTO travelDTO = new TravelDTO();
		travelDTO.setTitle(title);
		travelDTO.setContent(sContent);
		travelDTO.setDone(done);
		travelDTO.setMembers(members);
		travelDTO.setRegion(region);
		travelDTO.setCustomized(0);

		boolean isS = false;
		isS = travelService.createTravel(travelDTO);
		System.out.println("travelcreate.do isS = " + isS);
		
		if (isS) {
			System.out.println("travelcreate.do 여행일정생성 성공");
			int travel_seq = travelService.getLastTravelSeq();
			travelDTO.setTravel_seq(travel_seq);;
			
			model.addAttribute("travel", travelDTO);			
			
			MemberAndTravelDTO memberAndTravelDTO = new MemberAndTravelDTO();
			memberAndTravelDTO.setId(id);
			memberAndTravelDTO.setTravel_seq(travel_seq);			

			boolean isS2 = false;
			isS2 = memberAndTravelService.addMemberAndTravel(memberAndTravelDTO);
			System.out.println("travelcreate.do isS2 = " + isS2);

			if (isS2) {
				System.out.println("MemberAndTravels 기입성공");
			} else {
				System.out.println("MemberAndTravels 기입실패");
			}

			// 이미지를 뿌려주기 위한 memberList
			List<MemberDTO> memberList = memberService.getMemberList();
			model.addAttribute("memberList", memberList);
			model.addAttribute("id", id);			
			model.addAttribute("defaultDate", defaultDate);
			System.out.println("defaultDate = " + defaultDate);

			return "travel/travelupdate";
			

		} else {
			System.out.println("travelcreate.do 여행일정생성 실패");
			return "redirect:/main.do";
		}
	}

	@RequestMapping(value = "traveldelete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void traveldelete(Model model, int travel_seq, String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("Welcome TravelController traveldelete.do! " + new Date());

		travelService.updateTravelDelete(travel_seq);

		// 전 url 찾기
		String url = request.getHeader("referer");
		System.out.println(url);

		if (url.contains("traveldetail")) {
			response.sendRedirect("main.do");
		} else
			response.sendRedirect(url);

	}

	@RequestMapping(value = "travelsave.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void travelsave(Model model, int travel_seq, String title, String content, int done, int members,
			String region, String events, Double budget, HttpServletRequest request, HttpServletResponse response)
					throws Exception {
		logger.info("Welcome TravelController travelsave.do! " + new Date());

		System.out.println("travelsave.do travel_seq = " + travel_seq);
		System.out.println("travelsave.do title = " + title);
		System.out.println("travelsave.do content = " + content);
		System.out.println("travelsave.do done = " + done);
		System.out.println("travelsave.do members = " + members);
		System.out.println("travelsave.do region = " + region);
		System.out.println("travelsave.do events = " + events);
		System.out.println("travelsave.do budget = " + budget);

		// 1. updateTravel (여행정보 업데이트)
		TravelDTO travelDTO = new TravelDTO();
		travelDTO.setTravel_seq(travel_seq);
		travelDTO.setTitle(title);
		travelDTO.setContent(content);
		travelDTO.setDone(done);
		travelDTO.setMembers(members);
		travelDTO.setRegion(region);
		travelDTO.setBudget(budget);

		boolean isS1 = travelService.updateTravel(travelDTO);
		System.out.println("boolean isS1 = " + isS1);

		// 2. 한 일정 내에 있는 상세일정 비워주기(delete)
		boolean isS2 = eventService.deleteEvent(travel_seq);
		System.out.println("boolean isS2 = " + isS2);

		// 3. 캘린더에 입력된 상세일정 하나씩 파싱해서 개수만큼 넣어주기
		JSONParser jsonParser = new JSONParser();

		JSONArray jsonArray = null;
		try {

			jsonArray = (JSONArray) jsonParser.parse(events);
			for (int i = 0; i < jsonArray.size(); i++) {
				// {"title":"DDN","type":0,"lat":37.511959,"lng":127.02516089999995,"start":"2015-12-28T12:00:00","end":"2015-12-28T13:00:00","_id":"_fc7","className":[],"allDay":false,"_allDay":false,"_start":"2015-12-28T12:00:00","_end":"2015-12-28T13:00:00"}]

				JSONObject jsonObject = (JSONObject) jsonArray.get(i);

				EventDTO eventDTO = new EventDTO();
				eventDTO.setTravel_seq(travel_seq);
				eventDTO.setTitle(jsonObject.get("title").toString());
				eventDTO.setLat(Double.parseDouble(jsonObject.get("lat").toString()));
				eventDTO.setLng(Double.parseDouble(jsonObject.get("lng").toString()));
				eventDTO.setStart_time(toTime(jsonObject.get("start").toString()));
				eventDTO.setEnd_time(toTime(jsonObject.get("end").toString()));

				System.out.println(i + "번째 일정정보");
				System.out.println("jsonObject seq = " + travel_seq);
				System.out.println("jsonObject title = " + jsonObject.get("title").toString());
				System.out.println("jsonObject lat = " + Double.parseDouble(jsonObject.get("lat").toString()));
				System.out.println("jsonObject lng = " + Double.parseDouble(jsonObject.get("lng").toString()));
				System.out.println("jsonObject start = " + toTime(jsonObject.get("start").toString()));
				System.out.println("jsonObject end = " + toTime(jsonObject.get("end").toString()));

				boolean isS3 = eventService.addEvent(eventDTO);
				System.out.println(i + "번째 isS3 = " + isS3);
				System.out.println("eventDTO.getLat()=" + eventDTO.getLat());
			}

		} catch (ParseException e) {
			e.printStackTrace();
		}

		// 4. traveldetail로 넘겨줄 데이터 준비
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("login");
		String id = memberDTO.getId();
		request.setAttribute("id", id);
		request.setAttribute("travel_seq", travel_seq);

		response.sendRedirect("traveldetail.do?travel_seq=" + travel_seq + "&id=" + id);

	}

	// 날짜형태(yyyyMMDDhhmm)로 바꿔주는 helper
	public String toTime(String time) {
		time = time.replaceAll("T", "");
		time = time.replaceAll(":", "");
		time = time.replaceAll("-", "");
		return time;

	}

	@RequestMapping(value = "traveldetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String traveldetail(Model model, HttpSession session, int travel_seq) throws Exception {
		logger.info("Welcome TravelController traveldetail.do! " + new Date());

		List<MemberDTO> memberList = null;
		TravelDTO travel = travelService.getTravel(travel_seq);
		List<EventDTO> eventList = eventService.getEventList(travel_seq);
		System.out.println("traveldetail.do eventService 바로 밑 " + eventList.size());
		List<MemberAndTravelDTO> memberandtravellist = memberAndTravelService
				.getMemberAndTravelListbyTravelSeq(travel_seq);
		List<Map<Object, Object>> travelLikeCountMapList = null;
		travelLikeCountMapList = travelService.getTravelLikeCountMapList();
	
		
		String writerID = "";
		String sessionID = "";
		int accessLevel = 0;
		List<Integer> travellikelist = null;  

		if (session.getAttribute("login") != null) {
			MemberDTO memberDTO = (MemberDTO) session.getAttribute("login");
			sessionID = memberDTO.getId();
			accessLevel++;
			travellikelist = travelService.getTravelLikeListByID(sessionID);
		}

		for (int i = 0; i < memberandtravellist.size(); i++) {

			if (memberandtravellist.get(i).getWauth() == 0) {
				writerID = memberandtravellist.get(i).getId();
				String profileImg = memberService.getImage(writerID);
				model.addAttribute("profileImg", profileImg);
				System.out.println("TravelDetailController writerID = " + writerID);
			}

			if (!sessionID.equals("") && memberandtravellist.get(i).getId().equals(sessionID)) {
				accessLevel++;
			}

			if (!sessionID.equals("") && memberandtravellist.get(i).getWauth() == 0
					&& memberandtravellist.get(i).getId().equals(sessionID)) {
				accessLevel++;
				// writerID = memberandtravellist.get(i).getId();
			}
		}

		System.out.println("traveldetail.do");

		List<TravelAnswerDTO> travelAnswerList = null;
		travelAnswerList = travelService.getAnswerList(travel_seq);

		System.out.println("traveldetail.do travel.getMembers()" + travel.getMembers());
		System.out.println("traveldetail.do travel_seq = " + travel_seq);
		System.out.println("traveldetail.do accessLevel = " + accessLevel);
		// System.out.println("traveldetail.do id = " + id);
		System.out.println("traveldetail.do travel.getBudget() = " + travel.getBudget());
		System.out.println("traveldetail.do eventList.size() = " + eventList.size());
		System.out.println("traveldetail.do travelAnswerList.size() = " + travelAnswerList.size());

		model.addAttribute("travel", travel);
		model.addAttribute("eventList", eventList);
		model.addAttribute("travelAnswerList", travelAnswerList);
		model.addAttribute("memberandtravellist", memberandtravellist);
		model.addAttribute("travellikeList",travellikelist);
		model.addAttribute("travelLikeCountMapList", travelLikeCountMapList);
		System.out.println("traveldetail.do travelLikeCountMapList.size()="+travelLikeCountMapList.size());
		
		memberList = memberService.getMemberList();
		model.addAttribute("memberList", memberList);
		// request.setAttribute("id", id);
		model.addAttribute("writerID", writerID);
		// request.setAttribute("cowriterID", cowriterID);
		model.addAttribute("accessLevel", accessLevel);
		
		
		return "travel/traveldetail";
	}

	@RequestMapping(value = "travelupdate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String travelupdate(Model model, HttpSession session, int travel_seq) throws Exception {
		logger.info("Welcome TravelController travelupdate.do! " + new Date());

		System.out.println("travelupdate.do 실행 1");
		
		String id = "";
		if (session.getAttribute("login") != null) {
			MemberDTO memberDTO = null;
			memberDTO = (MemberDTO) session.getAttribute("login");
			id = memberDTO.getId();
		}

		System.out.println("travelupdate.do travel_seq = " + travel_seq);
		System.out.println("travelupdate.do id = " + id);

		System.out.println("travelupdate.do 실행 2");

		TravelDTO travel = travelService.getTravel(travel_seq);
		List<EventDTO> eventList = eventService.getEventList(travel_seq);
		System.out.println(
				"eventService.getEventList(travel_seq).size() = " + eventService.getEventList(travel_seq).size());
		System.out.println("travelupdate.do 실행 3");
		List<MemberDTO> memberList = null;
		memberList = memberService.getMemberList();
		model.addAttribute("memberList", memberList);

		model.addAttribute("seq", travel_seq);
		model.addAttribute("travel", travel);
		model.addAttribute("eventList", eventList);
		model.addAttribute("id", id);

		System.out.println("travelupdate.do 실행 4");
		// id도 보내줘라

		if (travel != null && eventList != null) {
			System.out.println("수정페이지 불러오기 성공");
			return "/travel/travelupdate";

		} else {
			System.out.println("수정페이지 불러오기 실패");
			return "/traveldetail";
		}
	}

	@RequestMapping(value = "travellikeup.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void travellikeup(Model model, HttpServletResponse response, HttpServletRequest request, int travel_seq)
			throws IOException {
		logger.info("Welcome TravelController travellikeup.do! " + new Date());

		// 좋아요 1 증가
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("login");
		String id = memberDTO.getId();

		TravelLikeDTO travellikedto = new TravelLikeDTO();
		travellikedto.setId(id);
		travellikedto.setTravels_seq(travel_seq);

		// 좋아요 1 증가
		boolean isS = travelService.addTravelLike(travellikedto);

		String url = request.getHeader("referer");
		
		if(url.contains("traveldetail")) {
			response.sendRedirect("traveldetail.do?travel_seq="+travel_seq);
		} else {
			if (isS) {
				response.getWriter().print(1);
			} else {
				response.getWriter().print(2);
			}
			
		}
		
		
	}

	@RequestMapping(value = "travellikedown.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void travellikedown(Model model, HttpServletResponse response, HttpServletRequest request, int travel_seq)
			throws IOException {
		logger.info("Welcome TravelController traveltravellikedown.do! " + new Date());

		// 좋아요 1 증가
		HttpSession session = request.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("login");
		String id = memberDTO.getId();

		TravelLikeDTO travellikedto = new TravelLikeDTO();
		travellikedto.setId(id);
		travellikedto.setTravels_seq(travel_seq);

		// 좋아요 1 증가
		boolean isS = travelService.deleteTravelLike(travellikedto);

		String url = request.getHeader("referer");

		if(url.contains("traveldetail")) {
			response.sendRedirect("traveldetail.do?travel_seq="+travel_seq);
		} else {
			if (isS) {
				response.getWriter().print(1);
			} else {
				response.getWriter().print(2);
			}
			
		}
		
	}

	@RequestMapping(value = "travelopen.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void travelopen(Model model, HttpServletResponse response, HttpServletRequest request, int travel_seq)
			throws IOException {
		logger.info("Welcome TravelController travelopen.do! " + new Date());

		boolean isS = travelService.openTravel(travel_seq);
		String url = request.getHeader("referer");
		System.out.println("referer=" + url);

		if (isS) {
			// 성공
			response.getWriter().print(1);
		} else {
			// 실패
			response.getWriter().print(2);
		}
	}

	@RequestMapping(value = "traveldownload.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void traveldownload(Model model, HttpServletResponse response, HttpServletRequest request, int travel_seq)
			throws Exception {
		logger.info("Welcome TravelController traveldownload.do! " + new Date());
		
		System.out.println("traveldownload.do travel_seq = " + travel_seq);
		TravelDTO travel = null; 				
		List<EventDTO> eventList = null;
				
		travel = travelService.getTravel(travel_seq);
		eventList = eventService.getEventList(travel_seq);

		// workbook을 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		// sheet생성
		XSSFSheet sheet1 = workbook.createSheet("여행기본정보");				
		XSSFSheet sheet2 = workbook.createSheet("여행상세일정");
		
		// 첫번째 sheet에 넣어주기: 여행기본정보
		XSSFRow row0 = sheet1.createRow(0);
		row0.createCell(0).setCellValue("여행제목");
		row0.createCell(1).setCellValue(travel.getTitle());
		
		XSSFRow row1 = sheet1.createRow(1);
		row1.createCell(0).setCellValue("여행설명");
		row1.createCell(1).setCellValue(travel.getContent().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", ""));
		
		XSSFRow row2 = sheet1.createRow(2);
		row2.createCell(0).setCellValue("여행인원");
		row2.createCell(1).setCellValue(travel.getMembers());
				
		XSSFRow row3 = sheet1.createRow(3);
		row3.createCell(0).setCellValue("여행경비");
		row3.createCell(1).setCellValue(travel.getBudget());
		
		if (eventList != null && eventList.size() > 0) {
				XSSFRow rowHeader = sheet2.createRow(0);
				rowHeader.createCell(0).setCellValue("일정장소");
				rowHeader.createCell(1).setCellValue("시작시간");
				rowHeader.createCell(2).setCellValue("종료시간");
				rowHeader.createCell(3).setCellValue("메모");			
			for (int i = 0; i < eventList.size(); i++) {
				XSSFRow rowContent = sheet2.createRow(i + 1);
				rowContent.createCell(0).setCellValue(eventList.get(i).getTitle());
				rowContent.createCell(1).setCellValue(eventList.get(i).getStart_time());
				rowContent.createCell(2).setCellValue(eventList.get(i).getEnd_time());				
			}			
		}		
		
		String filename = new String(travel.getTitle().getBytes("KSC5601"), "8859_1");		
		String userBrowser = request.getHeader("User-Agent");
		System.out.println("traveldownload.do userBrowser = " + userBrowser);
	
		if (userBrowser.indexOf("MSIE 5.5")> -1 || userBrowser.indexOf("MSIE 6.0") > -1 ){
		  response.setHeader("Content-Type", "doesn/matter;");
		  response.setHeader("Content-Disposition", "filename="+filename+".xlsx");
		} else {
		  response.setHeader("Content-Type", "application/vnd.ms-excel;charset=EUC-KR");
		  response.setHeader("Content-Disposition", "attachment; filename="+filename+".xlsx");
		}
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");		
		
		workbook.write(response.getOutputStream());
		workbook.close();
		System.out.println("엑셀파일생성성공");
	}
	
	@RequestMapping(value = "travelcopy.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void travelcopy(Model model, int travel_seq, String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("Welcome TravelController travelcopy.do! " + new Date());
		
		TravelDTO travelDTO = null; 
		travelDTO = travelService.getTravel(travel_seq);
		System.out.println("travelcopy.do travelDTO.getContent = "+travelDTO.getContent());
		
		
		travelDTO.setTitle(travelDTO.getTitle()+" (customized)");
		travelDTO.setCustomized(1);
		

		System.out.println("travelcopy.do travelDTO.getContent2 = "+travelDTO.getContent());
	
		travelService.createTravel(travelDTO);
		
		System.out.println("travelcopy.do travelDTO.getBudget 3= "+travelDTO.getBudget());
		System.out.println("travelcopy.do travelDTO.getContent 3= "+travelDTO.getContent());
		System.out.println("travelcopy.do travelDTO.getCustomized 3= "+travelDTO.getCustomized());
		System.out.println("travelcopy.do travelDTO.getDel 3= "+travelDTO.getDel());
		System.out.println("travelcopy.do travelDTO.getDone 3= "+travelDTO.getDone());
		System.out.println("travelcopy.do travelDTO.getEdate 3= "+travelDTO.getEdate());
		System.out.println("travelcopy.do travelDTO.getMembers 3= "+travelDTO.getMembers());
		System.out.println("travelcopy.do travelDTO.getOpen 3= "+travelDTO.getOpen());
		System.out.println("travelcopy.do travelDTO.getRegion 3= "+travelDTO.getRegion());
		System.out.println("travelcopy.do travelDTO.getTitle 3= "+travelDTO.getTitle());
		System.out.println("travelcopy.do travelDTO.getTravel_seq 3= "+travelDTO.getTravel_seq());
		System.out.println("travelcopy.do travelDTO.getWdate 3= "+travelDTO.getWdate());
		
		int customized_seq = travelService.getLastTravelSeq();
		travelDTO.setTravel_seq(customized_seq);
	
		
		System.out.println("travelcopy.do travelDTO.getBudget beforeupdate= "+travelDTO.getBudget());
		System.out.println("travelcopy.do travelDTO.getContent beforeupdate= "+travelDTO.getContent());
		System.out.println("travelcopy.do travelDTO.getDone beforeupdate= "+travelDTO.getDone());
		System.out.println("travelcopy.do travelDTO.getMembers beforeupdate= "+travelDTO.getMembers());
		System.out.println("travelcopy.do travelDTO.getRegion beforeupdate= "+travelDTO.getRegion());
		System.out.println("travelcopy.do travelDTO.getTitle beforeupdate= "+travelDTO.getTitle());
		System.out.println("travelcopy.do travelDTO.getTravel_seq beforeupdate= "+travelDTO.getTravel_seq());
		
		travelService.updateTravel(travelDTO);
		
		// event 복사
		List<EventDTO> eventList = null;
		eventList = eventService.getEventList(travel_seq);
		for(int i=0; i < eventList.size();i++){					
		
			System.out.println("eventList.get("+i+").getStart_time="+eventList.get(i).getStart_time());
			System.out.println("eventList.get("+i+").getEnd_time="+eventList.get(i).getEnd_time());
			
			String start_time = "";
			start_time = eventList.get(i).getStart_time().toString();
			System.out.println("eventDTO.getStart_time="+eventList.get(i).getStart_time());
			start_time = start_time.trim();
			start_time = start_time.replace(".0", "");
			start_time = start_time.replace("-", "");
			start_time = start_time.replace(":", "");
			System.out.println("start_time="+start_time);
			eventList.get(i).setStart_time(start_time);
			
			String end_time = "";
			end_time =  eventList.get(i).getEnd_time().toString();
			System.out.println("eventDTO.getEnd_time="+eventList.get(i).getEnd_time());
			end_time = end_time.trim();
			end_time = end_time.replace(".0", "");
			end_time = end_time.replace("-", "");
			end_time = end_time.replace(":", "");
			System.out.println("end_time="+end_time);
			eventList.get(i).setEnd_time(end_time);
			
			eventList.get(i).setTravel_seq(customized_seq);
			
			eventService.addEvent(eventList.get(i));	
		}		
	
		MemberAndTravelDTO memberAndTravelDTO =  null;
		memberAndTravelDTO = new MemberAndTravelDTO();
		memberAndTravelDTO.setId(id);
		memberAndTravelDTO.setTravel_seq(customized_seq);
		
		memberAndTravelService.addMemberAndTravel(memberAndTravelDTO);
	
		// 전 url 찾기
		String url = request.getHeader("referer");
		System.out.println(url);
		model.addAttribute("id", id);

		if (url.contains("traveldetail")) {
			response.sendRedirect("traveldetail.do?travel_seq="+customized_seq);
		} else
			response.sendRedirect(url);

	}
	
	
}
