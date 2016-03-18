<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- header -->
<jsp:include page="../common/header.jsp"></jsp:include>


<div class="jumbotron">
	<div class="container text-center">
		<h1>회원관리</h1>
	</div>
</div>



<div class="container-fluid">
			<div class="container">
				<h3>회원관리</h3>
				<p>회원관리 입니다..</p>
				<table class="table table-hover">
					<thead>
						<tr>
							<th>아이디</th>	
							<th>나이</th>
							<th>성별</th>
							<th>여행일정 갯수</th>
							<th>포스트 갯수</th>
							<th>회원 삭제</th>
						</tr>
					</thead>
					<tbody>
					
					<c:forEach var="member" items="${memberList}" >
						<tr>
							<td>${member.id}</td>
							<td>${member.birth}</td>
							<td>${member.sex}</td>
							<c:forEach var="travel" items="${travelCountMapList}" >
								<c:if test="${member.id == travel.ID}">
								<td>${travel.COUNT}</td>
								</c:if>
							</c:forEach>							
							<c:forEach var="post" items="${postCountMapList}" >
								<c:if test="${member.id == post.ID}">
								<td>${post.COUNT}</td>
								</c:if>
							</c:forEach>										
							<td>
								<!-- 관리자가아닌경우 에만 회원학제 버튼이 보여짐..-->
								<c:if test="${member.auth == 0}">
							<!-- 	<form role="form" method="post" action="memberdelete.do"> -->
									<%-- <input type="hidden" name="id" value="${member.id}"> --%>
									<button id="deleteMemberBtn" class="btn btn-danger" data-id="${member.id}">
										<span class="glyphicon glyphicon-remove-circle"></span>회원삭제
									</button>
								<!-- </form> -->
								</c:if>
							</td>						
						</tr>
							</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

<!--  footer -->
<jsp:include page="../common/footer.jsp"></jsp:include>


<script>
$(".btn-danger").click(function() {		
 	var id = $(this).data("id");
 		$("#deleteMemberModal").modal();		
		 	$("#modal_delete_membebr_btn").click(function() {			
				location.href = "memberdelete.do?id="+id;				
		});	 	
	});
	
</script>



</body>
</html>