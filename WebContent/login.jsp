<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/loginStyle.css" rel="stylesheet" type="text/css">
<title>ログイン</title>
</head>
<body>


	<div class="link">　</div>
	<div class="login">
		<p class="login-header">　ログイン　</p><br>

		<form action="login" method="post" class="login-container">

			<c:if test="${ not empty errorMessages }">
				<div style="color:#ff6161" class="errorMessages">
					<ul>
						<c:forEach items="${errorMessages}" var="message">
							<c:out value="${message}" />
						</c:forEach>
					</ul>
				</div>
				<c:remove var="errorMessages" scope="session" />
			</c:if>
			<label for="loginId">ログインID</label>
			<p class="loginId"><input name="loginId"  value="${loginId }" placeholder="login id"/></p><br />

			<label for="password">パスワード</label>
			<p class="password"><input name="password" type="password" placeholder="password"/></p><br />

			<p class="submit"><input type="submit" value="ログイン" /></p><br />

		</form>

	</div>
</body>
</html>
