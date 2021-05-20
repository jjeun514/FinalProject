<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  <title>MEMBER : INTRO</title>
<link href="/webjars/bootstrap/4.6.0-1/css/bootstrap.min.css" rel="stylesheet">
<script src="/webjars/bootstrap/4.6.0-1/js/bootstrap.min.js"></script>
<%@ include file="template/memberNavBar.jspf" %>
<%@ include file="template/cssForMember.jspf" %>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>

</script>
<body>
	<div class="content main">
		<div class = "container">
			<div class = "row" id = "introRow">
			
				<form action="#">
				
				</form>
			
				<div class = "col-xs-12 col-md-5" id = "introNotice">
					<div id = "noticeTitle">notice</div>
					
						<table id = "introNoticeContent" class = "table table-bordered">
							<tbody>
								<c:forEach var = "content" items = "${noticeContent }">
									<tr style = "line-height:7px;">
										<td id = "noticeOverFlow"><a href = "/notice/detail?selectNum=${content.num }" style = "color:black;">${content.title }</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					
					<div id = "moreNotice"><a href = "notice" style = "color:gray;">more</a></div>
				</div>
				
				<div class = "col-xs-0 col-md-1"></div>
				
				<div class = "col-xs-12 col-md-6" id = "introBoard">
					<div id = "boardTitle">board</div>
					
						<table id = "introBoardContent" class = "table table-bordered">
							<tbody>
								<c:forEach var = "content" items = "${boardContent }">
									<tr style = "line-height:7px;">
										<td id = "boardOverFlow"><a href = "/board/detail?selectNum=${content.num }" style = "color:black;">${content.title }</a></td>
										<td><a href = "/board/detail?selectNum=${content.num }" style = "color:black;">${content.writer }</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					
					<div id = "moreBoard"><a href = "board" style = "color:gray;">more</a></div>
				</div>
			</div>
			
			<div class = "row" id = "introRow">
				<div class = "col-xs-5 col-md-6" id = "introReservation">
					<div id = "reservationTitle">reservation</div>
					
					<c:forEach var = "content" items = "${reservationContent }">
						<c:if test = "${content ne null }"></c:if>
							<table id = "introBoardContent" class = "table table-bordered">
								<tbody>
									<tr style = "line-height:7px;">
										<td id = "reservationTd">${content.roomNum } 회의실</td>
										<c:set var = "useStartTime" value = "${content.useStartTime }"/>
										<c:set var = "substringStartTime" value = "${fn:substring(useStartTime,11,13)}"/>
										<c:set var = "useFinishTime" value = "${content.useFinishTime }"/>
										<c:set var = "substringFinishTime" value = "${fn:substring(useFinishTime,11,13)}"/>
											<td>${substringStartTime}시-${substringFinishTime}시</td>
											<td>${substringFinishTime-substringStartTime}시간</td>
									</tr>
								</tbody>
							</table>
						<c:if test="${content eq null}">
							<div id = "todayReservationMSG">오늘 회의실 예약이 없습니다 :)</div>
						</c:if>
					</c:forEach>
					
					
					<div id = "moreReservation"><a href = "reservation" style = "color:gray;">more</a></div>
				</div>
				
				<div class = "col-xs-1 col-md-1"></div>
				
				<div class = "col-xs-6 col-md-5" id = "introEvent">
					<div id = "eventTitle">event
					</div>
						<img id = "introEventIMG" src="imgs/event.png">
				</div>
			</div>
			
		</div>
	</div>
</body>
<!--body end-->
<%@ include file="./template/footer.jspf" %>
</html>
