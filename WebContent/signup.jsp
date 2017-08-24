<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/signupStyle.css" rel="stylesheet" type="text/css">
<script>
function disabledButton(btn){
	btn.disabled=true;
	btn.form.submit();
}
function check(){
	if(window.confirm('本当にログアウトしますか？')){ // 確認ダイアログを表示
		return true; // 「OK」時は送信を実行
	}
	else{ // 「キャンセル」時の処理
		return false; // 送信を中止
	}
}
</script>
<title>ユーザー新規登録</title>
</head>
<body>
	<div class="link">
		<a href="./" class="homeLink">ホーム</a>
		<a href="manage" class="manageLink">ユーザー管理</a>
		<form  method="POST" onClick="return check()" style="display: inline">
			<a href="logout" style="float:right;" class="logoutLink">ログアウト</a>
		</form><br />
	</div>
	<div class="header"><c:out value="　ユーザー新規登録　" /></div>
	<div class="signup">

	<div class="main-contents">
		<c:if test="${ not empty errorMessages }">
			<div style="color:red" class="errorMessages">
				<p class="errorMessage">
					<c:forEach items="${errorMessages}" var="message">
						<c:out value="${message}" /><br />
					</c:forEach>
				</p>
			</div>
			<c:remove var="errorMessages" scope="session" />
		</c:if>


		<form action="signup" method="post" class="signupForm" >
		<br>

			<label for="name"><b>名前</b></label><br>
			<input name="name" value="${user.name}" maxlength='10' class="text"/><h5 style="display: inline">（10文字以下で入力してください）</h5><br /><br />

			<label for="loginId"><b>ログインID</b></label><br>
			<input name="loginId"value="${user.loginId}" maxlength='20' class="text"/><h5 style="display: inline">（半角英数字6文字以上20文字以下で入力してください）</h5><br /><br />

			<label for="password"><b>パスワード</b></label><br>
			<input name="password" type="password" maxlength='20' class="text"/><h5 style="display: inline">（記号または半角文字6文字以上20文字以下で入力してください）</h5><br />

			<label for="checkPassword"><b>パスワード（再入力）</b></label><br>
			<input name="checkPassword" type="password" maxlength='20' class="text"/><br /><br />


 			<label for="branchId"><b>支店</b></label><br>
 			<SELECT name="branch" class="dropdown" style="font-size:13px;">
 				<c:if test="${user.branchId == null}">
 					<option value="" selected>選択してください</option>
 				</c:if>
 				<c:if test="${user.branchId != null}">
 					<option value="">選択してください</option>
 				</c:if>
 				<c:forEach items="${branches}" var="branch" >
 					<c:if test="${user.branchId == branch.id}">
 						<option value="${branch.id}" selected>${branch.name}</option>
 					</c:if>
 					<c:if test="${user.branchId != branch.id}">
 						<option value="${branch.id}">${branch.name}</option>
 					</c:if>
 				</c:forEach>
 			</SELECT><br><br>

 			<label for="positionId"><b>部署/役職</b></label><br>
 			<SELECT name="position" class="dropdown" style="font-size:13px;">
 				<c:if test="${user.branchId == null}">
 					<option value="" selected>選択してください</option>
 				</c:if>
 				<c:if test="${user.branchId != null}">
 					<option value="">選択してください</option>
 				</c:if>
 				<c:forEach items="${positions}" var="position" >
 					<c:if test="${user.positionId == position.id}">
 						<option value="${position.id}" selected>${position.name}</option>
 					</c:if>
 					<c:if test="${user.positionId != position.id}">
 						<option value="${position.id}">${position.name}</option>
 					</c:if>
 				</c:forEach>
 			</SELECT> <br /><br>

 			<input type="submit" value="入力した内容で登録" onClick="disabledButton(this)" class="signupButton"/> <br /><br />
 		</form><br><br>

	</div>
</div>
</body>
</html>
