<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/settingStyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function check(){
	if(window.confirm('本当にログアウトしますか？')){ // 確認ダイアログを表示
		return true; // 「OK」時は送信を実行
	}
	else{ // 「キャンセル」時の処理
		return false; // 送信を中止
	}
}

</script>
<title>ユーザー編集</title>
</head>
<body>
<div class="link">
	<a href="./" class="homeLink">ホーム</a>
	<a href="manage" class="manageLink">ユーザー管理</a>
	<form method="POST" onClick="return check()" style="display: inline">
		<a href="logout" style="float:right;" class="logoutLink">ログアウト</a>
	</form>
	</div>
	<div class="header"><c:out value="　ユーザー編集　" /></div>


	<div class="main-contents">
		<c:if test="${ not empty errorMessages }">
			<div style="color:red" class="errorMessage">
				<ul>
					<c:forEach items="${errorMessages}" var="message">
						<c:out value="${message}" /><br>
					</c:forEach>
				</ul>
			</div>
			<c:remove var="errorMessages" scope="session" />
		</c:if>

		<form action="setting" method="post" >
			<div class="settingForm">
			<br>

			<label	for="name"><b>名前</b></label><br>
			<input name="name" value="${editUser.name}" maxlength='10' class="text"/><h5 style="display: inline">（10文字以下で入力してください）</h5><br /><br />

			<label for="loginId"><b>ログインID</b></label><br>
			<input name="loginId" value="${editUser.loginId}" maxlength='20' class="text"/><h5 style="display: inline">（半角英数字6文字以上20文字以下で入力してください）</h5><br /><br />

			<label	for="password"><b>パスワード</b></label><br>
			<input name="password" 	type="password" maxlength='20' class="text"/><h5 style="display: inline">（記号または半角文字6文字以上20文字以下で入力してください）</h5><br />

			<label for="checkPassword"><b>パスワード（再入力）</b></label><br>
			<input name="checkPassword" type="password" maxlength='20' class="text"/> <br /><br />

			<c:if test="${loginUser.id != editUser.id }">
				<c:forEach items="${branches}" var="branch" >
					<c:if test="${branchId == branch.id}">
						<b>現在の支店:<c:out value="${branch.name}" /></b>
					</c:if>
				</c:forEach>
				<br />

				<b>変更後の支店:</b>
				<SELECT name="branch" class="dropdown" style="font-size:13px;">
					<c:forEach items="${branches}" var="branch" >
						<c:if test="${editUser.branchId == branch.id}">
							<option value="${branch.id}" selected>${branch.name}</option>
						</c:if>
						<c:if test="${editUser.branchId != branch.id}">
							<option value="${branch.id}">${branch.name}</option>
						</c:if>
					</c:forEach>
				</SELECT>
				<br /><br />


				<c:forEach items="${positions}" var="position" >
					<c:if test="${positionId == position.id}">
						<b>現在の部署/役職:<c:out value="${position.name}" /></b>
					</c:if>
				</c:forEach>
				<br />
				<b>変更後の部署/役職:</b>
				<SELECT name="position" class="dropdown" style="font-size:13px;">
					<c:forEach items="${positions}" var="position" >
						<c:if test="${editUser.positionId == position.id}">
							<option value="${position.id}" selected>${position.name}</option>
						</c:if>
						<c:if test="${editUser.positionId != position.id}">
							<option value="${position.id}">${position.name}</option>
						</c:if>
					</c:forEach>
				</SELECT> <br />
			</c:if>
			<c:if test="${loginUser.id == editUser.id }">
				<c:forEach items="${branches}" var="branch" >
					<c:if test="${editUser.branchId == branch.id}">
						<input type="hidden" name="branch" value="${branch.id}" >
					</c:if>
				</c:forEach>
				<c:forEach items="${positions}" var="position" >
					<c:if test="${editUser.positionId == position.id}">
						<input name="position" type="hidden" value="${position.id}" >
					</c:if>
				</c:forEach>
			</c:if><br>


			<button type="submit" name="id" value="${editUser.id }" class="settings" >入力した内容で編集</button><br /><br />
			</div><br><br>
		</form>
	</div>
</body>
</html>