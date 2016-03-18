<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<style>
.modal-vertical-centered {
	transform: translate(0, 50%) !important;
	-ms-transform: translate(0, 50%) !important; /* IE 9 */
	-webkit-transform: translate(0, 50%) !important;
	/* Safari and Chrome */
}
</style>

<!-- header -->
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="jumbotron" >
<br>
	<div class="container text-center">
		<c:forEach var="member" items="${memberList}">
			<c:if test="${member.id == id}">
				<!-- 회원 개인이 업로드한 이미지가 있는 경우 -->
				<c:if test="${not empty member.img}">
					<img src="profileImage/${member.img}" alt="${member.img}"
						style="display: inline; width: 200px; height: 200px;"
						class="img-responsive img-circle margin">
				</c:if>
				<!-- 회원 개인이 업로드한 이미지가 없는 경우 기본 사람모양 아이콘 활용 -->
				<c:if test="${empty member.img}">
					<img src="image/default-user-icon-profile.png"
						style="display: inline; width: 200px; height: 200px;"
						class="img-responsive img-circle margin">
				</c:if>
			</c:if>
		</c:forEach>
		<br> <br>
		<c:if test="${login.id eq id}">
			<span style="font-size: 20px"
				class="glyphicon glyphicon-camera profileupload_span"></span>
			<br>
		</c:if>
		<br>
		<p class="hanna-title">${id}님의 프로필</p>
	</div>
</div>

<div class="container-fluid">
	<ul class="nav nav-tabs">
		<li class="active"><a href="#menu1">여행일정</a></li>
		<li><a href="#menu2">포스트</a></li>
		<!-- 로그인한 본인과 일치할 경우만 정보수정 탭 활성화 -->
		<c:if test="${not empty login}">
			<c:if test="${login.id == id}">
				<li id="regiupdate_btn"><a href="#menu3">정보수정</a></li>
			</c:if>
		</c:if>
	</ul>

	<div class="tab-content">
		<div id="menu1" class="tab-pane fade in active">
			<br>
			<div class="row">
				<div class="col-xs-9 col-sm-9 col-md-9 col-lg-9">
					<h3 style="display: inline;" class="hanna-title" >여행일정</h3>
				</div>
				<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2"
					style="text-align: right; display: inline-flex;">
					<button id="travel_new_list_btn" type="submit"
						class="btn btn-default">최신순</button>
					&nbsp;&nbsp;
					<button id="travel_answer_list_btn" type="submit"
						class="btn btn-default">댓글순</button>
					&nbsp;&nbsp;
					<button id="travel_like_list_btn" type="submit"
						class="btn btn-default">좋아요순</button>
				</div>
			</div>
			<br>
			<div class="row" id="myTravel">
				<c:forEach var="travel" items="${travelDTOlist}" varStatus="vs">
					<li class="travel" style="list-style: none;">
						<div class="col-sm-4">
							<div class="panel panel-default">
								<div class="panel-heading" style="background-color: #28A8DE;border-color: #28A8DE">
									<c:forEach var="member" items="${memberList}">
										<c:if test="${member.id == id}">
											<!-- 회원 개인이 업로드한 이미지가 있는 경우 -->
											<c:if test="${not empty member.img}">
												<img src="profileImage/${member.img}" alt="${member.img}"
													style="width: 30px; height: 30px;" class="img-circle">
											</c:if>
											<!-- 회원 개인이 업로드한 이미지가 없는 경우 기본 사람모양 아이콘 활용 -->
											<c:if test="${empty member.img}">
												<img src="image/default-user-icon-profile.png"
													style="width: 30px; height: 30px;" class="img-circle">
											</c:if>
										</c:if>
									</c:forEach>
									<a style="color: white;" href="mypage.do?id=${id}">${id}</a>
									<div style="display: inline-block; float: right;">
										<c:if test="${login.id == id}">
											<c:if test="${travel.open == 1 }">
												<img class="openBtn" src="image/glyphicons-204-lock.png"
													style="vertical-align: baseline;" width="15px"
													height="15px" data-seq="${travel.travel_seq}" />
											</c:if>
											<c:if test="${travel.open == 0 }">
												<img class="openBtn" src="image/glyphicons-205-unlock.png"
													style="vertical-align: baseline;" width="15px"
													height="15px" data-seq="${travel.travel_seq}" />
											</c:if>
										</c:if>
										<!-- 로그인한 아이디와 일치할 경우 여행일정 삭제 아이콘 보여주기 -->
										<!-- 관리자 모드 -->
										<c:if test="${login.auth == 1}">
										&nbsp;
										<span style="padding-top: 5px; font-size: 15px"
												class="glyphicon glyphicon-remove-circle remove-travel-icon white"
												data-travel_seq="${travel.travel_seq}"></span>
										</c:if>
										<!-- 일반회원 모드 -->
										<c:if test="${login.id == id}">
										&nbsp;
										<span style="padding-top: 5px; font-size: 15px;"
												class="glyphicon glyphicon-remove-circle remove-travel-icon white"
												data-travel_seq="${travel.travel_seq}"></span>
										</c:if>
									</div>
								</div>
								<div class='panel-body' id="divWithImage${travel.travel_seq}"
									style='background-size: 100%; height: 110px; background-size: cover; background-position: center;'>
									<h2 align="center"
										style="color: white; text-shadow: 0 0 1px black;width:300px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis"
										class="hanna-title">
										<a style="color: white; text-decoration: none;"
											href="traveldetail.do?travel_seq=${travel.travel_seq}">
											${travel.title} </a>
									</h2>
									<h2 id='customized' align="right"
										style="color: white; text-shadow: 0 0 1px black; margin-right: -5%"
										class="hanna-title">${travel.customized == 0?  "Original" : "Customized"}
									</h2>
								</div>
								<script type="text/javascript">
									var randomNumber = Math
											.floor(Math.random() * 5) + 1;
									switch ('${travel.region}') {
									case 'kr':
										$(
												"#divWithImage"
														+ '${travel.travel_seq}')
												.css(
														"background-image",
														"url(image/korea"
																+ randomNumber
																+ ".jpg)");
										break;
									case 'gl':
										$(
												"#divWithImage"
														+ '${travel.travel_seq}')
												.css(
														"background-image",
														"url(image/global"
																+ randomNumber
																+ ".jpg)");
										break;
									case 'as':
										$(
												"#divWithImage"
														+ '${travel.travel_seq}')
												.css(
														"background-image",
														"url(image/asia"
																+ randomNumber
																+ ".jpg)");
										break;
									case 'af':
										$(
												"#divWithImage"
														+ '${travel.travel_seq}')
												.css(
														"background-image",
														"url(image/africa"
																+ randomNumber
																+ ".jpg)");
										break;
									case 'na':
										$(
												"#divWithImage"
														+ '${travel.travel_seq}')
												.css(
														"background-image",
														"url(image/northamerica"
																+ randomNumber
																+ ".jpg)");
										break;
									case 'sa':
										$(
												"#divWithImage"
														+ '${travel.travel_seq}')
												.css(
														"background-image",
														"url(image/southamerica"
																+ randomNumber
																+ ".jpg)");
										break;
									case 'eu':
										$(
												"#divWithImage"
														+ '${travel.travel_seq}')
												.css(
														"background-image",
														"url(image/europe"
																+ randomNumber
																+ ".jpg)");
										break;
									default:
										$(
												"#divWithImage"
														+ '${travel.travel_seq}')
												.css("background-image",
														"url(image/travel_background.jpg)");
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
									<!-- 로그인한 경우 본인이 좋아요한 여행일정 엄지모양 파란색으로 바꾸기 -->
									<c:if test="${not empty travelLikeList}">
										<c:forEach items="${travelLikeList}" var="travelLike">
											<c:if test="${travelLike == travel.travel_seq}">
												<script type="text/javascript">
													$("span.travel-thumbs-up")
															.eq('${vs.index}')
															.css(
																	{
																		'color' : 'blue',
																		'font-weight' : 'bold'
																	});
												</script>
											</c:if>
										</c:forEach>
									</c:if>
									<!-- 좋아요 갯수 뿌려주기 -->
									<c:forEach items="${travelLikeMapList}" var="travel_like">
										<c:if test="${travel_like.TRAVEL_SEQ == travel.travel_seq}">
											<span class="travel_like_count"
												data-seq="${travel.travel_seq}">${travel_like.COUNT}</span>
										</c:if>
									</c:forEach>	
									<span class="glyphicon glyphicon-comment"></span>
									<!-- 댓글 갯수 뿌려주기 -->
									<c:forEach items="${travelAnswerMapList}" var="travel_answer">
										<c:if test="${travel_answer.TRAVEL_SEQ eq travel.travel_seq}">
											<span class="travel_answer_count">${travel_answer.COUNT}</span>
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
									<span style="float: right;" class="wdate"
										data-wdate="${travel.wdate}">
										${fn:substring(travel.wdate, 0, 16)} </span>
								</div>
							</div>
						</div>
					</li>
				</c:forEach>
			</div>
		</div>
		<div id="menu2" class="tab-pane fade">
			<br>
			<div class="row">
				<div class="col-xs-9 col-sm-9 col-md-9 col-lg-9">
					<h3 style="display: inline;" class="hanna-title" >포스트</h3>
				</div>
				<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2"
					style="text-align: right; display: inline-flex;">
					<button id="post_new_list_btn" type="submit"
						class="btn btn-default">최신순</button>
					&nbsp;&nbsp;
					<button id="post_answer_list_btn" type="submit"
						class="btn btn-default">댓글순</button>
					&nbsp;&nbsp;
					<button id="post_like_list_btn" type="submit"
						class="btn btn-default">좋아요순</button>
				</div>
			</div>
			<br>
			<div class="row" id="myPost">
				<c:forEach var="post" items="${postDTOlist}" varStatus="vs">
					<li class="post" style="list-style: none;">
						<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
							<div class="panel panel-default">
								<div class="panel-heading" style="background-color: #28A8DE;border-color: #28A8DE">
									<c:forEach var="member" items="${memberList}">
										<c:if test="${member.id == post.id}">
											<!-- 회원 개인이 업로드한 이미지가 있는 경우 -->
											<c:if test="${not empty member.img}">
												<img src="profileImage/${member.img}" alt="${member.img}"
													style="width: 30px; height: 30px;" class="img-circle">
											</c:if>
											<!-- 회원 개인이 업로드한 이미지가 없는 경우 기본 사람모양 아이콘 활용 -->
											<c:if test="${empty member.img}">
												<img src="image/default-user-icon-profile.png"
													style="width: 30px; height: 30px;" class="img-circle">
											</c:if>
										</c:if>
									</c:forEach>
									&nbsp;<a style="color: white;" href="mypage.do?id=${post.id}">${post.id}</a>
									<!-- 로그인한 아이디와 일치할 경우 여행일정 삭제 아이콘 보여주기 -->
									<c:if test="${not empty login}">
										<!-- 관리자 모드 -->
										<c:if test="${login.auth == 1}">
											<span
												class="glyphicon glyphicon-remove-circle remove-post-icon white"
												data-post_seq="${post.post_seq}" style="float: right;"></span>
										</c:if>
										<!-- 일반회원 모드 -->
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
									<span class="glyphicon glyphicon-thumbs-up post-thumbs-up"></span>
									<!-- 로그인한 경우 포스트 좋아요 아이콘 파란색으로 바꿔주기 -->
									<c:forEach items="${postLikeList}" var="postLike">
										<c:if test="${postLike == post.post_seq}">
											<script type="text/javascript">
												$("span.post-thumbs-up").eq(
														'${vs.index}').css({
													'color' : 'blue',
													'font-weight' : 'bold'
												});
											</script>
										</c:if>
									</c:forEach>
									<!-- 각 포스트 좋아요 갯수 뿌려주기 -->
									<c:forEach items="${postLikeMapList}" var="postLikeCountMap">
										<c:if test="${postLikeCountMap.POST_SEQ eq post.post_seq}">
											<span class="post_like_count" data-seq="${post.post_seq}">${postLikeCountMap.COUNT}</span>
										</c:if>
									</c:forEach>
									<span class="glyphicon glyphicon-comment"></span>
									<!-- 각 포스트 댓글 갯수 뿌려주기 -->
									<c:forEach items="${postAnswerMapList}"
										var="postAnswerCountMap">
										<c:if test="${postAnswerCountMap.POST_SEQ == post.post_seq}">
											<span class="post_answer_count">${postAnswerCountMap.COUNT}</span>
										</c:if>
									</c:forEach>
									&nbsp;
									<c:if test="${post.budget != 0}">
									<b>&#8361;</b><fmt:formatNumber value="${post.budget}" type="number" groupingUsed="true"/>
									</c:if>
									<span style="float: right;" class="wdate"
										data-wdate="${post.wdate}">${fn:substring(post.wdate, 0, 16)}</span>
								</div>
							</div>
						</div>
					</li>
				</c:forEach>
			</div>
		</div>
		<div id="menu3" class="tab-pane fade">
			<h3 class="hanna-title" >정보수정</h3>
			<p>정보수정입니다..</p>
		</div>
	</div>
</div>

<!--  footer -->
<jsp:include page="../common/footer.jsp"></jsp:include>


<!-- 부트스트랩  modal(회원정보수정 팝업) -->
<div class="modal fade" id="regiupdate_Modal" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"
				style="padding: 35px 50px; background-color: #49B2E9">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 style="background-color: #49B2E9">
					<span class="glyphicon glyphicon-lock"
						style="background-color: #49B2E9"></span>회원정보수정
				</h4>
			</div>
			<div class="modal-body" style="padding: 40px 50px;">

				<form role="form" method="post" action="updatemember.do" id="pwd-check-form">
					<div class="form-group">
						<label for="id"><span class="glyphicon glyphicon-user"></span>
							아이디</label> <input type="text" class="form-control" name="id"
							value="${login.id}" readonly="readonly">
					</div>
					<div class="form-group">
						<label for="pwd"><span
							class="glyphicon glyphicon-eye-open"></span> 비밀번호</label> <input
							type="text" class="form-control" name="current_pwd"
							id="current_pwd" placeholder="현재비밀번호">
					</div>
					<div class="form-group">
						<label for="pwd"><span
							class="glyphicon glyphicon-eye-open"></span> 새 비밀번호</label> <input
							type="text" class="form-control" name="new_pwd" id="new_pwd"
							placeholder="새비밀번호">
					</div>

					<div class="form-group">
						<label for="pwd"><span
							class="glyphicon glyphicon-eye-open"></span> 새 비밀번호 확인</label> <input
							type="text" class="form-control" name="new_pwd_again" placeholder="새비밀번호 재입력">
					</div>

					<div class="form-group">
						<label for="name"><span
							class="glyphicon glyphicon-eye-open"></span>이메일</label> <input
							type="text" class="form-control" name="email"
							value="${login.email}">
					</div>
					<div class="form-group">
						<label for="birth"><span
							class="glyphicon glyphicon-eye-open"></span> 출생년도</label> <input
							type="text" class="form-control" name="birth"
							value="${login.birth}년도" readonly="readonly">
					</div>
					<div class="form-group">
						<label for="sex"><span
							class="glyphicon glyphicon-eye-open"></span> 성별</label> 
							<c:if test="${login.sex eq 0}">
							<input type="text" class="form-control" name="sex" value="남자" readonly="readonly">
							</c:if>
							<c:if test="${login.sex eq 1}">
							<input type="text" class="form-control" name="sex" value="여자" readonly="readonly">
							</c:if>
					</div>
					<button type="submit" class="btn btn-info btn-block"
						style="background-color: #49B2E9">
						<span class="glyphicon glyphicon-pencil"
							style="background-color: #49B2E9"></span>&nbsp;회원정보수정
					</button>
				</form>
				<br>
				<!-- <form role="form" method="post" action="memberdelete.do"> -->
				<%-- <input type="hidden" name="id" value="${login.id}"> --%>
				<button id="deleteMemberBtn" class="btn btn-info btn-block"
					data-id="${login.id}" style="background-color: #49B2E9">
					<span class="glyphicon glyphicon-remove-circle "
						style="background-color: #49B2E9"></span>&nbsp;회원탈퇴
				</button>
				<!-- </form> -->

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

<!-- 사진 업로드 팝업 -->
<div class="modal fade" id="profileupload_Modal" role="dialog">
	<div class="modal-dialog modal-sm modal-vertical-centered">
		<div class="modal-content">
			<div class="modal-header"
				style="padding: 10px 10px; background-color: #49B2E9">사진 업로드</div>
			<div class="modal-body" style="padding: 10px 15px;">
				<!-- 이미지 업로드 폼 -->
				<form method="post" enctype="multipart/form-data"
					action="profileupload.do" id="profileupload_form">
					<input type="hidden" name="id" value="${login.id}" /> <input
						type="file" name="file">
				</form>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-default pull-left"
					data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span> 취소
				</button>
				<button type="submit"
					class="btn btn-default pull-left profileupload_btn"
					data-dismiss="modal">
					<span class="glyphicon glyphicon-check"></span> 올리기
				</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(document)
			.ready(
					function() {
						/* 업로드 팝업 */
						$(".profileupload_span").click(function() {
							$("#profileupload_Modal").modal();
						});

						/* 업로트 submit */
						$(".profileupload_btn").click(function() {
							$("#profileupload_form").submit();
						});

						/* 회원정보수정 팝업 */
						$("#regiupdate_btn").click(function() {
							$("#regiupdate_Modal").modal();
						});

						/* 마이페이지 탭(여행일정/포스트/정보수정)*/
						$(".nav-tabs a").click(function() {
							$(this).tab('show');
						});

						// travel 정렬
						// 댓글많은순으로 정렬
						$("#travel_answer_list_btn")
								.click(
										function() {
											// 화면에 보여진 것들의 갯수 받아오기
											var count = $('li.travel:visible').length;
											// 일단 전부 숨겨주고					
											$("li.travel").hide();
											// 정렬 후 넣어주기
											$("li.travel")
													.sort(
															function(a, b) {
																var a_count = parseInt($(
																		a)
																		.find(
																				".travel_answer_count")
																		.text());
																var b_count = parseInt($(
																		b)
																		.find(
																				".travel_answer_count")
																		.text());
																return b_count
																		- a_count;
															}).appendTo(
															"div#myTravel");
											// 처음에 보여진 갯수만큼 잘라서 보여주기					
											$("li.travel").slice(0, count)
													.show();
										});

						// 좋아요 많은순으로 정렬
						$("#travel_like_list_btn")
								.click(
										function() {
											// 화면에 보여진 것들의 갯수 받아오기
											var count = $('li.travel:visible').length;
											// 전부 일단 숨겨주고					
											$("li.travel").hide();
											// 정렬!
											$("li.travel")
													.sort(
															function(a, b) {
																var a_count = parseInt($(
																		a)
																		.find(
																				".travel_like_count")
																		.text());
																var b_count = parseInt($(
																		b)
																		.find(
																				".travel_like_count")
																		.text());
																return b_count
																		- a_count;
															}).appendTo(
															"div#myTravel");
											// 처음에 보여진 갯수만큼 잘라서 보여주기
											$("li.travel").slice(0, count)
													.show();
										});

						//최신순으로 정렬
						$("#travel_new_list_btn").click(
								function() {
									// 화면에 보여진 것들의 갯수 받아오기
									var count = $('li.travel:visible').length;
									// 전부 일단 숨겨주고					
									$("li.travel").hide();
									// 정렬!
									$("li.travel").sort(
											function(a, b) {
												var a_wdate = $(a).find(
														"span.wdate").data(
														"wdate");
												var b_wdate = $(b).find(
														"span.wdate").data(
														"wdate");
												if (a_wdate > b_wdate) {
													return -1;
												} else if (a_wdate < b_wdate) {
													return 1;
												} else {
													return 0;
												}
											}).appendTo("div#myTravel");
									// 처음에 보여진 갯수만큼 잘라서 보여주기
									$("li.travel").slice(0, count).show();
								});
						// post 정렬
						// 댓글많은순으로 정렬
						$("#post_answer_list_btn")
								.click(
										function() {
											// 화면에 보여진 것들의 갯수 받아오기
											var count = $('li.post:visible').length;
											// 일단 전부 숨겨주고					
											$("li.post").hide();
											// 정렬 후 넣어주기
											$("li.post")
													.sort(
															function(a, b) {
																var a_count = parseInt($(
																		a)
																		.find(
																				".post_answer_count")
																		.text());
																var b_count = parseInt($(
																		b)
																		.find(
																				".post_answer_count")
																		.text());
																return b_count
																		- a_count;
															}).appendTo(
															"div#myPost");
											// 처음에 보여진 갯수만큼 잘라서 보여주기					
											$("li.post").slice(0, count).show();
										});

						// 좋아요 많은순으로 정렬
						$("#post_like_list_btn")
								.click(
										function() {
											// 화면에 보여진 것들의 갯수 받아오기
											var count = $('li.post:visible').length;
											// 전부 일단 숨겨주고					
											$("li.post").hide();
											// 정렬!
											$("li.post")
													.sort(
															function(a, b) {
																var a_count = parseInt($(
																		a)
																		.find(
																				".post_like_count")
																		.text());
																var b_count = parseInt($(
																		b)
																		.find(
																				".post_like_count")
																		.text());
																return b_count
																		- a_count;
															}).appendTo(
															"div#myPost");
											// 처음에 보여진 갯수만큼 잘라서 보여주기
											$("li.post").slice(0, count).show();
										});

						//최신순으로 정렬
						$("#post_new_list_btn").click(
								function() {
									// 화면에 보여진 것들의 갯수 받아오기
									var count = $('li.post:visible').length;
									// 전부 일단 숨겨주고					
									$("li.post").hide();
									// 정렬!
									$("li.post").sort(
											function(a, b) {
												var a_wdate = $(a).find(
														"span.wdate").data(
														"wdate");
												var b_wdate = $(b).find(
														"span.wdate").data(
														"wdate");
												if (a_wdate > b_wdate) {
													return -1;
												} else if (a_wdate < b_wdate) {
													return 1;
												} else {
													return 0;
												}
											}).appendTo("div#myPost");
									// 처음에 보여진 갯수만큼 잘라서 보여주기
									$("li.post").slice(0, count).show();
								});

						$("span.remove-travel-icon")
								.click(
										function() {
											var travel_seq = $(this).data(
													"travel_seq");
											var delete_confirm = confirm("travel_seq = "
													+ travel_seq
													+ "를 삭제하시겠습니까?");
											if (delete_confirm == true) {
												location.href = "traveldelete.do?travel_seq="
														+ travel_seq;
											}
											//alert(delete_confirm);
											// alert(travel_seq);		
										});

						$("span.remove-post-icon")
								.click(
										function() {
											var post_seq = $(this).data(
													"post_seq");
											//alert(post_seq);
											var delete_confirm = confirm("post_seq = "
													+ post_seq + "를 삭제하시겠습니까?");
											if (delete_confirm == true) {
												location.href = "postdelete.do?post_seq="
														+ post_seq;
											}
											//alert(delete_confirm);
											// alert(post_seq);		
										});

						//회원탈퇴
						$("#deleteMemberBtn").click(function() {
							//alert("들어옵니다.");
							var id = $(this).data("id");
							$("#regiupdate_Modal").hide();
							$("#deleteMemberModal").modal();
							$("#modal_delete_membebr_btn").click(function() {
								location.href = "memberdelete.do?id=" + id;
							});
						});

						$("#pwd-check-form").validate({
							//규칙
							rules : {
								current_pwd : {
									required : true,
									remote : {
										url : "pwdcheck.do",
										type : "post",
										data : {
											current_pwd : function() {
												return $("#current_pwd").val();	
											}
										}
									}
								},
								new_pwd : {
									required : true
								},
								new_pwd_again : {
									required : true,
									equalTo : "#new_pwd"
								}
							},
							//규칙체크 실패시 출력될 메시지
							messages : {
								current_pwd : {
									required : "현재 비밀번호를 입력해주세요",
									remote : "비밀번호가 일치하지 않습니다"
								},
								new_pwd : {
									required : "새 비밀번호를 입력해주세요",
								},
								new_pwd_again : {
									required : "새 비밀번호를 한번 더 입력해주세요",
									equalTo : "새 비밀번호와 일치하지 않습니다"
								}
							}/* ,
							// validation이 끝난 이후의 submit 직전 추가 작업할 부분
							submitHandler : function(f) {
								$("#pwd-check-form").submit();
							} */
						});

					});
</script>

<!-- 로그인 되었을 때만 좋아요버튼 클릭 가능 -->
<c:if test="${not empty login}">
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							// 최근 포스트 좋아요 증가시키기(ajax)					
							$("span.post-thumbs-up")
									.click(
											function() {
												var $this = $(this);
												var index = $(
														"span.post-thumbs-up")
														.index(this);
												var post_seq = $(
														"span.post_like_count")
														.eq(index).data("seq");
												var likeCount = Number($(
														"span.post_like_count")
														.eq(index).text());
												//alert("index = " + index+ " / post_seq는  = "+ post_seq+ " / likeCount = " + likeCount);

												// 좋아요를 누르지 않은 경우(rgb 값으로 체크해야됨)
												if ($this.css("color") != "rgb(0, 0, 255)") {
													//alert("좋아요 누르지 않은 게시물");
													$
															.ajax({
																url : 'postlikeup.do',
																data : {
																	post_seq : post_seq
																},
																dataType : "text",
																success : function(
																		data) {
																	var isS = data;
																	// 컨트롤러에서 좋아요 증가에 성공했을 경우
																	if (isS) {
																		// 좋아요 아이콘 색 변화		                	
																		$this
																				.css({
																					"color" : "blue",
																					"font-weight" : "bold"
																				});

																		// 좋아요 1 증가		                	    	
																		$(
																				"span.post_like_count:eq("
																						+ index
																						+ ")")
																				.text(
																						likeCount + 1)
																		//alert("post_seq: "+ post_seq+ " 좋아요 증가");
																	}
																},
																error : function() {
																	//alert("좋아요 증가 실패");
																},
															});

													// 이미 좋아요를 누른 경우
												} else {
													//alert("좋아요 누른 게시물");
													$
															.ajax({
																url : 'postlikedown.do',
																data : {
																	post_seq : post_seq
																},
																dataType : "text",
																success : function(
																		data) {
																	var isS = data;
																	// 컨트롤러에서 좋아요 증가에 실패했을 경우
																	if (isS) {
																		//alert("isS = "+ isS);
																		// 좋아요 아이콘 색 변화		                	
																		$this
																				.css({
																					"color" : "black",
																					"font-weight" : "normal"
																				});

																		// 좋아요 1 감소		                	    	
																		$(
																				"span.post_like_count")
																				.eq(
																						index)
																				.text(
																						likeCount - 1)
																		//alert("post_seq: "+ post_seq+ " 좋아요 감소");
																	}
																},
																error : function() {
																	//alert("좋아요 감소 실패");
																},
															});

												}
											});

							// 최근 여행일정 좋아요 증가시키기(ajax)					
							$("span.travel-thumbs-up")
									.click(
											function() {
												var $this = $(this);
												var index = $(
														"span.travel-thumbs-up")
														.index(this);
												var travel_seq = $(
														"span.travel_like_count")
														.eq(index).data("seq");
												var likeCount = Number($(
														"span.travel_like_count")
														.eq(index).text());
												//alert("index = " + index+ " / travel_seq  = "+ travel_seq+ " / like = "+ likeCount);

												// 좋아요를 누르지 않은 경우(rgb 값으로 체크해야됨)
												if ($this.css("color") != "rgb(0, 0, 255)") {
													//alert("좋아요 누르지 않은 게시물");
													$
															.ajax({
																url : 'travellikeup.do',
																data : {
																	travel_seq : travel_seq
																},
																dataType : "text",
																success : function(
																		data) {
																	var isS = data;
																	// 컨트롤러에서 좋아요 증가에 성공했을 경우
																	if (isS) {
																		// 좋아요 아이콘 색 변화		                	
																		$this
																				.css({
																					"color" : "blue",
																					"font-weight" : "bold"
																				});

																		// 좋아요 1 증가		                	    	
																		$(
																				"span.travel_like_count")
																				.eq(
																						index)
																				.text(
																						likeCount + 1)
																		//alert("travel_seq: " + travel_seq + " 좋아요 증가");
																	}
																},
																error : function() {
																	//alert("좋아요 증가 실패");
																},
															});

													// 이미 좋아요를 누른 경우
												} else {
													//alert("좋아요 누른 게시물");
													$
															.ajax({
																url : 'travellikedown.do',
																data : {
																	travel_seq : travel_seq
																},
																dataType : "text",
																success : function(
																		data) {
																	var isS = data;
																	// 컨트롤러에서 좋아요 증가에 실패했을 경우
																	if (isS) {
																		//alert("isS = " + isS);
																		// 좋아요 아이콘 색 변화		                	
																		$this
																				.css({
																					"color" : "black",
																					"font-weight" : "normal"
																				});

																		// 좋아요 1 감소		                	    	
																		$(
																				"span.travel_like_count")
																				.eq(
																						index)
																				.text(
																						likeCount - 1)
																		//alert("travel_seq: "+ travel_seq+ " 좋아요 감소");
																	}
																},
																error : function() {
																	//alert("좋아요 감소 실패");
																},
															});

												}
											});
						});
	</script>
</c:if>
<script>
	$(document).ready(function() {
		$(".openBtn").click(function() {
			var $this = $(this);
			var index = $("img.openBtn").index(this);
			var travel_seq = $("img.openBtn").eq(index).data("seq");
			var unlock = "image/glyphicons-205-unlock.png";
			var lock = "image/glyphicons-204-lock.png";
			$.ajax({
				url : 'travelopen.do',
				data : {
					travel_seq : travel_seq
				},
				dataType : "text",
				success : function(data) {
					if (data == 1) {
						if ($this.attr("src") == unlock) {
							$this.attr("src", lock);
						} else if ($this.attr("src") == lock) {
							$this.attr("src", unlock);
						}
					} else {
						//alert("data = 2");
						//alert(travel_seq + "번 여행일정의 공개/비공개 설정 변경 실패");
					}
				},
				error : function() {
					//alert("통신 실패");
				}
			});
			return false;
		});
	});
</script>
