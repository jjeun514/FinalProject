<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%@ include file="./template/header.jspf" %>
<body>
<div class="content main"><!--content start-->

<!-- carousel start-->
<div id="carouselExampleFade" class="carousel slide carousel-fade " data-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="imgs/11.jpg" class="d-block w-100" alt="img1">
    </div>
    <div class="carousel-item">
      <img src="imgs/22.jpg" class="d-block w-100" alt="img2">
    </div>
    <div class="carousel-item">
      <img src="imgs/33.jpg" class="d-block w-100" alt="img3">
    </div>
    <div class="carousel-item">
      <img src="imgs/44.jpg" class="d-block w-100" alt="img3">
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleFade" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleFade" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div><!-- carousel end-->


<div class="container-fluid c1"><!--center start-->
   <div class="row r3">
    <div class="col">
       <h2>Service</h2>
       <p>저희 9 : clack에 오신것을 환영합니다.</p>
    </div>
   </div><!--row(r3) end-->
    <div class="row r4">
       <div class="col">
        <div class="card" >
          <a href="#"><img src="imgs/home-service-PC.png" class="card-img-top" alt="..."></a>
          <div class="card-body">
            <h3 class="card-title">서비스</h3>
            <p class="card-text">회사 규모, 필요 기간에 맞춰 쉽고 빠르게 사무공간을 마련할 수 있습니다.</p>
          </div>
        </div>
       </div>
       <div class="col">
        <div class="card" >
          <a href="#"><img src="imgs/home-place-PC.png" class="card-img-top" alt="..."></a>
          <div class="card-body">
            <h3 class="card-title">지점 소개</h3>
            <p class="card-text">초역세권에 위치한 16개의 지점 중우리 회사가 원하는 지점을 찾아보세요.</p>
          </div>
        </div>
       </div>
       <div class="col">
        <div class="card" >
          <a href="#"><img src="imgs/home-member-PC.png" class="card-img-top" alt="..."></a>
          <div class="card-body">
            <h3 class="card-title">멤버 혜택</h3>
            <p class="card-text">입주 멤버를 위해 휴게공간부터 이벤트까지다양한 혜택을 제공합니다.</p>
          </div>
        </div>
       </div>
    </div><!--row(r4) end-->
   </div><!--container end-->
  </div><!--centent end-->
 </body><!--body end-->
 
 <%@ include file="./template/footer.jspf" %>
</html>



<!--
justify-content-center= 가운데 정렬
my-2= 높이주기
mr-3= 너비주기
m-3= 전체적인 간격주기
fixed-top= 위로고정
-->