<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>请假列表</title>
<style type="text/css">
#content{
	height: 415px;
}
input[type='submit'] {
	background: url('/img_server/submit.gif') no-repeat;
	background-size: 100% 100%;
	border: 0px;
	outline: none;
	height: 25px;
	width: 80%;
}

label {
	font-weight: 500;
	line-height: 25px;
}
#leaveList{
	height: 305px;
}
#leaveTable th,td{
	text-align: center;
	font-size: 11px;
	
}
td{
	
}
</style>
</head>
<body>
	<div class="continer">
		<div class="col-md-12 text-left" style="margin: 10px 0;">
			<form action="javascript:void(0)" id="leavefrom">
				<div class="col-md-2">
					<select id="option">
						<c:if test="${sessionScope.evo.positionId!=0 }">
							<option value="1">个人请假</option>
						</c:if>
						<c:if test="${sessionScope.evo.positionId==0|| sessionScope.evo.positionId==1}">
							<option value="2">批假请求</option>
						</c:if>
						<c:if test="${sessionScope.evo.positionId==4 }">
							<option value="3">入档批假</option>
						</c:if>
					</select>
				</div>
				<div class="col-md-4">
					<label style="padding: 0" class="col-md-5">开始时间：</label>
					<div style="padding: 0" class="col-md-7">
						<input type="date" name="startDate" id="startDate">
					</div>
				</div>
				<div class="col-md-4">
					<label style="padding: 0" class="col-md-5">结束时间：</label>
					<div style="padding: 0" class="col-md-7">
						<input type="date" name="endDate" id="endDate">
					</div>
				</div>
				<div style="padding: 0" class="col-md-2">
					<input type="submit" value="查询" style="width: 100px"/>
				</div>
			</form>
		</div>
		<div class="col-md-12" id="leaveList" >
			<table class="table table-default" id="leaveTable">
				<tr>
					<th>编号</th>
					<th>名称</th>
					<th>发起时间</th>
					<th>审批时间</th>
					<th>审批意见</th>
					<th>待处理人</th>
					<th>审批状态</th>
					<th>操作</th>
				</tr>
			</table>
		</div>
		<div class="col-md-12" id="page">
		
		</div>
	</div>
</body>
<script type="text/javascript">
    var employeeId = $("#employeeId").attr("data-id");
	var startDate = null;
	var endDate   = null;
	var option    = 1;
	pageNum   = 1;
	pageSize  = 7;
	var path = "../leave/leaveList";
	show({option:option,pageNum:pageNum,pageSize:pageSize})
	$("#startDate").change(function(){
		 startDate = $(this).val();
		 endDate = $("#endDate").val();
		startDate = new Date(startDate.replace(/-/g, "/"));
		endDate   = new Date(endDate.replace(/-/g, "/"));
		if (startDate > new Date()||startDate>endDate) {
			alert("请假日期不正确！");
			$(this).val("");
			startDate = null;
			return;
		}
	});
	$("#endDate").change(function(){
		 endDate = $(this).val();
		 startDate= $("#startDate").val();
		if(endDate<startDate){
			alert("日期选择错误");
			$(this).val("");
			endDate   = null;
			return false;
		}
	});
	//按下拉列表选择
	$("#option").change(function(){
		option = $("#option").val();
		show({option:option,pageNum:pageNum,pageSize:pageSize,startDate:startDate,endDate:endDate});
	});

	//按日期查询
	$("#leavefrom").submit(function(){
		startDate = $("#startDate").val();
		endDate   = $("#endDate").val();
		show({option:option,pageNum:pageNum,pageSize:pageSize,startDate:startDate,endDate:endDate});
	});

	function show(data){
		$.post(path,data,function(res){
			$(".info").remove();
			pageInfo = res;
			$.each(res.list,function(i,obj){
				var $tr = `<tr class="info">
							<td>`+((pageNum-1)*pageSize+i+1)+`</td>
							<td>`+(obj.createName+"请假"+obj.totalCount+"天")+`</td>
							<td>`+obj.createTime+`</td>`;
							if(obj.checks.length<1){
								$tr+=`<th>无</td>
								<td>无</td>`;
							}else{
								$tr+=`<td>`+obj.checks[0].checkTime+`</td>
									 <td>`+obj.checks[0].checkResult+`</td>`;
							}
				$tr+=`<td>`+obj.nextDealName+`</td>
					  <td>`+obj.statusName+`</td>
					  <td>`;
					if(obj.statusName=="已打回"){
						$tr+=`<a data-id="`+obj.leaveId+`" style="background:url('/img_server/edit.gif') no-repeat;background-position: center;width: 20px;height: 20px;display: inline-block;" href="javascript:void(0);" onclick="update(this)"></a>
							  <a data-id="`+obj.leaveId+`" style="background:url('/img_server/sub.gif') no-repeat;background-position: center;width: 20px;height: 20px;display: inline-block;" href="javascript:void(0);" onclick="sub(this)"></a>`;
					}else{
						$tr+=`<a data-id="`+obj.leaveId+`" style="background:url('/img_server/search.gif') no-repeat;background-position: center;width: 20px;height: 20px;display: inline-block;" href="javascript:void(0);" onclick="query(this)"></a>`;
						if(obj.nextDealMan==employeeId){
							$tr += `<a data-id="`+obj.leaveId+`" style="background:url('/img_server/sub.gif') no-repeat;background-position: center;width: 20px;height: 20px;display: inline-block;" href="javascript:void(0);" onclick="check(this)"></a>`;
						}
					}
				
				$tr +=`</td></tr>`;
				$("#leaveTable").append($tr);
			});
			if($(".info").length<1){
				$("#leaveTable").append(`<tr><td style="line-height:250px;text-align: center" colspan="8">暂时没有请假记录！<td><tr>`);
				return;
			}
			$("#page").html(page(5));
		},"json");
	}

	//翻页
	$(document).on("click",".curr",function(){
		pageNum = $(this).attr("data-id");
		if(pageNum==pageInfo.pageNum){
			return;
		}
		show({option:option,pageNum:pageNum,pageSize:pageSize,startDate:startDate,endDate:endDate});
	});

	//请假详情页面
	function query(e){
		var leaveId = $(e).attr("data-id");
		$("#content").load("../leave/queryLeave?leaveId="+leaveId);
		
	}
	//提交请假条
	/* function sub(e){
		var leaveId = $(e).attr("data-id");
		$.post("../leave/")
	} */

	//审核请假条
	function check(e){
		var leaveId = $(e).attr("data-id");
		$("#content").load("../leave/queryCheckLeave?leaveId="+leaveId);
	}
</script>
</html>