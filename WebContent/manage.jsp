<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/manageStyle.css" rel="stylesheet" type="text/css">
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
<title>ユーザー管理</title>
<script type="text/javascript">
function stopped(){
	if(window.confirm('ユーザーを停止しますか？')){ // 確認ダイアログを表示
		return true; // 「OK」時は送信を実行
	}
	else{ // 「キャンセル」時の処理
		return false; // 送信を中止
	}
}
function working(){
	if(window.confirm('ユーザーを復活しますか？')){ // 確認ダイアログを表示
		return true; // 「OK」時は送信を実行
	}
	else{ // 「キャンセル」時の処理
		return false; // 送信を中止
	}
}
</script>
</head>
<body>
	<div class="link">
	<a href="./" class="homeLink">ホーム</a>
	<a href="signup" class="signupLink">ユーザー新規登録</a>
	<form method="POST" onClick="return check()" style="display: inline">
		<a href="logout" style="float:right;" class="logoutLink">ログアウト</a>
	</form>
	</div>

<div class="header">
	　ユーザー管理　
	</div>

	<c:if test="${ not empty errorMessages }">
			<div style="color:red" class="errorMessages">
				<ul>
					<c:forEach items="${errorMessages}" var="message">
						<c:out  value="${message}" />
					</c:forEach>
				</ul>
			</div>
		<c:remove var="errorMessages" scope="session" />
	</c:if>

	<table  class="manage">
			<tr class="header">
				<th class="name">名前</th>
				<th class="loginId">ログインID</th>
				<th class="branch">支店</th>
				<th class="position">部署/役職</th>
				<th class="setting">編集</th>
				<th class="isWorking">復活/停止</th>
			</tr>

			<c:forEach items="${users}" var="user">
				<tr class="user">
					<td class="nameCell" width="250"><c:if test="${user.isWorking == 0}"><div style="color:red;display:inline;">【停止中】</div></c:if><c:out value="${user.name }" /></td>

					<td class="loginIdCell"><c:out value="${user.loginId }" /></td>

					<c:forEach items="${branches}" var="branch">
						<c:if test="${user.branchId == branch.id}">
							<td class="branchCell"><c:out value="${branch.name }" /></td>
						</c:if>
					</c:forEach>

					<c:forEach items="${positions}" var="position">
						<c:if test="${user.positionId == position.id}">
							<td class="positionCell"><c:out value="${position.name }" /></td>
						</c:if>
					</c:forEach>

					<td class="settingCell">
						<form action="setting" method="get">
							<button type="submit" name="id" value="${user.id}" class="settingButton">編集</button>
						</form>
					</td>

					<td class="isWorkingCell">
						<div align="center">
							<c:if test="${loginUser.id != user.id }" >
								<form  action="is_working" method="post" onClick="return stopped()" style="display: inline">
									<c:if test="${user.isWorking == 1 }">
										<button type="submit" name="isWorking" value="0" class="stop">停止</button>
										<input type="hidden" name="id" value="${user.id}">
									</c:if>
								</form>
								<form  action="is_working" method="post" onClick="return working()" style="display: inline">
									<c:if test="${user.isWorking == 0 }">
										<button type="submit" name="isWorking" value="1" class="work">復活</button>
										<input type="hidden" name="id" value="${user.id}">
									</c:if>
								</form>
							</c:if>
							<c:if test="${loginUser.id == user.id }" ><font size="2">ログイン中</font>
							</c:if>
						</div>
					</td>
				</tr>
			</c:forEach>
	</table><br>
</body>
</html>