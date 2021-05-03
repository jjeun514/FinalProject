<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%@ include file="./template/header.jspf" %>
<body>
<div class="content main"><!--content start-->
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
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
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
<div class="container t1 " ><!-- 이미지템플릿  start-->
 
  <div class="box_t1" data-toggle="modal" data-target="#exampleModal-1">
    <img src="https://source.unsplash.com/1000x800">
    <span>First floor&nbsp;&nbsp;</span>
  </div>

  <div class="box_t1 " data-toggle="modal" data-target="#exampleModal-2">
    <img src="https://source.unsplash.com/1000x802">
    <span>Second floor</span>
  </div>
  
  <div class="box_t1" data-toggle="modal" data-target="#exampleModal-3">
    <img src="https://source.unsplash.com/1000x804">
    <span>Third floor</span>
  </div>
  <div class="box_t1" data-toggle="modal" data-target="#exampleModal-4">
    <img src="https://source.unsplash.com/1000x806">
    <span>Fourth floor</span>
  </div>
</div><!--이미지템플릿  end-->
</div><!--centent end-->
</body><!--body end-->
<!--body end-->
<%@ include file="./template/footer.jspf" %>
<!-- 모달-1 start-->
  <div class="modal fade" id="exampleModal-1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
     <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLabel">Modal-1</h5>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
       <span aria-hidden="true">&times;</span>
      </button>
     </div>
     <div class="modal-body">
      <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
       <ol class="carousel-indicators">
        <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
        <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
       </ol>
       <div class="carousel-inner"><!--모달안에 캐러셀 start-->
        <div class="carousel-item active">
         <img src="imgs/M3-1.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>First slide label</h5>
          <p>Some representative placeholder content for the first slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/M2-1.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Second slide label</h5>
          <p>Some representative placeholder content for the second slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/M1-1.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Third slide label</h5>
          <p>Some representative placeholder content for the third slide.</p>
         </div>
        </div>
       </div><!--모달안에 캐러셀 end-->
       
       <table class="table"><!--모달안에 테이블 start-->
          <thead>
           <tr>
            <th scope="col">#</th>
            <th scope="col">First</th>
            <th scope="col">Last</th>
            <th scope="col">Handle</th>
           </tr>
          </thead>
          <tbody>
           <tr>
            <th scope="row">1</th>
            <td>Mark</td>
            <td>Otto</td>
            <td>@mdo</td>
           </tr>
           <tr>
            <th scope="row">2</th>
            <td>Jacob</td>
            <td>Thornton</td>
            <td>@fat</td>
           </tr>
           <tr>
            <th scope="row">3</th>
            <td>Larry</td>
            <td>the Bird</td>
            <td>@twitter</td>
           </tr>
          </tbody>
         </table><!--모달안에 테이블 end-->

       <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
       </a>
       <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
       </a>
      </div>
     </div>
     <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      <button type="button" class="btn btn-primary">Save changes</button>
     </div>
    </div>
   </div>
  </div><!-- 모달-1 end--> 
  
  <!-- 모달-2 start-->
  <div class="modal fade" id="exampleModal-2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
     <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLabel">Modal-2</h5>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
       <span aria-hidden="true">&times;</span>
      </button>
     </div>
     <div class="modal-body">
      <div id="carouselExampleCaptions-2" class="carousel slide" data-ride="carousel">
       <ol class="carousel-indicators">
        <li data-target="#carouselExampleCaptions-2" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleCaptions-2" data-slide-to="1"></li>
        <li data-target="#carouselExampleCaptions-2" data-slide-to="2"></li>
       </ol>
       <div class="carousel-inner"><!--모달안에 캐러셀 start-->
        <div class="carousel-item active">
         <img src="imgs/M3-1.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>First slide label</h5>
          <p>Some representative placeholder content for the first slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/M2-1.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Second slide label</h5>
          <p>Some representative placeholder content for the second slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/M1-1.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Third slide label</h5>
          <p>Some representative placeholder content for the third slide.</p>
         </div>
        </div>
       </div><!--모달안에 캐러셀 end-->
       
       <table class="table"><!--모달안에 테이블 start-->
          <thead>
           <tr>
            <th scope="col">#</th>
            <th scope="col">First</th>
            <th scope="col">Last</th>
            <th scope="col">Handle</th>
           </tr>
          </thead>
          <tbody>
           <tr>
            <th scope="row">1</th>
            <td>Mark</td>
            <td>Otto</td>
            <td>@mdo</td>
           </tr>
           <tr>
            <th scope="row">2</th>
            <td>Jacob</td>
            <td>Thornton</td>
            <td>@fat</td>
           </tr>
           <tr>
            <th scope="row">3</th>
            <td>Larry</td>
            <td>the Bird</td>
            <td>@twitter</td>
           </tr>
          </tbody>
         </table><!--모달안에 테이블 end-->

       <a class="carousel-control-prev" href="#carouselExampleCaptions-2" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
       </a>

       <a class="carousel-control-next" href="#carouselExampleCaptions-2" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
       </a>
      </div>
     </div>
     <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      <button type="button" class="btn btn-primary">Save changes</button>
     </div>
    </div>
   </div>
  </div><!-- 모달 end--> 
  <!-- 모달-3 start-->
  <div class="modal fade" id="exampleModal-3" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
     <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLabel">Modal-3</h5>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
       <span aria-hidden="true">&times;</span>
      </button>
     </div>
     <div class="modal-body">
      <div id="carouselExampleCaptions-3" class="carousel slide" data-ride="carousel">
       <ol class="carousel-indicators">
        <li data-target="#carouselExampleCaptions-3" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleCaptions-3" data-slide-to="1"></li>
        <li data-target="#carouselExampleCaptions-3" data-slide-to="2"></li>
       </ol>
       <div class="carousel-inner"><!--모달안에 캐러셀 start-->
        <div class="carousel-item active">
         <img src="imgs/M3-1.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>First slide label</h5>
          <p>Some representative placeholder content for the first slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/M2-1.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Second slide label</h5>
          <p>Some representative placeholder content for the second slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/M1-1.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Third slide label</h5>
          <p>Some representative placeholder content for the third slide.</p>
         </div>
        </div>
       </div><!--모달안에 캐러셀 end-->
       
       <table class="table"><!--모달안에 테이블 start-->
          <thead>
           <tr>
            <th scope="col">#</th>
            <th scope="col">First</th>
            <th scope="col">Last</th>
            <th scope="col">Handle</th>
           </tr>
          </thead>
          <tbody>
           <tr>
            <th scope="row">1</th>
            <td>Mark</td>
            <td>Otto</td>
            <td>@mdo</td>
           </tr>
           <tr>
            <th scope="row">2</th>
            <td>Jacob</td>
            <td>Thornton</td>
            <td>@fat</td>
           </tr>
           <tr>
            <th scope="row">3</th>
            <td>Larry</td>
            <td>the Bird</td>
            <td>@twitter</td>
           </tr>
          </tbody>
         </table><!--모달안에 테이블 end-->

       <a class="carousel-control-prev" href="#carouselExampleCaptions-3" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
       </a>

       <a class="carousel-control-next" href="#carouselExampleCaptions-3" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
       </a>
      </div>
     </div>
     <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      <button type="button" class="btn btn-primary">Save changes</button>
     </div>
    </div>
   </div>
  </div><!-- 모달-3 end-->
  <!-- 모달-4 start-->
  <div class="modal fade" id="exampleModal-4" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
     <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLabel">Modal-4</h5>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
       <span aria-hidden="true">&times;</span>
      </button>
     </div>
     <div class="modal-body">
      <div id="carouselExampleCaptions-4" class="carousel slide" data-ride="carousel">
       <ol class="carousel-indicators">
        <li data-target="#carouselExampleCaptions-4" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleCaptions-4" data-slide-to="1"></li>
        <li data-target="#carouselExampleCaptions-4" data-slide-to="2"></li>
       </ol>
       <div class="carousel-inner"><!--모달안에 캐러셀 start-->
        <div class="carousel-item active">
         <img src="imgs/M3-1.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>First slide label</h5>
          <p>Some representative placeholder content for the first slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/M2-1.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Second slide label</h5>
          <p>Some representative placeholder content for the second slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/M1-1.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Third slide label</h5>
          <p>Some representative placeholder content for the third slide.</p>
         </div>
        </div>
       </div><!--모달안에 캐러셀 end-->
       
       <table class="table"><!--모달안에 테이블 start-->
          <thead>
           <tr>
            <th scope="col">#</th>
            <th scope="col">First</th>
            <th scope="col">Last</th>
            <th scope="col">Handle</th>
           </tr>
          </thead>
          <tbody>
           <tr>
            <th scope="row">1</th>
            <td>Mark</td>
            <td>Otto</td>
            <td>@mdo</td>
           </tr>
           <tr>
            <th scope="row">2</th>
            <td>Jacob</td>
            <td>Thornton</td>
            <td>@fat</td>
           </tr>
           <tr>
            <th scope="row">3</th>
            <td>Larry</td>
            <td>the Bird</td>
            <td>@twitter</td>
           </tr>
          </tbody>
         </table><!--모달안에 테이블 end-->

       <a class="carousel-control-prev" href="#carouselExampleCaptions-4" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
       </a>

       <a class="carousel-control-next" href="#carouselExampleCaptions-4" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
       </a>
      </div>
     </div>
     <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      <button type="button" class="btn btn-primary">Save changes</button>
     </div>
    </div>
   </div>
  </div><!-- 모달-4 end-->  
</html>



<!--
justify-content-center= 가운데 정렬
my-2= 높이주기
mr-3= 너비주기
m-3= 전체적인 간격주기
fixed-top= 위로고정
-->