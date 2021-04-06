<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value='/js/jquery-3.3.1.min.js' />"></script>
<title>List</title>
</head>
<body>
	<h1>學生列表</h1>
	<form id="viewDetail" action="view" method="post">
		<input name="id" type="hidden" /> <input name="type" type="hidden" />
		<table>
			<c:if test="${resultList.size()>0}">
				<tr>
					<td>學號</td>
					<td>名字</td>
					<td>操作</td>
				</tr>
				<c:forEach items="${resultList}" var="result" varStatus="s">
					<tr>
						<td>${result.id}</td>
						<td>${result.name}</td>
						<td><input type="button" value="查看"
							onclick="view(${result.id},'view')"></td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</form>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		
	})
	function view(id,type){
		$('input[name="id"]').val(id);
		$('input[name="type"]').val(type);
		$("#viewDetail").submit();
	}
</script>
</html>
