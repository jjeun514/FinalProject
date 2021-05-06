<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<title>마스터계정관리</title>
<script type="text/javascript">
$(document).ready(function(){
	$('#detail').on('show.bs.modal', function(event) {
		var officeNum="";
		officeNum = $(event.relatedTarget).data('officenum');
		console.log("offceNum: "+officeNum);

		var csrfToken = $("meta[name='_csrf']").attr("content");
		$.ajaxPrefilter(function(options, originalOptions, jqXHR){
			if (options['type'].toLowerCase() === "post") {
				jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
			}
		});
		
		$.ajax({
			url: "/spaceDetail",
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "JSON",
			data: {
				officeNum:officeNum
			},
			success: function(data){
				console.log('[ajax성공] data: '+JSON.stringify(data));
				$.each(data, function(key, value){
					$('#branchName').html(JSON.stringify(value[0].branchName).replaceAll("\"",""));
					$('#floor').html(JSON.stringify(value[0].floor).replaceAll("\"",""));
					$('#officeNum').html(JSON.stringify(value[0].officeNum).replaceAll("\"",""));
					$('#acreages').html(JSON.stringify(value[0].acreages).replaceAll("\"",""));
					$('#rent').html(JSON.stringify(value[0].rent).replaceAll("\"",""));
					$('#max').html(JSON.stringify(value[0].max).replaceAll("\"",""));
					$('#comName').html(JSON.stringify(value[0].comName).replaceAll("\"",""));
					
					if(JSON.stringify(value[0].occupancy)==0){
						$('#occupancy').html('공실');
					} else if(JSON.stringify(value[0].occupancy)==1){
						$('#occupancy').html('임대중');
					} else{
						$('#occupancy').html('-');
					}
				});
			},
			error: function(request, status, error){
				console.log("ajax 에러");
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				document.getElementById('modalText01').innerHTML='오류가 발생했습니다. 다시 시도해주세요.';
			}
		})
		
		$.ajax({
			url: "/officeFacilities",
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "JSON",
			data: {
				officeNum:officeNum
			},
			success: function(data){
				console.log('[ajax성공] data: '+JSON.stringify(data));
				$.each(data, function(key, value){
					$('#desk').html(JSON.stringify(value[0].desk).replaceAll("\"",""));
					$('#chair').html(JSON.stringify(value[0].chair).replaceAll("\"",""));
					$('#modem').html(JSON.stringify(value[0].modem).replaceAll("\"",""));
					$('#fireExtinguisher').html(JSON.stringify(value[0].fireExtinguisher).replaceAll("\"",""));
					$('#airConditioner').html(JSON.stringify(value[0].airConditioner).replaceAll("\"",""));
					$('#radiator').html(JSON.stringify(value[0].radiator).replaceAll("\"",""));
					$('#descendingLifeLine').html(JSON.stringify(value[0].descendingLifeLine).replaceAll("\"",""));
					$('#powerSocket').html(JSON.stringify(value[0].powerSocket).replaceAll("\"",""));
				});
			},
			error: function(request, status, error){
				console.log("ajax 에러");
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				document.getElementById('modalText01').innerHTML='오류가 발생했습니다. 다시 시도해주세요.';
			}
		})
       });
});
</script>

<div class="content main">
	<h1> 마스터계정 관리 </h1>
	<table class="table spaceMgmtTable">
		<thead class="thead-light">
		    <tr>
				<th scope="col">No</th>
				<th scope="col">회사</th>
				<th scope="col">입주 사무실</th>
				<th scope="col">아이디</th>
				<th scope="col">가입일</th>
		    </tr>
		</thead>
		<tbody>
		<c:forEach items="${spaceInfo}" var="spaceInfo">
			<c:if test="${spaceInfo.occupancy eq 0}">
				<tr id="highlight" data-toggle="modal" data-target="#detail" data-officenum="${spaceInfo.officeNum}">
					<td><a href="#">${spaceInfo.branchName}</a></td>
					<td><a href="#">${spaceInfo.floor}</a></td>
					<td class="officeNum"><a href="#">${spaceInfo.officeNum}</a></td>
					<td><a href="#">${spaceInfo.acreages}</a></td>
					<td><a href="#">${spaceInfo.rent}</a></td>
					<td id="empty"><a href="#">공실</a></td>
					<td><a href="#">${spaceInfo.comName}</a></td>
					<td><a href="#">${spaceInfo.max}</a></td>
				</tr>
			</c:if>
			
			<c:if test="${spaceInfo.occupancy eq 1}">
				<tr id="spaceInfo" data-toggle="modal" data-target="#detail" data-officenum="${spaceInfo.officeNum}">
					<td><a href="#">${spaceInfo.branchName}</a></td>
					<td><a href="#">${spaceInfo.floor}</a></td>
					<td class="officeNum"><a href="#">${spaceInfo.officeNum}</a></td>
					<td><a href="#">${spaceInfo.acreages}</a></td>
					<td><a href="#">${spaceInfo.rent}</a></td>
					<td id="occupied"><a href="#">임대</a></td>
					<td><a href="#">${spaceInfo.comName}</a></td>
					<td><a href="#">${spaceInfo.max}</a></td>
				</tr>
			</c:if>
		</c:forEach>
		</tbody>
	</table>
</div>
<%@ include file="template/footer.jspf" %>