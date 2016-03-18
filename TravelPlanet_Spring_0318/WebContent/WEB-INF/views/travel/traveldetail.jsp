<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<!-- header -->
<jsp:include page="../common/header.jsp"></jsp:include>

<script>
	var eventArray = [];
	var defaultDate;
	var memberandtravelArray = [];
</script>
<!-- eventlist만큼 자바스크립트 배열 생성해주기 -->
<c:if test="${not empty eventList}">
	<c:forEach items="${eventList}" var="event">
		<script>
			var eventObject = {};
			eventObject.title = '${event.title}';
			eventObject.start = '${event.start_time}';
			eventObject.end = '${event.end_time}';
			eventObject.lat = parseFloat('${event.lat}');
			eventObject.lng = parseFloat('${event.lng}');
			eventArray.push(eventObject);
		</script>
	</c:forEach>
	<script>
		defaultDate = moment(eventArray[0].start).format('YYYY-MM-DD');
	</script>
</c:if>

<c:if test="${empty eventList}">
	<script>
		var dt = new Date();
		var month = dt.getMonth() + 1 < 10 ? "0" + (dt.getMonth() + 1) : ""
				+ (dt.getMonth() + 1);
		var day = dt.getDate() < 10 ? "0" + dt.getDate() : "" + dt.getDate();
		var year = dt.getFullYear();
		defaultDate = year + "-" + month + "-" + day;
	</script>
</c:if>
<script>
	
</script>

<div class="col-sm-3 sidenav sidebar-nav" style="width: 20%">
	<div style="text-align: center">
		<p>
			<img src="profileImage/<c:out value='${profileImg}'/>"
				style="display: inline; width: 80px; height: 80px;"
				class="img-circle" alt="profile">
		</p>
		<p>ID: ${writerID} / accessLevel: ${accessLevel}</p>
		<br> <br>
	</div>
	<div style="margin-left: 15px">
		
			<!-- 목록보기 버튼 -->
			<form id="form" method="post" action="travelsearch.do"
				style="display: inline;">
				<button id="submit" type="submit" class="btn btn-default travelBtn"
					name="travelsearchBtn">목록보기</button>
			</form>
			<br><br>
		<!-- 복사하기 버튼 -->
			<c:if test="${accessLevel > 0}">
		<form id="form" method="post" action="travelcopy.do"
			style="display: inline;">
			<input id="travel_seq" type="hidden" name="travel_seq"
				value="${travel.travel_seq}"> <input id="id" type="hidden"
				name="id" value="${login.id}">

		
				<button id="copyBtn" class="btn btn-default travelBtn"
					name="copyBtn">복사하기</button>
				</form>
			</c:if>
	
		<br> <br>

		<div>
			<!-- '수정'버튼 클릭시 넘겨줄 값들  -->
				<c:if test="${accessLevel > 1}">
			<form id="form" method="post" action="travelupdate.do"
				style="display: inline;">
				<input id="travel_seq" type="hidden" name="travel_seq"
					value="${travel.travel_seq}"> <input id="id" type="hidden"
					name="id" value="${login.id}">
			
					<button id="submit" type="submit" class="btn btn-default travelBtn"
						name="updateBtn">수정하기</button>
				</form>
				</c:if>
			
			<br> <br>
			<!-- 함께쓰기 버튼 -->
			<c:if test="${accessLevel > 1}">
				<button type="button" class="btn btn-default travelBtn "
					id="inviteBtn" style="display: inline" name="inviteBtn">함께쓰기</button>
			</c:if>
			<br> <br>


			<!-- 다운로드 버튼 -->
			<c:if test="${accessLevel > 1}">
			<form id="form" method="post" action="traveldownload.do"
				style="display: inline;">
				<input id="travel_seq" type="hidden" name="travel_seq"
					value="${travel.travel_seq}">
				
					<button id="submit" type="submit"
						class="btn btn-default travelBtn " name="downloadBtn">다운로드</button>
			</form>
			</c:if>
			<br> <br>

			<!-- 공개/비공개 버튼 -->
			<c:if test="${accessLevel == 3}">
				<c:if test="${travel.open == 0}">
					<button id="openBtn" class="btn btn-default travelBtn">공개 → 비공개</button>
				</c:if>
				<c:if test="${travel.open == 1}">
					<button id="openBtn" class="btn btn-default travelBtn">비공개  → 공개</button>
				</c:if>
			</c:if>
			<br> <br>

			<!-- 일정탈퇴 버튼: 초대해서 쓰는 사람일 경우 -->

			<c:if test="${accessLevel == 2}">
				<form id="getOut_form" method="post" action="#">
					<input id="travel_seq" type="hidden" name="travel_seq"
						value="${travel.travel_seq}"> <input id="id" type="hidden"
						name="id" value="${login.id}">
				</form>
				<button id="getOutBtn" class="btn btn-default travelBtn">일정탈퇴</button>
			</c:if>

			<!-- 삭제 버튼 -->
			<c:if test="${accessLevel == 3}">
			<form id="form" method="post" action="traveldelete.do"
				style="display: inline;">
				<input id="travel_seq" type="hidden" name="travel_seq"
					value="${travel.travel_seq}"> <input id="id" type="hidden"
					name="id" value="${id}">
				
					<button id="deleteBtn" class="btn btn-default travelBtn"
						name="deleteBtn">삭제하기</button>
			</form>
				</c:if>
			<br> <br>
			
	
			
		</div>
	</div>
</div>



<div class="container-fluid text-center" style="margin-left: 10%">

	<div class="row content">

		<div class="col-sm-offset-3 col-sm-9 text-left"
			style="padding-left: 0; width: 70%">

			<div class="panel panel-default">

				<div class="panel-body">
					<div class="col-sm-offset-3 col-sm-9 text-left"
						style="margin-left: 0; width: 100%">
						<div class="form-group">
							<label for="usr">여행 제목</label> <input type="text"
								class="form-control" id="current_title" value="${travel.title}"
								placeholder="일정에 대한 간단한 설명" readonly>
						</div>
						<div class="form-group">
							<label for="comment">여행 내용</label>
							<div style="white-space: pre-wrap; word-break: normal"
								class="well">
								<p>${travel.content}</p>
							</div>
						</div>
						<div class="form-group">
							<label for="count">여행 인원 </label>
							<input id="current_members" type="text" class="form-control"
								value="${travel.members}" readonly>
						</div>
						<div class="form-group">
							<label for="region">여행 지역 </label>							
							 <select class="form-control" id="current_region"
								disabled="disabled">
								<option value="gl"
									${travel.region == "gl"? "selected='selected'" : ""}>글로벌</option>
								<option value="kr"
									${travel.region == "kr"? "selected='selected'" : ""}>한국</option>
								<option value="as"
									${travel.region == "as"? "selected='selected'" : ""}>아시아</option>
								<option value="eu"
									${travel.region == "eu"? "selected='selected'" : ""}>유럽</option>
								<option value="na"
									${travel.region == "na"? "selected='selected'" : ""}>북미</option>
								<option value="sa"
									${travel.region == "sa"? "selected='selected'" : ""}>남미</option>
								<option value="af"
									${travel.region == "af"? "selected='selected'" : ""}>아프리카</option>
							</select>
						</div>
						<div class="form-group">
							<label for="beforeafter">여행전 / 여행후 </label> 
							 <select class="form-control" name="current_done"
								id="current_done" disabled="disabled">
								<option value="0"
									${travel.done == 0? "selected='selected'" : ""}>여행전</option>
								<option value="1"
									${travel.done == 1? "selected='selected'" : ""}>여행후</option>
							</select>
						</div>
						<form class="form-inline">
							<label for="money">여행경비</label>						
							<div class="input-group" style="width: 100%">		
								<input class="form-control" id="current_budget"
									placeholder="여행 경비를 입력하세요" readonly="readonly" value="${travel.budget}"/>
								<div class="input-group-addon">KRW</div>
							</div>
						</form>
						<div class="panel-body">
							<!-- 지도/캘린더 -->
							<div align="center" style="text-align: left;">
								<div id="googleMap" style="height: 400px;"></div>
								<br> <br>
							</div>
							<div class="panel-body">
								<div id='calendar'></div>
							</div>
						</div>
					</div>
				</div>

				<div class="panel-footer">

					<span id="like-thumbs-up"
						class="glyphicon glyphicon-thumbs-up travel-thumbs-up"></span>&nbsp;
					<!-- '숫자'명이 이 포스트를 좋아합니다 -->
					<c:if test="${not empty travellikeList}">
						<c:forEach items="${travellikeList}" var="travelLike">
							<c:if test="${travelLike == travel.travel_seq}">
						${login.id}님 등
						<script type="text/javascript">
							$("#like-thumbs-up").css("color", "rgb(0, 0, 255)");
						</script>
							</c:if>
						</c:forEach>
					</c:if>
					<c:forEach items="${travelLikeCountMapList}" var="travelLikeCountMap">
						<c:if test="${travelLikeCountMap.TRAVEL_SEQ == travel.travel_seq}">
							<span class="travel_like_count" data-seq="${travel.travel_seq}">${travelLikeCountMap.COUNT}명이
								이 게시물 좋아합니다</span>
						</c:if>
					</c:forEach>


				</div>

			</div>




			<div class="panel-footer">
				<!-- 댓글 -->
				<div class="panel-body" style="padding-left: 0">
					<div class="form-group" style="text-align: left; padding-left: 0">
						<form action="travelanswerwrite.do" method="post">
							<input type="hidden" name="travel_seq"
								value="${travel.travel_seq}" /> <input type="hidden" name="id"
								value="${login.id}" />
							<c:if test="${empty login}">
								<span class="input-group"> <input type="text"
									id="answer_nologin" class="form-control" name="content"
									placeholder="로그인 해주세요.">
									<span class="input-group-btn">
									<button class="btn btn-default" type="submit">
										<span class="glyphicon glyphicon-ok"></span>
									</button>
									</span>
								</span>
							</c:if>
							<c:if test="${not empty login}">
								<span class="input-group"> <input type="text"
									class="form-control" name="content" placeholder="댓글을 입력해주세요."
									size="74">
									<span class="input-group-btn">
									<button class="btn btn-default" type="submit">
										<span class="glyphicon glyphicon-ok"></span>
									</button>
									</span>
								</span>
							</c:if>
						</form>
					</div>
					<br>
					<c:forEach var="travelAnswer" items="${travelAnswerList}" varStatus="vs">
					<li class="list-group-item">
						<div style="width: 100%;">
							<div class="profile-Image"
								style="float: left; width: 5%; height: 100%">
								<c:forEach var="member" items="${memberList}">
									<c:if test="${member.id == travelAnswer.id}">
										<!-- 회원 개인이 업로드한 이미지가 있는 경우 -->
										<c:if test="${not empty member.img}">
											<img src="profileImage/${member.img}" alt="${member.img}"
												style="width: 40px; height: 40px;" class="img-circle">
										</c:if>
										<!-- 회원 개인이 업로드한 이미지가 없는 경우 기본 사람모양 아이콘 활용 -->
										<c:if test="${empty member.img}">
											<img src="image/default-user-icon-profile.png"
												style="width: 40px; height: 40px;" class="img-circle">
										</c:if>
									</c:if>
								</c:forEach>
							</div>
							
							<div class="username-date"
								style="float: left; height: 18px; line-height: 18px; width: 93%; height: 50%;">
								&nbsp;
								<span class="writer" style="font-weight: bold;"> 
									<a style="color: black;" href="mypage.do?id=${travelAnswer.id}">&nbsp;${travelAnswer.id}</a>
								</span> 
								<span style="font-size: 12px; color: #999; margin-left: 3px;">&nbsp;${travelAnswer.wdate} </span> 
								<span> 
									<c:if test="${login.id eq travelAnswer.id}">
										<div class="modify-delete"
											style="float: right; display: inline-flex; width: 2%;">
											<div class="comment-modify-toggle"
												data-seq="${travelAnswer.travel_answer_seq}">
												<span class="glyphicon glyphicon-pencil"></span>
											</div>
											&nbsp;
											<div class="comment-delete-btn">
												<span class="glyphicon glyphicon-remove"></span>
											</div>
											<form class="comment-delete-form"
												action="travelanswerdelete.do" method="post">
												<input type="hidden" name="travel_answer_seq"
													value="${travelAnswer.travel_answer_seq}"> <input
													type="hidden" name="travel_seq"
													value="${travelAnswer.travel_seq}">
											</form>
										</div>
									</c:if>
								</span>
							</div>
							<div style="height: 50%; width: 90%;word-break:break-all" class="comment-view">&nbsp;&nbsp;&nbsp;${travelAnswer.content}</div>				
							<div id="comment-modify-${travelAnswer.travel_answer_seq}" style="display: none; height: 50px">	
								<form class="comment-modify-form" action="travelanswerupdate.do"
									method="post" style="padding-top: 5px;">
									<input type="hidden" name="travel_answer_seq" value="${travelAnswer.travel_answer_seq}"/> 
									<input type="hidden" name="travel_seq" value="${travelAnswer.travel_seq}"/>
									
									<div class="input-group" style="display: inline-flex;">					
										<div style="width: 95%; padding-left: 10px">
											<textarea class="form-control" name="content"
												style="height: 50px">${travelAnswer.content}
											</textarea>
										</div>
										<div style="width: 5%; height: 100%;">
											<span class="input-group-btn">
												<button class="btn btn-default comment-modify-btn" type="submit" style="height: 50px">
													<span class="glyphicon glyphicon-ok"></span>
												</button>
											</span>
										</div>	
									</div>									
								</form>			
							</div>
						</div>
					</li>
				</c:forEach>
				</div>

			</div>
		</div>
	</div>
</div>




<!--  footer -->
<jsp:include page="../common/footer.jsp"></jsp:include>


<!-- 함께쓰기 모달 -->
<div class="modal fade" id="invite_Modal" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"
				style="padding: 35px 50px; background-color: #49B2E9">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 style="background-color: #49B2E9">
					<span class="glyphicon glyphicon-pencil"
						style="background-color: #49B2E9"></span> 
						함께쓰기
				</h4>
			</div>
			<div class="modal-body" style="padding: 40px 50px;">

				<form role="form" method="post" action="invitemail.do">
					<div class="form-group">
						<label for="email"><span
							class="glyphicon glyphicon-envelope"></span> 이메일</label> <input
							type="text" class="form-control" name="email" id="email"
							placeholder="이메일"> <input type="hidden" name="name"
							value="${login.email}"> <input type="hidden"
							name="travel_seq" value="${travel.travel_seq}">
					</div>
					<button type="submit" id="mailBtn"
						class="btn btn-success btn-block"
						style="background-color: #49B2E9">
						<span class="glyphicon glyphicon-user"
							style="background-color: #49B2E9"></span>초대하기
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



<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA_d2NXiQsKlnfFyp8r8yK__hl_58CLdpo&signed_in=true&callback=initMap&libraries=places"></script>
<script>
	$(document).ready(
			function() {
				$("#likeBtn").click(function() {
					if ($("#likeBtn").hasClass("btn-default")) {
						// 증가
						$("#like_form").attr("action", "travellikeup.do");
						$("#like_form").submit();
					} else {
						// 감소
						$("#like_form").attr("action", "travellikedown.do");
						$("#like_form").submit();
					}

				});

				//초대하기 버튼
				$("#inviteBtn").click(function() {
					$("#invite_Modal").modal();
				});

				$("#getOutBtn").click(
						function() {
							$("#getOut_form").attr("action",
									"exitFromMemberAndTravel.do");
							$("#getOut_form").submit();
						});

				// 메일 보내기 버튼
				$("#mailBtn").click(function() {
					var email = $("#email").val;
					$.ajax({
						url : 'invitemail.do',
						data : {
							travel_seq : '${travel.travel_seq}',
							id : '${login.id}',
							name : '${login.email}',
							email : email
						},
						dataType : "text",
						success : function(isS) {
 							//alert($("#email").val());
							$('#mailBtn').text("메일전송성공");
						},
						error : function() {
							$('#mailBtn').text("메일전송실패");
						}
					});
					return false;
				});

				$("#openBtn").click(function() {
				 var travel_seq = ${travel.travel_seq};
					$.ajax({
						url : 'travelopen.do',
						data : {
							travel_seq : travel_seq
						},
						dataType : "text",
						success : function(data) {
							//alert("통신성공")
							if (data == 1) {
								if ($('#openBtn').text() == "공개 → 비공개") {
									$('#openBtn').text("비공개 → 공개");
								} else {
									$('#openBtn').text("공개 → 비공개");
								}
							} else {
								//alert(travel_seq + "번 여행일정의 공개/비공개 설정 변경 실패");
							}
						},
						error : function() {
							//alert("통신 실패");
						}
					}); 
				});

				$('#calendar').fullCalendar(
						{
							header : {
								left : "",
								center : "",
								right : 'myCustomButton today prev, next'
							},
							customButtons : {
								myCustomButton : {
									text : defaultDate,
									click : function() {
										$('#calendar').fullCalendar('gotoDate',
												defaultDate);
									}
								}
							},
							views : {
								agenda : {
									title : '',
									allDaySlot : false
								}
							},
							lang : 'ko',
							droppable : true,
							defaultView : 'agendaWeek',
							dropAccept : "*",
							editable : false,
							defaultDate : defaultDate,
							views : {
								agenda : {
									allDaySlot : false
								}
							},
							events : eventArray
						});

				/* 로그인 하지않고 댓글 작성시 */
				$("#answer_nologin").click(function() {
					$("#login_Modal").modal();
				});

				/* 댓글 삭제시 */
				$(".comment-delete-btn").click(function() {
					var index = $(".comment-delete-btn").index(this);
					var check = confirm("댓글을 삭제하시겠습니까?");
					if (check) {
						$(".comment-delete-form:eq(" + index + ")").submit();
					}
				});

				$(".comment-modify-toggle")
						.click(
								function() {
									var travel_answer_seq = $(this).data("seq");
									if ($("#comment-modify-" + travel_answer_seq)
											.css("display") == "none") {
										$("#comment-modify-" + travel_answer_seq)
												.show();
									} else {
										$("#comment-modify-" + travel_answer_seq)
												.hide();
									}
								});

				$(".comment-modify-btn").click(function() {
					$(".comment-modify-form").submit();
				});
			});
	
			// 좋아요 증가/감소
			if ('${login.id}' != null && '${login.id}' != '') {
				$("#like-thumbs-up").click(function () {
					// 파란색이 아닌경우 -> 좋아요 증가
					if ($("#like-thumbs-up").css("color") != "rgb(0, 0, 255)") {
						//alert("파란색이 아님!!! 좋아요 증가 실행");
						location.href = "travellikeup.do?travel_seq=" + ${travel.travel_seq}; 
					// 파란색안 경우 -> 좋아요 감소
					} else {
						//alert("파란색임!!! 좋아요 감소실행");
						location.href = "travellikedown.do?travel_seq=" + ${travel.travel_seq};
					} 
					
				});					
			}

	//구글맵 api 초기화
	function initMap() {

		var map = new google.maps.Map(document.getElementById('googleMap'), {
			center : {
				lat : 0,
				lng : -180
			},
			zoom : 3,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		});

		var path = [];

		// 폴리라인/마커 생성 
		if (eventArray.length > 0) {

			for (var i = 0; i < eventArray.length; i++) {
				var latLng = {};
				latLng.lat = eventArray[i].lat;
				latLng.lng = eventArray[i].lng;
				path.push(latLng);

				// 마커표시
				marker = new google.maps.Marker({
					position : new google.maps.LatLng(eventArray[i].lat,
							eventArray[i].lng),
					map : map
				});
			}
			var latlng = new google.maps.LatLng(eventArray[0].lat,
					eventArray[0].lng);
			map.setCenter(latlng);
		}

		// 폴리라인을 지도에 표시
		var polyline = new google.maps.Polyline({
			path : path,
			geodesic : false,
			strokeColor : '#FF0000',
			strokeOpacity : 1.0,
			strokeWeight : 2,
			map : map
		});
	}

	window.onload = function() {
		initMap();
	}
</script>