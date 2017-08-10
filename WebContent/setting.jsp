<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ユーザー編集</title>
</head>
<body>
	<h2><c:out value="ユーザー編集" /></h2>
	<div class="main-contents">
		<c:if test="${ not empty errorMessages }">
			<div class="errorMessages">
				<ul>
					<c:forEach items="${errorMessages}" var="message">
						<li><c:out value="${message}" />
					</c:forEach>
				</ul>
			</div>
			<c:remove var="errorMessages" scope="session" />
		</c:if>

		<form action="setting" method="post">

			<label for="loginId">ログインID</label>
			<input name="loginId"value="${editUser.loginId}" maxlength='20'/><h5 style="display: inline">（半角英数字6文字以上20文字以下で入力してください）</h5><br />

			<label	for="password">パスワード</label>
			<input name="password" 	type="password" maxlength='20'/><h5 style="display: inline">（記号または半角英数字6文字以上20文字以下で入力してください）</h5><br />

			<label for="checkPassword">パスワード(再入力)</label>
			<input name="checkPassword" type="password" maxlength='20'/> <br />

			<label	for="name">名前</label>
			<input name="name" value="${editUser.name}" maxlength='10' /><h5 style="display: inline">（10文字以内で入力してください）</h5><br />

			<c:forEach items="${branches}" var="branch" >
				<c:if test="${branchId == branch.id}">
					現在の支店:<c:out value="${branch.name}" />
				</c:if>
			</c:forEach>
			<br />

			変更後の支店:
			<SELECT name="branch">
				<c:forEach items="${branches}" var="branch" >
					<c:if test="${editUser.branchId == branch.id}">
						<option value="${branch.id}" selected>${branch.name}</option>
					</c:if>
					<c:if test="${editUser.branchId != branch.id}">
						<option value="${branch.id}">${branch.name}</option>
					</c:if>
				</c:forEach>
			</SELECT>
			<br />

			<c:forEach items="${positions}" var="position" >
				<c:if test="${positionId == position.id}">
					現在の部署/役職:<c:out value="${position.name}" />
				</c:if>
			</c:forEach>
			<br />
			変更後の部署/役職:
			<SELECT name="position">
				<c:forEach items="${positions}" var="position" >
					<c:if test="${editUser.positionId == position.id}">
						<option value="${position.id}" selected>${position.name}</option>
					</c:if>
					<c:if test="${editUser.positionId != position.id}">
						<option value="${position.id}">${position.name}</option>
					</c:if>
				</c:forEach>
			</SELECT> <br />

			<input type="submit" value="入力した内容で編集" /><br /><br />
			<a href="manage">編集せずに戻る</a>
		</form>

	</div>
</body>
</html>