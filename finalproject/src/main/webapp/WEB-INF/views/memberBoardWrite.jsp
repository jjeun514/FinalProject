<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>MEMBER : BOARD</title>
<%@ include file="template/memberNavBar.jspf" %>
<%@ include file="template/cssForMember.jspf" %>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="/webjars/bootstrap/4.6.0-1/css/bootstrap.min.css" rel="stylesheet">
<script src="/webjars/bootstrap/4.6.0-1/js/bootstrap.min.js"></script>

  <%@ include file="template/cssForReservation.jspf" %>
<script>

var csrfToken = $("meta[name='_csrf']").attr("content");
$.ajaxPrefilter(function(options, originalOptions, jqXHR){
   if (options['type'].toLowerCase() === "post" || options['type'].toLowerCase() === "put" || options['type'].toLowerCase() === "delete") {
      jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
   }
});

$(document).ready(function() {
	
	$('#submitbtn').click(function() {

		var writePost = {
			title : document.getElementById('writeTitle').value,
			content : document.getElementById('writeContent').value
		};
		
		$.ajax({
			url : "/board/save",
			type : "POST",
			data : writePost,
			dataType : "text",
			success : function() {
				location.href = "/board";
			}
		});
		
	});
	
});

</script>
<body>
	<div class="content bbs"><!--content start-->
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<form action="/board/save" method = "post">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
						<table id = "bbsTable" class="table table-bordered table-hover">
							<thead id = "boardDetailContent">
								<tr>
									<th class = "detailHeader">제목</th>
									<td class = "headerContent">
										<input id = "writeTitle" type = "text" autofocus/>
									</td>
								</tr>
								<tr>
									<th style = "vertical-align : top;" class = "detailHeader">내용</th>
									<td id = "textField">
										<input id = "writeContent" type = "text" autofocus/>
									</td>
								</tr>
							</thead>
							
						</table>
					</form>
					<div id = "detailbtn">
						<button id = "backbtn" type="button" class="btn btn-default" style = "position : relative; left : 80%;" onclick = "history.back()">뒤로</button>
						<button id = "submitbtn" type="button" class="btn btn-default" style = "position : relative; left : 82%;">등록</button>
					</div>
				</div>
			</div>
		</div>
	</div><!--centent end-->
</body><!--body end-->
<%@ include file="./template/twoDepthFooter.jspf" %>
</html>



<!--
justify-content-center= 가운데 정렬
my-2= 높이주기
mr-3= 너비주기
m-3= 전체적인 간격주기
fixed-top= 위로고정
-->