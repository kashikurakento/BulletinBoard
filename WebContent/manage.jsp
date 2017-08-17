<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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
	<a href="./">ホーム</a>
	<a href="signup">ユーザー新規登録</a>
	<form method="POST" onClick="return check()" style="display: inline">
		<a href="logout" style="float:right;">ログアウト</a>
	</form>

	<c:if test="${ not empty errorMessages }">
			<div style="color:red" class="errorMessages">
				<ul>
					<c:forEach items="${errorMessages}" var="message">
						<li><c:out  value="${message}" />
					</c:forEach>
				</ul>
			</div>
		<c:remove var="errorMessages" scope="session" />
	</c:if>


	<h2>ユーザー管理</h2>
	<table border=1>
			<tr>
				<th>名前</th>
				<th>ログインID</th>
				<th>支店</th>
				<th>部署/役職</th>
				<th>編集</th>
				<th>復活/停止</th>
			</tr>

			<c:forEach items="${users}" var="user">
				<tr>
					<td  width="250"><c:if test="${user.isWorking == 0}"><div style="color:red;display:inline;">【停止中】</div></c:if><c:out value="${user.name }" /></td>

					<td><c:out value="${user.loginId }" /></td>

					<c:forEach items="${branches}" var="branch">
						<c:if test="${user.branchId == branch.id}">
							<td><c:out value="${branch.name }" /></td>
						</c:if>
					</c:forEach>

					<c:forEach items="${positions}" var="position">
						<c:if test="${user.positionId == position.id}">
							<td><c:out value="${position.name }" /></td>
						</c:if>
					</c:forEach>

					<td>
						<form action="setting" method="get">
							<button type="submit" name="id" value="${user.id}">編集</button>
						</form>
					</td>

					<td>
						<div align="center">
							<c:if test="${loginUser.id != user.id }" >
								<form  action="is_working" method="post" onClick="return stopped()" style="display: inline">
									<c:if test="${user.isWorking == 1 }">
										<button style="color:red" type="submit" name="isWorking" value="0">停止</button>
										<input type="hidden" name="id" value="${user.id}">
									</c:if>
								</form>
								<form  action="is_working" method="post" onClick="return working()" style="display: inline">
									<c:if test="${user.isWorking == 0 }">
										<button style="color:blue" type="submit" name="isWorking" value="1">復活</button>
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
	</table>
</body>
</html>