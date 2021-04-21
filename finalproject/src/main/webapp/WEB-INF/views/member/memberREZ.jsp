<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <title>MEMBER : RESERVATION</title>
<%@ include file="../template/memberPageHeader.jspf" %>
<script>

    
</script>
<body>
	<div class = "content bbs">
		<div class = "container">
			<div class = "row">
				<div class = "col-md-12">
					<table class = "table table-bordered">
						<thead>
							<tr>
								<th></th>
								<th id = "REZTimeCell">09시</th>
								<th id = "REZTimeCell">10시</th>
								<th id = "REZTimeCell">11시</th>
								<th id = "REZTimeCell">12시</th>
								<th id = "REZTimeCell">13시</th>
								<th id = "REZTimeCell">14시</th>
								<th id = "REZTimeCell">15시</th>
								<th id = "REZTimeCell">16시</th>
								<th id = "REZTimeCell">17시</th>
								<th id = "REZTimeCell">18시</th>
								<th id = "REZTimeCell">19시</th>
								<th id = "REZTimeCell">20시</th>
								<th id = "REZTimeCell">21시</th>
								<th id = "REZTimeCell">22시</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td id = "roomCell">121</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							
							<tr>
								<td id = "roomCell">131</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
					<div>
						<button id = "REZbtn" type="button" class="btn btn-default">사용예약</button>
					</div>
				</div>
			</div>
			<p></p>
			<p>* 회의실 예약은 최대 2시간까지 가능합니다.</p>
			<p>* 회의실 예약은 결제가 완료되어야 확정됩니다.</p>
			<p>* 문의 : 112</p>
		</div>
	</div>
</body>
<!--body end-->
<%@ include file="../template/footer.jspf" %>
</html>



<!--
justify-content-center= 가운데 정렬
my-2= 높이주기
mr-3= 너비주기
m-3= 전체적인 간격주기
fixed-top= 위로고정
-->