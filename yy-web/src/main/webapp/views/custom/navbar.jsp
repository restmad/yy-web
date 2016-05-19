<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand">冰胡子资讯</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav" id="header">
				<li><a href="${pageContext.request.contextPath}/index/${username}">资讯<span class="sr-only">(current)</span></a></li>
				<li><a href="${pageContext.request.contextPath}/news">投稿</a></li>
				<li class="dropdown"><a href="${pageContext.request.contextPath}/news" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">融资<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="hidden-sm hidden-md"><a href="${pageContext.request.contextPath}/finance">我是投资人</a></li>
						<li role="separator" class="divider"></li>
						<li><a href="${pageContext.request.contextPath}/finance">寻求投资</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">招聘<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="hidden-sm hidden-md"><a href="${pageContext.request.contextPath}/job">寻求职位</a></li>
						<li role="separator" class="divider"></li>
						<li><a href="#">发布职位</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">活动<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="hidden-sm hidden-md"><a href="${pageContext.request.contextPath}/activity">活动回顾</a></li>
						<li role="separator" class="divider"></li>
						<li><a href="${pageContext.request.contextPath}/activity">参加活动</a></li>
						<li role="separator" class="divider"></li>
						<li><a href="${pageContext.request.contextPath}/activity">举办活动</a></li>
					</ul></li>
			</ul>
			<c:choose>
				<c:when test="${isLogin == null}">
				<ul class="nav navbar-nav navbar-right hidden-sm">
					<li><a href="${pageContext.request.contextPath}/loginView">登陆/注册</a></li>
				</ul>
				</c:when>
   			    <c:when test="${isLogin==false}">
				<ul class="nav navbar-nav navbar-right hidden-sm">
					<li><a href="${pageContext.request.contextPath}/loginView">登陆/注册</a></li>
				</ul>
				</c:when>
				<c:when test="${isAive==false}">
					<script type="text/javascript">
						alert("登陆失效，请重新登陆！");
					</script>
				</c:when>
				<c:otherwise>
				<script type="text/javascript">
				<!-- 用户登陆后的处理-->
				$(function(){
					$(document).click(function(){
						$.get("${pageContext.request.contextPath}/common/event", function(result){});
					})
				})
				</script>
				<ul class="nav navbar-nav navbar-right hidden-sm">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						style="padding-top: 8px; padding-bottom: 8px"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"><img src=${imgSrc} 
							class="img-circle" width="34x" height="34px" id="userOnlineImg"></a>
						<ul class="dropdown-menu">
							<li class="hidden-sm hidden-md"><a href='${pageContext.request.contextPath}/account/base/${username}/${token}' data-click="info">基本信息</a></li>
							<li role="separator" class="divider"></li>
							<li><a href='${pageContext.request.contextPath}/account/resume/${username}/${token}' data-click="resume" class="req">我的简历</a></li>
							<li role="separator" class="divider" ></li>
							<li><a href='${pageContext.request.contextPath}/account/article/${username}/${token}' data-click="article" class="req">我的文章</a></li>
							<li role="separator" class="divider"></li>
							<li><a href='${pageContext.request.contextPath}/account/company/${username}/${token}' data-click="company" class="req">关注的公司</a></li>
							<li role="separator" class="divider"></li>
							<li><a href='${pageContext.request.contextPath}/account/collects/${username}/${token}' data-click="collects" class="req">收藏的文章</a></li>
							<li role="separator" class="divider"></li>
							<li><a href='' data-click="loginout" id="req">退出</a></li>
							<script>
							$(document).ready(function() {
								$("#req").click(function() {
									$.ajax({
										type : "post",
										url : "${pageContext.request.contextPath}/loginOut/${username}",
										data : json,
										dataType : "json",
										success : function(message) {
											window.location.href="${pageContext.request.contextPath}/index";
										}
									});
								});
							});
							</script>
						</ul></li>
				</ul>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
</nav>