<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<!-- header -->
<jsp:include page="../common/header.jsp"></jsp:include>

<script>
   var eventArray = [];
   var defaultDate = '';
</script>

<style>
.update {
   width: 80%
}
</style>
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
<c:if test="${not empty defaultDate}">
   <script>
      defaultDate = '${defaultDate}';
   </script>
</c:if>

   
<div class="col-sm-3 sidenav sidebar-nav"  style="width: 30%">
   
   <div style="margin-left: 25%">
      <c:forEach items="${memberList}" var="member">
         <c:if test="${member.id == id}">
            <!-- 회원 개인이 업로드한 이미지가 있는 경우 -->
            <c:if test="${not empty member.img}">
               <img src="profileImage/${member.img}" alt="${member.img}"
                  style="width: 80px; height: 80px;" class="img-circle">
            </c:if>
            <!-- 회원 개인이 업로드한 이미지가 없는 경우 기본 사람모양 아이콘 활용 -->
            <c:if test="${empty member.img}">
               <img src="image/default-user-icon-profile.png"
                  style="width: 80px; height: 80px;" class="img-circle">
            </c:if>
         </c:if>
      </c:forEach>
      <p >ID: ${id}</p>
      <br> <br>
   </div>
   <div id="side-first">
      <!-- auto complete-->

      <div class="form-inline update">
         <div class="input-group">
            <div class="input-group-addon">장소검색</div>
            <!-- Centered Pills -->
            <!-- 구글 자동완성 검색창 -->
            <input id="searchTextField" type="text" class="form-control update clearable" placeholder="">
         </div>
      </div>
      <br>



      <div id="my-draggable" class="form-control  update"
         style="color: black; border-radius: 5px; padding: 5px; font-color: gray; text-align: center;">
         <p>입력후 드래그</p>
      </div>

   </div>

   <br> <br> <br> <br>

   <div id="side-second">

      <div class="input-group update">
         <div class="input-group-addon">작성시기</div>
         <select class="form-control" name="current_done" id="current_done">
            <option value="0" ${travel.done == 0? "selected='selected'" : ""}>여행전</option>
            <option value="1" ${travel.done == 1? "selected='selected'" : ""}>여행후</option>
         </select>
      </div>
      <br>



      <div class="input-group update">
         <div class="input-group-addon">인원</div>
         <input id="current_members" type="number" min="1" size="1"
            class="form-control" value="${travel.members}">
         <div class="input-group-addon">명</div>
      </div>
      <br>


      <div class="input-group  update">
         <div class="input-group-addon">지역</div>
         <select class="form-control" id="current_region">
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
      <br>


      <div class="input-group update">
         <div class="input-group-addon">여행경비</div>
         <input type="number" min="0" class="form-control" id="current_budget"
            placeholder="여행경비를 입력하세요" value="${travel.budget}">
         <div class="input-group-addon">KRW</div>
      </div>
   </div>
   <br> <br>


   <div id="side-third">
      <!-- '저장'버튼 클릭시 넘겨줄 값들  -->
      <form id="save_form" method="post" style="display: inline;">
         <input type="hidden" name="id" value="${login.id}"> <input
            type="hidden" name="travel_seq" value="${travel.travel_seq}">
         <input id="new_title" type="hidden" name="title"> <input
            id="new_content" type="hidden" name="content"> <input
            id="new_members" type="hidden" name="members"> <input
            id="new_done" type="hidden" name="done"> <input
            id="new_region" type="hidden" name="region"> <input
            id="new_events" type="hidden" name="events"> <input
            id="new_budget" type="hidden" name="budget">
      </form>
      <form id="cancel_form" method="post">
         <input type="hidden" name="travel_seq" value="${travel.travel_seq}">
      </form>

      <div class="row">

         <div class="col-sm-6" style="margin-left: 15%">
            <button id="save_button" class="btn btn-default">저장</button>
            <button id="cancel_button" class="btn btn-default">취소</button>
         </div>

      </div>
      <br>
   </div>
</div>
<br>

<div class="container-fluid text-center" style="margin-left: 10%">

   <div class="row content">
   
      <div class="col-sm-offset-3 col-sm-9 text-left"
         style="padding-left: 0; width: 70%">

         <div class="panel panel-default">

            <div class="panel-body">

               <div class="form-group update" style="width:100%">
                  <label for="usr">title:</label> <input type="text"
                     class="form-control" id="current_title" value="${travel.title}"
                     placeholder="일정에 대한 간단한 설명">
                  <div class="form-group update" style="width:100%">
                     <label for="comment">Content:</label>
                     <div id="current_content">${travel.content}</div>
                     <!--             <textarea class="form-control" rows="5" id="current_content" -->
                     <%--                placeholder="일정에 대한 자세한 설명">${travel.content}</textarea> --%>
                  </div>
               </div>
            </div>


            <!-- 지도 -->
            <div class="panel-body">
               <div id="googleMap" style="height: 400px;"></div>

            </div>

            <!--  캘린더 -->
            <div class="panel-body">
               <div id='calendar'></div>
            </div>


         </div>



      </div>
   </div>
</div>

<!--  footer -->
<jsp:include page="../common/footer.jsp"></jsp:include>

<script async defer
   src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA_d2NXiQsKlnfFyp8r8yK__hl_58CLdpo&signed_in=true&callback=initMap&libraries=places"></script>
<script>
   $(document).ready(function() {
      
//       $('#calendar').click(function() {
//          var checksize = $('#calendar').fullCalendar('clientEvents');
//          alert(checksize.length);
//       })
      
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
                        $('#calendar').fullCalendar('gotoDate', defaultDate);
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
               editable : true,
               defaultDate : defaultDate,
//                drop : function(event) {
//                   alert("drop");
//                   $('#calendar').fullCalendar('renderEvent', event, true);
//                   $("#my-draggable").removeData('event');
//                   $("#my-draggable").text("");                  
//                   addLine();
//                },
               eventReceive : function(event) {	   
                  $("#my-draggable").removeData('event');
                  $("#my-draggable").text("");                  
                  addLine();
               },
               eventDrop : function(event, delta, revertFunc, jsEvent, ui, view) {           
                  addLine();
               },
               views : {
                  agenda : {
                     allDaySlot : false
                  }
               },
               eventRender : function(event, element) {
                  element.bind('dblclick', function() {
                     $('#calendar').fullCalendar('removeEvents', event._id);
						alert("eventRender remove");
                     addLine(); // 구글맵 초기화 후에 다시 선 그려주기
                  });
               },
               eventOverlap : false,               
               events: eventArray
            });            

         
            $('#my-draggable').draggable({
               revert : true, // immediately snap back to original position
               revertDuration : 1000
            });
            $("#cancel_button").click(function() {
               $("#cancel_form").attr("action", "traveldetail.do");
               $("#cancel_form").submit();
            });
            $("#save_button").click(function() {
               var title = $("#current_title").val();
               var content = $('#current_content').summernote('code');
               var members = $("#current_members").val();
               var done = $("#current_done").val();
               var region = $("#current_region").val();
               var budget = $("#current_budget").val();

               var jsArray = [];
               jsArray = $('#calendar').fullCalendar('clientEvents');

               var jsonArray = [];
               for (var i = 0; i < jsArray.length; i++) {
                  var jsonObject = {};
                  jsonObject.title = jsArray[i].title;
                  jsonObject.start = jsArray[i].start;
                  jsonObject.end = jsArray[i].end;
                  jsonObject.lat = jsArray[i].lat;
                  jsonObject.lng = jsArray[i].lng;
                  jsonArray.push(jsonObject);
               }

               var events = JSON.stringify(jsonArray);

               $("#new_title").val(title);
               $("#new_content").val(content);
               $("#new_members").val(members);
               $("#new_done").val(done);
               $("#new_region").val(region);
               $("#new_events").val(events);
               $("#new_budget").val(budget);

               $("#save_form").attr("action", "travelsave.do");
               $("#save_form").submit();
            });

            $('#current_content').summernote({
               lang : 'ko-KR',
               height : 300,
               minHeight : null,
               maxHeight : null,
               focus : true
            });
         });

   // 구글맵 api 전역변수
   var map;
   var markers = [];
   var polyline;

   function initMap() {
      map = new google.maps.Map(document.getElementById('googleMap'), {
         // 시작을 한국으로!!
         center : {
            lat : 37.5529273,
            lng : 126.9369388
         },
         zoom : 3,
         mapTypeId : google.maps.MapTypeId.ROADMAP
      });

      // polyline의  path 설정
      var path = [];
      markers = [];
      for (var i = 0; i < eventArray.length; i++) {
         var newPlace = {};
         newPlace.lat = eventArray[i].lat;
         newPlace.lng = eventArray[i].lng;
         path.push(newPlace);

         // 마커 설정
         var marker = new google.maps.Marker({
            position : new google.maps.LatLng(eventArray[i].lat,
                  eventArray[i].lng),
            map : map
         })
         markers.push(marker);
      }

      // polyline을 맵에 띄우기
      polyline = new google.maps.Polyline({
         path : path,
         strokeColor : '#FF0000',
         strokeOpacity : 1.0,
         strokeWeight : 2
      });

      polyline.setMap(map);

      autocomplete = new google.maps.places.Autocomplete(document
            .getElementById('searchTextField'));
      autocomplete.addListener('place_changed', fillInAddress);
   }
	//자동완성 부분에 x표시 넣기
   function tog(v){return v?'addClass':'removeClass';} 
   $(document).on('input', '.clearable', function(){
       $(this)[tog(this.value)]('x');
   }).on('mousemove', '.x', function( e ){
       $(this)[tog(this.offsetWidth-18 < e.clientX-this.getBoundingClientRect().left)]('onX');
   }).on('touchstart click', '.onX', function( ev ){
       ev.preventDefault();
       $(this).removeClass('x onX').val('').change();
   });

   
   function addLine() {

      // 캘린더에 있는 이벤트 다시 받아오기
      var array = [];
      array = $('#calendar').fullCalendar('clientEvents');

      // 마지막에 등록한 이벤트로 맵의 중심 잡아주기
      map.setCenter(new google.maps.LatLng(array[array.length - 1].lat,
            array[array.length - 1].lng));

      // 시작시간 순으로 정렬해주기
      array.sort(function(a, b) {
         if (a.start > b.start)
            return 1;
         else if (a.start < b.start)
            return -1;
         else
            return 0;
      });      

      // 마커 초기화
      for (var i = 0; i < markers.length; i++) {
         markers[i].setMap(null);
      }
      markers = [];

      // polyline, marker 다시 그려주기   
      path = [];
      for (var i = 0; i < array.length; i++) {

         var latLng = new google.maps.LatLng(array[i].lat, array[i].lng);
         path.push(latLng);

         // 마커생성
         var marker = new google.maps.Marker({
            position : new google.maps.LatLng(array[i].lat, array[i].lng),
            map : map
         });
         markers.push(marker);

      }
      polyline.setPath(path);
      polyline.setMap(map);
   }

   // 자동완성 기능을 통해서 추가할 부분
   function fillInAddress() {
      var place = autocomplete.getPlace();
      $("#my-draggable").text(place.name);
      $("#my-draggable").data('event', {
         title : place.name,
         lat : place.geometry.location.lat(),
         lng : place.geometry.location.lng(),
         duration : "01:00",
         stick : true
      });
      
   }

   window.onload = function() {
      initMap();
   }
</script>