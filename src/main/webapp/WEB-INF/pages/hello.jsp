<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value='/js/jquery-3.3.1.min.js' />"></script>
<title>HelloWorld</title>
</head>
<body>
	<h1>Hello World!! Spring MVC</h1>
	<input type="button" id="getAll" value="列出全部學生" />
</body>
<script type="text/javascript">
	$(document).ready(function() {
		if ('${message}' != '') {
			alert('${message}')
		}

		$("#getAll").click(function() {
			window.location.href = "<c:url value='/list' />"
		});
	})
</script>
</html>
