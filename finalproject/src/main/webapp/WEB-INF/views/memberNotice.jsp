<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <title>MEMBER : NOTICE</title>
<%@ include file="template/memberNavBar.jspf" %>
<%@ include file="template/cssForMember.jspf" %>
<script>
//게시판 검색기능//
  $(document).ready(function() {
    var activeSystemClass = $('.list-group-item.active');

    //something is entered in search form
    $('#system-search').keyup( function() {
       var that = this;
        // affect all table rows on in systems table
        var tableBody = $('.table-list-search tbody');
        var tableRowsClass = $('.table-list-search tbody tr');
        $('.search-sf').remove();
        tableRowsClass.each( function(i, val) {
        
            //Lower text for case insensitive
            var rowText = $(val).text().toLowerCase();
            var inputText = $(that).val().toLowerCase();
            if(inputText != '')
            {
                $('.search-query-sf').remove();
                tableBody.prepend('<tr class="search-query-sf"><td colspan="6"><strong>Searching for: "'
                    + $(that).val()
                    + '"</strong></td></tr>');
            }
            else
            {
                $('.search-query-sf').remove();
            }

            if( rowText.indexOf( inputText ) == -1 )
            {
                //hide rows
                tableRowsClass.eq(i).hide();
                
            }
            else
            {
                $('.search-sf').remove();
                tableRowsClass.eq(i).show();
            }
        });
        //all tr elements are hidden
        if(tableRowsClass.children(':visible').length == 0)
        {
            tableBody.append('<tr class="search-sf"><td class="text-muted" colspan="6">No entries found.</td></tr>');
        }
    });
});  
//게시판 검색기능//  
    
</script>
<body>
	<div class="content bbs"><!--content start-->
		<div class="container">
			<div class="row">
				<div class="col-md-3">
					<form action="#" method="get">
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
					<table id = "noticeTable" class="table table-bordered table-hover">
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