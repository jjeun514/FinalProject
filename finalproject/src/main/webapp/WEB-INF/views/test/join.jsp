<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<title>DataTables</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<!-- DataTable cdn -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/r/bs-3.3.5/jq-2.1.4,dt-1.10.8/datatables.min.css" />
<script type="text/javascript"
	src="https://cdn.datatables.net/r/bs-3.3.5/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('#mytable').DataTable({
			"lengthMenu" : [ [ 5, 10, 50, -1 ], [ 5, 10, 50, "All" ] ]
		});
	});
</script>
</head>

	<table id="mytable" class="table table-bordred table-striped">
		<colgroup>
			<col width="20%" />
			<col width="*" />
			<col width="20%" />
		</colgroup>
		<thead>
			<tr>
				<td>제목</td>
				<td>설명</td>
				<td>날짜</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>1</td>
				<td>1에 대한 설명</td>
				<td>2018-4-11</td>
			</tr>
			<tr>
				<td>2</td>
				<td>2에 대한 설명</td>
				<td>2018-4-12</td>
			</tr>
			<tr>
				<td>3</td>
				<td>3에 대한 설명</td>
				<td>2018-4-13</td>
			</tr>
			<tr>
				<td>4</td>
				<td>4에 대한 설명</td>
				<td>2018-4-14</td>
			</tr>
			<tr>
				<td>5</td>
				<td>5에 대한 설명</td>
				<td>2018-4-15</td>
			</tr>
			<tr>
				<td>6</td>
				<td>6에 대한 설명</td>
				<td>2018-4-16</td>
			</tr>
			<tr>
				<td>7</td>
				<td>7에 대한 설명</td>
				<td>2018-4-17</td>
			</tr>
			<tr>
				<td>8</td>
				<td>8에 대한 설명</td>
				<td>2018-4-18</td>
			</tr>
			<tr>
				<td>9</td>
				<td>9에 대한 설명</td>
				<td>2018-4-19</td>
			</tr>
			<tr>
				<td>10</td>
				<td>10에 대한 설명</td>
				<td>2018-4-20</td>
			</tr>
		</tbody>
	</table>

</body>
</html>