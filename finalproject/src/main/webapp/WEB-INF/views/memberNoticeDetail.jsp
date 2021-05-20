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
				
				<div class="col-md-12">
					<table id = "bbsTable" class="table table-bordered table-hover">
						<thead>
							<tr>
								<th class = "detailHeader">글번호</th>
								<td class = "headerContent">${detail.num }</td>
							</tr>
							<tr>
								<th class = "detailHeader">지점명</th>
								<td class = "headerContent">${detail.nickName }</td>
							</tr>
							<tr>
								<th class = "detailHeader">날짜</th>
								<td class = "headerContent">${detail.date }</td>
							</tr>
							<tr>
								<th style = "vertical-align : top;"  class = "detailHeader">내용</th>
								<td id = "textField"><textarea rows="15" cols="63" id = "boardContent" style = "border:none" readonly>${detail.content }</textarea></td>
							</tr>
						</thead>
					</table>
					
					<div id = "detailbtn">
						<button id = "backbtn" type="button" class="btn btn-default" onclick = "history.back()">뒤로</button>
						<!-- 어드민이 아닐경우 아래 버튼 히든 상태로 만들어야 함 -->
						<!--<button id = "modifybtn" type="button" class="btn btn-default">수정</button> -->
						<!-- <button id = "deletebtn" type="button" class="btn btn-default">삭제</button> -->
					</div>
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