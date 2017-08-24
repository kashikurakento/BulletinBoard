<%@page import="java.util.List"%>
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
function checkdiv( obj,id ) {
if( obj.checked ){
document.getElementById(id).style.display = "block";
}
else {
document.getElementById(id).style.display = "none";
}
}

</script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script>
$(function(){
	$("#body").fadeOut(800);
})
</script>
<title>ホーム</title>
</head>
<body >
	<div class="link">
		<a href="message" class="messageLink">新規投稿</a>
		<c:if test="${loginUser.positionId == 1 }">
				<a href="manage" class="manageLink" >ユーザー管理</a>
		</c:if>
		<form method="POST" onClick="return check()" style="display: inline">
			<a href="logout" style="float:right;" class="logoutLink">ログアウト</a>
		</form>
	</div>

	<div class="header">　社内掲示板　</div>
	<div class="Heading">

		<p class="profile">
			<c:out value="${loginUser.name }さんがログイン中です" />
		</p>
		<c:if test="${ not empty errorMessages }">

			<div style="color:red" class="errorMessages">
				<ul>
					<c:forEach items="${errorMessages}" var="message">
						<c:out  value="${message}" /><br />
					</c:forEach>
				</ul>
			</div>
			<c:remove var="errorMessages" scope="session" />
		</c:if><br />
		<div >
		<p>


		<form action="./" style="display: inline" name="search">
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
			<br /><br />
			日付指定
			<input type="date" name="startDate"  max="${date }" value="${startDate }" class="date"/> から
			<input type="date" name="endDate"  max="${date }" value="${endDate }" class="date"/>まで
			<br /><br />
			<a class="button" href="javascript:document.search.submit()">絞込む</a>
		</form>
		<form action="./" style="display: inline" name="allSearch">
			<a class="button" href="javascript:document.allSearch.submit()">全件表示</a>
		</form><br />


		<div class="search">
		<c:if test="${ selectStart != null || selectEnd != null || selectCategory != null}">
		<p class="searchCondition">
		<c:forEach items="${categories}" var="category">
			<c:if test="${ selectCategory == category.category}">&nbsp;&nbsp;<c:out value="　カテゴリー：${selectCategory }"></c:out><br /></c:if>
		</c:forEach>
		<c:if test="${ selectStart != null || selectEnd != null}">&nbsp;&nbsp;　日付：</c:if>
		<c:if test="${ selectStart != null}"><c:out value="${selectStart }から"></c:out></c:if>
		<c:if test="${ selectEnd != null}"><c:out value="${selectEnd }まで"></c:out></c:if>
		<c:if test="${ selectStart != null || selectEnd != null}"></c:if>
		</p>この条件で絞り込んだ結果</c:if>


		<c:if test="${ fn:length(messages) != 0 && fn:length(messages) != fn:length(allMessages)}"><c:out value=" 全件中 ${ fn:length(messages)}件 の投稿が見つかりました" /></c:if>
		<c:if test="${ fn:length(messages) == fn:length(allMessages)}">
		<c:if test="${ selectStart != null || selectEnd != null || selectCategory != null}"><c:out value="全件 の投稿が見つかりました" /></c:if>
		</c:if>
		<c:if test="${ fn:length(messages) == 0 }">条件に当てはまる投稿が見つかりませんでした</c:if>
		<br /><br />
		</div>


		</div>
	</div>
	<div  class="main">

		<c:forEach items="${messages}" var="message">
			<div class="message" >
				<br />
				<p class="time" style="display:inline;"><fmt:formatDate value="${message.insertDate}" pattern="yyyy/MM/dd HH:mm:ss" /></p>
				<div class="title" >
    				<p class="box-title">件名</p>
  					<p><c:out value="　${message.title}　" /></p>
				</div>
				<c:if test="${fn:length(message.title) > 13}"><br><br></c:if>
				<div class="category" >
    				<p class="box-title" >カテゴリー</p>
  					<p>&nbsp;<c:out value="　　${message.category}　　" />&nbsp;</p>
				</div>
					<div class="messageText">
						<p>
							<c:forEach var="text" items="${fn:split(message.text, '
							')}" >
								<c:out  value="${text}" /><br />
							</c:forEach>
						</p>
					</div>



				<p class="contributor">
					投稿者：<span class="name"><c:out value="${message.name}" /></span>
				</p><br/>

				<form action="messageDelete" onClick="return Delete()" style="display: inline" method="post" class="delete" name="delete">
					<c:choose>
						<c:when test="${ loginUser.positionId == 2 }">
							<button type="submit" name="messageId" value="${message.id}" class="deleteButton">投稿削除</button>
							<input type="hidden" name="messageId" value="${message.id}">
						</c:when>
						<c:when test="${ loginUser.branchId == message.branchId && loginUser.positionId == 3 }">
							<button type="submit" name="messageId" value="${message.id}" class="deleteButton">投稿削除</button>
							<input type="hidden" name="messageId" value="${message.id}">
						</c:when>
						<c:when test="${ loginUser.id == message.userId }">
							<button type="submit" name="messageId" value="${message.id}" class="deleteButton">投稿削除</button>
							<input type="hidden" name="messageId" value="${message.id}">
						</c:when>
					</c:choose>
				</form>


			<br />
			<br />
			<br />
			<form method="POST" action="comment" name="comment" onSubmit="return checkk()" class="commentArea">
				<textarea name="comment" style="width:80%;height:90px;resize:none" maxlength='500' onkeyup="CountDownLength( 'cdlength' , value , 500 );" ></textarea><br />
				<input type="submit" value="コメント" onClick="disabledButton(this)" class="commentButton">
				<div id="cdlength" style="display: inline" >残り500文字</div><br /><br />
				<input type="hidden" name="messageId" value='${message.id}'>
			</form>


			<c:forEach items="${comments}" var="comment">
				<c:if test="${ comment.messageId == message.id }">
					<div class="comment">
					<div  class="commentText">
						<p>
						<c:forEach var="text" items="${fn:split(comment.text, '
						')}" >
							<c:out value="${text}" /><br />
						</c:forEach>
						</p>

					</div>
					<p class="commentName">
					投稿者：<c:out value="${comment.name}　" />
					<fmt:formatDate value="${comment.insertDate}" pattern="yyyy/MM/dd HH:mm:ss" />
					</p><br />
					<form action="commentDelete" onClick="return Delete()" style="display: inline" method="post" class="delete">
						<c:choose>
							<c:when test="${ loginUser.positionId == 2 }">
							<button type="submit" name="commentId" value="${comment.id}" class="deleteButton">コメント削除</button>
								<input type="hidden" name="messageId" value="${message.id}">
							</c:when>
							<c:when test="${ loginUser.branchId == comment.branchId && loginUser.positionId == 3 }">
								<button type="submit" name="commentId" value="${comment.id}" class="deleteButton">コメント削除</button>
								<input type="hidden" name="messageId" value="${message.id}">
							</c:when>
							<c:when test="${ loginUser.id == comment.userId }">
								<button type="submit" name="commentId" value="${comment.id}" class="deleteButton">コメント削除</button>
								<input type="hidden" name="messageId" value="${message.id}">
							</c:when>
						</c:choose>
					</form>
					<br />
					<br />
					</div>
				</c:if>
			</c:forEach>



			</div>
		</c:forEach>
		</div>
</body>
</html>