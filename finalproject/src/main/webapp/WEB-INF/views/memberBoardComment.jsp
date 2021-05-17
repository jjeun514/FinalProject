<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>MEMBER : COMMENT</title>
<link href="/webjars/bootstrap/4.6.0-1/css/bootstrap.min.css" rel="stylesheet">
<script src="/webjars/bootstrap/4.6.0-1/js/bootstrap.min.js"></script>
<%@ include file="template/memberNavBar.jspf" %>
<%@ include file="template/cssForMember.jspf" %>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>

var num = $("#boardNum").val();

$('[name=commentInsertBtn]').click(function(){ //댓글 등록 버튼 클릭시 
    var insertData = $('[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
    commentInsert(insertData); //Insert 함수호출(아래)
});

//댓글 목록 
function commentList(){
    $.ajax({
        url : '/board/comment',
        type : 'get',
        dataType : "json",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data : {'num':num},
        success : function(data){
        	
        	var comment = data.commentList[no];
            var a =''; 
            
        	for (var no = 0; no < data.commentList.length; no++ ) {
        		a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                a += '<div class="commentInfo'+comment.commentNum+'">'+'댓글번호 : '+comment.commentNum+' / 작성자 : '+comment.commentWriter;
                a += '<a onclick="commentUpdate('+comment.commentNum+',\''+comment.commentContent+'\');"> 수정 </a>';
                a += '<a onclick="commentDelete('+comment.commentNum+');"> 삭제 </a> </div>';
                a += '<div class="commentContent'+comment.commentNum+'"> <p> 내용 : '+comment.commentContent +'</p>';
                a += '</div></div>';
			}
        	
            $(".commentList").html(a);
        }
    });
}

//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
function commentUpdate(commentNum, commentContent){
    var a ='';
    
    a += '<div class="input-group">';
    a += '<input type="text" class="form-control" name="content_'+commentNum+'" value="'+commentContent+'"/>';
    a += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="commentUpdateProc('+commentNum+');">수정</button> </span>';
    a += '</div>';
    
    $('.commentContent'+commentNum).html(a);
    
}
 
//댓글 수정
function commentUpdateProc(commentNum){
    var updateContent = $('[name=content_'+commentNum+']').val();
    
    $.ajax({
        url : '/board/updateComment',
        type : 'post',
        data : {'content' : updateContent, 'commentNum' : commentNum},
        success : function(data){
            commentList(num); //댓글 수정후 목록 출력 
        }
    });
}
 
//댓글 삭제 
function commentDelete(commentNum){
    $.ajax({
        url : '/board/deleteComment/'+commentNum,
        type : 'post',
        success : function(data){
            commentList(num); //댓글 삭제후 목록 출력 
        }
    });
}
 
$(document).ready(function(){
    commentList(); //페이지 로딩시 댓글 목록 출력 
});

</script>

</html>
