<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<script type="text/javascript">
$(document).ready(function(){
	var company;
	$('.valueSetting').html('0');
	$('.valueSetting').val('0');
	$('#comName').html('(없음)');

	$('#detail').on('show.bs.modal', function(event) {
		var officeName=$(event.relatedTarget).data('officename');
		var floorInput=$(event.relatedTarget).data('floorvalue');
		console.log("officeName: "+officeName+", floorInput: "+floorInput);

		$.ajax({
			url: "/spaceDetail",
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "JSON",
			data: {
				officeName:officeName,
				floorInput:floorInput
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
						$('#acreagesValue').val(JSON.stringify(value[0].acreages).replaceAll("\"",""));
						$('#rentValue').attr('type','text').val(JSON.stringify(value[0].rent).replaceAll("\"","").replace(/\B(?=(\d{3})+(?!\d))/g, ","));
						$('#maxValue').val(JSON.stringify(value[0].max).replaceAll("\"",""));
						company=JSON.stringify(value[0].comName).replaceAll("\"","")
						$('#comName').html(company);
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
				officeName:officeName,
				floorInput:floorInput
			},
			success: function(data){
				console.log('[ajax성공] data: '+JSON.stringify(data));
				$.each(data, function(key, value){
					try{
						if(JSON.stringify(value)=='[]'){
							console.log('facilities 값이 없음');
							return false;
						} else {
							$('#deskValue').val(JSON.stringify(value[0].desk).replaceAll("\"",""));
							$('#chairValue').val(JSON.stringify(value[0].chair).replaceAll("\"",""));
							$('#modemValue').val(JSON.stringify(value[0].modem).replaceAll("\"",""));
							$('#fireExtinguisherValue').val(JSON.stringify(value[0].fireExtinguisher).replaceAll("\"",""));
							$('#airConditionerValue').val(JSON.stringify(value[0].airConditioner).replaceAll("\"",""));
							$('#radiatorValue').val(JSON.stringify(value[0].radiator).replaceAll("\"",""));
							$('#descendingLifeLineValue').val(JSON.stringify(value[0].descendingLifeLine).replaceAll("\"",""));
							$('#powerSocketValue').val(JSON.stringify(value[0].powerSocket).replaceAll("\"",""));
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
	
	$(document).on('click','.closeBtn',function(){
		console.log('modal 닫힘');
		$('.valueSetting').html('0');
		$('.valueSetting').val('0');
		$('#comName').html('(없음)');
	});
	
	// 추가
	$(document).on('click','.submitSpaceBtn',function(){
		console.log('submit버튼');
		if($('#rentInput').val()==""||$('#floorInput').val()==""||$('#officeNameInput').val()==""||$('#acreagesInput').val()==""||$('#maxInput').val()==""){
			document.getElementById('modalText01').innerHTML='필수 입력값을 입력해주세요.';
			$('#dangerModal').modal('show');
			return false;
		} else{
			$.ajax({
				url: "/addSpace",
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				data: {
					branchInput:$('#branchInput').val(),
					floorInput:+$('#floorInput').val(),
					officeNameInput:$('#officeNameInput').val(),
					acreagesInput:+$('#acreagesInput').val(),
					rentInput:+$('#rentInput').val(),
					maxInput:+$('#maxInput').val()
				},
				success: function(data){
					console.log('[ajax성공] data: '+JSON.stringify(data));
					if(data=='중복'){
						console.log('branch & office 중복');
						document.getElementById('modalText01').innerHTML='입력하신 '+$('#branchInput').val()+'지점 '+$('#floorInput').val()+'층에 '+$('#officeNameInput').val()+' 사무실이 이미 등록되어 있습니다.';
						$('#dangerModal').modal('show');
						return false;
					} else if(data=='가능') {
						console.log('branch & office 가능');
						document.getElementById('modalText02').innerHTML='입력하신 공간이 추가되었습니다.';
						$('#primaryModal').modal('show');
						$('#primaryModal').on('hidden.bs.modal',function(){
							location.reload();
						});
					}
				},
				error: function(request, status, error){
					console.log("ajax 에러");
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					document.getElementById('modalText01').innerHTML='오류가 발생했습니다. 다시 시도해주세요.';
					$('#dangerModal').modal('show');
				}
			})
		}
	});

	// 수정
	$(document).on('click','.editBtn', function(){
		if($('#comName').text()=='(없음)'){
			company='(없음)';
		}
		$('.editBtn').attr('class','btn btn-success okBtn');
		$('.okBtn').html('확인');

		$('.valueSetting').prop('readonly', false);
		
		if($('#comName').text()=='(없음)'){
			console.log('company 없다: '+company);
		}
		$('#comName').html('<select class="form-control companySelected" name="companySelected">'
				+'<option>(없음)</option>'
				+'<c:forEach items="${companyList }" var="list">'
				+'<option value="${list.comName }" >${list.comName }</option>'
				+'</c:forEach>'
				+'</select>');
		$('.companySelected').val(company).prop("selected",true);
		console.log('선택값: '+$('.companySelected option:selected').val())	// 수정값
		
		$('#detail').on('hidden.bs.modal',function(){
			console.log('상세페이지 닫힘');
			$('.okBtn').attr('class','btn btn-primary editBtn');
			$('.editBtn').html('수정');
		});
		
		$(document).on('click','.okBtn', function(){
			console.log('company: '+company);
			if(company==$('.companySelected').val()){
				console.log('값 같음');
				console.log('company: '+company);
			}else{
				console.log('값 다름');
				company=$('.companySelected option:selected').val()
				console.log('company: '+company);
			}
			
			$.ajax({
				url: "/updateSpaceDetail",
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				data: {
					officeName:$('#officeName').text(),
					floorInput:$('#floor').text(),
					acreagesInput:$('#acreagesValue').val(),
					rentInput:$('#rentValue').attr('type','number').val().replaceAll(",",""),
					maxInput:$('#maxValue').val(),
					deskInput:$('#deskValue').val(),
					chairInput:$('#chairValue').val(),
					modemInput:$('#modemValue').val(),
					fireExtinguisherInput:$('#fireExtinguisherValue').val(),
					airConditionerInput:$('#airConditionerValue').val(),
					radiatorInput:$('#radiatorValue').val(),
					descendingLifeLineInput:$('#descendingLifeLineValue').val(),
					powerSocketInput:$('#powerSocketValue').val()
				},
				success: function(){
					console.log('[ajax성공] 공간 상세 정보 업데이트됨');
					document.getElementById('modalText02').innerHTML='수정이 완료되었습니다.';
					$('#primaryModal').modal('show');
					$('#primaryModal').on('hidden.bs.modal',function(){
						location.reload();
					});
				},
				error: function(request, status, error){
					console.log("ajax 에러");
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					document.getElementById('modalText01').innerHTML='오류가 발생했습니다. 다시 시도해주세요.';
					$('#dangerModal').modal('show');
				}
			})
			
			//$('.okBtn').attr('class','btn btn-primary editBtn');
			//$('.editBtn').html('수정');
		});
	});
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
				<tr id="highlight" data-toggle="modal" data-target="#detail" data-officename="${spaceInfo.officeName}" data-floorvalue="${spaceInfo.floor}">
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
				<tr id="spaceInfo" data-toggle="modal" data-target="#detail" data-officename="${spaceInfo.officeName}" data-floorvalue="${spaceInfo.floor}">
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
<div class="modal fade" id="detail" tabindex="-1" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="ModalTitle">공간 상세 정보</h5>
			</div>
			
			<div class="modal-body">
				<div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
					<ol class="carousel carousel-indicators indicatorIcon">
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
							<td id="rent"><input type="number" name="rentValue" id="rentValue" class="valueSetting" readonly></td>
						</tr>
						<tr>
							<th>층</th>
							<td id="floor" class="valueSetting">-</td>
							<th>임대현황</th>
							<td id="occupancy" class="valueSetting">-</td>
						</tr>
						<tr>
							<th>호수</th>
							<td id="officeName" class="valueSetting"></td>
							<th>가용인원</th>
							<td id="max"><input type="number" name="maxValue" id="maxValue" class="valueSetting" readonly></td>
						</tr>
						<tr>
							<th>평수</th>
							<td id="acreages"><input type="number" name="acreagesValue" id="acreagesValue" class="valueSetting" readonly></td>
							<th>현재입주사</th>
							<td id="comName" class="valueSetting"></td>
						</tr>
					</table>

					<table class="table spaceTable facilityTable">
						<tr colspan="4"><h3 class="spaceTitle">기본 제공</h3></tr>	       
						<tr>
							<th>책상</th>
							<td id="desk"><input type="number" name="deskValue" id="deskValue" class="valueSetting" readonly></td>
							<th>의자</th>
							<td id="chair"><input type="number" name="chairValue" id="chairValue" class="valueSetting" readonly></td>
						</tr>
						<tr>
							<th>공유기</th>
							<td id="modem"><input type="number" name="modemValue" id="modemValue" class="valueSetting" readonly></td>
							<th>소화기</th>
							<td id="fireExtinguisher"><input type="number" name="fireExtinguisherValue" id="fireExtinguisherValue" class="valueSetting" readonly></td>
						</tr>
						<tr>
							<th>냉반기</th>
							<td id="airConditioner"><input type="number" name="airConditionerValue" id="airConditionerValue" class="valueSetting" readonly></td>
							<th>난방기</th>
							<td id="radiator"><input type="number" name="radiatorValue" id="radiatorValue" class="valueSetting" readonly></td>
						</tr>
						<tr>
							<th>완강기</th>
							<td id="descendingLifeLine"><input type="number" name="descendingLifeLineValue" id="descendingLifeLineValue" class="valueSetting" readonly></td>
							<th>콘센트</th>
							<td id="powerSocket"><input type="number" name="powerSocketValue" id="powerSocketValue" class="valueSetting" readonly></td>
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
				<button type="button" class="btn btn-primary editBtn">수정</button>
				<button type="button" class="btn btn-danger deleteBtn">삭제</button>
			</div>
		</div>
	</div>
</div>

<%//공간 추가 %>
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="ModalTitle">공간 추가</h5>
		</div>
		
		<!-- <form action="/addSpace" method="post"> -->
		<!-- <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> -->
		<!-- <input type="hidden" name="_method" value="POST"/> -->
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
					<td id="rent"><input type="number" name="rentInput" id="rentInput" placeholder="(월 임대료 입력)"></td>
				</tr>
				<tr>
					<th>층 <font color="red">*</font></th>
					<td id="floor"><input type="number" name="floorInput" id="floorInput" placeholder="(층 입력)"></td>
					<th>호수 <font color="red">*</font></th>
					<td id="officeName"><input name="officeNameInput" id="officeNameInput" placeholder="(호수 입력)"></td>
				</tr>
				<tr>
					<th>평수 <font color="red">*</font></th>
					<td id="acreages"><input type="number" name="acreagesInput" id="acreagesInput" placeholder="(평수 입력)"></td>
					<th>가용인원 <font color="red">*</font></th>
					<td id="max"><input type="number" name="maxInput" id="maxInput" placeholder="(가용인원 입력)"></td>
				</tr>
			</table>

			<table class="table addSpaceTable">
				<tr colspan="4"><h3 class="spaceTitle">기본 제공</h3></tr>	       
				<tr>
					<th>책상</th>
					<td id="desk"><input type="number" name="deskInput" id="deskInput" placeholder="(책상 갯수 입력)"></td>
					<th>의자</th>
					<td id="chair"><input type="number" name="chairInput" id="chairInput" placeholder="(의자 갯수 입력)"></td>
				</tr>
				<tr>
					<th>공유기</th>
					<td id="modem"><input type="number" name="modemInput" id="modemInput" placeholder="(공유기 갯수 입력)"></td>
					<th>소화기</th>
					<td id="fireExtinguisher"><input type="number" name="fireExtinguisherInput" id="fireExtinguisherInput" placeholder="(소화기 갯수 입력)"></td>
				</tr>
				<tr>
					<th>냉반기</th>
					<td id="airConditioner"><input type="number" name="airConditionerInput" id="airConditionerInput" placeholder="(냉반기 갯수 입력)"></td>
					<th>난방기</th>
					<td id="radiator"><input type="number" name="radiatorInput" id="radiatorInput" placeholder="(난방기 갯수 입력)"></td>
				</tr>
				<tr>
					<th>완강기</th>
					<td id="descendingLifeLine"><input type="number" name="descendingLifeLineInput" id="descendingLifeLineInput" placeholder="(완강기 갯수 입력)"></td>
					<th>콘센트</th>
					<td id="powerSocket"><input type="number" name="powerSocketInput" id="powerSocketInput" placeholder="(콘센트 갯수 입력)"></td>
				</tr>
			</table>
		</div>
	
		<div class="modal-footer">
			<button type="submit" class="btn btn-primary submitSpaceBtn">확인</button>
			<button type="button" class="btn btn-secondary" onclick="location.href='spaceMgmt'">취소</button>
		</div>
		<!-- </form> -->
	</div>
</div>

<%//1. danger Modal%>
<div class="modal fade" id="dangerModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<h5 class="modal-title" id="modalTitle">알림</h5>
			<div class="modal-body" id="modalText01"></div>
			<button type="button" class="btn btn-danger btn-block" data-dismiss="modal" id="closeBtn">확인</button>
		</div>
	</div>
</div>

<%//2. primary Modal%>
<div class="modal fade" id="primaryModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true" data-backdrop="static" data-keyboard="false">
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