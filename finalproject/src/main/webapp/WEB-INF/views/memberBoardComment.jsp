<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>MEMBER : BOARD</title>
<link href="/webjars/bootstrap/4.6.0-1/css/bootstrap.min.css" rel="stylesheet">
<script src="/webjars/bootstrap/4.6.0-1/js/bootstrap.min.js"></script>
<%@ include file="template/memberNavBar.jspf" %>
<%@ include file="template/cssForMember.jspf" %>
<script>

var num = '${detail.num}';

$('[name=commentInsertBtn]').click(function(){ //댓글 등록 버튼 클릭시 
    var insertData = $('[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
    commentInsert(insertData); //Insert 함수호출(아래)
});

//댓글 목록 
function commentList(){
    $.ajax({
        url : '/board/comment',
        type : 'get',
        data : {'num':num},
        success : function(data){
            var a =''; 
            $.each(data, function(key, value){ 
                a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                a += '<div class="commentInfo'+value.commentNum+'">'+'댓글번호 : '+value.commentNum+' / 작성자 : '+value.commentWriter;
                a += '<a onclick="commentUpdate('+value.commentNum+',\''+value.commentContent+'\');"> 수정 </a>';
                a += '<a onclick="commentDelete('+value.commentNum+');"> 삭제 </a> </div>';
                a += '<div class="commentContent'+value.commentNum+'"> <p> 내용 : '+value.commentContent +'</p>';
                a += '</div></div>';
            });
            
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
