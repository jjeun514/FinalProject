<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<div id="chartTitle">
		<h2 id="dataTitle">〈회의실 예약현황〉</h2>
			<%
				Date today=new Date();
				SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
			%>
		<div id="calendar">
			<p id="today"><strong>날짜:</strong> <input type="date" value="<%=sf.format(today)%>" name="dateInput" id="dateInput"></p>
			<button class="btn btn-dark me-md-2" type="submit" id="dateBtn">확인</button>
		</div>
	</div>
		<canvas id="chart"></canvas>
		<p id="resMsg">예약된 회의실이 없습니다.</p>

	<script type="text/javascript">
	$(document).ready(function(){
		var csrfToken = $("meta[name='_csrf']").attr("content");
		$.ajaxPrefilter(function(options, originalOptions, jqXHR){
			if (options['type'].toLowerCase() === "post") {
				jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
			}
		});
		
		var labels=[];
		<c:forEach items="${roomNum}" var="roomNum">
			labels.push('${roomNum.roomNum}');
		</c:forEach>
		
		var datas=[];
		<c:forEach items="${totalReservation}" var="totalReservation">
			datas.push(${totalReservation.totalReservation});
		</c:forEach>
		
		var ctx = document.getElementById("chart").getContext('2d');
		var chart;
		
		function drawing(){
			chart = new Chart(ctx, {
				  type: 'doughnut',
				  data: {
				      labels: labels,
				      datasets: [{
				          label: '회의실 예약현황',
				          data: datas,
				          backgroundColor: [
				              'rgba(255, 99, 132, 0.2)',
				              'rgba(54, 162, 235, 0.2)',
				              'rgba(255, 206, 86, 0.2)',
				              'rgba(75, 192, 192, 0.2)',
				              'rgba(153, 102, 255, 0.2)',
				              'rgba(255, 159, 64, 0.2)'
				          ],
				          borderColor: [
				              'rgba(255,99,132,1)',
				              'rgba(54, 162, 235, 1)',
				              'rgba(255, 206, 86, 1)',
				              'rgba(75, 192, 192, 1)',
				              'rgba(153, 102, 255, 1)',
				              'rgba(255, 159, 64, 1)'
				          ],
				          borderWidth: 1
				      }]
				  }
				});
			
			var index;
			var sum=0;
			for(index=0; index<datas.length; index++){
				sum=sum+datas[index];
			}
			if(sum==0){
				datas=[0];
				$('#resMsg').css('color','red');
				$('#resMsg').css('background-color','lightyellow');
			}else{
				$('#resMsg').css('color','rgba(0,0,0,0)');
				$('#resMsg').css('background-color','transparent');
			}
		};
		
		drawing();

		$(document).on('click','#dateBtn',function() {
			var dateSelected=$('#dateInput').val();
			$.ajax({
				url: "/chart",
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "JSON",
				data: {
					dateSelected: dateSelected
				},
				success: function(updatedTotalReservation){
					$.each(updatedTotalReservation, function(key, value){
						datas=value;
					});

					chart.destroy();
					drawing();
				},
				error: function(){
					document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
					$('#dangerModal').modal('show');
				}
			});
		});
	});
	</script>