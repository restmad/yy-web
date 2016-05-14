<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆</title>
<link rel="stylesheet" href="/system-web/css/bootstrap.min.css">
<link rel="stylesheet" href="/system-web/css/basepage.css">
<script src="/system-web/js/jquery-2.1.4.min.js"></script>
<script>
	$(document).ready(function() {
		$("#btnRegister").click(function(){
			window.location.href = "/system-web/register";
		})
		$("#btnLogin").click(function() {
			var username = $("#username").val();
			var password = $("#password").val();
			var chk = document.getElementById('rememberPas');
			var value = chk.checked;
			var obj = {
				"username" : username,
				"password" : password,
				"rememberPas" : value
			};
			$.ajax({
				type : "post",
				url : "/system-web/userInform/loginIn",
				data : JSON.stringify(obj),
				contentType : "application/json;charset=utf-8",
				dataType : "json",
				success : function(message) {
					window.location.href = "/system-web/index";
				}
			});
		});
	});
</script>
<style type="text/css">
body {
	background: url("/system-web/img/loginbg.jpg") no-repeat;
}

.wrap {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 300px;
	margin-top: -8%;
	margin-left: -150px;
	text-align: center;
}

.sub {
	padding: 10px;
	position: absolute;
	width: 100%;
}

.sign {
	width: 100%;
	height: 20%;
	text-align: center;
	font-size: 25px;
	color: #fff;
}

.form-control {
	margin-bottom: 10px;
}

.btn.btn-primary {
	background-color: #1abc9c
}
</style>
</head>
<body>
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="content">
		<div class="wrap">
			<div class="sign">欢迎登陆</div>
			<div class="sub">
				<input type="text" id="username" class="form-control"
					placeholder="username" autofocus> <input type="password"
					id="password" class="form-control" placeholder="password">
				<div class="checkbox">
					<a href="#" style="color: #fff; float: left">忘记密码</a> <label
						style="color: #fff; float: right"> <input type="checkbox"
						id="rememberPas"> 记住密码
					</label>
				</div>
				<button type="button" class=" btn btn-primary"
					style="margin-right: 8%; width: 45%;" id="btnRegister">注册</button>
				<button type="button" class=" btn btn-primary" style="width: 45%;"
					id="btnLogin">登陆</button>
			</div>
		</div>
	</div>
	<script src="/system-web/js/bootstrap.min.js"></script>
</body>
</html>