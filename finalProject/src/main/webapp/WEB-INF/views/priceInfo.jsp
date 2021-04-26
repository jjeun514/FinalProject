<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/navbar.jspf" %>
<div class="content main">
	<%//배너 carousel %>
	<div id="carouselIndicators" class="carousel slide" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselIndicators" data-slide-to="0" class="active"></li>
			<li data-target="#carouselIndicators" data-slide-to="1"></li>
			<li data-target="#carouselIndicators" data-slide-to="2"></li>
			<li data-target="#carouselIndicators" data-slide-to="3"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="imgs/2.jpg" class="d-block w-100">
			</div>
			<div class="carousel-item">
				<img src="imgs/3.jpg" class="d-block w-100">
			</div>
			<div class="carousel-item">
				<img src="imgs/4.jpg" class="d-block w-100">
			</div>
			<div class="carousel-item">
				<img src="imgs/5.jpg" class="d-block w-100">
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
	<p id="process">
		<img src="imgs/process.png">
	</p>
	
	<h1> 가격 안내 </h1>
	<table class="table priceInfo">
		<thead class="thead-light">
		    <tr>
				<th scope="col">층</th>
				<th scope="col">사무실</th>
				<th scope="col">평수</th>
				<th scope="col">월세</th>
				<th scope="col">인원</th>
				<th scope="col">계약 가능 여부</th>
		    </tr>
		</thead>
		<tbody>
		<c:forEach items="${priceItems }" var="priceList">
		    <tr id="priceData">
				<td><a href="#">${priceList.floor}</a></td>
				<td><a href="#">${priceList.officeNum}</a></td>
				<td><a href="#">${priceList.acreages}평</a></td>
				<td><a href="#">${priceList.rent}원</a></td>
				<td><a href="#">${priceList.max}명</a></td>
			<c:if test="${priceList.occupancy eq 1 }">
				<td><a href="#">불가능</a></td>
			</c:if>
			<c:if test="${priceList.occupancy eq 0 }">
				<td><a href="#">가능</a></td>
			</c:if>
		    </tr>
	    </c:forEach>
		</tbody>
	</table>
	
<div class="container t1" >
  <div class="box_t1" data-toggle="modal" data-target="#exampleModal-1">
    <img src="https://source.unsplash.com/1000x800">
    <span>1F</span>
  </div>

  <div class="box_t1" data-toggle="modal" data-target="#exampleModal-2">
    <img src="https://source.unsplash.com/1000x802">
    <span>2F</span>
  </div>
  
  <div class="box_t1" data-toggle="modal" data-target="#exampleModal-3">
    <img src="https://source.unsplash.com/1000x804">
    <span>3F</span>
  </div>
  <div class="box_t1" data-toggle="modal" data-target="#exampleModal-4">
    <img src="https://source.unsplash.com/1000x806">
    <span>4F</span>
  </div>
</div>

	<div id="application">
	<h1> 입주 상담 신청서 </h1>
	<form id="formContents">
	이름, 연락처, 이메일, 회사명, 소속, 직책, 희망 금액대, 입주 예정 인원, 추가 메세지
	  <div class="form-row">
	    <div class="form-group col-md-6">
	      <label for="inputEmail4">이름</label>
	      <input type="text" class="form-control" id="inputEmail4">
	    </div>
	    <div class="form-group col-md-6">
	      <label for="inputPassword4">연락처</label>
	      <input type="text" class="form-control" id="inputPassword4">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputAddress">Address</label>
	    <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St">
	  </div>
	  <div class="form-group">
	    <label for="inputAddress2">Address 2</label>
	    <input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
	  </div>
	  <div class="form-row">
	    <div class="form-group col-md-6">
	      <label for="inputCity">City</label>
	      <input type="text" class="form-control" id="inputCity">
	    </div>
	    <div class="form-group col-md-4">
	      <label for="inputState">State</label>
	      <select id="inputState" class="form-control">
	        <option selected>Choose...</option>
	        <option>...</option>
	      </select>
	    </div>
	    <div class="form-group col-md-2">
	      <label for="inputZip">Zip</label>
	      <input type="text" class="form-control" id="inputZip">
	    </div>
	  </div>
	  <div class="form-group">
	    <div class="form-check">
	      <input class="form-check-input" type="checkbox" id="gridCheck">
	      <label class="form-check-label" for="gridCheck">
	        Check me out
	      </label>
	    </div>
	  </div>
	  <button type="submit" class="btn btn-primary">Sign in</button>
	</form>
	</div>

</div>

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
         <img src="imgs/2.jpg" class="d-block w-100">
         <div class="carousel-caption d-none d-md-block">
          <h5>First slide label</h5>
          <p>Some representative placeholder content for the first slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/3.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Second slide label</h5>
          <p>Some representative placeholder content for the second slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/4.jpg" class="d-block w-100" alt="...">
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
         <img src="imgs/2.jpg" class="d-block w-100">
         <div class="carousel-caption d-none d-md-block">
          <h5>First slide label</h5>
          <p>Some representative placeholder content for the first slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/3.jpg" class="d-block w-100">
         <div class="carousel-caption d-none d-md-block">
          <h5>Second slide label</h5>
          <p>Some representative placeholder content for the second slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/4.jpg" class="d-block w-100">
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
         <img src="imgs/2.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>First slide label</h5>
          <p>Some representative placeholder content for the first slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/3.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Second slide label</h5>
          <p>Some representative placeholder content for the second slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/4.jpg" class="d-block w-100" alt="...">
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
         <img src="imgs/2.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>First slide label</h5>
          <p>Some representative placeholder content for the first slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/3.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Second slide label</h5>
          <p>Some representative placeholder content for the second slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/4.jpg" class="d-block w-100" alt="...">
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
<%@ include file="template/footer.jspf" %>