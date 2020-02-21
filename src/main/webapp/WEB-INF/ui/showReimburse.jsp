<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>报销列表查看页面</title>
<style type="text/css">
	.continer>.col-md-12{
		font-size: 12px;
	}
	#tbody{
		height: 300px;
	}
	#page>div>nav>ul{
		margin: 0;
	}
	th,td{
		text-align: center;
	}
</style>
</head>
<body>
	<div class="continer text-left">
		<div class="col-md-12" style="margin-top: 10px;">
		
			<c:if test="${user.positionId==1||user.positionId==0 }">
				<div class="col-md-2" style="padding: 3px">	
					<select id="option">
						<option value="2">个人报销</option>
						<option value="1">部门报销</option>
					</select>
				</div>	
			</c:if>
			
			<div class="col-md-3" style="padding: 0">
				<div class="col-md-6" style="padding: 3px"><label>报销单状态</label></div>
				<div class="col-md-6" style="padding: 3px">
					<select id="statusId">
						
						<c:if test="${user.positionId!=5 }">
							<option value="0">全部</option>
							<c:if test="${user.positionId!=3 }">
								<option value="1">新创建</option>
							</c:if>
							<option value="2">待审批</option>
							<option value="3">审批中</option>
							<option value="6">已打回</option>
						</c:if>
						<option value="4">已审批</option>
						<option value="5">已付款</option>
					</select>
				</div>
			</div>
			<div class="col-md-3" style="padding: 0">
				<div class="col-md-4" style="padding: 3px"><label>开始时间</label></div>
				<div class="col-md-8" style="padding: 0"><input type="date" id="startDate"/></div>
			</div>
			<div class="col-md-3" style="padding: 0">
				<div class="col-md-4" style="padding: 3px"><label>结束时间</label></div>
				<div class="col-md-8" style="padding: 0"><input type="date" id="endDate"/></div>
			</div>
			<div class="col-md-1" style="padding:0"><button id="quey">查询</button></div>
		</div>
		<div class="col-md-12" style="margin-bottom: 3px;height: 325px">
			<table class="table table-default " style="margin: 0;">
				<thead><tr>
					<th>序号</th>
					<th>填写日期</th>
					<th>填报人</th>
					<th>总金额</th>
					<th>状态</th>
					<th>待处理人</th>
					<th>操作</th>
				</tr></thead>
				<tbody id="tbody">
					
				</tbody>
			</table>
		</div>
		<div class="col-md-12" id="page">
			
		</div>
	</div>
</body>
<script type="text/javascript">
	var employeeName="${requestScope.user.employeeName }";	
	var path = "/JBOA/c/reimburse/api/"
	var pageInfo = null;
	var startDate = null;
	var endDate   = null;
	pageNum = 1;
	pageSize= 7;
	var option = 1;
	var statusId = 0;

	if($("option").val()==undefined){
		show({statusId:statusId,pageNum:pageNum,pageSize:pageSize});
	}else{
		option = $("option").val();
		show({statusId:statusId,pageNum:pageNum,pageSize:pageSize,option:option});
	}
	
	function show(data){
		
		$.post(path+"page",data,function(res){
			pageInfo = res;
			$(".info").remove();
			console.log(res);
			$.each(res.list,function(i,obj){
				
				var $tr = `<tr class="info">
								<td>`+((pageNum-1)*pageSize+i+1)+`</td>
								<td>`+obj.createTime+`</td>
								<td>`+obj.employeeName+`</td>
								<td>`+obj.totalCount+`</td>
								<td>`+obj.statusName+`</td>
								<td>`+obj.nextDealMan+`</td><td>`;
				if(obj.employeeId==employeeId&&(obj.statusName=="新创建"||obj.statusName=="已打回")){
					
					$tr+=`<a data-id="`+obj.reimburseId+`" style="background:url('/img_server/edit.gif') no-repeat;background-position: center;width: 20px;height: 20px;display: inline-block;" href="javascript:void(0);" onclick="update(this)"></a>
						  <a data-id="`+obj.reimburseId+`" style="background:url('/img_server/sub.gif') no-repeat;background-position: center;width: 20px;height: 20px;display: inline-block;" href="javascript:void(0);" onclick="sub(this)"></a>`;
					if(obj.statusName=="新创建"){
						$tr+=`<a data-id="`+obj.reimburseId+`" style="background:url('/img_server/delete.gif') no-repeat;background-position: center;width: 20px;height: 20px;display: inline-block;" href="javascript:void(0);" onclick="deletes(this)"></a>`;
					}
				}else{
					$tr+=`<a data-id="`+obj.reimburseId+`" style="background:url('/img_server/search.gif') no-repeat;background-position: center;width: 20px;height: 20px;display: inline-block;" href="javascript:void(0);" onclick="query(this)"></a>`;
					//alert(obj.nextDealMan);
					if(obj.nextDealMan==employeeName){
						$tr += `<a data-id="`+obj.reimburseId+`" style="background:url('/img_server/sub.gif') no-repeat;background-position: center;width: 20px;height: 20px;display: inline-block;" href="javascript:void(0);" onclick="check(this)"></a>`;
					}
				}
					$tr +=  `</td></tr>`;
					$("#tbody").append($tr);
			});
			$("#page").html(page(9));
		});
	}

	//翻页
	$(document).off("click",".curr").on("click",".curr",function(){
		if(pageNum==$(this).attr("data-id")){
			return;
		}
		pageNum = $(this).attr("data-id");
		show({statusId:statusId,option:option,pageNum:pageNum,pageSize:pageSize,startDate:startDate,endDate:endDate});
	});


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


	//个人部门下拉框切换
	$("#option").change(function(){
		$("#statusId").find("option[value='1']").remove();
		option = $(this).val();
		pageNum=1;
		if($(this).val()==1){
			
		}else{
			$("#statusId").append(`<option value="1">新创建</option>`);
		}
		show({statusId:statusId,option:option,pageNum:pageNum,pageSize:pageSize,startDate:startDate,endDate:endDate});
	});
	$("#statusId").change(function(){
		statusId = $(this).val();
		pageNum=1;
		show({statusId:statusId,option:option,pageNum:pageNum,pageSize:pageSize,startDate:startDate,endDate:endDate});
	});
	$("#quey").click(function(){
		pageNum=1;
		show({statusId:statusId,option:option,pageNum:pageNum,pageSize:pageSize,startDate:startDate,endDate:endDate});
	});

	//点击事件
	function query(e){
		$("#content").load("/JBOA/c/reimburse/queryApply?reimId="+$(e).attr("data-id"));
	}
	//修改
	function update(e){
		$("#content").load("/JBOA/c/reimburse/updateApply?reimId="+$(e).attr("data-id"));
	}
	//删除
	function deletes(e){
		if(confirm("确认删除？")){
			$.ajax("/JBOA/api/person/Reims/Reim/"+$(e).attr("data-id"), {
				type : "delete",
				dataType : "json",
				success : function(res) {
					alert("删除" + res);
					show({statusId:statusId,option:option,pageNum:pageNum,pageSize:pageSize,startDate:startDate,endDate:endDate});
				}
			});
		}
	}
	//审核
	function check(e){
		$("#content").load("../reimburse/checkApply?reimId="+$(e).attr("data-id"));
	}

	//提交
	function sub(e){
		if(confirm("确认提交？")){
			
			$.ajax("/JBOA/api/person/Reims/Riem/Sub/"+$(e).attr("data-id"), {
				type : "put",
				dataType : "json",
				success : function(res) {
					alert("提交" + res);
					show({statusId:statusId,option:option,pageNum:pageNum,pageSize:pageSize,startDate:startDate,endDate:endDate});
				}
			});
		}
	}
</script>
</html>