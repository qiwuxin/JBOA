<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>审核报销单</title>
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
	height: 550px;
}
</style>
</head>
<body>
	<div class="continer text-left" id="reimburseId" data-id="${rvo.reimburseId }">
		<h4
			style="margin-top: 0px; font-weight: bold; line-height: 40px; padding-left: 30px;">
			报销管理——报销单审核 <span
				style="float: right;margin-right:10px;font-weight: bold; font-size: 10px">${rvo.createTime }</span>
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
							<td><img src="${reim.pictureName }" height="71px" /></td>
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
		<div class="col-md-12" style="height: 64px;margin-bottom: 0">
			<div class="col-md-12">
				<label class="col-md-2" style="line-height: 50px">审核批注：</label>
				<div class="col-md-10" style="padding-left: 10px">
					<textarea id="checkComment" style="width: 80%;height: 50px"></textarea>
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-12 text-center">
			<button onclick="review()" >返回</button>
			  <c:if test="${sessionScope.evo.positionId==0||sessionScope.evo.positionId==1||sessionScope.evo.positionId==3 }">
				<button class="check" data-id="1">同意</button>
				<button class="check" data-id="3">打回</button>
				<c:if test="${sessionScope.evo.positionId==0||sessionScope.evo.positionId==1}">
					<button class="check" data-id="2">拒绝</button>
				</c:if>
			  </c:if>
			  <c:if test="${sessionScope.evo.positionId==5}">
				<button class="check" data-id="1">付款</button>
			  </c:if>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$("#title").text("审核报销流程");	

	$("#reset").click(function(){
		$("#content").load("../leave/showLeave");
		$("#title").text("请假列表查看");
	});
	
	function review() {
		$("#content").load("../reimburse/applyList");
		$("#title").text("报销单列表查看");
	}
	$(document).off("click",".check").on("click",".check",function(){
		var $this = $(this);
		var checkInfo ={};
		 checkInfo["bizId"]       = $("#reimburseId").attr("data-id");
		 checkInfo["checkResult"] = $this.attr("data-id");
		 checkInfo["checkComment"]= $.trim($("#checkComment").val());
		 checkInfo["leaveId"]     = $("#reimburseId").attr("data-id");
		 checkInfo["typeId"]      = 2;
		 checkInfo["checkMan"]    = $("#employeeId").attr("data-id");
		$.ajax("/JBOA/api/person/checks/check",{
			type:"post",
			datatype:"json",
			contentType:"application/json;charset=UTF-8",
			data:JSON.stringify(checkInfo),
			success:function(res){
					alert(res+$this.text());
					$("#content").load("../reimburse/applyList");
					$("#title").text("报销单列表查看");
			}
		});
	});
</script>
</html>