<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
   </div><!--container end-->
  </div><!--centent end-->
 </body><!--body end-->
 
 <%@ include file="./template/footer.jspf" %>
</html>