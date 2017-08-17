<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ログイン</title>
</head>
<body>
	<div id="form">
		<p class="formTitle">ログイン</p>
		<c:if test="${ not empty errorMessages }">
			<div style="color:red" class="errorMessages">
				<ul>
					<c:forEach items="${errorMessages}" var="message">
						<li><c:out value="${message}" />
					</c:forEach>
				</ul>
			</div>
			<c:remove var="errorMessages" scope="session" />
		</c:if>

		<form action="login" method="post">

			<label for="loginId">ログインID</label>
			<p class="loginId"><input name="loginId"  value="${loginId }"/></p><br />

			<label for="password">パスワード</label>
			<p class="password"><input name="password" type="password" /></p><br />

			<p class="submit"><input type="submit" value="ログイン" /></p><br />

		</form>
	</div>
</body>
</html>
