<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/navbar.jspf" %>
<script>
//게시판 검색기능//
  $(document).ready(function() {
    var activeSystemClass = $('.list-group-item.active');

    //something is entered in search form
    $('#system-search').keyup( function() {
       var that = this;
        // affect all table rows on in systems table
        var tableBody = $('.table-list-search tbody');
        var tableRowsClass = $('.table-list-search tbody tr');
        $('.search-sf').remove();
        tableRowsClass.each( function(i, val) {
            //Lower text for case insensitive
            var rowText = $(val).text().toLowerCase();
            var inputText = $(that).val().toLowerCase();
            if(inputText != '')
            {
                $('.search-query-sf').remove();
                tableBody.prepend('<tr class="search-query-sf"><td colspan="6"><strong>Searching for: "'
                    + $(that).val()
                    + '"</strong></td></tr>');
            }
            else
            {
                $('.search-query-sf').remove();
            }

            if( rowText.indexOf( inputText ) == -1 )
            {
                //hide rows
                tableRowsClass.eq(i).hide();
            }
            else
            {
                $('.search-sf').remove();
                tableRowsClass.eq(i).show();
            }
        });
        //all tr elements are hidden
        if(tableRowsClass.children(':visible').length == 0)
        {
            tableBody.append('<tr class="search-sf"><td class="text-muted" colspan="6">No entries found.</td></tr>');
        }
    });
});  
</script>

<div class="content main bbs">
 <div class="container">
  <div class="row">
   <div class="col-md-3">
    <form action="#" method="get">
     <div class="input-group">
     <!-- USE TWITTER TYPEAHEAD JSON WITH API TO SEARCH -->
      <input class="form-control" id="system-search" name="q" placeholder="Search for" required>
      <span class="input-group-btn">
      <button type="submit" class="btn btn-default"><i class="glyphicon glyphicon-search"></i></button>
      </span>
     </div>
    </form>
   </div>
   <div class="col-md-9">
    <table class="table table-list-search">
     <thead>
      <tr>
       <th>번호</th>
       <th>회사명</th>
       <th>닉네임</th>
       <th>제목</th>
       <th>날짜</th>
      </tr>
     </thead>
     <tbody>
      <tr>
       <td>Sample</td>
       <td>Filter</td>
       <td>12-11-2011 11:11</td>
       <td>OK</td>
       <td>123</td>
      </tr>
      <tr>
       <td>호호</td>
       <td>It</td>
       <td>11-20-2013 08:56</td>
       <td>It</td>
       <td>Works</td>
      </tr>
      <tr>
       <td>안농</td>
       <td>It</td>
       <td>11-20-2013 08:56</td>
       <td>It</td>
       <td>Works</td>
      </tr>
      <tr>
       <td>더미더미</td>
       <td>It</td>
       <td>11-20-2013 08:56</td>
       <td>It</td>
       <td>Works</td>
      </tr>
     </tbody>
    </table>   
   </div>
  </div>
 </div>
</div>
<%@ include file="./template/footer.jspf" %>