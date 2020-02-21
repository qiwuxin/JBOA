<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看报销单</title>
<style type="text/css">
.box {
	padding: 0;
}

button {
	background: url('/img_server/submit.gif') no-repeat;
	background-size: 100% 100%;
	border: 0px;
	outline: none;
	height: 25px;
	width: 80px;
}

th, td {
	text-align: center;
}

.table>thead>tr>th {
	vertical-align: bottom;
	border-bottom: 0px solid #ddd;
}

.col-md-12 {
	margin-bottom: 10px;
}

#content {
	height: 500px;
}
</style>
</head>
<body>
	<div class="continer text-left">
		<h4
			style="margin-top: 0px; font-weight: bold; line-height: 40px; padding-left: 30px;">
			报销管理——报销单查看 <span
				style="float: right; font-weight: bold; font-size: 10px">${rvo.createTime }</span>
		</h4>
		<div class="col-md-12">
			<div class="col-md-3 box">
				<label class="col-md-3 box">编号：</label><label class="col-md-6 box">${rvo.employeeId }</label>
			</div>
			<div class="col-md-3 box">
				<label class="col-md-3 box">姓名：</label><label class="col-md-6 box">${rvo.employeeName }</label>
			</div>
			<div class="col-md-3 box">
				<label class="col-md-3 box">部门：</label><label class="col-md-6 box">${rvo.departmentName }</label>
			</div>
			<div class="col-md-3 box">
				<label class="col-md-3 box">职位：</label><label class="col-md-6 box">${rvo.positionName }</label>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-6 box">
				<label class="col-md-3 box">总金额：</label> <label class="col-md-6 box"
					style="color: red">${rvo.totalCount }￥</label>
			</div>
			<div class="col-md-6 box">
				<label class="col-md-3 box">当前状态：</label> <label
					class="col-md-6 box" style="color: red; font-weight: bold;">${rvo.statusName }</label>
			</div>
		</div>
		<div class="col-md-12"
			style="border-top: 1px dashed; height: 150px; overflow-y: scroll;">
			<table class="table table-default">
				<thead>
					<tr>
						<th>消费说明</th>
						<th>消费金额</th>
						<th>消费凭据</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${rvo.reims }" var="reim">
						<tr>
							<td>${reim.desc }</td>
							<td>${reim.subTotal }</td>
							<td><img src="${reim.pictureName }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col-md-12"
			style="border-top: 1px dashed; height: 150px; overflow-y: scroll;">
			<table class="table table-default">
				<thead>
					<tr>
						<th>审核人</th>
						<th>审核批注</th>
						<th>审核时间</th>
						<th>审核结果</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${rvo.checks }" var="check">
						<tr>
							<td>${check.checkMan }</td>
							<td>${check.checkComment }</td>
							<td>${check.checkTime }</td>
							<td style="color: red">${check.checkResult }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="col-md-12">
			<div class="col-md-3 text-center">
				<button onclick="review()" >返回</button>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	function review() {
		$("#content").load("../reimburse/applyList");
		$("#title").text("报销单列表查看");
	}
</script>
</html>