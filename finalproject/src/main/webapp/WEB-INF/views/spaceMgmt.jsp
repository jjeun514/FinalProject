<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<script type="text/javascript">
$(document).ready(function(){
	console
	$('#detail').on('show.bs.modal', function(event) {
		var officeName="";
		officeName = $(event.relatedTarget).data('officename');
		console.log("officeName: "+officeName);

		$.ajax({
			url: "/spaceDetail",
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "JSON",
			data: {
				officeName:officeName
			},
			success: function(data){
				console.log('[ajax성공] data: '+JSON.stringify(data));
				$.each(data, function(key, value){
					try{
						if(JSON.stringify(value[0].occupancy)==0||JSON.stringify(value[0].occupancy)==null){
							$('#occupancy').html('공실');
						} else if(JSON.stringify(value[0].occupancy)==1){
							$('#occupancy').html('임대중');
						} else{
							$('#occupancy').html('-');
						}
						$('#branchName').html(JSON.stringify(value[0].branchName).replaceAll("\"",""));
						$('#floor').html(JSON.stringify(value[0].floor).replaceAll("\"",""));
						$('#officeName').html(JSON.stringify(value[0].officeName).replaceAll("\"",""));
						$('#acreages').html(JSON.stringify(value[0].acreages).replaceAll("\"",""));
						$('#rent').html(JSON.stringify(value[0].rent).replaceAll("\"","").replace(/\B(?=(\d{3})+(?!\d))/g, ","));
						$('#max').html(JSON.stringify(value[0].max).replaceAll("\"",""));
						$('#comName').html(JSON.stringify(value[0].comName).replaceAll("\"",""));
					} catch(TypeError){
						console.log('공간 정보 특정 값 null');
					}
				});
			},
			error: function(request, status, error){
				console.log("ajax 에러");
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				document.getElementById('modalText01').innerHTML='오류가 발생했습니다. 다시 시도해주세요.';
				$('#dangerModal').modal('show');
			}
		})
		
		$.ajax({
			url: "/officeFacilities",
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "JSON",
			data: {
				officeName:officeName
			},
			success: function(data){
				console.log('[ajax성공] data: '+JSON.stringify(data));
				$.each(data, function(key, value){
					try{
						if(JSON.stringify(value)=='[]'){
							console.log('값이 없음');
							return false;
						} else {
							$('#desk').html(JSON.stringify(value[0].desk).replaceAll("\"",""));
							$('#chair').html(JSON.stringify(value[0].chair).replaceAll("\"",""));
							$('#modem').html(JSON.stringify(value[0].modem).replaceAll("\"",""));
							$('#fireExtinguisher').html(JSON.stringify(value[0].fireExtinguisher).replaceAll("\"",""));
							$('#airConditioner').html(JSON.stringify(value[0].airConditioner).replaceAll("\"",""));
							$('#radiator').html(JSON.stringify(value[0].radiator).replaceAll("\"",""));
							$('#descendingLifeLine').html(JSON.stringify(value[0].descendingLifeLine).replaceAll("\"",""));
							$('#powerSocket').html(JSON.stringify(value[0].powerSocket).replaceAll("\"",""));
						}
					} catch(TypeError){
						console.log('공간 시설 특정 값 null');
					}
				});
			},
			error: function(request, status, error){
				console.log("ajax 에러");
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				document.getElementById('modalText01').innerHTML='오류가 발생했습니다. 다시 시도해주세요.';
				$('#dangerModal').modal('show');
			}
		})
       });
	
	$('.modal').on('hidden.bs.modal',function(){
		console.log('modal 닫힘');
		$('.valueSetting').html('-');
	});
});

$(document).on('click','.submitSpaceBtn',function(){
	console.log('submit버튼');
	if($('#rentInput').val()==""||$('#floorInput').val()==""||$('#officeNameInput').val()==""||$('#acreagesInput').val()==""||$('#maxInput').val()==""){
		document.getElementById('modalText01').innerHTML='필수 입력값을 입력해주세요.';
		$('#dangerModal').modal('show');
		return false;
	}
});
</script>

<div class="content main">
	<h1> 공간 관리 </h1>
	<table class="table spaceMgmtTable">
		<thead class="thead-light">
			<tr>
				<td colspan="8" id="addSpaceBtn">
					<button type="button" class="btn btn-primary addSpaceBtn" data-toggle="modal" data-target="#addModal">추가</button>
				</td>
			</tr>
		    <tr>
				<th scope="col">지점</th>
				<th scope="col">층</th>
				<th scope="col">호수</th>
				<th scope="col">평수</th>
				<th scope="col">가격</th>
				<th scope="col">임대 현황</th>
				<th scope="col">입주사</th>
				<th scope="col">가용 인원수</th>
		    </tr>
		</thead>
		<tbody>
		<c:forEach items="${spaceInfo}" var="spaceInfo">
			<c:if test="${spaceInfo.occupancy eq 0}">
				<tr id="highlight" data-toggle="modal" data-target="#detail" data-officename="${spaceInfo.officeName}">
					<td><a href="#">${spaceInfo.branchName}</a></td>
					<td><a href="#">${spaceInfo.floor}</a></td>
					<td class="officeName"><a href="#">${spaceInfo.officeName}</a></td>
					<td><a href="#">${spaceInfo.acreages}</a></td>
					<td><a href="#">${spaceInfo.rent}</a></td>
					<td id="empty"><a href="#">공실</a></td>
					<td><a href="#">${spaceInfo.comName}</a></td>
					<td><a href="#">${spaceInfo.max}</a></td>
				</tr>
			</c:if>
			
			<c:if test="${spaceInfo.occupancy eq 1}">
				<tr id="spaceInfo" data-toggle="modal" data-target="#detail" data-officename="${spaceInfo.officeName}">
					<td><a href="#">${spaceInfo.branchName}</a></td>
					<td><a href="#">${spaceInfo.floor}</a></td>
					<td class="officeName"><a href="#">${spaceInfo.officeName}</a></td>
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

<%//상세 Modal %>
<div class="modal fade" id="detail" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="ModalTitle">공간 상세 정보</h5>
			</div>
			
			<div class="modal-body">
				<div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
					<ol class="carousel carousel-indicators">
				        <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
				        <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
				        <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner">
						<div class="carousel-item active spacePic">
							<img src="imgs/2.jpg" class="d-block w-100">
							<div class="carousel-caption d-none d-md-block">
								<h5>First slide label</h5>
								<p>Some representative placeholder content for the first slide.</p>
							</div>
						</div>
						
						<div class="carousel-item spacePic">
							<img src="imgs/3.jpg" class="d-block w-100" alt="...">
							<div class="carousel-caption d-none d-md-block">
								<h5>Second slide label</h5>
								<p>Some representative placeholder content for the second slide.</p>
							</div>
						</div>
						
						<div class="carousel-item spacePic">
							<img src="imgs/4.jpg" class="d-block w-100" alt="...">
							<div class="carousel-caption d-none d-md-block">
								<h5>Third slide label</h5>
								<p>Some representative placeholder content for the third slide.</p>
							</div>
						</div>
					</div>
					
					<table class="table spaceTable">
			      		<tr colspan="4"><h3 class="spaceTitle">INFORMATION</h3></tr>
						<tr>
							<th>지점</th>
							<td id="branchName" class="valueSetting">-</td>
							<th>가격</th>
							<td id="rent" class="valueSetting">-</td>
						</tr>
						<tr>
							<th>층</th>
							<td id="floor" class="valueSetting">-</td>
							<th>임대현황</th>
							<td id="occupancy" class="valueSetting">-</td>
						</tr>
						<tr>
							<th>호수</th>
							<td id="officeName" class="valueSetting">-</td>
							<th>가용인원</th>
							<td id="max" class="valueSetting">-</td>
						</tr>
						<tr>
							<th>평수</th>
							<td id="acreages" class="valueSetting">-</td>
							<th>현재입주사</th>
							<td id="comName" class="valueSetting">-</td>
						</tr>
					</table>

					<table class="table spaceTable">
						<tr colspan="4"><h3 class="spaceTitle">기본 제공</h3></tr>	       
						<tr>
							<th>책상</th>
							<td id="desk" class="valueSetting">-</td>
							<th>의자</th>
							<td id="chair" class="valueSetting">-</td>
						</tr>
						<tr>
							<th>공유기</th>
							<td id="modem" class="valueSetting">-</td>
							<th>소화기</th>
							<td id="fireExtinguisher" class="valueSetting">-</td>
						</tr>
						<tr>
							<th>냉반기</th>
							<td id="airConditioner" class="valueSetting">-</td>
							<th>난방기</th>
							<td id="radiator" class="valueSetting">-</td>
						</tr>
						<tr>
							<th>완강기</th>
							<td id="descendingLifeLine" class="valueSetting">-</td>
							<th>콘센트</th>
							<td id="powerSocket" class="valueSetting">-</td>
						</tr>
					</table>
	
					<a class="carousel-control-prev prevIcon" href="#carouselExampleCaptions" role="button" data-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="carousel-control-next nextIcon" href="#carouselExampleCaptions" role="button" data-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
		
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary closeBtn" data-dismiss="modal">목록</button>
				<button type="button" class="btn btn-primary">수정</button>
				<button type="button" class="btn btn-danger">삭제</button>
			</div>
		</div>
	</div>
</div>

<%//공간 추가 %>
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="ModalTitle">공간 추가</h5>
		</div>
		
		<form action="/addSpace" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
		<input type="hidden" name="_method" value="POST"/>
		<div class="modal-body">
			<table class="table addSpaceTable">
	      		<tr colspan="4"><h3 class="spaceTitle">INFORMATION</h3></tr>
	      		<tr><font color="red">필수*</font></tr>
				<tr>
					<th>지점 <font color="red">*</font></th>
					<td id="branchName">
						<select type="selectBox" name="branchInput" id="branchInput">
							<c:forEach items="${branchList }" var="list">
								<option value="${list.branchName}">${list.branchName}</option>
							</c:forEach>
						</select>
					</td>
					<th>가격 <font color="red">*</font></th>
					<td id="rent"><input name="rentInput" id="rentInput" placeholder="(월 임대료 입력)"></td>
				</tr>
				<tr>
					<th>층 <font color="red">*</font></th>
					<td id="floor"><input name="floorInput" id="floorInput" placeholder="(층 입력)"></td>
					<th>호수 <font color="red">*</font></th>
					<td id="officeName"><input name="officeNameInput" id="officeNameInput" placeholder="(호수 입력)"></td>
				</tr>
				<tr>
					<th>평수 <font color="red">*</font></th>
					<td id="acreages"><input name="acreagesInput" id="acreagesInput" placeholder="(평수 입력)"></td>
					<th>가용인원 <font color="red">*</font></th>
					<td id="max"><input name="maxInput" id="maxInput" placeholder="(가용인원 입력)"></td>
				</tr>
			</table>

			<table class="table addSpaceTable">
				<tr colspan="4"><h3 class="spaceTitle">기본 제공</h3></tr>	       
				<tr>
					<th>책상</th>
					<td id="desk"><input name="deskInput" id="deskInput" placeholder="(책상 갯수 입력)"></td>
					<th>의자</th>
					<td id="chair"><input name="chairInput" id="chairInput" placeholder="(의자 갯수 입력)"></td>
				</tr>
				<tr>
					<th>공유기</th>
					<td id="modem"><input name="modemInput" id="modemInput" placeholder="(공유기 갯수 입력)"></td>
					<th>소화기</th>
					<td id="fireExtinguisher"><input name="fireExtinguisherInput" id="fireExtinguisherInput" placeholder="(소화기 갯수 입력)"></td>
				</tr>
				<tr>
					<th>냉반기</th>
					<td id="airConditioner"><input name="airConditionerInput" id="airConditionerInput" placeholder="(냉반기 갯수 입력)"></td>
					<th>난방기</th>
					<td id="radiator"><input name="radiatorInput" id="radiatorInput" placeholder="(난방기 갯수 입력)"></td>
				</tr>
				<tr>
					<th>완강기</th>
					<td id="descendingLifeLine"><input name="descendingLifeLineInput" id="descendingLifeLineInput" placeholder="(완강기 갯수 입력)"></td>
					<th>콘센트</th>
					<td id="powerSocket"><input name="powerSocketInput" id="powerSocketInput" placeholder="(콘센트 갯수 입력)"></td>
				</tr>
			</table>
		</div>
	
		<div class="modal-footer">
			<button type="submit" class="btn btn-primary submitSpaceBtn">확인</button>
			<button type="button" class="btn btn-secondary" onclick="location.href='spaceMgmt'">취소</button>
		</div>
		</form>
	</div>
</div>

<%//1. danger Modal%>
<div class="modal fade" id="dangerModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<h5 class="modal-title" id="modalTitle">알림</h5>
			<div class="modal-body" id="modalText01"></div>
			<button type="button" class="btn btn-danger btn-block" data-dismiss="modal" id="closeBtn">확인</button>
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