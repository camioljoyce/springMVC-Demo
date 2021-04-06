<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value='/js/jquery-3.3.1.min.js' />"></script>
<title>View Detail</title>
</head>
<body>
	<h1>詳細資料</h1>
	<form:form id="viewDetail" action="view" method="post" modelAttribute="s">
		<form:input path="id" type="hidden" /> <input name="type" type="hidden" />
		<table>
			<tr>
				<td>學號</td>
				<td>名字</td>
				<td>數學成績</td>
			</tr>

			<tr>
				<td>${s.id}</td>
				<c:choose>
					<c:when test="${type eq 'view'}">
						
						<td>${s.name}</td>
						<td align="center">${s.mathScore}</td>
					</c:when>
					<c:otherwise>
							<td><form:input path="name" /> </td>
							<td align="center"><form:input path="mathScore" /></td>
					</c:otherwise>
				</c:choose>
			</tr>

		</table>
	</form:form>
	<input type="button" value="回上ㄧ頁" onclick="history.back()" />
	<c:choose>
		<c:when test="${type eq 'view'}">
			<input type="button" value="修改"
				onclick="modifyDetail(${s.id}),'modify'" />
		</c:when>
		<c:otherwise>
			<input type="button" value="確認修改" onclick="update()" />
		</c:otherwise>
	</c:choose>
</body>
<script type="text/javascript">
	$(document).ready(function() {

	})
	function modifyDetail(id,type){
		$('input[name="id"]').val(id);
		$('input[name="type"]').val(type);
		$("#viewDetail").submit();
	}
	function update(){
		$("#viewDetail").attr("action","update").submit();
	}
</script>
</html>
