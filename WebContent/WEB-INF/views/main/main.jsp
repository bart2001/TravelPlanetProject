<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<!DOCTYPE html>
<!-- header -->
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="jumbotron banner">
	<div id="maincount" style="margin-top: 2%;font-size: 30px"><span>누구나 쉽게 작성하는 여행노트,&nbsp;&nbsp;</span><span>트래블 플래닛</span><span>을 통해 지금까지 
		<span style ="color: #40597F; font-weight: bold;">${totalMemberCount}</span>명이 <span style ="color: #40597F ;font-weight: bold;">${totalTravelCount}</span>번의 여행을 떠났습니다.</span></div>
	</div>
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
		<!-- Indicators -->
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
			<li data-target="#myCarousel" data-slide-to="2"></li>
			<li data-target="#myCarousel" data-slide-to="3"></li>
		</ol>

		<!-- Wrapper for slides -->
		<div class="carousel-inner" role="listbox">
			<div class="item active">
				<a href="#"
					onClick="window.open('https://www.lonelyplanet.com/singapore')"><img
					src="image/asia4.jpg" alt="singapore"> </a>
			</div>

			<div class="item">
				<a href="#"
					onClick="window.open('https://www.lonelyplanet.com/victoria-falls-town')"><img
					src="image/europe3.jpg" alt="florence"></a>
			</div>

			<div class="item">
				<a href="#"
					onClick="window.open('http://www.lonelyplanet.com')"><img
					src="image/europe1.jpg" alt="hallsatt"></a>
			</div>
			<div class="item">
				<a href="#"
					onClick="window.open('https://www.lonelyplanet.com/austria/salzkammergut/hallstatt')"><img
					src="image/korea2.jpg" alt="jusanji"></a>
			</div>
		</div>

		<!-- Left and right controls -->
		<a class="left carousel-control" href="#myCarousel" role="button"
			data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"
			aria-hidden="true"></span> <span class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#myCarousel" role="button"
			data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
	
	<br>
	<div class="container-fluid " id="travel-container" >
		<h3 class="hanna-title">최근 여행일정</h3>
		<br>
		<div class="row">
			<c:forEach var="travel" items="${travelList}" begin="0" end="2" varStatus="vs">
			<li class="travel" style="list-style: none;">
				<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
					<div class="panel panel-default">						
						<div class="panel-heading" class="hanna-title" style="background-color: #28A8DE;border-color: #28A8DE">																									
							<c:forEach items="${memberAndTravelList}" var="memberAndTravel">
								<c:if test="${travel.travel_seq == memberAndTravel.travel_seq}">
									<c:forEach items="${memberList}" var="member">
										<c:if test="${member.id == memberAndTravel.id}">										
											<img src="profileImage/${member.img}" alt="${member.img}" style="width: 30px; height: 30px;" class="img-circle">
										</c:if>
									</c:forEach>								
									<a style="color: white; text-decoration: none;" href="mypage.do?id=${memberAndTravel.id}">&nbsp;${memberAndTravel.id}</a>
									<!-- 로그인한 아이디와 일치할 경우 여행일정 삭제 아이콘 보여주기 -->
									<c:if test="${not empty login}">
										<!-- 관리자 모드 -->
										<c:if test="${login.auth == 1}">
											<span class="glyphicon glyphicon-remove-circle remove-travel-icon white"
											data-travel_seq="${travel.travel_seq}" style="float: right;"></span>
										</c:if>
										<!-- 일반회원 모드 -->
										<c:if test="${login.auth != 1}">
											<c:if test="${login.id == memberAndTravel.id}">
												<span style="float: right;"
												class="glyphicon glyphicon-remove-circle remove-travel-icon white"
												data-travel_seq="${travel.travel_seq}"></span>
											</c:if>
										</c:if>
									</c:if>
								</c:if>
							</c:forEach>
						</div>						
						<div class='panel-body' id="divWithImage${travel.travel_seq}" style='background-size: 100%; height: 110px; background-size: cover; background-position: center;'
						onclick="location.href='traveldetail.do?travel_seq=${travel.travel_seq}'">
							<h2 align="center" style="color: white; text-shadow: 0 0 1px black;width:300px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis" class="hanna-title">															
									${travel.title}								
							</h2>	
							<h2 id = 'customized' align="right" style="color: white; text-shadow: 0 0 1px black; margin-right: -5%" class="hanna-title">
								${travel.customized == 0?  "Original" : "Customized"}
							</h2>				
						</div>
						<script type="text/javascript">
							var randomNumber = Math.floor(Math.random() * 5) + 1;						
							switch ('${travel.region}') {
							  case 'kr' : $("#divWithImage" + '${travel.travel_seq}').css("background-image", "url(image/korea" + randomNumber + ".jpg)");
								break;							
							  case 'gl' : $("#divWithImage" + '${travel.travel_seq}').css("background-image", "url(image/global" + randomNumber + ".jpg)");
											break;
							  case 'as' : $("#divWithImage" + '${travel.travel_seq}').css("background-image", "url(image/asia" + randomNumber + ".jpg)");
											break;
							  case 'af' : $("#divWithImage" + '${travel.travel_seq}').css("background-image", "url(image/africa" + randomNumber + ".jpg)");
											break;
							  case 'na' : $("#divWithImage" + '${travel.travel_seq}').css("background-image", "url(image/northamerica" + randomNumber + ".jpg)");
				               				break;
							  case 'sa' : $("#divWithImage" + '${travel.travel_seq}').css("background-image", "url(image/southamerica" + randomNumber + ".jpg)");
				               				break;
							  case 'eu' : $("#divWithImage" + '${travel.travel_seq}').css("background-image", "url(image/europe" + randomNumber + ".jpg)");
	               							break;
							  default : $("#divWithImage" + '${travel.travel_seq}').css("background-image", "url(image/travel_background.jpg)");							               
							}							
						</script>										
						<div class='panel-body' onclick="location.href='traveldetail.do?travel_seq=${travel.travel_seq}'">
							<div style="text-decoration: none; color: black;">				
								<div style="width:340px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis"><b class="hanna-mini-title">${travel.title}</b></div>
								<br>
								<c:if test="${not empty travel.content}">				
								<div style="width:340px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis">${travel.content}</div>
								</c:if>
								<c:if test="${empty travel.content}">				
									<div style="color: gray; font-weight: lighter;">입력된 내용이 없습니다 </div>						                                                   
								</c:if>
							</div>						
						</div>
																														
						<div class="panel-footer">
							<span class="glyphicon glyphicon-thumbs-up travel-thumbs-up"></span>
							<!-- 로그인이 되었을 경우  -->
							<c:if test="${not empty travelLikeList}">
								<!-- 좋아요를 눌렀을 경우메나 파란색+진하게 엄지마크 표시하기  -->
								<c:forEach items="${travelLikeList}" var="travelLike">
									<c:if test="${travel.travel_seq == travelLike}">
										<script type="text/javascript">
											$("span.travel-thumbs-up").eq(
													'${vs.index}').css({
												'color' : 'blue',
												'font-weight' : 'bold'
											});
										</script>
									</c:if>
								</c:forEach>
							</c:if>
							<c:forEach items="${travelLikeCountMapList}" var="travelLikeCountMap">
								<c:if test="${travelLikeCountMap.TRAVEL_SEQ == travel.travel_seq}">
									<span class="travel_like_count" data-seq="${travel.travel_seq}">${travelLikeCountMap.COUNT}</span>
								</c:if>
							</c:forEach>
							<span class="glyphicon glyphicon-comment"></span>
							<c:forEach items="${travelAnswerCountMapList}"
								var="travelAnswerCountMap">
								<c:if
									test="${travelAnswerCountMap.TRAVEL_SEQ eq travel.travel_seq}">
									<span class="travel_answer_count">${travelAnswerCountMap.COUNT}</span>
								</c:if>
							</c:forEach>
							&nbsp;							
							<c:if test="${travel.done == 0}">							
								여행전
							</c:if>							
							<c:if test="${travel.done == 1}">
								여행후
							</c:if>															
							&nbsp;
							<c:if test="${travel.budget != 0}">
								<b>&#8361;</b><fmt:formatNumber value="${travel.budget}" type="number" groupingUsed="true"/>
							</c:if>
													
							
							
							
							<span style="float: right;" class="wdate" data-wdate="${travel.wdate}">
								${fn:substring(travel.wdate, 0, 16)}																
							</span>				
							
						</div>
					</div>
				</div>
			</li>
		</c:forEach>
		
		</div>
	
		<div align="right">
			<h3 class="hanna-title"> <a href="travelsearch.do">더보기</a></h3>
		</div>
	</div> 
	
	<div class="container-fluid" id="post-container">
		<h3 class="hanna-title">최근 포스트</h3>
		<br>
		 <div class="row">
			<c:forEach items="${postList}" var="post" begin="0" end="2" varStatus="vs">
			<li class="post" style="list-style: none;">
				<div class="col-sm-4">			
<!-- 				<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 box"> -->
					<div class="panel panel-default">
						<div class="panel-heading" style="background-color: #28A8DE;border-color: #28A8DE">						
								<c:forEach var="member" items="${memberList}">								
									<c:if test="${member.id == post.id}">
										<!-- 회원 개인이 업로드한 이미지가 있는 경우 -->
										<c:if test="${not empty member.img}">
											<img src="profileImage/${member.img}" alt="${member.img}" style="width:30px; height:30px;" class="img-circle">
										</c:if>
										<!-- 회원 개인이 업로드한 이미지가 없는 경우 기본 사람모양 아이콘 활용 -->
										<c:if test="${empty member.img}">
											<img src="image/default-user-icon-profile.png" style="width:30px; height:30px;" class="img-circle">
										</c:if>
									</c:if>
								</c:forEach>
								
									&nbsp;<a style="color: white;" href="mypage.do?id=${post.id}">${post.id}</a>
								
								
									<!-- 로그인한 아이디와 일치할 경우 포스트 삭제 아이콘 보여주기 -->
									<c:if test="${not empty login}">
										<!-- 관리자 모드 -->
										<c:if test="${login.auth == 1}">
											<span
												class="glyphicon glyphicon-remove-circle remove-post-icon white"
												data-post_seq="${post.post_seq}" style="float: right;"></span>
											<!-- <span style="float: right;" class="glyphicon glyphicon-remove-circle"></span> -->
										</c:if>
										<c:if test="${login.auth != 1}">
											<c:if test="${login.id == post.id}">
												<span style="float: right;"
													class="glyphicon glyphicon-remove-circle remove-post-icon white" 
													data-post_seq="${post.post_seq}"></span>
											</c:if>
										</c:if>
									</c:if>							
						</div>						
						<div class="panel-body" onclick="location.href='postdetail.do?post_seq=${post.post_seq}'">
							<div style="text-decoration: none; color: black;">							
							<div style="width:340px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis"><b class="hanna-mini-title">${post.title}</b></div>
							<br>						
							<c:if test="${not empty post.content}">							
							<div style="width:340px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis">${post.content}</div>
							</c:if>
							<c:if test="${empty post.content}">				
								<div style="color: gray; font-weight: lighter;">입력된 내용이 없습니다 </div>						                                                   
							</c:if>
							</div>
						</div>						
						<div class="panel-footer">
							<span class='glyphicon glyphicon-thumbs-up post-thumbs-up'></span>
							<!-- 로그인이 되었을 경우  -->							
								<!-- 좋아요를 눌렀을 경우메나 파란색+진하게 엄지마크 표시하기  -->
								<c:forEach items="${postLikeList}" var="postLike">
									<c:if test="${post.post_seq == postLike}">
										<script type="text/javascript">
											$("span.post-thumbs-up").eq(
													'${vs.index}').css({
												'color' : 'blue',
												'font-weight' : 'bold'
											});
										</script>
									</c:if>
								</c:forEach>
							<c:forEach items="${postLikeCountMapList}" var="postLikeCountMap">
								<c:if test="${postLikeCountMap.POST_SEQ == post.post_seq}">
								
									<span class="post_like_count" data-seq="${post.post_seq}">${postLikeCountMap.COUNT}  									
									</span>
								</c:if>
							</c:forEach>
							<span class="glyphicon glyphicon-comment"></span>
							<c:forEach items="${postAnswerCountMapList}" var="postAnswerCountMap">
								<c:if test="${postAnswerCountMap.POST_SEQ == post.post_seq}">
									<span class="post_answer_count">${postAnswerCountMap.COUNT}</span>
								</c:if>
							</c:forEach>
							&nbsp;
							<c:if test="${post.budget != 0}">
									<b>&#8361;</b><fmt:formatNumber value="${post.budget}" type="number" groupingUsed="true"/>
							</c:if>
							<span style="float: right;" class="wdate" data-wdate="${post.wdate}">${fn:substring(post.wdate, 0, 16)}</span>
						</div>
					</div>
				</div>
			</li>
			</c:forEach>

		</div> 
		<div align="right">
			<h3 class="hanna-title"><a href="newsfeed.do">더보기</a></h3>
		</div>
	</div>

	<div class="container-fluid text-center ">
		<h3>Who We Are</h3>
		<p>
			<em>TravelPlanner!</em>
		</p>
		<br>
		<div class="row">
			<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
				<p>
					<strong>이병우</strong>
				</p>
				<br> <a href="#"
					onClick="window.open('https://www.facebook.com/bart2001')"><img
					src="image/bw.png" style="width: 150px; height: 200px"
					alt="Random Name" class="person"></a>
			</div>
			<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
				<p>
					<strong>박혜지</strong>
				</p>
				<br> <a href="#"
					onClick="window.open('https://www.facebook.com/profile.php?id=100002611470227')"><img
					src="image/hj.jpg" style="width: 150px; height: 200px"
					alt="Random Name" class="person"></a>
			</div>
			<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
				<p>
					<strong>김다예</strong>
				</p>
				<br> <a href="#"
					onClick="window.open('https://www.facebook.com/profile.php?id=100002010175470')"><img
					src="image/dy.jpg" style="width: 150px; height: 200px"
					alt="Random Name" class="person"></a>
			</div>
			<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
				<p>
					<strong>홍상원</strong>
				</p>
				<br> <a href="#"
					onClick="window.open('https://www.facebook.com/hongsangwon')"><img
					src="image/sw.jpg" style="width: 150px; height: 200px"
					alt="Random Name" class="person"></a>
			</div>
		</div>
	</div>
	<br>
	<br>
	<!--  footer -->
	<jsp:include page="../common/footer.jsp"></jsp:include>
	
<!-- 로그인 되었을 때만 좋아요버튼 클릭 가능 -->
<c:if test="${not empty login}">	
<script type="text/javascript">	 
$(document).ready(function() {	
		// 최근 포스트 좋아요 증가시키기(ajax)					
		$("span.post-thumbs-up").click(function() {
			var $this = $(this);
			var index = $("span.post-thumbs-up").index(this);									
			var post_seq = $("span.post_like_count").eq(index).data("seq");
			var likeCount = Number($("span.post_like_count").eq(index).text());				
			//alert("index = " + index + " / post_seq  = " + post_seq + " / likeCount = " + likeCount);
											 
			// 좋아요를 누르지 않은 경우(rgb 값으로 체크해야됨)
	         if ($this.css("color") != "rgb(0, 0, 255)") {
	        	// alert("좋아요 누르지 않은 게시물");
        	$.ajax({
                 url:'postlikeup.do',		                 
                 data: {post_seq: post_seq},
                 dataType: "text",
                 success: function(data) {                	 
                	 // 컨트롤러에서 좋아요 증가에 성공했을 경우
                	 if (data == 1) {
                		// 좋아요 아이콘 색 변화		                	
	                	$this.css({"color": "blue", "font-weight" : "bold"});
	                	
	                	// 좋아요 1 증가		                	    	
	                	$("span.post_like_count:eq("+ index +")").text(likeCount + 1)
	                	//alert("post_seq: " + post_seq + " 좋아요 증가"); 		                	 
                	 }   	
                 },
                 error: function() {
                	// alert("좋아요 증가 실패");		                	 
                 },
             });
        	 
        // 이미 좋아요를 누른 경우
         } else {
        	// alert("좋아요 누른 게시물");
        		$.ajax({
                 url:'postlikedown.do',		                 
                 data: {post_seq: post_seq},
                 dataType: "text",
                 success: function(data) {
                	 
                	 // 컨트롤러에서 좋아요 증가에 실패했을 경우
                	 if (data == 1) {       		 
                		 
	                	 // 좋아요 아이콘 색 변화		                	
	                	$this.css({"color": "black", "font-weight" : "normal"});
	                	
	                	// 좋아요 1 감소		                	    	
	                	$("span.post_like_count").eq(index).text(likeCount - 1)
	                	//alert("post_seq: " + post_seq + " 좋아요 감소");		                		 
                	 }		                	
                 },
                 error: function() {
                	// alert("좋아요 감소 실패");		                	 
                 },
             });	        	     
        	 
         }
      });
		
	// 최근 여행일정 좋아요 증가시키기(ajax)					
	$("span.travel-thumbs-up").click(function() {
		var $this = $(this);
		var index = $("span.travel-thumbs-up").index(this);									
		var travel_seq = $("span.travel_like_count").eq(index).data("seq");
		var likeCount = Number($("span.travel_like_count").eq(index).text());				
		//alert("index = " + index + " / travel_seq  = " + travel_seq + " / like = " + likeCount);
										 
	// 좋아요를 누르지 않은 경우(rgb 값으로 체크해야됨)
       if ($this.css("color") != "rgb(0, 0, 255)") {
      	 //alert("좋아요 누르지 않은 게시물");
     	$.ajax({
              url:'travellikeup.do',		                 
              data: {travel_seq: travel_seq},
              dataType : "text",
              success: function(data) {
             	 
             	 // 컨트롤러에서 좋아요 증가에 성공했을 경우
             	 if (data == 1) {
             		// 좋아요 아이콘 색 변화		                	
              	$this.css({"color": "blue", "font-weight" : "bold"});
              	
              	// 좋아요 1 증가		                	    	
              	$("span.travel_like_count").eq(index).text(likeCount + 1)
              	//alert("travel_seq: " + travel_seq + " 좋아요 증가"); 		                	 
             	 }   	
              },
              error: function() {
             	// alert("좋아요 증가 실패");		                	 
              },
          });
     	 
     // 이미 좋아요를 누른 경우
      } else {
     	 alert("좋아요 누른 게시물");
     		$.ajax({
              url:'travellikedown.do',		                 
              data: {travel_seq: travel_seq},
              dataType: "text",
              success: function(data) {
             	 
             	 // 컨트롤러에서 좋아요 증가에 실패했을 경우
             	 if (data == 1) {		                		 
             		 
              	 // 좋아요 아이콘 색 변화		                	
              	$this.css({"color": "black", "font-weight" : "normal"});
              	
              	// 좋아요 1 감소		                	    	
              	$("span.travel_like_count").eq(index).text(likeCount - 1)
              //	alert("travel_seq: " + travel_seq + " 좋아요 감소");		                		 
             	 }		                	
              },
              error: function() {
             	// alert("좋아요 감소 실패");		                	 
              }
          });	        	     
     	 
      }
   });

 	$("span.remove-travel-icon").click(function() {
		var travel_seq = $(this).data("travel_seq");	
		$("#deleteModal").modal();		
		$("#modal_delete_btn").click(function() {						
		//	alert("travel_seq = " + travel_seq + "를 삭제합니다!!!");
			location.href = "traveldelete.do?travel_seq=" + travel_seq;
		});	
	});		 		
	
	$("span.remove-post-icon").click(function() {
		var post_seq = $(this).data("post_seq");	
		$("#deleteModal").modal();		
		$("#modal_delete_btn").click(function() {						
			//alert("post_seq = " + post_seq + "를 삭제합니다!!!");
			location.href = "postdelete.do?post_seq=" + post_seq;
		});		
	});

});


</script>
</c:if>				


