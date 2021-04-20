<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%@ include file="./template/header.jspf" %>
<body>
	<div class="content main"><!--content start-->
		<div id="carouselExampleIndicators" class="carousel slide"
			data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#carouselExampleIndicators" data-slide-to="0"
					class="active"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="imgs/11.jpg" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="imgs/11.jpg" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="imgs/11.jpg" class="d-block w-100" alt="...">
				</div>
			</div>
			<a class="carousel-control-prev" href="#carouselExampleIndicators"
				role="button" data-slide="prev"> <span
				class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="sr-only">Previous</span>
			</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
				role="button" data-slide="next"> <span
				class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="sr-only">Next</span>
			</a>
		</div>
		<div class="container t1"><!-- 이미지템플릿  start-->
			<div class="box_t1">
				<img src="https://source.unsplash.com/1000x800"> <span>First
					floor&nbsp;&nbsp;</span>
			</div>
			<div class="box_t1">
				<img src="https://source.unsplash.com/1000x802"> <span>Second
					floor</span>
			</div>
			<div class="box_t1">
				<img src="https://source.unsplash.com/1000x804"> <span>Third
					floor</span>
			</div>
			<div class="box_t1">
				<img src="https://source.unsplash.com/1000x806"> <span>Fourth
					floor</span>
			</div>
		</div><!--이미지템플릿  end-->
	</div><!--centent end-->
</body>
<!--body end-->
<%@ include file="./template/footer.jspf" %>
</html>



<!--
justify-content-center= 가운데 정렬
my-2= 높이주기
mr-3= 너비주기
m-3= 전체적인 간격주기
fixed-top= 위로고정
-->