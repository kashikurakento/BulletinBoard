<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<title>ユーザー登録</title>
</head>
<body>
	<form method="POST" onClick="return check()" style="display: inline">
		<a href="logout" style="float:right;">ログアウト</a>
	</form><br />
	<h2><c:out value="ユーザー登録" /></h2>
	<div class="main-contents">
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

		<form action="signup" method="post">
			<label for="loginId">ログインID</label>
			<input name="loginId"value="${user.loginId}" maxlength='20' /><h5 style="display: inline">（半角英数字6文字以上20文字以下で入力してください）</h5><br />

			<label for="password">パスワード</label>
			<input name="password" type="password" maxlength='20'/><h5 style="display: inline">（記号または半角英数字6文字以上20文字以下で入力してください）</h5><br />

			<label for="checkPassword">パスワード(再入力)</label>
			<input name="checkPassword" type="password" maxlength='20'/><br />

			<label for="name">名前</label>
			<input name="name" value="${user.name}" /><h5 style="display: inline">（10文字以内で入力してください）</h5><br />

			<label for="branchId">支店</label>
			<SELECT name="branch">
				<c:if test="${user.branchId == null}">
					<option value="noSelectBranch" selected="selected">選択してください</option>
				</c:if>
				<c:if test="${user.branchId != null}">
					<option value="noSelectBranch">選択してください</option>
				</c:if>
				<c:forEach items="${branches}" var="branch" >
					<c:if test="${user.branchId == branch.id}">
						<option value="${branch.id}" selected="selected">${branch.name}</option>
					</c:if>
					<c:if test="${user.branchId != branch.id}">
						<option value="${branch.id}">${branch.name}</option>
					</c:if>
				</c:forEach>
			</SELECT>

			<label for="positionId">部署/役職</label>
			<SELECT name="position">
				<c:if test="${user.branchId == null}">
					<option value="noSelectPosition" selected="selected">選択してください</option>
				</c:if>
				<c:if test="${user.branchId != null}">
					<option value="noSelectPosition">選択してください</option>
				</c:if>
				<c:forEach items="${positions}" var="position" >
					<c:if test="${user.positionId == position.id}">
						<option value="${position.id}" selected="selected">${position.name}</option>
					</c:if>
					<c:if test="${user.positionId != position.id}">
						<option value="${position.id}">${position.name}</option>
					</c:if>
				</c:forEach>
			</SELECT> <br />

			<input type="submit" value="入力した内容で登録" onClick="disabledButton(this)" /> <br /><br />
			<a href="manage">登録せずに戻る</a>
		</form>
	</div>
</body>
</html>
