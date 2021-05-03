<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<div class="content main">
	<h1> 공간 관리 </h1>
	<table class="table spaceMgmtTable">
		<thead class="thead-light">
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
	<script>
	$(document).ready(function(){
		var branchName, floor, officeNum, acreages, rent, occupancy, max, comName;
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
				url: "/spaceMgmt",
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				data: {
					officeNum:officeNum
				},
				success: function(data){
					console.log('[ajax성공] spaceDetail: '+data);
					console.log(typeof data);
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
						<tr>
							<th>지점</th>
							<td id="branchName">여기</td>
							<th>가격</th>
							<td>here</td>
						</tr>
						<tr>
							<th>층</th>
							<td>here</td>
							<th>임대현황</th>
							<td>here</td>
						</tr>
						<tr>
							<th>호수</th>
							<td>here</td>
							<th>가용인원</th>
							<td>here</td>
						</tr>
						<tr>
							<th>평수</th>
							<td>here</td>
							<th>현재입주사</th>
							<td>here</td>
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
				<button type="button" class="btn btn-secondary" onclick="location.href='spaceMgmt'">목록</button>
				<button type="button" class="btn btn-primary">수정</button>
				<button type="button" class="btn btn-danger">삭제</button>
			</div>
		</div>
	</div>
</div>
</div>
<%@ include file="template/footer.jspf" %>