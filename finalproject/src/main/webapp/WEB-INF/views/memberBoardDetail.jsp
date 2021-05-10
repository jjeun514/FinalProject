<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>MEMBER : BOARD</title>
<link href="/webjars/bootstrap/4.6.0-1/css/bootstrap.min.css" rel="stylesheet">
<script src="/webjars/bootstrap/4.6.0-1/js/bootstrap.min.js"></script>
<%@ include file="template/memberNavBar.jspf" %>
<%@ include file="template/cssForMember.jspf" %>
<script>
    
</script>
<body>
	<div class="content bbs"><!--content start-->
		<div class="container">
			<div class="row">
				<div class="col-md-3">
				</div>
				
				<button id = "writebtn" type="button" class="btn btn-default">글쓰기</button>
				
				<div class="col-md-12">
					<table id = "bbsTable" class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>닉네임</th>
								<th>회사명</th>
								<th>날짜</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var = "list" items = "${NoticeList }">
								<tr id = "notice">
									<td>공지</td>
									<td>${list.title }</td>
									<td>admin</td>
									<td>${list.nickName }</td>
									<td>${list.date }</td>
								</tr>
							</c:forEach>
							<c:forEach var = "list" items = "${boardList }">
								<tr>
									<td><a href = "${list.num }">${list.num }</a></td>
									<td><a href = "${list.num }">${list.title }</a></td>
									<td><a href = "${list.num }">${list.memName }</a></td>
									<td><a href = "${list.num }">${list.comName }</a></td>
									<td><a href = "${list.num }">${list.date }</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
				</div>
			</div>
		</div>
	</div><!--centent end-->
</body><!--body end-->

<%@ include file="./template/footer.jspf" %>
</html>



<!--
justify-content-center= 가운데 정렬
my-2= 높이주기
mr-3= 너비주기
m-3= 전체적인 간격주기
fixed-top= 위로고정
-->