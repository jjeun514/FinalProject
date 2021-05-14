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
								<th>글번호</th>
								<th>${detail.num }</th>
							</tr>
							<tr>
								<th>이름</th>
								<th>${detail.writer }</th>
							</tr>
							<tr>
								<th>회사명</th>
								<th>${detail.company }</th>
							</tr>
							<tr>
								<th>날짜</th>
								<th>${detail.date }</th>
							</tr>
						</thead>
						
						<tbody>
								<tr>
									<td colspan = "2" id = "textField">${detail.content }</td>
								</tr>
						</tbody>
					</table>
					
					<div id = "detailbtn">
						<button id = "backbtn" type="button" class="btn btn-default" onclick = "history.back()">뒤로</button>
						<button id = "modifybtn" type="button" class="btn btn-default">수정</button>
						<button id = "deletebtn" type="button" class="btn btn-default">삭제</button>
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