<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>MEMBER : BOARD</title>
<%@ include file="template/memberNavBar.jspf" %>
<%@ include file="template/cssForMember.jspf" %>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="/webjars/bootstrap/4.6.0-1/css/bootstrap.min.css" rel="stylesheet">
<script src="/webjars/bootstrap/4.6.0-1/js/bootstrap.min.js"></script>

 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 <%@ include file="template/cssForReservation.jspf" %>

<script>

$(document).ready(function(){
	commentList(); //페이지 로딩시 댓글 목록 출력 
	
	var num = $("#boardNum").val();

	$('#commentInsertBtn').click(function(){ //댓글 등록 버튼 클릭
	    var content = {
			commentContent : document.getElementById('content').value,
			num : $("#boardNum").val()
		}
	    commentInsert(content); //Insert 함수 호출
	});
});

// 댓글 목록
function commentList(){
    $.ajax({
        url : '/board/detail/comment',
        type : 'get',
        data : "num="+$("#boardNum").val(),
        dataType : "json",
        success : function(data){
            var a ='';
            
        	for (var no = 0; no < data.commetData.length; no++ ) {
        		a += '<div class="commentArea" style="border-bottom:1px solid lightgray; margin-bottom: 15px;">';
                a += '<div class="commentInfo'+data.commetData[no].commentNum+'" style="font-size:14px;">'+data.commetData[no].commentNum+'   |   '+data.commetData[no].commentWriter+'   |   '+data.commetData[no].commentDate;
                a += '<a onclick="commentUpdate('+data.commetData[no].commentNum+',\''+data.commetData[no].commentContent+'\');"></a>';
                a += '<a onclick="commentDelete('+data.commetData[no].commentNum+');"></a> </div>';
                a += '<div class="commentContent'+data.commetData[no].commentNum+'"> <p>    '+data.commetData[no].commentContent +'</p>';
                a += '</div></div>';
			}
        	
            $(".commentList").html(a);
        },
        error : function (a,b,c) { console.log(a,b,c); }
    });
}

//댓글 등록
function commentInsert(content){
    $.ajax({
        url : '/board/insertComment',
        type : 'post',
        data : content,
        dataType : "json",
        success : function(data){
            if(data.insertResult == 1) {
                commentList(); //댓글 작성 후 댓글 목록 reload가 왜 안되지?
                $('[name=content]').val('');
            }
        }
    });
}


</script>
<body>
	<div class="content bbs"><!--content start-->
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<table id = "bbsTable" class="table table-bordered table-hover">
						<thead id = "boardDetailContent">
							<tr>
								<th class = "detailHeader">글번호</th>
								<td class = "headerContent">${detail.num }</td>
							</tr>
							<tr>
								<th class = "detailHeader">이름</th>
								<td class = "headerContent">${detail.writer }</td>
							</tr>
							<tr>
								<th class = "detailHeader">회사명</th>
								<td class = "headerContent">${detail.company }</td>
							</tr>
							<tr>
								<th class = "detailHeader">날짜</th>
								<td class = "headerContent">${detail.date }</td>
							</tr>
							<tr>
								<th class = "detailHeader">제목</th>
								<td class = "headerContent">${detail.title }</td>
							</tr>
							<tr>
								<th class = "detailHeader">내용</th>
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
			        <label for="content" id = "commentLable">댓글</label>
			        <form name="commentInsertForm" id = "commentBox">
			            <div class="input-group">
			               <input type="hidden" name="num" id = "boardNum" value="${detail.num}"/>
			               <input type="text" class="form-control" id="content" name="content" placeholder="내용을 입력하세요.">
			               <span class="input-group-btn">
			                    <button class="btn btn-default" type="button" id = "commentInsertBtn" name="commentInsertBtn">등록</button>
			               </span>
			              </div>
			        </form>
			    </div>
		    	<div class="container">
        			<div class="commentList"></div>
    			</div>
			</div>
		</div>
	</div><!--centent end-->
</body><!--body end-->

</html>
