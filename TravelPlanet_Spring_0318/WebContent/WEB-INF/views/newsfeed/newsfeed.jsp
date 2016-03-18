<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<style>
#myList li {
	display: none;
}
</style>
<!-- header -->
<jsp:include page="../common/header.jsp"></jsp:include>

<div class="jumbotron">
	<div class="container text-center">
		<h1 class="hanna-title" style="margin-top: 3%;">뉴스피드</h1>
		<br>
		<div>
			<form id="form" class="form-inline" method="get" action="newsfeed.do">
				<select id="options" name="options" class="form-control">
					<option value="0">아이디</option>
					<option value="1">제목</option>
					<option value="2">내용</option>
				</select> <input type="text" id="tags" class="form-control" name="query"
					size="60" placeholder="검색명을 선택하세요">
				<button class="btn btn-default" type="submit" id="selectBtn">
					<span class="glyphicon glyphicon-search"></span>
				</button>
			</form>
		</div>
		<br>
		<div style="text-align: right;">
			<button id="new_list_btn" type="submit" class="btn btn-default">최신순</button>
			<button id="answer_list_btn" type="submit" class="btn btn-default">댓글순</button>
			<button id="like_list_btn" type="submit" class="btn btn-default">좋아요순</button>
		</div>

	</div>
</div>
<br>
<div class="container-fluid">
	<div class="row">
<!-- 		<div class="col-xs-11 col-sm-11 col-md-11 col-lg-11"> -->
<!-- 			<h3 style="display: inline;" class="hanna-title">뉴스피드</h3> -->
<!-- 		</div> -->
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"
			style="text-align: right;">
			<button id="postwrite_btn" type="submit" class="btn btn-info">글쓰기</button>
		</div>
	</div>
	<br>
	<div class="row" id="myList">
		<c:forEach var="post" items="${postList}" varStatus="vs">
			<li class="post" style="list-style: none;">
				<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 box">
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
							<span class='glyphicon glyphicon-thumbs-up'></span>
							<!-- 로그인이 되었을 경우  -->
							<!-- 좋아요를 눌렀을 경우메나 파란색+진하게 엄지마크 표시하기  -->
							<c:forEach items="${postLikeList}" var="postLike">
								<c:if test="${post.post_seq == postLike}">
									<script type="text/javascript">
										$("span.glyphicon-thumbs-up").eq(
												'${vs.index}').css({
											'color' : 'blue',
											'font-weight' : 'bold'
										});
									</script>
								</c:if>
							</c:forEach>
							<c:forEach items="${postLikeCountMapList}" var="postLikeCountMap">
								<c:if test="${postLikeCountMap.POST_SEQ == post.post_seq}">
									<span class="post_like_count" data-seq="${post.post_seq}">${postLikeCountMap.COUNT}</span>
								</c:if>
							</c:forEach>
							<span class="glyphicon glyphicon-comment"></span>
							<c:forEach items="${postAnswerCountMapList}"
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
	<div id="lastLoader" style="text-align: center;"></div>
</div>
<br>

<!--  footer -->
<jsp:include page="../common/footer.jsp"></jsp:include>

<!-- 부트스트랩  modal(포스트 작성 팝업) -->
<div class="modal fade" id="postwrite_Modal" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header"
				style="padding: 35px 50px; background-color: #49B2E9">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 style="background-color: #49B2E9">
					<span class="glyphicon glyphicon-pencil"
						style="background-color: #49B2E9"></span> 포스트 작성
				</h4>
			</div>
			<div class="modal-body" style="padding: 40px 50px;">
				<form role="form" method="post" id="write_form">
					<div class="form-group">
						<label for="title"> <span class="glyphicon glyphicon-user"></span>
							제목
						</label> <input type="text" class="form-control" id="traveltitle"
							name="title" placeholder="제목을 입력해주세요.">
					</div>
					<div class="form-group">
						<label for="content"><span
							class="glyphicon glyphicon-user"></span> 내용</label><br>
						<!-- 서머노트 -->
						<div id="summernote"></div>
						<input id="content" type="hidden" name="content">
					</div>
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">여행경비</div>
							<input type="number" class="form-control" name="budget" value="0"
								min="0">
							<div class="input-group-addon">KRW</div>
						</div>
					</div>
					<br>
					<button id="submit_btn" class="btn btn-info btn-block"
						style="background-color: #49B2E9">
						<span class="glyphicon glyphicon-off"
							style="background-color: #49B2E9"></span> 작성
					</button>
				</form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default pull-left"
					data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span> 취소
				</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(
			function() {
				/* 로그인하지 않은 상태일때  -> 로그인 모달 띄우기 */
				$("#postwrite_btn").click(function() {
					if ('${login.id}' == null || '${login.id}' == '') {
						$("#login_Modal").modal();
						/* 로그인했을 때 -> 글쓰기 모달 띄우기 */
					} else {
						$("#postwrite_Modal").modal();
					}
				});

				// 댓글많은순으로 정렬
				$("#answer_list_btn").click(
						function() {
							// 화면에 보여진 것들의 갯수 받아오기
							var count = $('li.post:visible').length;
							// 일단 전부 숨겨주고					
							$("li.post").hide();
							// 정렬 후 넣어주기
							$("li.post").sort(
									function(a, b) {
										var a_count = parseInt($(a).find(
												".post_answer_count").text());
										var b_count = parseInt($(b).find(
												".post_answer_count").text());
										return b_count - a_count;
									}).appendTo("div#myList");
							// 처음에 보여진 갯수만큼 잘라서 보여주기					
							$("li.post").slice(0, count).show();
						});

				// 좋아요 많은순으로 정렬
				$("#like_list_btn").click(
						function() {
							// 화면에 보여진 것들의 갯수 받아오기
							var count = $('li.post:visible').length;
							// 전부 일단 숨겨주고					
							$("li.post").hide();
							// 정렬!
							$("li.post").sort(
									function(a, b) {
										var a_count = parseInt($(a).find(
												".post_like_count").text());
										var b_count = parseInt($(b).find(
												".post_like_count").text());
										return b_count - a_count;
									}).appendTo("div#myList");
							// 처음에 보여진 갯수만큼 잘라서 보여주기
							$("li.post").slice(0, count).show();
						});

				//최신순으로 정렬
				$("#new_list_btn").click(function() {
					// 화면에 보여진 것들의 갯수 받아오기
					var count = $('li.post:visible').length;
					// 전부 일단 숨겨주고					
					$("li.post").hide();
					// 정렬!
					$("li.post").sort(function(a, b) {
						var a_wdate = $(a).find("span.wdate").data("wdate");
						var b_wdate = $(b).find("span.wdate").data("wdate");
						if (a_wdate > b_wdate) {
							return -1;
						} else if (a_wdate < b_wdate) {
							return 1;
						} else {
							return 0;
						}
					}).appendTo("div#myList");
					// 처음에 보여진 갯수만큼 잘라서 보여주기
					$("li.post").slice(0, count).show();
				});

				$("span.remove-post-icon").click(function() {
					var post_seq = $(this).data("post_seq");
					$("#deleteModal").modal();
					$("#modal_delete_btn").click(function() {
// 						alert("post_seq = " + post_seq + "를 삭제합니다!!!");
						location.href = "postdelete.do?post_seq=" + post_seq;
					});
				});

				/* $("span.remove-post-icon").click(
						function() {
							var post_seq = $(this).data("post_seq");
							var delete_confirm = confirm("post_seq = "
									+ post_seq + "를 삭제하시겠습니까?");
							if (delete_confirm == true) {

								location.href = "postdelete.do?post_seq="
										+ post_seq;
							}							
							// alert(post_seq);		
						}); */

				size_li = $("#myList li").size();
				x = 6;
				$('#myList li:lt(' + x + ')').show();
				$(window).scroll(
						function() {
							if ($(window).scrollTop() == $(document).height()
									- $(window).height()) {
								$("#lastLoader").html(
										'<img src="image/bigLoader.gif">');
								x = (x + 9 <= size_li) ? x + 9 : size_li;
								$('#myList li:lt(' + x + ')').show();
							}
							if (x == size_li) {
								$("#lastLoader").empty();
							}
						});
				
				
				$("#write_form").validate({
	                   //규칙
	                   rules: {
	                	   title: {
	                           required : true  
	                       }
	                },
	                   //규칙체크 실패시 출력될 메시지
	                   messages : {
	                	   title: {
	                           required : "제목을 입력해주세요."
	                       }
	                   }
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
								var post_seq = $("span.post_like_count").eq(
										index).data("seq");
								var like = Number($("span.post_like_count").eq(
										index).text());
// 								alert("인덱스 = " + index + " / post_seq  = "
// 										+ post_seq + " / 좋아요 수 = " + like);

								// 좋아요를 누르지 않은 경우
								if ($this.css("color") != "rgb(0, 0, 255)") {
									$.ajax({
										url : 'postlikeup.do',
										data : {
											post_seq : post_seq
										},
										dataType : "text",
										success : function(data) {

											// 컨트롤러에서 좋아요 증가에 성공했을 경우
											if (data == 1) {
												// 좋아요 아이콘 색 변화		                	
												$this.css({
													"color" : "blue",
													"font-weight" : "bold"
												});

												// 좋아요 1 증가		                	    	
												$(
														"span.post_like_count:eq("
																+ index + ")")
														.text(like + 1)
// 												alert("post_seq: " + post_seq
// 														+ " 좋아요 증가");
											}
										},
										error : function() {
// 											alert("좋아요 증가 실패");
										},
									});

									// 이미 좋아요를 누른 경우
								} else {
									$.ajax({
										url : 'postlikedown.do',
										data : {
											post_seq : post_seq
										},
										dataType : "text",
										success : function(data) {

											// 컨트롤러에서 좋아요 증가에 실패했을 경우
											if (data == 1) {
// 												alert("data = " + data);
												// 좋아요 아이콘 색 변화		                	
												$this.css({
													"color" : "black",
													"font-weight" : "normal"
												});

												// 좋아요 1 감소		                	    	
												$("span.post_like_count").eq(
														index).text(like - 1)
// 												alert("post_seq: " + post_seq
// 														+ " 좋아요 감소");
											}
										},
										error : function() {
											//alert("좋아요 감소 실패");
										},
									});

								}
							});

					// 서머노트				
					$('#summernote').summernote({
						lang : 'ko-KR',
						height : 300,
						minHeight : null,
						maxHeight : null,
						focus : true
					});

					/* 작성완료 버튼 */
					$("#submit_btn").click(function(event) {
						event.preventDefault();
						$("#content").val($('#summernote').summernote('code'));
						$("#write_form").attr("action", "postwrite.do");
						$("#write_form").submit();
					});

				});
	</script>
</c:if>

