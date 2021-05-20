<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/navbar.jspf" %>
<title>Home</title>
<div class="content main">
	<%//배너 carousel %>
	<div id="carouselIndicators" class="carousel slide" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselIndicators" data-slide-to="0" class="active carouselLi"></li>
			<li data-target="#carouselIndicators" data-slide-to="1"></li>
			<li data-target="#carouselIndicators" data-slide-to="2"></li>
			<li data-target="#carouselIndicators" data-slide-to="3"></li>
			<li data-target="#carouselIndicators" data-slide-to="4"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="imgs/banner01.png" class="d-block w-100">
			</div>
			<div class="carousel-item">
				<img src="imgs/banner02.jpg" class="d-block w-100">
			</div>
			<div class="carousel-item">
				<img src="imgs/banner03.jpg" class="d-block w-100">
			</div>
			<div class="carousel-item">
				<img src="imgs/banner04.jpg" class="d-block w-100">
			</div>
			<div class="carousel-item">
				<img src="imgs/banner05.png" class="d-block w-100">
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselIndicators" role="button" data-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="sr-only"></span>
		</a>
		<a class="carousel-control-next" href="#carouselIndicators" role="button" data-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="sr-only"></span>
		</a>
	</div>
	
	<%//본문 - 소개 %>
	<div class="container-fluid contentsContainer">
		<div class="row serviceSection">
			<div class="col">
				<h2>Service</h2>
				<p>9 O' Clock에 입주하시면 다양한 혜택을 받으실 수 있습니다.</p>
			</div>
		</div>
	    <div class="row cardSection">
			<div class="col">
				<div class="card" >
					<a href="#" onclick="return false;"><img src="imgs/home-service-PC.png" class="card-img-top"></a>
					<div class="card-body">
						<h3 class="card-title">서비스</h3>
						<p class="card-text">회사 규모, 필요 기간에 맞춰 쉽고 빠르게 사무공간을 마련할 수 있습니다.</p>
	         		</div>
				</div>
			</div>
			<div class="col">
				<div class="card" >
					<a href="#" onclick="return false;"><img src="imgs/home-place-PC.png" class="card-img-top" alt="..."></a>
					<div class="card-body">
						<h3 class="card-title">지점 소개</h3>
						<p class="card-text">초역세권에 위치한 16개의 지점 중우리 회사가 원하는 지점을 찾아보세요.</p>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card" >
					<a href="#" onclick="return false;"><img src="imgs/home-member-PC.png" class="card-img-top" alt="..."></a>
					<div class="card-body">
						<h3 class="card-title">멤버 혜택</h3>
						<p class="card-text">입주 멤버를 위해 휴게공간부터 이벤트까지다양한 혜택을 제공합니다.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="template/footer.jspf" %>