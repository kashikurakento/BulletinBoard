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
<link href="css/homeStyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function check(){
	if(window.confirm('本当にログアウトしますか？')){ // 確認ダイアログを表示
		return true; // 「OK」時は送信を実行
	}
	else{ // 「キャンセル」時の処理
		return false; // 送信を中止
	}
}
function Delete(){
	if(window.confirm('本当に削除しますか？')){ // 確認ダイアログを表示
		return true; // 「OK」時は送信を実行
	}
	else{ // 「キャンセル」時の処理
		return false; // 送信を中止
	}
}
function disabledButton(btn){
	btn.disabled=true;
	btn.form.submit();
}
function CountDownLength( idn, str, mnum ) {
	   document.getElementById(idn).innerHTML = "残り" + (mnum - str.length) + "文字";
	}
</script>
<title>ホーム</title>
</head>
<body>
	<div class="link">
		<a href="message">新規投稿</a>
		<c:if test="${loginUser.positionId == 1 }">
				<a href="manage">ユーザー管理</a>
		</c:if>
		<form method="POST" onClick="return check()" style="display: inline">
			<a href="logout" style="float:right;">ログアウト</a>
		</form>
	</div>
	<div class="Heading">
		<p class="profile">
			<c:out value="${loginUser.name }がログイン中です" />
		</p>
		<c:if test="${ not empty errorMessages }">
		<p>
			<div style="color:red" class="errorMessages">
				<ul>
					<c:forEach items="${errorMessages}" var="message">
						<c:out  value="${message}" /><br />
					</c:forEach>
				</ul>
			</div>
			<c:remove var="errorMessages" scope="session" />
		</c:if>
		<div >
		<h2>社内BBS</h2>

		<form action="./" style="display: inline">
			カテゴリー指定
			<SELECT name="category" >
				<option value="" selected>カテゴリーを選択</option>
				<c:forEach items="${categories}" var="category">
					<c:if test="${ selectCategory == category.category}">
						<option  value="${category.category}" selected><c:out value="${category.category}"></c:out></option>
					</c:if>
					<c:if test="${ selectCategory != category.category}">
						<option  value="${category.category}"><c:out value="${category.category}"></c:out></option>
					</c:if>
				</c:forEach>
			</SELECT>
			日付指定
			<input type="date" name="startDate" min="2017-08-01" max="${date }" value="${startDate }" /> から
			<input type="date" name="endDate" min="2017-08-01" max="${date }" value="${endDate }" />まで
			<button type="submit">絞込み</button>
		</form>
		<form action="./" style="display: inline"><button type="submit">全件表示</button></form><br />




		<p class="search">
		<c:forEach items="${categories}" var="category">
			<c:if test="${ selectCategory == category.category}"><c:out value="カテゴリー「${selectCategory }」"></c:out></c:if>
		</c:forEach>
		<c:if test="${ selectStart != null && selectEnd != null && selectCategory != null}"><br /></c:if>
		<c:if test="${ selectStart != null || selectEnd != null}">日付「</c:if>
		<c:if test="${ selectStart != null}"><c:out value="${selectStart }から"></c:out></c:if>
		<c:if test="${ selectEnd != null}"><c:out value="${selectEnd }まで"></c:out></c:if>
		<c:if test="${ selectStart != null || selectEnd != null}">」</c:if>

		<c:if test="${ selectStart != null || selectEnd != null || selectCategory != null}">の条件で絞り込んだ結果</c:if>


		<c:if test="${ fn:length(messages) != 0 && fn:length(messages) != fn:length(allMessages)}"><c:out value=" 全件中 ${ fn:length(messages)}件 の投稿が見つかりました" /></c:if>
		<c:if test="${ fn:length(messages) == fn:length(allMessages)}">
		<c:if test="${ selectStart != null || selectEnd != null || selectCategory != null}"><c:out value="全件 の投稿が見つかりました" /></c:if>
		</c:if>
		<c:if test="${ fn:length(messages) == 0 }">条件に当てはまる投稿が見つかりませんでした</c:if>
		<br /><br />
		</p>


		</div>
	</div>
	<div  class="main">



	<br />
	<br />
	<div class="messages">
		<c:forEach items="${messages}" var="message">
			<div class="message" >
					件名：<span class="title"><c:out value="${message.title}　　" /></span>
					カテゴリー：<span class="category"><c:out value="${message.category}" /></span><br /><br>
					本文<br />
					<div style="width:80%;word-wrap: break-word;">
						<p>
							<c:forEach var="text" items="${fn:split(message.text, '
							')}" >
								<c:out  value="${text}" /><br />
							</c:forEach>
						</p>
					</div>
				<p class="contributor">
					投稿者：<span class="name"><c:out value="${message.name}　" /></span>
				<fmt:formatDate value="${message.insertDate}" pattern="yyyy/MM/dd HH:mm:ss" />
				</p><br />

				<form action="messageDelete" onClick="return Delete()" style="display: inline" method="post" class="delet">
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

			<br />






			<form method="POST" action="comment" name="comment" onSubmit="return checkk()">
				<textarea name="comment" style="width:80%;height:90px;resize:none" maxlength='500' onkeyup="CountDownLength( 'cdlength' , value , 500 );" ></textarea><br />
				<input type="submit" value="コメント" onClick="disabledButton(this)" >
				<div id="cdlength" style="display: inline" >残り500文字</div><br />
				<input type="hidden" name="messageId" value='${message.id}'><br />
			</form>

			</div>







			<c:forEach items="${comments}" var="comment">
				<c:if test="${ comment.messageId == message.id }">
					<br />コメント<br>
					<div >
						<p>
							<c:forEach var="text" items="${fn:split(comment.text, '
							')}" >
								<c:out value="${text}" /><br />
							</c:forEach>
						</p>
					</div>
					投稿者：<c:out value="${comment.name}　" />

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
	</div>
</body>
</html>