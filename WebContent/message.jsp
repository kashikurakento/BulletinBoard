<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function disabledButton(btn){
	btn.disabled=true;
	btn.form.submit();
}
</script>
<title>新規投稿</title>
</head>
<body>
	<h2>新規投稿</h2>
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

	<form action="message" method="post">

		<label for="title" >件名</label>
		<input name="title" value="${message.title }" maxlength='30'/><br />

		<label for="category">カテゴリーを入力または選択</label><br />
		<input name="category" value="${message.category }" maxlength='10' placeholder="カテゴリーを入力"/><br />

		<label for="selectCategory"></label>
		<SELECT name="selectCategory">
			<option value="" selected>カテゴリーを選択</option>
			<c:forEach items="${categories}" var="category">
				<c:if test="${selectCategory == category.category }">
					<option  value="${category.category}" selected><c:out value="${category.category}"></c:out></option>
				</c:if>
				<c:if test="${selectCategory != category.category }">
					<option  value="${category.category}" ><c:out value="${category.category}"></c:out></option>
				</c:if>
			</c:forEach>
		</SELECT><br />

		<label for="text">本文</label><br />
		<textarea name="text" rows="7" cols="100" class="tweet-box" maxlength="1000">${message.text }</textarea><br />
		<input type="submit" value="投稿する" onClick="disabledButton(this)">(1000文字まで)<br /><br /><br />

	</form>

	<div class="header">
		<a href="./">ホームへ戻る</a>
	</div>
</body>
</html>