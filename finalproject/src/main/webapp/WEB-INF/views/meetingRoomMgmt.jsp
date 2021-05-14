<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>

<script type="text/javascript">
//10,20,30개씩 selectBox 클릭 이벤트
function changeSelectBox(currentPage, countPerPage, pageSize){
    var selectValue = $("#cntSelectBox").children("option:selected").val();
    movePage(currentPage, selectValue, pageSize);
}
 
//페이지 이동
function movePage(currentPage, countPerPage, pageSize){
    
    var url = "/mypage";
    url = url + "?currentPage="+currentPage;
    url = url + "&countPerPage="+countPerPage;
    url = url + "&pageSize="+pageSize;
    
    location.href=url;
}


//만들어진 테이블에 페이지 처리

function page(table){ 
$('.'+table).each(function() {

var pagesu = 10;  //페이지 번호 갯수

var currentPage = 0;

var numPerPage = 10;  //목록의 수

var $table = $(this);    

var pagination = $("#pagination");


//length로 원래 리스트의 전체길이구함

var numRows = $table.find('tbody tr').length;


//Math.ceil를 이용하여 반올림

var numPages = Math.ceil(numRows / numPerPage);


//리스트가 없으면 종료

if (numPages==0) return;



//pager라는 클래스의 div엘리먼트 작성

var $pager = $('<div class="pager"></div>');

var nowp = currentPage;

var endp = nowp+10;


//페이지를 클릭하면 다시 셋팅

$table.bind('repaginate', function() {

//기본적으로 모두 감춘다, 현재페이지+1 곱하기 현재페이지까지 보여준다

$table.find('tbody tr').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();

$("#pagination").html("");



if (numPages > 1) {     // 한페이지 이상이면

if (currentPage < 5 && numPages-currentPage >= 5) {   // 현재 5p 이하이면

nowp = 0;     // 1부터 

endp = pagesu;    // 10까지

}else{

nowp = currentPage -5;  // 6넘어가면 2부터 찍고

endp = nowp+pagesu;   // 10까지

pi = 1;

}

if (numPages < endp) {   // 10페이지가 안되면

endp = numPages;   // 마지막페이지를 갯수 만큼

nowp = numPages-pagesu;  // 시작페이지를   갯수 -10

}

if (nowp < 1) {     // 시작이 음수 or 0 이면

nowp = 0;     // 1페이지부터 시작

}

}else{       // 한페이지 이하이면

nowp = 0;      // 한번만 페이징 생성

endp = numPages;

}


// [처음]

$('<span class="pageNum first"><<</span>').bind('click', {newPage: page},function(event) {

currentPage = 0;   

$table.trigger('repaginate');  

$($(".pageNum")[2]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');



// [이전]

$('<span class="pageNum back">&nbsp;<&nbsp;</span>').bind('click', {newPage: page},function(event) {

if(currentPage == 0) return; 


currentPage = currentPage-1;

$table.trigger('repaginate'); 

$($(".pageNum")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');


// [1,2,3,4,5,6,7,8]

for (var page = nowp ; page < endp; page++) {

$('<span  style="cursor:pointer" class="pageNum"></span>').text(page + 1).append('&nbsp;').bind('click', {newPage: page}, function(event) {

currentPage = event.data['newPage'];

$table.trigger('repaginate');

$($(".pageNum")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');

} 



// [다음]

$('<span class="pageNum next">>&nbsp;</span>').bind('click', {newPage: page},function(event) {

if(currentPage == numPages-1) return;


currentPage = currentPage+1;

$table.trigger('repaginate'); 

$($(".pageNum")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');


// [끝]

$('<span class="pageNum last">>></span>').bind('click', {newPage: page},function(event) {

currentPage = numPages-1;

$table.trigger('repaginate');

$($(".pageNum")[endp-nowp+1]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');


$($(".pageNum")[2]).addClass('active');

});


$pager.insertAfter($table).find('span.pageNum:first').next().next().addClass('active');   

$pager.appendTo(pagination);

$table.trigger('repaginate');

});

}



$(function(){

// table pagination

page('paginatedRev');

});
</script>

<title>회의실관리</title>
<div class="content main">
<div class="content main revervationManage">
	<h1> 예약 관리 </h1>
	<table class="table masterMgmtTable paginatedRev">
		<thead class="thead-light">
			<tr>
				<td colspan="8" id="addMasterBtn">
					<button type="button" class="btn btn-primary addMasterBtn" onclick="location.href='addMasterAccount'">추가</button>
				</td>
			</tr>
		    <tr>
				<th scope="col">번호</th>
				<th scope="col">예약일</th>
				<th scope="col">예약자</th>
				<th scope="col">아이디</th>
				<th scope="col">회사</th>
				<th scope="col">방번호</th>
				<th scope="col">입실시간</th>
				<th scope="col">퇴실시간</th>
				<th scope="col">사용인원</th>
				<th scope="col">결제금액</th>
				<th scope="col">주문번호</th>
		    </tr>
		</thead>
		<tbody>
			<c:forEach items="${revList }" var="revAllList" varStatus="status">
			<tr id="masterAccounts" data-toggle="modal" data-target="#accountDetail" >
				<td><a href="#" onclick="return false;">${status.index + 1}</a></td>
				<td><a href="#" onclick="return false;">${revAllList.reservation.reservationDay }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.memberInfo.memNickName }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.memberInfo.id }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.companyInfo.comName }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.reservation.roomNum }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.reservation.useStartTime }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.reservation.useFinishTime }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.reservation.userCount }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.reservation.amount }</a></td>
				<c:if test="${revAllList.reservation.merchant_uid == null}">
				<td><a href="#" onclick="return false;">미결제</a></td>
				</c:if>
				<c:if test="${revAllList.reservation.merchant_uid != null}">
				<td><a href="#" onclick="return false;">${revAllList.reservation.merchant_uid }</a></td>
				</c:if>
			</tr>
				</c:forEach>
		</tbody>
	</table>
	<div class="btnContent">
		<div class="pagination paginatedRev" id="pagination">페이지 영역</div>
	</div>
</div>

<div class="content main meetingRoomManage">
	<h1> 회의실 관리 </h1>
	<table class="table masterMgmtTable">
		<thead class="thead-light">
			<tr>
				<td colspan="8" id="addMasterBtn">
					<button type="button" class="btn btn-primary addMasterBtn" onclick="location.href='addMasterAccount'">추가</button>
				</td>
			</tr>
		    <tr>
				<th scope="col">회사코드</th>
				<th scope="col">회사명</th>
				<th scope="col">대표</th>
				<th scope="col">담당자</th>
				<th scope="col">대표번호</th>
				<th scope="col">마스터계정</th>
				<th scope="col">가입일</th>
		    </tr>
		</thead>
		<tbody>
			<tr id="masterAccounts" data-toggle="modal" data-target="#accountDetail" >
				<td><a href="#" onclick="return false;">ㅎ</a></td>
				<td><a href="#" onclick="return false;">ㅎ</a></td>
				<td><a href="#" onclick="return false;">ㅎ</a></td>
				<td><a href="#" onclick="return false;">ㅎ</a></td>
				<td><a href="#" onclick="return false;">ㅎ</a></td>
				<td><a href="#" onclick="return false;">ㅎ</a></td>
				<td><a href="#" onclick="return false;">ㅎ</a></td>
			</tr>
		</tbody>
	</table>
	
<%//상세 Modal %>
<div class="modal fade" id="accountDetail" tabindex="-1" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="ModalTitle">마스터계정 상세 정보</h5>
			</div>
			
		
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary closeBtn" data-dismiss="modal">목록</button>
				<button type="button" class="btn btn-primary editBtn">수정</button>
				<button type="button" class="btn btn-danger deleteBtn">삭제</button>
			</div>
		</div>
	</div>
</div>

</div>

<%//1. danger Modal%>
<div class="modal fade" id="dangerModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<h5 class="modal-title" id="modalTitle">알림</h5>
			<div class="modal-body" id="modalText01"></div>
			<button type="button" class="btn btn-danger btn-block closeDangerModal" data-dismiss="modal" id="closeBtn">확인</button>
		</div>
	</div>
</div>

<%//2. primary Modal%>
<div class="modal fade" id="primaryModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<h5 class="modal-title" id="modalTitle">알림</h5>
			<div class="modal-body" id="modalText02"></div>
			<button type="button" class="btn btn-primary btn-block" data-dismiss="modal" id="closeBtn">확인</button>
		</div>
	</div>
</div>
</div>
<%@ include file="template/footer.jspf" %>