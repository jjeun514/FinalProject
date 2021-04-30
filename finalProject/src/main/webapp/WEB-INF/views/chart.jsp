<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<div id="chartTitle">
		<h2 id="dataTitle">회의실 예약현황</h2>
		<br><a href="#" id="more">더보기</a>
			<%
				Date today=new Date();
				SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
			%>
		<div id="calendar">
			<p id="today"><strong>날짜:</strong> <input type="date" value="<%=sf.format(today)%>" name="dateInput" id="dateInput"></p>
			<button class="btn btn-dark me-md-2" type="submit" id="dateBtn">확인</button>
		</div>
	</div>
		<p id="resMsg">예약된 회의실이 없습니다.</p>
		<canvas id="chart"></canvas>

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
			console.log(${roomNum.roomNum});
		</c:forEach>
		
		var datas=[];
		<c:forEach items="${totalReservation}" var="totalReservation">
			datas.push(${totalReservation.totalReservation});
			console.log(${totalReservation.totalReservation});
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
		};
		
		drawing();

		$(document).on('click','#dateBtn',function() {
			var dateSelected=$('#dateInput').val();
			console.log('선택날짜:');
			console.log(dateSelected);
			console.log($('#dateInput').val());
				$.ajax({
					url: "/chart",
					type: "POST",
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					dataType: "JSON",
					data: {
						dateSelected: dateSelected
					},
					success: function(updatedTotalReservation){
						console.log('[ajax 성공]');
						$.each(updatedTotalReservation, function(key, value){
							datas=value;
							console.log(key);
							console.log(value);
						});
						console.log('[ajax성공] datas: ');
						console.log(datas);
						
						console.log(datas.length);
						var index;
						var sum=0;
						for(index=0; index<datas.length; index++){
							console.log('index: '+index+', data: '+datas[index]);
							sum=sum+datas[index];
							console.log('sum: '+sum);
						}
						if(sum==0){
							console.log('sum=0');
							datas=[0];
							$('#resMsg').css('color','red');
							$('#resMsg').css('background-color','lightyellow');
						}else{
							console.log('sum!=0');
						}
						
						chart.destroy();
						drawing();
					},
					error: function(request, status, error){
						console.log("[ajax 에러]");
						console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
		});
	
	});
	</script>