<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function check(){
	if(window.confirm('本当にログアウトしますか？')){ // 確認ダイアログを表示
		return true; // 「OK」時は送信を実行
	}
	else{ // 「キャンセル」時の処理
		window.alert('キャンセルされました'); // 警告ダイアログを表示
		return false; // 送信を中止
	}
}
function Delete(){
	if(window.confirm('本当に削除しますか？')){ // 確認ダイアログを表示
		return true; // 「OK」時は送信を実行
	}
	else{ // 「キャンセル」時の処理
		window.alert('キャンセルされました'); // 警告ダイアログを表示
		return false; // 送信を中止
	}
}
function disabledButton(btn){
	btn.disabled=true;
	btn.form.submit();
}
</script>
<title>ホーム</title>
</head>
<body>
	<div class="main-contents">

		<div class="header">
			<a href="message">新規投稿</a>
			<c:if test="${loginUser.positionId == 1 }">
				<a href="manage">ユーザー管理</a>
			</c:if>
			<form method="POST" onClick="return check()" style="display: inline">
				<a href="logout">ログアウト</a>
			</form>
		</div>

		<div class="profile">
			<div class="name">
				<c:out value="${loginUser.name }" />
				がログイン中です
			</div>
			<h2>わったい菜掲示板</h2>


		</div>
	</div>

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

	<form action="./" style="display: inline">
		カテゴリー指定
		<SELECT name="category">
			<option value="" selected>カテゴリーを選択</option>
			<c:forEach items="${categories}" var="category">
				<option  value="${category.category}"><c:out value="${category.category}"></c:out></option>
			</c:forEach>
		</SELECT>
		日付指定
		<input type="date" name="startDate" min="2017-08-01" max="${date }" /> －
		<input type="date" name="endDate" min="2017-08-01" max="${date }" />
		<button type="submit">絞込み</button>
	</form>
	<form action="./" style="display: inline"><button type="submit">全件表示</button></form><br />

	<c:forEach items="${categories}" var="category">
			<c:if test="${ selectCategory == category.category}"><c:out value="「${selectCategory }」で絞り込んだ結果"></c:out></c:if>
	</c:forEach>
	<c:if test="${ fn:length(messages) != 0 && fn:length(messages) != fn:length(allMessages)}"><c:out value=" ${ fn:length(messages)}件 の投稿が見つかりました" /></c:if>
	<c:if test="${ fn:length(messages) == 0 }">条件に当てはまる投稿が見つかりませんでした</c:if>

	<br />
	<br />
	<div class="messages">
		<c:forEach items="${messages}" var="message">
			<div class="message">
					【件名】：<span class="title"><c:out value="${message.title}" /></span><br />
					【カテゴリー】：<span class="category"><c:out value="${message.category}" /></span><br />
					【本文】<br />
					<span class="text">
					<c:forEach var="text" items="${fn:split(message.text, '
					')}" >
					<c:out value="${text}" /><br />
					</c:forEach>
					</span><br /><br />
					投稿者：<span class="name"><c:out value="${message.name}" /></span>

					<c:forEach items="${branches}" var="branch">
						<c:if test="${message.branchId == branch.id}">
							<c:out value="(${branch.name }" />
						</c:if>
					</c:forEach>

					<c:forEach items="${positions}" var="position">
						<c:if test="${message.positionId == position.id}">
							<c:out value="${position.name })" />
						</c:if>
					</c:forEach>

				<fmt:formatDate value="${message.insertDate}" pattern="yyyy/MM/dd HH:mm:ss" />
				<form action="messageDelete" onClick="return Delete()" style="display: inline" method="post">
					<c:choose>
						<c:when test="${ loginUser.positionId == 2 }">
							<button type="submit" name="messageId" value="${message.id}">投稿削除</button>
						</c:when>
						<c:when test="${ loginUser.branchId == message.branchId && loginUser.positionId == 3 }">
							<button type="submit" name="messageId" value="${message.id}">投稿削除</button>
						</c:when>
						<c:when test="${ loginUser.id == message.userId }">
							<button type="submit" name="messageId" value="${message.id}">投稿削除</button>
						</c:when>
					</c:choose>
				</form>
			</div>
			<br />


			<form action="comment" method="post">
				<textarea name="comment" rows="3" cols="100" class="tweet-box"></textarea>
				<br /> <input type="submit" value="コメント" onClick="disabledButton(this)">(500文字まで)<br />
				<input type="hidden" name="messageId" value='${message.id}'><br />
			</form>

			<c:forEach items="${comments}" var="comment">
				<c:if test="${ comment.messageId == message.id }">
					コメント<br>
					<c:forEach var="text" items="${fn:split(comment.text, '
					')}" >
					<c:out value="${text}" /><br />
					</c:forEach>
					投稿者：<c:out value="${comment.name}" />

					<c:forEach items="${branches}" var="branch">
						<c:if test="${comment.branchId == branch.id}">
							<c:out value="(${branch.name }" />
						</c:if>
					</c:forEach>

					<c:forEach items="${positions}" var="position">
						<c:if test="${comment.positionId == position.id}">
							<c:out value="${position.name })" />
						</c:if>
					</c:forEach>
					<fmt:formatDate value="${comment.insertDate}" pattern="yyyy/MM/dd HH:mm:ss" />

 					<form action="commentDelete" onClick="return Delete()" style="display: inline" method="post">
						<c:choose>
							<c:when test="${ loginUser.positionId == 2 }">
								<button type="submit" name="commentId" value="${comment.id}">コメント削除</button>
							</c:when>
							<c:when test="${ loginUser.branchId == comment.branchId && loginUser.positionId == 3 }">
								<button type="submit" name="commentId" value="${comment.id}">コメント削除</button>
							</c:when>
							<c:when test="${ loginUser.id == comment.userId }">
								<button type="submit" name="commentId" value="${comment.id}">コメント削除</button>
							</c:when>
						</c:choose>
					</form>
					<br />
				</c:if>
			</c:forEach>


			<br />
			<br />
			<br />
			<br />
		</c:forEach>
	</div>
</body>
</html>