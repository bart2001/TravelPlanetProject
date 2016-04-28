package travelplanet.controller;

import java.io.IOException;
import java.util.Date;
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

import travelplanet.model.MemberAndTravelDTO;
import travelplanet.model.MemberDTO;
// import controller.InviteMailController.SMTPAuthenticator;
import travelplanet.service.MemberAndTravelService;
import travelplanet.service.MemberService;

@Controller
public class MemberAndTravelController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);	
	@Autowired
	private MemberAndTravelService memberAndTravelService;
	@Autowired
	private MemberService memberService;
	
	public class SMTPAuthenticator extends Authenticator {
		public SMTPAuthenticator() {
			super();
		}

		public PasswordAuthentication getPasswordAuthentication() {
			String username = "ssittravelmate@gmail.com";
			String password = // 패스워드
			return new PasswordAuthentication(username, password);
		}
	}

	@RequestMapping(value = "invitemail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void travelopen(Model model, HttpServletResponse response, HttpServletRequest request, int travel_seq)
			throws IOException {
		logger.info("Welcome MemberAndTravelController invitemail.do! " + new Date());

		request.setCharacterEncoding("UTF-8");
		System.out.println("invitemail.do 실행");

		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");

		String email = request.getParameter("email");

		String name = request.getParameter("name");

		// String id = request.getParameter("id");
		int invite_seq = Integer.parseInt(request.getParameter("travel_seq"));

		System.out.println("email=" + email);
		System.out.println("name=" + name);
		System.out.println("invite_seq=" + invite_seq);

		try {
			String mail_from = "ssittravelmate@gmail.com";
			String mail_to = email;
			String title = name + "님이 당신을 TravelMate로 초대합니다.";
			String contents = "함께하시겠습니까 ?" + "<a href = http://211.238.142.165:8090/SpringSamAll/main.do?invite_seq="
					+ invite_seq + ">" + "링크로 이동" + "</a>";

			mail_from = new String(mail_from.getBytes("UTF-8"), "UTF-8");
			mail_to = new String(mail_to.getBytes("UTF-8"), "UTF-8");

			Properties props = new Properties();
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "465");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.socketFactory.fallback", "false");
			props.put("mail.smtp.auth", "true");

			Authenticator auth = new SMTPAuthenticator();

			Session sess = Session.getDefaultInstance(props, auth);

			MimeMessage msg = new MimeMessage(sess);

			msg.setFrom(new InternetAddress(mail_from));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(mail_to));
			msg.setSubject(title, "UTF-8");
			msg.setContent(contents, "text/html; charset=UTF-8");
			msg.setHeader("Content-type", "text/html; charset=UTF-8");

			Transport.send(msg);

			response.sendRedirect("traveldetail.do?travel_seq=" + invite_seq);

		} catch (Exception e) {
			System.out.println("메일발송 실패");

		} finally {

		}
	}

	
	@RequestMapping(value = "inviteregi.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void inviteregi(Model model, HttpServletResponse response, HttpServletRequest request, int invite_seq, String regi_id, String regi_pwd, String regi_email, 
			int regi_birth, int regi_sex)
			throws Exception {
		logger.info("Welcome MemberAndTravelController inviteregi.do! " + new Date());

		
		System.out.println("invite regi id="+ regi_id);
		System.out.println("invite regi pwd="+regi_pwd);
		System.out.println("invite regi name="+regi_email);
		System.out.println("invite regi birth="+regi_birth);
		System.out.println("invite regi sex="+regi_sex);
		System.out.println("invite regi travel_seq="+invite_seq);		
		
		MemberDTO member = new MemberDTO();
		member.setId(regi_id);
		member.setPwd(regi_pwd);
		member.setEmail(regi_email);
		member.setBirth(regi_birth);
		member.setSex(regi_sex);
		
		MemberAndTravelDTO memberAndTravelDTO = new  MemberAndTravelDTO();
		memberAndTravelDTO.setId(regi_id);
		memberAndTravelDTO.setTravel_seq(invite_seq);
		
		boolean isS = memberService.addMember(member);
		boolean isS2= memberAndTravelService.inviteAddMemberAndTravel(memberAndTravelDTO);
		MemberDTO mem = memberService.login(member);
		
		HttpSession session = request.getSession();
		
		if(isS && isS2){
			System.out.println("회원가입 성공");
			System.out.println("MemberAndTravel 추가 성공");
			
	
				
			if(mem!=null && !mem.getId().equals("")){
					System.out.println("로그인 성공");
					System.out.println("MemberAndTravel 추가 성공");
					
					session.setAttribute("login", mem);
					
//					request.setAttribute("travel_seq", travel_seq);
//					request.setAttribute("id", id);
					response.sendRedirect("traveldetail.do?travel_seq=" + invite_seq);
					
//					dispatcher = request.getRequestDispatcher("traveldetail.do");
//					dispatcher.forward(request, response);
					
				}else{
					System.out.println("로그인 실패");
				}
			
		}else{
			System.out.println("회원가입 실패");
			response.sendRedirect("main.do");
//			dispatcher = request.getRequestDispatcher("main.do");
//			dispatcher.forward(request, response);
		}
		//response.sendRedirect("views/main/main.jsp");

	}
	
	@RequestMapping(value = "invitelogin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void invitelogin(Model model, HttpServletResponse response, HttpServletRequest request, int invite_seq, String id, String pwd) throws Exception {
		logger.info("Welcome MemberAndTravelController invitelogin.do! " + new Date());

		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		MemberDTO member = new MemberDTO();
		member.setId(id);
		member.setPwd(pwd);
		
		MemberAndTravelDTO memberAndTravelDTO = new  MemberAndTravelDTO();
		memberAndTravelDTO.setId(id);
		memberAndTravelDTO.setTravel_seq(invite_seq);
		
		MemberDTO mem = memberService.login(member);
		boolean isS = memberAndTravelService.inviteAddMemberAndTravel(memberAndTravelDTO);
		
		HttpSession session = request.getSession();
		
		
		if(mem!=null && !mem.getId().equals("") && isS){
			System.out.println("로그인 성공");
			System.out.println("MemberAndTravel 추가 성공");
			
			session.setAttribute("login", mem);

		}else{
			System.out.println("로그인 실패");
		}
				
//		request.setAttribute("travel_seq", invite_seq);
		response.sendRedirect("traveldetail.do?travel_seq=" + invite_seq);
		
		// RequestDispatcher dispatcher = request.getRequestDispatcher("traveldetail.do");
		// dispatcher.forward(request, response);

	}
	
		@RequestMapping(value = "exitFromMemberAndTravel.do", method = { RequestMethod.GET, RequestMethod.POST })
		public void deleteMemberAndTravel(Model model, HttpServletResponse response, HttpServletRequest request, String id, int travel_seq) throws Exception {
			logger.info("Welcome MemberAndTravelController exitFromMemberAndTravel.do! " + new Date());

			System.out.println("exitFromMemberAndTravel id="+id);
			System.out.println("exitFromMemberAndTravel travel_seq="+travel_seq);
			
			
			MemberAndTravelDTO memberAndTravelDTO = new MemberAndTravelDTO();
			memberAndTravelDTO.setId(id);
			memberAndTravelDTO.setTravel_seq(travel_seq);
	
			memberAndTravelService.exitFromMemberAndTravel(memberAndTravelDTO);


			response.sendRedirect("traveldetail.do?travel_seq=" + travel_seq);
		

		}
}
