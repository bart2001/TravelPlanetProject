<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- header -->
<jsp:include page="../common/header.jsp"></jsp:include>
<!-- 포스트 상세보기 ------------------------------------>
<div class="container">
	<h3>포스트 상세보기</h3>
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="panel panel-primary">
			<div class="panel-heading"
				style="padding: 35px 50px; background-color: #49B2E9">
				<h4 style="background-color: #49B2E9">
					<!-- <span class="glyphicon glyphicon-user" style="background-color: #49B2E9"></span> -->
					<c:forEach var="member" items="${memberList}">
						<c:if test="${member.id == post.id}">
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
					${post.id}
				</h4>
				<p align="center" style="font-size: small;">${fn:replace(post.wdate, '.0', '')}</p>
			</div>
			<div class="panel-body" style="padding: 40px 50px;">		
				<div class="form-group">
					<label for="title"><span class="glyphicon glyphicon-user"></span>
						제목</label> <input type="text" class="form-control" id="traveltitle"
						readonly="readonly" value="${post.title}">
				</div>
				
				<div class="form-group">
					<label for="content"><span class="glyphicon glyphicon-user"></span>내용</label><br>
					<div class="well">${post.content}</div>
				</div>
				
				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">여행경비</div>
						<input type="number" min="0" class="form-control"
							value="${post.budget}">
						<div class="input-group-addon">KRW</div>
					</div>
				</div>

				<br>
				<div class="input-group" style="width: 100%">
					<div style="float: right">
						<c:if test="${login.id eq post.id}">
							<button type="submit" class="btn btn-info btn-default"
								data-dismiss="modal" id="postupdate_btn"
								value="${post.post_seq}">
								&nbsp;<span class="glyphicon glyphicon-pencil">수정</span>&nbsp;
							</button>
							<button class="btn btn-default btn-info  postdelete"
								style="display: inline-flex">
								&nbsp;<span class=" glyphicon glyphicon-remove">삭제</span>&nbsp;
							</button>
							<form id="postdeleteform" method="post" action="postdelete.do">
								<input type="hidden" value="${post.post_seq}" name="post_seq" />
							</form>
						</c:if>
					</div>
					<form action="newsfeed.do">
						<button id="submit" type="submit"
							class="btn btn-default pull-left travelBtn"
							style="float: left; display: inline">목록보기</button>
					</form>
				</div>			
			</div>
			
			<div class="panel-footer">
				<span id="like-thumbs-up"class="glyphicon glyphicon-thumbs-up travel-thumbs-up"></span>&nbsp;<!-- '숫자'명이 이 포스트를 좋아합니다 -->
				<c:if test="${not empty postLikeList}">
				<c:forEach items="${postLikeList}" var="postLike">					
					<c:if test="${postLike == post.post_seq}">
						${login.id}님 등
						<script type="text/javascript">
							$("#like-thumbs-up").css("color", "rgb(0, 0, 255)");							
						</script>
					</c:if>						
				</c:forEach>
				</c:if>				
				<c:forEach items="${postLikeCountMapList}" var="postLikeCountMap">
					<c:if test="${postLikeCountMap.POST_SEQ == post.post_seq}">
							<span class="post_like_count" data-seq="${post.post_seq}">${postLikeCountMap.COUNT}명이 이 포스트를 좋아합니다</span>
					</c:if>
				</c:forEach>
				
			
				
			</div>
			<div class="panel-footer">		
				<!-- 댓글 -->
				<form action="postanswerwrite.do" method="post">
					<div class="form-group">
						<input type="hidden" name="post_seq" value="${post.post_seq}" />
						<input type="hidden" name="id" value="${login.id}" />
						<c:if test="${empty login}">
							<div class="input-group">
								<input type="text" id="answer_nologin" class="form-control" name="content" placeholder="로그인 해주세요.">
								<span class="input-group-btn">
								<button class="btn btn-default" type="submit">
									<span class="glyphicon glyphicon-ok"></span>
								</button>
								</span>
							</div>
						</c:if>
						<c:if test="${not empty login}">
							<div class="input-group">
								<input type="text" class="form-control" name="content" placeholder="댓글을 입력해주세요."> 
								<span class="input-group-btn">
								<button class="btn btn-default" type="submit">
									<span class="glyphicon glyphicon-ok"></span>
								</button>
								</span>
							</div>
						</c:if>
					</div>
				</form>
				
				<c:forEach var="postAnswer" items="${postAnswerList}" varStatus="vs">
					<li class="list-group-item">
						<div style="width: 100%;">
							<div class="profile-Image"
								style="float: left; width: 5%; height: 100%">
								<c:forEach var="member" items="${memberList}">
									<c:if test="${member.id == postAnswer.id}">
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
								<span class="writer" style="font-weight: bold;"> 
									<a style="color: black;" href="mypage.do?id=${postAnswer.id}">${postAnswer.id}</a>
								</span> 
								<span style="font-size: 12px; color: #999; margin-left: 3px;">&nbsp;${postAnswer.wdate} </span> 
								<span> 
									<c:if test="${login.id eq postAnswer.id}">
										<div class="modify-delete"
											style="float: right; display: inline-flex; width: 2%;">
											<div class="comment-modify-toggle"
												data-seq="${postAnswer.post_answer_seq}">
												<span class="glyphicon glyphicon-pencil"></span>
											</div>
											&nbsp;
											<div class="comment-delete-btn">
												<span class="glyphicon glyphicon-remove"></span>
											</div>
											<form class="comment-delete-form"
												action="postanswerdelete.do" method="post">
												<input type="hidden" name="post_answer_seq"
													value="${postAnswer.post_answer_seq}"> <input
													type="hidden" name="post_seq"
													value="${postAnswer.post_seq}">
											</form>
										</div>
									</c:if>
								</span>
							</div>
							<div style="height: 50%; width: 90%;word-break:break-all" class="comment-view">${postAnswer.content}</div>				
							<div id="comment-modify-${postAnswer.post_answer_seq}" style="display: none; height: 50px">	
								<form class="comment-modify-form" action="postanswerupdate.do"
									method="post" style="padding-top: 5px;">
									<input type="hidden" name="post_answer_seq" value="${postAnswer.post_answer_seq}"/> 
									<input type="hidden" name="post_seq" value="${postAnswer.post_seq}"/>
									
									<div class="input-group" style="display: inline-flex;">					
										<div style="width: 95%; padding-left: 10px">
											<textarea class="form-control" name="content"
												style="height: 50px">${postAnswer.content}
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
<!-- 포스트 상세보기---------- 끝--------------------------------------->

	<!--  footer -->
	<jsp:include page="../common/footer.jsp"></jsp:include>

	<!-- 부트스트랩  modal(포스트 수정 팝업) -->
	<div class="modal fade" id="postupdate_Modal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header"
					style="padding: 35px 50px; background-color: #49B2E9">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 style="background-color: #49B2E9">
						<span class="glyphicon glyphicon-pencil"
							style="background-color: #49B2E9"></span> 포스트 수정
					</h4>
				</div>
				<div class="modal-body" style="padding: 40px 50px;">
					<form role="form" id="update_form" method="post">
						<div class="form-group">
							<label for="title"><span class="glyphicon glyphicon-user"></span>
								제목</label> <input type="text" class="form-control" id="traveltitle"
								name="title" placeholder="제목을 입력해주세요." value="${post.title}">
						</div>
						<div class="form-group">
							<label for="content"><span
								class="glyphicon glyphicon-user"></span> 내용</label><br>
							<!-- 서머노트 -->
							<div id="summernote">${post.content}</div>
							<input id="content" type="hidden" name="content">
						</div>
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-addon">여행경비</div>
								<input type="number" class="form-control" name="budget"
									value="${post.budget}">
								<div class="input-group-addon">KRW</div>
							</div>
						</div>
						<input name="post_seq" type="hidden" value="${post.post_seq}">
						<br>
						<button type="submit" class="btn btn-info btn-block"
							style="background-color: #49B2E9" id="postupdateAf_btn">
							<span class="glyphicon glyphicon-off"
								style="background-color: #49B2E9"></span>수정
						</button>
					</form>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-danger btn-default pull-left"
						data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"></span> 취소
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 부트스트랩  modal(포스트 수정 ----------끝-------------------------------->


	<script>
		$(document).ready(function() {
					/* 포스트 수정시 모달 */
					$("#postupdate_btn").click(function() {
						$("#postupdate_Modal").modal();
					});

					/* 포스트 삭제시  */
					$(".postdelete").click(function() {
						$("#postdeleteform").submit();
					});

					/* 로그인 하지않고 댓글 작성시 */
					$("#answer_nologin").click(function() {
						$("#login_Modal").modal();
					});

					/* 댓글 삭제시 */
					$(".comment-delete-btn").click(
							function() {
								var index = $(".comment-delete-btn")
										.index(this);
								var check = confirm("댓글을 삭제하시겠습니까?");
								if (check) {
									$(".comment-delete-form:eq(" + index + ")")
											.submit();
								}
							});

					$(".comment-modify-toggle").click(
							function() {
								var post_answer_seq = $(this).data("seq");
								if ($("#comment-modify-" + post_answer_seq)
										.css("display") == "none") {
									$("#comment-modify-" + post_answer_seq)
											.show();
								} else {
									$("#comment-modify-" + post_answer_seq)
											.hide();
								}
							});

					$(".comment-modify-btn").click(function() {
						$(".comment-modify-form").submit();
					});

					// 서머노트				
					$('#summernote').summernote({
						lang : 'ko-KR',
						height : 300,
						minHeight : null,
						maxHeight : null,
						focus : true
					});

					$("#postupdateAf_btn").click(function() {
// 						alert($('#summernote').summernote('code'));
						$("#content").val($('#summernote').summernote('code'));
						$("#update_form").attr("action", "postupdate.do");
						$("#update_form").submit();
					});
										
					// 좋아요 증가/감소
					if ('${login.id}' != null && '${login.id}' != '') {
						$("#like-thumbs-up").click(function () {
							// 파란색이 아닌경우 -> 좋아요 증가
							if ($("#like-thumbs-up").css("color") != "rgb(0, 0, 255)") {
// 								alert("파란색이 아님!!! 좋아요 증가 실행");
								location.href = "postlikeup.do?post_seq=" + ${post.post_seq}; 
							// 파란색안 경우 -> 좋아요 감소
							} else {
// 								alert("파란색임!!! 좋아요 감소실행");
								location.href = "postlikedown.do?post_seq=" + ${post.post_seq};
							} 
							
						});					
					}
				});
	</script>
