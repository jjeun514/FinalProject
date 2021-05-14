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
						<thead id = "boardDetailContent">
							<tr>
								<th>글번호</th>
								<td>${detail.num }</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>${detail.writer }</td>
							</tr>
							<tr>
								<th>회사명</th>
								<td>${detail.company }</td>
							</tr>
							<tr>
								<th>날짜</th>
								<td>${detail.date }</td>
							</tr>
							<tr>
								<th>내용</th>
								<td id = "textField">${detail.content }</td>
							</tr>
						</thead>
						
					</table>
					
					<div id = "detailbtn">
						<button id = "backbtn" type="button" class="btn btn-default" onclick = "history.back()">뒤로</button>
						<button id = "modifybtn" type="button" class="btn btn-default">수정</button>
						<button id = "deletebtn" type="button" class="btn btn-default">삭제</button>
					</div>
				</div>
				    <!--  댓글  -->
			    <div class="container">
			        <label for="content">comment</label>
			        <form name="commentInsertForm">
			            <div class="input-group">
			               <input type="hidden" name="num" value="${detail.num}"/>
			               <input type="text" class="form-control" id="content" name="content" placeholder="내용을 입력하세요.">
			               <span class="input-group-btn">
			                    <button class="btn btn-default" type="button" name="commentInsertBtn">등록</button>
			               </span>
			              </div>
			        </form>
			    </div>
			    <%@ include file="./memberBoardComment.jsp" %>
    <div class="container">
        <div class="commentList"></div>
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