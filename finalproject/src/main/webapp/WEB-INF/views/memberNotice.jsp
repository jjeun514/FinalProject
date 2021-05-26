<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <title>MEMBER : NOTICE</title>
  <link href="/webjars/bootstrap/4.6.0-1/css/bootstrap.min.css" rel="stylesheet">
<script src="/webjars/bootstrap/4.6.0-1/js/bootstrap.min.js"></script>
<%@ include file="template/memberNavBar.jspf" %>
<%@ include file="template/cssForMember.jspf" %>
<%@ include file="./util/search.jspf" %>
<body>
	<div class="content bbs"><!--content start-->
		<div class="container">
			<div class="row">
				<div class="col-md-3">
					<form action="#" method="get">
					<input type="hidden" name="memNum" value="${member.memNum}"/>
						<div class="input-group">
							<!-- USE TWITTER TYPEAHEAD JSON WITH API TO SEARCH -->
							<input class="form-control" id="system-search" name="q"
								placeholder="Search for" required> <span
								class="input-group-btn">
								<button type="submit" class="btn btn-default">
									<i class="glyphicon glyphicon-search"></i>
								</button>
							</span>
						</div>
					</form>
				</div>
				
				<div class="bottom">
				        <div class="bottom-left">
				            <select id="cntSelectBox" name="cntSelectBox"
				                onchange="changeSelectBox(${pagination.currentPage},${pagination.countPerPage},${pagination.pageSize});"
				                class="form-control" style="width: 100px;" hidden = "hidden">
				                <option value="10"
				                    <c:if test="${pagination.countPerPage == '10'}">selected</c:if>>10개씩</option>
				                <option value="20"
				                    <c:if test="${pagination.countPerPage == '20'}">selected</c:if>>20개씩</option>
				                <option value="30"
				                    <c:if test="${pagination.countPerPage == '30'}">selected</c:if>>30개씩</option>
				            </select>
				        </div>
				    </div>
				
				<div class="col-md-12">
					<table id = "noticeTable" class="table table-list-search table-hover">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>날짜</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var = "list" items = "${noticeList }">
								<tr>
									<td><a href = "/notice/detail?selectNum=${list.num }" style = "color:black">${list.num }</a></td>
									<td><a href = "/notice/detail?selectNum=${list.num }" style = "color:black">${list.title }</a></td>
									<td><a href = "/notice/detail?selectNum=${list.num }" style = "color:black">${list.nickName }</a></td>
									<td><a href = "/notice/detail?selectNum=${list.num }" style = "color:black">${list.count }</a></td>
									<td><a href = "/notice/detail?selectNum=${list.num }" style = "color:black">${list.date }</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<!--paginate -->
				    <div class="paginate">
				        <div class="paginaion">
				            <a class="direction prev" href="javascript:void(0);"
				                onclick="movePage(1,${pagination.countPerPage},${pagination.pageSize});">
				                &lt;&lt; </a> 
				            <a class="direction prev" href="javascript:void(0);"
				                onclick="movePage(${pagination.currentPage}<c:if test="${pagination.hasPreviousPage == true}">-1</c:if>,${pagination.countPerPage},${pagination.pageSize});">
				                &lt; </a>
				 
				            <c:forEach begin="${pagination.firstPageNum}"
				                end="${pagination.lastPageNum}" var="idx">
				                <a
				                    style="color:<c:out value="${pagination.currentPage == idx ? '#000000; font-weight:700; margin-bottom: 2px;' : ''}"/> "
				                    href="javascript:void(0);"
				                    onclick="movePage(${idx},${pagination.countPerPage},${pagination.pageSize});"><c:out
				                        value="${idx}" /></a>
				            </c:forEach>
				            
				            <a class="direction next" href="javascript:void(0);"
				                onclick="movePage(${pagination.currentPage}<c:if test="${pagination.hasNextPage == true}">+1</c:if>,${pagination.countPerPage},${pagination.pageSize});">
				                &gt; </a> 
				            <a class="direction next" href="javascript:void(0);"
				                onclick="movePage(${pagination.totalRecordCount},${pagination.countPerPage},${pagination.pageSize});">
				                &gt;&gt; </a>
				        </div>
				    </div>
					
				</div>
			</div>
		</div>
	</div><!--centent end-->
</body><!--body end-->

<script>
//10,20,30개씩 selectBox 클릭 이벤트
function changeSelectBox(currentPage, countPerPage, pageSize){
    var selectValue = $("#cntSelectBox").children("option:selected").val();
    movePage(currentPage, selectValue, pageSize);
}
 
//페이지 이동
function movePage(currentPage, countPerPage, pageSize){
    
    var url = "/notice";
    url = url + "?currentPage="+currentPage;
    url = url + "&countPerPage="+countPerPage;
    url = url + "&pageSize="+pageSize;
    
    location.href=url;
}
 
</script>

<%@ include file="./template/footer.jspf" %>
</html>


<!--
justify-content-center= 가운데 정렬
my-2= 높이주기
mr-3= 너비주기
m-3= 전체적인 간격주기
fixed-top= 위로고정
-->