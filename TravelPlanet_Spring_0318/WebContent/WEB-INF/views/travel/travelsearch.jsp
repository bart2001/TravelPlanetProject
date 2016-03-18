<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<style>
#myList li {
	display: none;
}

#loadMore {
	color: green;
	cursor: pointer;
}

#loadMore:hover {
	color: black;
}

#showLess {
	color: red;
	cursor: pointer;
	display: none;
}
#showLess:hover {
	color: black;
}
</style>


<!-- header -->
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="jumbotron">
	<div class="container text-center">
		<h1 class="hanna-title" style="margin-top: 3%;">여행일정찾기</h1>
		<br>
		<form id="form" class="form-inline" method="post"
			action="travelsearch.do">
			<select id="options" name="options" class="form-control">
				<option value="0">아이디</option>
				<option value="1">제목</option>
				<option value="2">내용</option>
				<option value="3">지역</option>
			</select> <input type="text" id="tags" class="form-control" name="query"
				size="60" placeholder="검색명을 선택하세요">

			<button class="btn btn-default" type="button" id="selectBtn">
				<span class="glyphicon glyphicon-search"></span>
			</button>
		</form>
		<br>
		<div style="text-align: right;">
			<button id="new_list_btn" type="submit" class="btn btn-default">최신순</button>
			<button id="answer_list_btn" type="submit" class="btn btn-default">댓글순</button>
			<button id="like_list_btn" type="submit" class="btn btn-default">좋아요순</button>
		</div>
	</div>
</div>
<!-- -------------------------------------------------------------------------------------------------- -->
<div class="container-fluid">
<!-- 	<h3 class="hanna-title">여행 일정</h3> -->
	<br>
	<div class="row" id="myList">
		<c:forEach var="travel" items="${travelList}" varStatus="vs">
			<li class="travel" style="list-style: none;">
				<div class="col-sm-4">
					<div class="panel panel-default">						
						<div class="panel-heading heading" style="background-color: #28A8DE;border-color: #28A8DE">																			
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
							<h2 align="center" style="color: white; text-shadow: 0 0 1px black;width:300px; none; overflow: hidden;white-space:nowrap;text-overflow:ellipsis" class="hanna-title">								
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
							<span class="glyphicon glyphicon-thumbs-up"></span>
							<!-- 로그인이 되었을 경우  -->
							<c:if test="${not empty travelLikeList}">
								<!-- 좋아요를 눌렀을 경우메나 파란색+진하게 엄지마크 표시하기  -->
								<c:forEach items="${travelLikeList}" var="travelLike">
									<c:if test="${travel.travel_seq == travelLike}">
										<script type="text/javascript">
											$("span.glyphicon-thumbs-up").eq(
													'${vs.index}').css({
												'color' : 'blue',
												'font-weight' : 'bold'
											});
										</script>
									</c:if>
								</c:forEach>
							</c:if>
							<c:forEach items="${travelLikeCountMapList}"
								var="travelLikeCountMap">
								<c:if
									test="${travelLikeCountMap.TRAVEL_SEQ == travel.travel_seq}">
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
	<div id="lastLoader" style="text-align: center;"></div>
</div>
<br>

<!--  footer -->
<jsp:include page="../common/footer.jsp"></jsp:include>

<script>
	$(document)
			.ready(
					function() {
						//댓글많은순으로 정렬
						$("#answer_list_btn")
								.click(
										function() {
											// 화면에 보여진 것들의 갯수 받아오기
											var count = $('li.travel:visible').length;
											// 전부 일단 숨겨주고
											$("li.travel").hide();
											// 섞어주기
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
															"div#myList");
											// 처음에 보여진 갯수만큼 잘라서 보여주기
											$("li.travel").slice(0, count)
													.show();

										});

						//좋아요많은순으로 정렬
						$("#like_list_btn")
								.click(
										function() {
											// 화면에 보여진 것들의 갯수 받아오기
											var count = $('li.travel:visible').length;
											// 전부 일단 숨겨주고
											$("li.travel").hide();

											// 섞어주기				
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
															"div#myList");
											// 처음에 보여진 갯수만큼 잘라서 보여주기
											$("li.travel").slice(0, count)
													.show();
										});

						//최신순으로 정렬
						$("#new_list_btn").click(
								function() {
									// 화면에 보여진 것들의 갯수 받아오기
									var count = $('li.travel:visible').length;
									// 전부 일단 숨겨주고
									$("li.travel").hide();
									// 섞어주기				
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
											}).appendTo("div#myList");
									// 처음에 보여진 갯수만큼 잘라서 보여주기
									$("li.travel").slice(0, count).show();
								});

						// 더보기 스크롤
						size_li = $("#myList li").size();
						x = 6;
						$('#myList li:lt(' + x + ')').show();
						$(window).scroll(function() {							
						    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
						    	$("#lastLoader").html('<img src="image/bigLoader.gif">');
						    	x = (x + 9 <= size_li) ? x + 9 : size_li;
								$('#myList li:lt(' + x + ')').show();
						    }
						    if (x == size_li){
						    	$("#lastLoader").empty();
						    }
					 	});
					});

	$("#selectBtn").click(function() {
		$("#form").submit();
		// location.href = "travelselect.do";
	});

	//자동완성	
	$("#options").change(
			function() {
				if ($("#options").val() == "3") {
					$("#tags").attr("placeholder",
							"예시: 글로벌 , 한국, 아시아, 유럽, 북미, 남미, 아프리카");
					$("#tags").autocomplete(
							{

								source : [ "글로벌", "한국", "아시아", "유럽", "북미",
										"남미", "아프리카" ]

							});
				}
			});

	// 삭제버튼 클릭시 삭제
	$("span.remove-travel-icon").click(function() {
			var travel_seq = $(this).data("travel_seq");	
			$("#deleteModal").modal();		
			$("#modal_delete_btn").click(function() {						
			//alert("travel_seq = " + travel_seq + "를 삭제합니다!!!");
			location.href = "traveldelete.do?travel_seq=" + travel_seq;
			});	
		});	
	

</script>
<!-- 로그인 되었을 때만 좋아요버튼 클릭 가능 -->

<c:if test="${not empty login}">
	<script type="text/javascript">
		$(document).ready(
				function() {
					// 좋아요 증가시키기(ajax)					
					$("span.glyphicon-thumbs-up").click(
							function() {
								var $this = $(this);
								var index = $("span.glyphicon-thumbs-up")
										.index(this);
								var travel_seq = $("span.travel_like_count")
										.eq(index).data("seq");
								var like = Number($("span.travel_like_count")
										.eq(index).text());
								//alert("인덱스 = " + index + " / travel_seq  = "
								//		+ travel_seq + " / 좋아요 수 = " + like);

								// 좋아요를 누르지 않은 경우
								if ($this.css("color") != "rgb(0, 0, 255)") {
									$.ajax({
										url : 'travellikeup.do',
										data : {
											travel_seq : travel_seq
										},
										dataType: "text",
										success : function(data) {
											// 컨트롤러에서 좋아요 증가에 성공했을 경우
											if (data == 1) {
												// 좋아요 아이콘 색 변화		                	
												$this.css({
													"color" : "blue",
													"font-weight" : "bold"
												});

												// 좋아요 1 증가		                	    	
												$("span.travel_like_count").eq(
														index).text(like + 1)
// 												alert("travel_seq: "
// 														+ travel_seq
// 														+ " 좋아요 증가 성공");
											} else {
// 												alert("travel_seq: "
// 														+ travel_seq
// 														+ " 좋아요 증가 실패");
											}
										},
										error : function() {
											//alert("통신성공");
										}
									});
									// 이미 좋아요를 누른 경우
								} else {
									$.ajax({
										url : 'travellikedown.do',
										data : {
											travel_seq : travel_seq
										},
										dataType: "text",
										success : function(data) {
											// 컨트롤러에서 좋아요 증가에 실패했을 경우
											if (data == 1) {
												// 좋아요 아이콘 색 변화		                	
												$this.css({
													"color" : "black",
													"font-weight" : "normal"
												});

												// 좋아요 1 감소		                	    	
												$("span.travel_like_count").eq(
														index).text(like - 1);
// 												alert("travel_seq: "
// 														+ travel_seq
// 														+ " 좋아요 감소 성공");
											} else {
// 												alert("travel_seq: "
// 														+ travel_seq
// 														+ " 좋아요 감소 실패");
											}
										},
										error : function() {
											//alert("좋아요 감소 실패");
										}
									});
								}
							});

				});
	</script>
</c:if>






