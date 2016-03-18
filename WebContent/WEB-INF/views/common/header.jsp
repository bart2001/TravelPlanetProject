<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<html>

<head>
<meta name="viewport" content="width=device-width, initial-scale=1">


<title>Insert title here</title>

<!-- 부트스트랩  + jquery -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<!-- 풀캘린더 / moment -->
<link rel='stylesheet' href='css/fullcalendar.min.css' />
<script src='js/moment.min.js'></script>
<script src='js/fullcalendar.min.js'></script>

<!-- full calendar 한글화 -->
<script src='js/lang-all.js'></script>
  
<!-- jquery datepicker(날짜선택기) -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<!-- form 검증 플러그인 -->
<script type="text/javascript" src="js/jquery.validate.js"></script>

<!-- 서머노트 -->
<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.1/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.1/summernote.js"></script>

<!-- 서머노트 한국어 적용 -->
<script src="js/summernote-ko-KR.js"></script>

<!-- 폰트 -->
<link rel="stylesheet" href="css/font.css"  type="text/css">

<!-- jquery cookie -->
<script src="js/jquery.cookie.js"></script>

<style>
/* Remove the navbar's default rounded borders and increase the bottom margin */
.white{
	color:white;
}

.navbar {
   margin-bottom: 50px;
   border-radius: 0;
}

#myNavbar a{
	color:white;
}

#myNavbar a:hover{
	color:grey;
}

/* Remove the jumbotron's default bottom margin */
.jumbotron {
   margin-top: 20px; 
   margin-bottom: 0;
   text-align: center;
}
/* Add a gray background color and some padding to the footer */
footer {
   /* background-color: #f2f2f2; */
   padding: 25px;
   background-color: grey;
   color: white;
}

/* 부트스트랩  modal(로그인팝업) */
.modal-header, h4, .close {
   background-color: #5cb85c;
   color: white !important;
   text-align: center;
   font-size: 30px;
}

.modal-footer {
   background-color: #f9f9f9;
}

.item img {
   width: 100% !important;
   height: 500px !important;
}

.person {
   border: 10px solid transparent;
   margin-bottom: 25px;
   width: 80%;
   height: 80%;
   opacity: 1.0;
}

.person:hover {
   border-color: #aaaaaa;
}

.sidebar-nav{
margin-top: 60px;
position: fixed;
}

.content{
   margin-top: 60px;

}

.draggable{
	font-size: 15px;
	text-align: center;
	
}
.fieldset {
	width: 170px;
    font-family: sans-serif;
    border: 1px solid black;
    background: white;
    border-radius: 5px;
    padding: 15px;
    align:center
}

.fieldset legend {
    background: white;
    color: black;
    font-size: 14px;
    width:75%;
    text-align: center;
    margin-left: 12.5%;
    padding: 0;
    margin-bottom: 5;
}

.sub-draggable{
	text-align:center;
	margin-top: 0px;
}

.travelBtn{
	width: 200px;
}

.title{
	font-size: 15px;
}

.clearable{
  background: #fff url(http://i.stack.imgur.com/mJotv.gif) no-repeat right -10px center;
  border: 1px solid #999;
  padding: 3px 18px 3px 4px;     /* Use the same right padding (18) in jQ! */
  border-radius: 3px;
  transition: background 0.4s;
}
.clearable.x  { background-position: right 5px center; } /* (jQ) Show icon */
.clearable.onX{ cursor: pointer; }              /* (jQ) hover cursor style */
.clearable::-ms-clear {display: none; width:0; height:0;} /* Remove IE default X */


</style>


</head>
<body>
   <nav class="navbar navbar-inverse navbar-fixed-top" style="background-color: #40597F; border: 0px solid #40597F;">
      <div class="container-fluid" >
         <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
               <span class="icon-bar"></span>
               <span class="icon-bar"></span>
               <span class="icon-bar"></span>               
            </button>        
           <!--  <a class="navbar-brand" href="main.do">TRAVEL PLANET</a> -->
            <div style="display: inline-flex">
            <a  href="main.do"><img src="image/PLANET.png" class="img-circle" alt="Cinque Terre" style="height: 40px; width: 40px; margin-top: 12%"/></a>&nbsp; &nbsp;<a class="navbar-brand home" href="main.do" style="color:white;"> TRAVEL PLANET</a> 
            </div>
            
         </div>
         <div class="collapse navbar-collapse" id="myNavbar">         	
            <ul class="nav navbar-nav title">            
               <c:if test="${not empty login}">
                  <li><a id="travelcreate_btn">일정작성</a></li>
               </c:if>
               <c:if test="${empty login}">
                  <li><a id="travelcreate_nologin_btn">일정작성</a></li>
               </c:if>
               <li><a href="travelsearch.do">일정찾기</a></li>
               <li><a href="newsfeed.do">뉴스피드</a></li>
               <li><a href="#" onClick="window.open('http://lpmagazine.co.kr/')">여행정보</a></li>
               <li><a href="#" onClick="window.open('http://www.hotelscombined.co.kr/')">숙박</a></li>
               <li><a href="#" onClick="window.open('http://www.skyscanner.co.kr/')">항공</a></li>
                       
                  <!-- 로그인한 본인과 일치할 경우만 정보수정 탭 활성화 -->
				<c:if test="${login.auth == 1}">
					<li><a href="admin.do">회원관리</a></li>
				</c:if>               
            </ul>

            <ul class="nav navbar-nav navbar-right">
               <c:if test="${empty login}">
               	
                  <li><a id="login_btn" href="#"><span
                        class="glyphicon glyphicon-log-in"></span> Login</a></li>
               </c:if>
               <c:if test="${not empty login}"> 
                  <li><a href="mypage.do"><span class="glyphicon glyphicon-user"></span> 
                  ${login.id}님 </a></li>
                  <li><a href="logout.do"><span
                        class="glyphicon glyphicon-log-out"></span> Logout</a></li>
               </c:if>
            </ul>
         </div>
      </div>
   </nav>


   <!-- 부트스트랩  modal(로그인팝업) -->
   <div class="modal fade" id="login_Modal" role="dialog" data-view="">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header"
               style="padding: 35px 50px; background-color: #49B2E9">
               <button type="button" class="close" data-dismiss="modal">&times;</button>
               <h4 style="background-color: #49B2E9">
                  <span class="glyphicon glyphicon-lock"
                     style="background-color: #49B2E9"></span>로그인
               </h4>
            </div>
            <div class="modal-body" style="padding: 40px 50px;">
               <form id="login-check-form" role="form" method="post">
                  <div class="form-group">
                     <label for="id"><span class="glyphicon glyphicon-user"></span>아이디</label> 
                     <input id="id" type="text" class="form-control" name="id" placeholder="아이디를 입력하세요">
                  </div>
                  <div class="form-group">
                     <label for="pwd"><span
                        class="glyphicon glyphicon-eye-open"></span>비밀번호</label> <input
                        type="password" class="form-control" name="pwd" id="pwd"
                        placeholder="비밀번호를 입력하세요">
                  </div>
                  <div class="login-check">
                  	<label id="login-check-label" style="display: none; color: red;">아이디 또는 비밀번호가 일치하지 않습니다.</label>
                  </div>
                  <div class="checkbox">
                     <label><input id="id_save" type="checkbox" value="">저장해두기</label>
                  </div>                  
               </form>
               <button class="btn btn-info btn-block" id="login-btn"
                     style="background-color: #49B2E9">
                     <span class="glyphicon glyphicon-off"
                        style="background-color: #49B2E9"></span> 로그인
                  </button>
            </div>
            <div class="modal-footer">               
               <p>회원이 아니신가요? <a id="regi_btn" href="#">회원가입</a></p>
               <p>비밀번호를 잊으셨나요? <a id="pwd_find_btn">비밀번호 찾기</a></p>
            </div>
         </div>
      </div>
   </div>


   <!-- 부트스트랩  modal(회원가입팝업) -->
   <div class="modal fade" id="regi_Modal" role="dialog">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header"
               style="padding: 35px 50px; background-color: #49B2E9">
               <button type="button" class="close" data-dismiss="modal">&times;</button>
               <h4 style="background-color: #49B2E9">
                  <span class="glyphicon glyphicon-lock"
                     style="background-color: #49B2E9"></span>회원가입
               </h4>
            </div>
            <div class="modal-body" style="padding: 40px 50px;">
               <form id="regi-check-form" role="form" method="post" action="${invite_seq == null? 'regi.do' : 'inviteregi.do'}">               	
               	  <label for="id"><span class="glyphicon glyphicon-user"></span>아이디</label><br>
                  <div class="form-group" >
                     <input type="text" class="form-control" name="regi_id" id="regi_id" placeholder="아이디를 입력하세요">
                  </div>
                  <div class="form-group">
                     <label for="pwd"><span
                        class="glyphicon glyphicon-eye-open"></span>비밀번호</label>
                        <input type="password" class="form-control" name="regi_pwd" id="regi_pwd" placeholder="비밀번호를 입력하세요">
                  </div>
                  <div class="form-group">
                     <label for="pwd"><span
                        class="glyphicon glyphicon-eye-open"></span>비밀번호 확인</label> <input
                        type="password" class="form-control" name="regi_pwd_check" id="regi_pwd_check"
                        placeholder="비밀번호를 다시한번 입력하세요">
                  </div>
           
                  <div class="form-group">
                     <label for="name"><span class="glyphicon glyphicon-user"></span>이메일</label>
                     <input type="text" class="form-control" name="regi_email" id="regi_email" placeholder="이메일을 입력하세요">
                  </div>
                       <!-- style="display: inline-flex" -->
<!-- 						<div class="form-inline"> -->
							<div class="form-group">
								<label for="birth"><span class="glyphicon glyphicon-user"></span>출생연도 </label>
								<% 
									Calendar cal = Calendar.getInstance();
			                   		int startyear = cal.get(Calendar.YEAR);
			                   		int endyear = startyear-100; 
								%>
								<select id="regi_birth" name="regi_birth" class="form-control">
									<c:forEach var="i" begin="<%=endyear%>" end="<%=startyear%>" step="1">
										<option value="${i}">${i}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label for="sex"><span class="glyphicon glyphicon-user"></span>성별</label>
								<select name="regi_sex" id="regi_sex" class="form-control">
									<option value="0">남자</option>
									<option value="1">여자</option>
								</select>
							</div>							
<!-- 						</div> -->
						<input type="hidden" name="invite_seq" id="invite_seq" value="${invite_seq}">
                  <div class="regi-check">
                  	<label id="regi-check-label" style="display: none; color: red;">회원정보를 모두 입력해주세요.</label>
                  </div>
                  <br>                  
	                  <button class="btn btn-info btn-block" type="submit"
	                     id="regi-submit-btn" style="background-color: #49B2E9">
	                     <span class="glyphicon glyphicon-off" style="background-color: #49B2E9"></span>회원가입
	                  </button>
               </form>
            </div>
            <div class="modal-footer">
               <button type="submit" class="btn btn-default pull-left"
                  data-dismiss="modal">
                  <span class="glyphicon glyphicon-remove"></span> 취소
               </button>
            </div>
         </div>
      </div>
   </div>
   
   
     <!-- 부트스트랩  modal(로그인팝업) -->
   <div class="modal fade" id="pwd_find_Modal" role="dialog" data-view="">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header"
               style="padding: 35px 50px; background-color: #49B2E9">
               <button type="button" class="close" data-dismiss="modal">&times;</button>
               <h4 style="background-color: #49B2E9">
                  <span class="glyphicon glyphicon-lock"
                     style="background-color: #49B2E9"></span>비밀번호 찾기
               </h4>
            </div>
            <div class="modal-body" style="padding: 40px 50px;">
               <form id="pwd-mail-send-form" role="form" method="post" action="pwdmailsend.do">
                  <div class="form-group">
                     <label for="id">등록된 이메일로 임시 비밀번호를 전송합니다</label> 
                     <input type="text" class="form-control" id="pwd_find_id" name="id" placeholder="등록하신 아이디를 입력하세요">
                  </div>              
					<button class="btn btn-info btn-block" id="pwd-mail-send-btn" style="background-color: #49B2E9">메일 전송
               </button>
               </form>
            </div>            
         </div>
      </div>
   </div>
   
   



   <!-- 부트스트랩  modal(일정작성 팝업) -->
   <div class="modal fade" id="travelcreate_Modal" role="dialog">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header"
               style="padding: 35px 50px; background-color: #49B2E9">
               <button type="button" class="close" data-dismiss="modal">&times;</button>
               <h4 style="background-color: #49B2E9">
                  <span class="glyphicon glyphicon-pencil"
                     style="background-color: #49B2E9"></span>새로운 여행일정 만들기
               </h4>
            </div>
            <div class="modal-body" style="padding: 40px 50px;">
               <form id="travel-create-form" role="form" action="travelcreate.do" method="post">
                  <div class="form-group">
                     <label for="title"><span class="glyphicon glyphicon-pencil"></span>여행제목</label>
                        <input type="text" value="${login.id}님의 여행" class="form-control" id="travel_title" name="title" placeholder="여행제목">
                  </div>
                  <div class="form-group">
                  <span class="glyphicon glyphicon-pencil"></span><label>여행설명</label>
                  <input id="content_check" type="checkbox" value="">
				  <input id="content_text" type="text" class="form-control" id="travel_content" name="content" placeholder="여행에 대한 간단한 설명" readonly="readonly">
                  </div>
                  <div class="form-group">
                     <label class="radio-inline">
                     	<input type="radio" name="done" id="travel_done" value="0" checked>여행전
                     </label>
                     <label class="radio-inline">
                     	<input type="radio" name="done" id="travel_done" value="1">여행후
                     </label>
                  </div>
                  <div class="form-group">
                  	<span class="glyphicon glyphicon-calendar"></span>
                     <label>여행시작일</label>
                     <!-- DateTimePicker 위젯를 적용하기 위한 TextBox를 선언한다. -->                     
                     <input type="text" class="form-control" id="defaultDate" name="defaultDate">
                  </div>
                  <div class="form-group">
                     <label for="members"><span
                        class="glyphicon glyphicon-user"></span>여행인원</label>
                        <input type="number" min="1" class="form-control" id="travel_members" name="members"
                        placeholder="몇명이 여행을 가나요?" value="1">
                  </div>
                  <div class="form-group">
                     <label for="region"><span
                        class="glyphicon glyphicon-plane"></span>여행지</label>
                     <select id="travel_region"
                        class="form-control" name="region">
                        <option value="gl" selected="selected">글로벌</option>
                        <option value="kr">한국</option>
                        <option value="as">아시아</option>
                        <option value="eu">유럽</option>
                        <option value="na">북미</option>
                        <option value="sa">남미</option>
                        <option value="af">아프리카</option>
                     </select>
                  </div>
                  <button type="submit" class="btn btn-info btn-block"
                     style="background-color: #49B2E9">
                     <span class="glyphicon glyphicon-off"
                        style="background-color: #49B2E9"></span> 작성시작
                  </button>
               </form>
            </div>
            <div class="modal-footer">
               <button type="submit" class="btn btn-default pull-left"
                  data-dismiss="modal">
                  <span class="glyphicon glyphicon-remove"></span> 취소
               </button>
            </div>
         </div>
      </div>
   </div>



  <!-- 부트스트랩  modal( 포스트,여행일정 삭제시 확인 팝업) -->
<div class="container">
  <!-- Trigger the modal with a button -->
  <!-- <button type="button" class="btn btn-info btn-lg" id="deleteBtn">Open Modal</button> -->

  <!-- Modal -->
  <div class="modal fade" id="deleteModal" role="dialog">
    <div class="modal-dialog">   
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header"  style="background-color: #49B2E9">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h3 class="modal-title">게시물 삭제</h3>
        </div>
        <div class="modal-body">
          <p><strong>해당 게시물을 삭제 하시겠습니까?</strong></p>
        </div>
        <div class="modal-footer">
        	<button id="modal_delete_btn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-trash"></span>삭제</button>
        	<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span>취소</button>
        </div>
      </div>
      
    </div>
  </div> 
</div>




 <!-- 부트스트랩  modal( 회원 삭제시 확인 팝업) -->
<div class="container">
  <!-- Modal -->
  <div class="modal fade" id="deleteMemberModal" role="dialog">
    <div class="modal-dialog">   
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="background-color: #49B2E9">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h3 class="modal-title">Travel Planet 확인메세지</h3>
        </div>
        <div class="modal-body">
        
         <c:if test="${login.auth == 1}">
          <p><strong>정말 회원을 삭제 하시겠습니까?</strong></p>
         </c:if> 
         
          <c:if test="${login.auth == 0}">
          <p><strong>정말 회원 탈퇴 하시겠습니까?</strong></p>
          </c:if>
          
        </div>
        <div class="modal-footer">
        	<button id="modal_delete_membebr_btn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-trash"></span>삭제</button>
        	<button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span>취소</button>
        </div>
      </div>
      
    </div>
  </div> 
</div>







<!-- travel_seq가 있을 경우 로그인 팝업창 띄우기 -->
<c:if test="${not empty invite_seq}">
	<script type="text/javascript">
	//alert("seq가 있으니 초대 로그인 팝업을 띄운다")
	//alert('${invite_seq}');
	$("#login_Modal").modal();		
	</script>
</c:if>

   <script>
      $(document).ready(function() {    	      	  	
    	  
    	  	// 로그인 아이디 입력란 쿠키 저장 설정
    	  	$("#login-btn").click(function(){    	  		
    		  	if ($("#id_save").is(':checked')) {
    		  		$.cookie('id', $("#id").val());
    		  	}
    		  	if ($("#id_save").is(':unchecked')) {
    		  		$.cookie('id', null); 
    		  	}
    		});  	  
    
               /* 로그인팝업(모달) 띄울때 쿠키에 저장된 아이디 가져오기 */
               $("#login_btn").click(function() {
                  $("#login_Modal").modal(); 
                  
                if ($.cookie('id') != null && $.cookie('id') != '') {
          	  		$("#id_save").attr("checked", true);    	  		
          	  		$("#id").val($.cookie('id'));
          	  	} else {
          	  		$("#id_save").attr("checked", false);    	  		
      	  			$("#id").val('');         	  		
          	  	} 
               });
               
               $("#login-btn").click(function() {
               var id = $("#id").val();
               var pwd = $("#pwd").val();
			         $.ajax({
			                url:'logincheck.do',		                 
			                data: {id: id, pwd: pwd},
			                dataType: "text",
			                success: function(data) {		
				                var isS = data;
				               	if (isS == 1) {
				               		// ${travel_seq}가 있을 경우 -> 초대 로그인
				               		if ('${invite_seq}' != null && '${invite_seq}') {
				               			$("#login-check-form").attr("action", "invitelogin.do?invite_seq=" + '${invite_seq}' );
					               		$("#login-check-form").submit();				               							   
				               		// ${travel_seq}가 없을 경우 -> 일반 로그인
				               		} else {
				               			$("#login-check-form").attr("action", "login.do");
					               		$("#login-check-form").submit();				  	
				               		}
				               		             		
				               		
				               	}else{				               		
				               		$("#login-check-label").show();
				               	}
			               	},
					          	error: function() {
					               	//alert("로그인 체크 실패");		                	 
					        	}
					})
               }); 

               /* 회원가입팝업  */
               $("#regi_btn").click(function() {
                  $("#login_Modal").modal("hide");
                  $("#regi_Modal").modal();
               });
               
               $("#pwd_find_btn").click(function() {
                   $("#login_Modal").modal("hide");
                   $("#pwd_find_Modal").modal();
                });

               /* 일정작성팝업 모델 */
               $("#travelcreate_btn").click(function() {
                  $("#travelcreate_Modal").modal();
               });
               
               /* 일정작성눌렀을 때 (로그인 안했을 시 ) */
               $("#travelcreate_nologin_btn").click(function() {
                  $("#login_Modal").modal();
               });

               /* 일정작성팝업 여행설명  */
               $("#content_check").click(function() {
                  if ($("#content_check").is(":checked")) {
                     //alert("checked");
                     $("#content_text").attr("readonly", false);
                  } else {
                     $("#content_text").attr("readonly", true);
                     //alert("not checked");
                  }
               });

               /* 일정작성팝업 달력 */
               $("#defaultDate").datepicker();
               $("#defaultDate").datepicker("option", "dateFormat", "yy-mm-dd");

               /* 일정작성 팝업 달력 한글화*/
               $.datepicker.regional['ko'] = {
                  closeText : '닫기',
                  prevText : '이전달',
                  nextText : '다음달',
                  currentText : '오늘',
                  monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
                        '7월', '8월', '9월', '10월', '11월', '12월' ],
                  monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
                        '7월', '8월', '9월', '10월', '11월', '12월' ],
                  dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
                  dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
                  dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
                  weekHeader : 'Wk',
                  dateFormat : 'yy-mm-dd',
                  firstDay : 0,
                  isRTL : false,
                  showMonthAfterYear : true,
                  yearSuffix : '년'
               };
               $.datepicker.setDefaults($.datepicker.regional['ko']);

               /* 로그아웃 */
               $("#logout_btn").click(function() {
                  location.href = "logout.do";
               });                             
               
               //  jquery validation 회원가입 모달 검사             
               $("#regi-check-form").validate({
                   //규칙
                   rules: {
                	   regi_id: {
                           required : true,                           
                           minlength: 4,
                           remote:  {                           
	                           url: "regicheck.do",
	                           type: "post",
	                           data: {regi_id : function() {
	                        	   return $("#regi_id").val()
	                           		}
	                       		}	                           
                           }                         
                       },
                       regi_pwd: {
                           required : true,
                           minlength: 4
                       },
                       regi_pwd_check: {
                           required : true,
                           equalTo : "#regi_pwd"
                       },
                       regi_email: {
                           required : true,
                           email : true
                       }

                },
                   //규칙체크 실패시 출력될 메시지
                   messages : {
                       regi_id: {
                           required : "아이디를 입력해주세요",                           
                           remote : "존재하는 아이디입니다",
							minlength: "아이디는 최소 4글자입니다"
                       },
                       regi_pwd: {
                           required : "비밀번호를 입력해주세요",
                           minlength: "비밀번호는 최소 4글자입니다"
                       },
                       regi_pwd_check: {
                           required : "비밀번호확인을 입력해주세요",
                           equalTo : "비밀번호가 일치하지 않습니다"
                       },
                       regi_email: {
                           required : "이메일을 입력해주세요",
                           email : "이메일 형식이 아닙니다"
                       }
                   }
				});
               
            // jquery validation 일정작성 모달 검사
			$("#travel-create-form").validate({                   
				rules: {
					title: {required : true},									
					defaultDate : {required : true, date: true},
					members : {required : true}													
				},
			//규칙체크 실패시 출력될 메시지
			messages : {
				title: {required : "여행제목을 입력해주세요"},									
				defaultDate : {required : "여행시작일을 입력해주세요",date: "날짜 형식이 아닙니다."},
				members : {required : "여행인원을 입력해주세요"}				
				}
			});
            
		    // jquery validation 일정작성 모달 검사
			$("#pwd-mail-send-form").validate({                   
				rules: {
					id: {
                        required : true,
                        remote:  {                           
	                       url: "regicheck.do",
	                       type: "post",
	                       data: {
	                    	   regi_id : function() {
									return $("#pwd_find_id").val()
							   },
							   pwd_find : "true"
	                       }	                           
                        }                       
                    }													
				},
			//규칙체크 실패시 출력될 메시지
			messages : {
				id: {
					required : "아이디를 입력해주세요",
					remote : "존재하지 않는 아이디입니다"				
				}						
			}
		});
            
             
       	  	var date = new Date();
       	    var temp = date.getFullYear()-20; 
       	    $("#regi_birth").val(temp);
            	
            });
               
            /*포스트, 여행일정 삭제시 확인 팝업  */
            $("#deleteBtn").click(function(){
                $("#deleteModal").modal("show");
            });
                $("#deleteModal").on('show.bs.modal', function () {
                   // alert('The modal is about to be shown.');
            });
            
           
            /*포스트, 여행일정 삭제시 확인 팝업  */
            $("#deleteMemberBtn").click(function(){
                $("#deleteMemberModal").modal("show");
            });
                $("#deleteMemberModal").on('show.bs.modal', function () {
                       // alert('The modal is about to be shown.');
            });
                    
                
                
                
                
   </script>
  

   
</body>
</html>