<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<%@ include file="template/navbar.jspf"%>
<div class="content main">
	<div id="chartTitle">
		<h1 id="dataTitle">회의실 예약현황</h1>
			<%
				Date today=new Date();
				SimpleDateFormat sf=new SimpleDateFormat("yyyy년 MM월 dd일");
			%>
		<p id="today"><strong>예약일자:</strong> <%=sf.format(today) %></p>
	</div>
	<canvas id="chart"></canvas>

	<script type="text/javascript">
	var ctx = document.getElementById("chart").getContext('2d');
	var chart = new Chart(ctx, {
	  type: 'doughnut',
	  data: {
	      labels: ["제1회의실", "제2회의실", "제3회의실", "제4회의실", "제5회의실", "제6회의실"],
	      datasets: [{
	          label: '회의실 예약현황',
	          data: [12, 19, 3, 5, 2, 3],
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
	</script>
</div>
<%@ include file="template/footer.jspf" %>