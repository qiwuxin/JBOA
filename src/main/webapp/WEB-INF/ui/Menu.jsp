<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/JBOA/css/bootstrap.min.css">
<script type="text/javascript" src="/JBOA/js/jquery-1.12.4.js"></script>

<style type="text/css">
header {
	background: url('/img_server/Top_bg.gif') repeat-x;
	height: 90px;
}

#left_top {
	background: url('/img_server/left_bg.gif') no-repeat;
	background-size: 300%;
	height: 20px;
}

#left_bottom {
	background: url('/img_server/left_bg.gif') no-repeat;
	background-size: 300%;
	height: 20px;
	background-position: right bottom;
}

#content {
	margin-bottom: 15px;
	background: white;
	height: 400px;
	box-shadow: inset 0px 0px 2px rgb(78, 147, 187);
	border-radius: 0 0 5px 5px;
}

#title {
	height: 30px;
	font-weight: bold;
	font-size: 20px;
	padding: 0;
	margin: 5px 0 0 0;
	line-height: 30px;
	padding-left: 30px;
	background: #9bd5ed;
	border-radius: 10px 10px 0 0;
	color: white;
}

#left_top+div>ul>li>dl>dt {
	cursor: pointer;
	padding-left: 30px;
}

#left_top+div>ul>li>dl>dd {
	cursor: pointer;
	padding-left: 20px;
	margin-left: 25px;
	display: none;
}

dl {
	margin-bottom: 10px;
}

/*----------用来移除上下箭头----------*/
input[type="date"]::-webkit-inner-spin-button {
	display: none;
}

/*----------用来移除叉叉按钮----------*/
input[type="date"]::-webkit-clear-button {
	display: none;
}
</style>
</head>
<body data-id="${requestScope.user.employeeId }" id="employeeId">
	<header>
		<img alt="????" src="/img_server/logo.gif" style="margin-top: 17px">
	</header>
	<div class="row" style="background: #e1eef3; margin-right: 0">
		<div class="col-md-4" style="margin: 10px 0">
			<span style="color: red; padding: 0 10px;">【登录角色：${requestScope.user.positionName }】</span><a
				href="javascript:cross()">退出登录</a>
		</div>
		<div class="col-md-8" style="margin: 10px 0">
			<span>欢迎您，<span style="color: red">${requestScope.user.employeeName }</span>！欢迎访问青鸟办公管理系统！
			</span>
		</div>
	</div>
	<article class="container-fluid "
		style="padding: 0; margin: 0; background: #4e93bb">
		<div class="col-md-3">
			<div id="left_top"></div>
			<div>
				<ul
					style="list-style: none; background: #ffffff; margin: 0px; padding: 1px; box-shadow: inset 0px 0px 2px #77abc8;">
					<li>
						<dl>
							<dt
								style="background: url('/img_server/ico.gif') no-repeat; background-position: 2px -22px;">报销单管理</dt>
							<c:if
								test="${requestScope.user.positionId==1 || requestScope.user.positionId==2 || requestScope.user.positionId==0}">
								<dd
									style="background: url('/img_server/ico.gif') no-repeat; background-position: 2px -50px;">添加报销单</dd>
							</c:if>
							<dd
								style="background: url('/img_server/ico.gif') no-repeat; background-position: 2px -50px;">查看报销单</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt
								style="background: url('/img_server/ico.gif') no-repeat; background-position: 2px -22px;">请假管理</dt>
							<c:if
								test="${requestScope.user.positionId!=0 || requestScope.user.positionId!=4}">
								<dd
									style="background: url('/img_server/ico.gif') no-repeat; background-position: 2px -50px;">添加请假</dd>
							</c:if>
							<dd
								style="background: url('/img_server/ico.gif') no-repeat; background-position: 2px -50px;">查看请假</dd>
						</dl>
					</li>
					<c:if
						test="${requestScope.user.positionName=='部门经理'|| requestScope.user.positionName=='总经理'}">
						<li>
							<dl>
								<dt
									style="background: url('/img_server/ico.gif') no-repeat; background-position: 2px -22px;">统计报表</dt>
								<dd
									style="background: url('/img_server/ico.gif') no-repeat; background-position: 2px -50px;">查看月度报销统计</dd>
								<dd
									style="background: url('/img_server/ico.gif') no-repeat; background-position: 2px -50px;">查看年度报销统计</dd>
							</dl>
						</li>
					</c:if>
					<li>
						<dl>
							<dt
								style="background: url('/img_server/ico.gif') no-repeat; background-position: 2px -22px;">信息中心</dt>
						</dl>
					</li>
				</ul>
			</div>
			<div id="left_bottom"></div>
		</div>
		<div class="col-md-9">
			<p id="title">主页</p>
			<div id="content">欢迎使用北大青鸟管理系统</div>
		</div>
	</article>
	<footer style="height: 50px; background: #4e93bb"> </footer>
</body>

<script type="text/javascript" src="/JBOA/js/page-0.1.3.js"></script>
<script type="text/javascript">
	var employeeId = $("#employeeId").attr("data-id");
	$("#left_top+div>ul>li>dl>dt").click(function() {
		if ($(this).attr("data-id") == 1) {
			$(this).parent().find("dd").hide();
			$(this).css("background-position", "2px -22px");
			$(this).attr("data-id", "0")
		} else {
			$(this).parent().find("dd").show();
			$(this).css("background-position", "2px 0px");
			$(this).attr("data-id", "1")
		}

	});
	$("#left_top+div>ul>li>dl>dd").click(function() {
		if ($(this).text() == "添加报销单") {
			$("#content").load("../reimburse/apply");
			$("#title").text("新增报销单");
		}
		if ($(this).text() == "添加请假") {
			$("#content").html("");
			$("#content").load("leave");
			$("#title").text("添加请假");
		}
		if ($(this).text() == "查看请假") {
			$("#content").load("../leave/showLeave");
			$("#title").text("请假列表查看");
		}
		if ($(this).text() == "查看报销单") {
			$("#content").load("../reimburse/applyList");
			$("#title").text("报销单列表查看");
		}
		if ($(this).text() == "查看年度报销统计") {
			$("#content").load("../person/count/AllYear");
		}
		if ($(this).text() == "查看月度报销统计") {
			$("#content").load("/JBOA/api/person/MonthCount");
		}
	});
	function cross() {
		if (confirm("是否退出登录？")) {
			location.href = "cross";
		}
	}
</script>
</html>