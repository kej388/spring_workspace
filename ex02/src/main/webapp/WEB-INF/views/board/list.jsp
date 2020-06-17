<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>List Page</h1>
	
	<c:forEach items="${list}" var="board">
		${board.bno}
		${board.title} 
		${board.writer} 
		${board.regdate}
		${board.updateDate}
	</c:forEach>
</body>
</html>