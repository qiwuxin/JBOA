<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看请假详情页面</title>
<style type="text/css">
label {
	font-weight: 500;
}
#reset{
	background: url('/img_server/submit.gif') no-repeat;
	background-size: 100% 100%;
	border: 0px;
	outline: none;
	height: 25px;
}
th,td{
	border: 0px;
	text-align: center;
}
.col-md-12{
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<div class="continer">
		<h4 style="margin-top:0px;font-weight: bold;line-height: 40px;padding-left: 30px;">请假管理——请假详情信息</h4>
		<div class="col-md-12">
			<div class="col-md-6">
				<label class="col-md-4">姓名：</label>
				<label class="col-md-8">${lvo.createName }</label>
			</div>
			<div class="col-md-6">
				<label class="col-md-4">部门：</label>
				<label class="col-md-8">${lvo.departmentName }</label>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-6">
				<label class="col-md-4">开始时间：</label>
				<label class="col-md-8">${lvo.startTime }</label>
			</div>
			<div class="col-md-6">
				<label class="col-md-4">开始时间：</label>
				<label class="col-md-8">${lvo.endTime }</label>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-6">
				<label class="col-md-4">请假天数：</label>
				<label class="col-md-8">${lvo.totalCount }</label>
			</div>
			<div class="col-md-6">
				<label class="col-md-4">审批状态：</label>
				<label class="col-md-8" style="color:red">${lvo.statusName }</label>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-12">
				<label class="col-md-2">请假事由：</label>
				<label class="col-md-10" style="padding-left: 10px">${lvo.event }</label>
			</div>
		</div>
		<div class="col-md-12" style="border-top: 1px dashed;height: 164px;">
		   <table class="table table-default">
		   	<tr>
		   		<th>审批人</th>
		   		<th>审批时间</th>
		   		<th>审批意见</th>
		   		<th>审批结果</th>
		   	</tr>
			<c:forEach items="${lvo.checks }" var="check">
				<tr>
					<td>${check.checkMan }</td>
					<td>${check.checkTime }</td>
					<td>${check.checkComment }</td>
					<td style="color:red;font-weight: 800">${check.checkResult }</td>
				</tr>
			</c:forEach>
			</table>
		</div>
		<div class="col-md-12"> 
			<button id="reset" class="col-md-2 col-md-offset-1">返回</button>
		</div>
	</div>
</body>
<script type="text/javascript">
$("#title").text("请假详情查看");

$("#reset").click(function(){
	$("#content").load("../leave/showLeave");
	$("#title").text("请假列表查看");
});
</script>
</html>