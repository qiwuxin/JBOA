<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>请假页面</title>
<style type="text/css">
#submit, #reset {
	background: url('/img_server/submit.gif') no-repeat;
	background-size: 100% 100%;
	border: 0px;
	outline: none;
	height: 25px;
}

#leavediv .col-md-12 {
	margin-bottom: 10px;
}

label {
	font-weight: 400;
}
</style>
</head>
<body>
	<div class="continer text-left">
		<p
			style="font-weight: bold; height: 50px; line-height: 50px; padding-left: 30px">请假条——基本信息</p>
		<div class="col-md-12" id="leavediv">
			<div class="col-md-12">
				<div class="col-md-6">
					<label class="col-md-4">姓名：</label> <label class="col-md-8">${requestScope.user.employeeName }</label>
				</div>
				<div class="col-md-6">
					<label class="col-md-4">部门：</label> <label class="col-md-8">${requestScope.user.positionName }</label>
				</div>
			</div>
			<div class="col-md-12">
				<div class="col-md-6">
					<label class="col-md-4">开始时间：</label>
					<div class="col-md-8">
						<input type="date"  id="startDate" />
					</div>
				</div>
				<div class="col-md-6">
					<label class="col-md-4">结束时间：</label>
					<div class="col-md-8">
						<input type="date"  id="endDate"/>
					</div>
				</div>
			</div>
			<div class="col-md-12">
				<div class="col-md-6">
					<label class="col-md-4">请假天数：</label> <label class="col-md-8"
						 id="totalCount">1</label>
				</div>
			</div>
			<div class="col-md-12">
				<div class="col-md-2" style="padding-left: 30px; padding-right: 0;">
					<label>请假事由：</label>
				</div>
				<div class="col-md-10">
					<textarea style="height: 80px; width: 350px" id="event"></textarea>
				</div>
			</div>
			<div class="col-md-12">
				<div class="col-md-6">
					<button id="submit" class="col-md-5 col-md-offset-1">提交</button>
					
					<button id="reset" class="col-md-5 col-md-offset-1">返回</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		//判断开始时间是否填写正确
		$("#startDate").change(function() {
			var sDate = $(this).val();
			var eDate = $("#endDate").val();
			sDate = new Date(sDate.replace(/-/g, "/"));
			if (sDate < new Date()) {
				alert("请假日期不正确！");
				$(this).val("");
				return;
			}
			if (eDate != "") {
				eDate = new Date(eDate.replace(/-/g, "/"));
				var days = eDate.getTime() - sDate.getTime();
				var time = parseInt(days / (1000 * 60 * 60 * 24));
				if (time <= 0) {
					alert("请选择正确的日期");
					$(this).val("");
					return false;
				} else {
					$("#totalCount").text(time).val(time);
					$("[name='totalCount']").val(time);
				}
			}
		});
		//判断结束时间是否填写正确
		$("#endDate").change(function() {
			var sDate = $("#startDate").val();
			var eDate = $(this).val();
			if (sDate != "") {
				sDate = new Date(sDate.replace(/-/g, "/"));
				eDate = new Date(eDate.replace(/-/g, "/"));
				var days = eDate.getTime() - sDate.getTime();
				var time = parseInt(days / (1000 * 60 * 60 * 24));
				if (time <= 0) {
					alert("请选择正确的日期");
					$(this).val("");
					return false;
				} else {
					$("#totalCount").text(time);
					$("[name='totalCount']").val(time);
				}
			}
		});
	});

	//提交请假条
	$(document).on("click","#submit",function(){
		if($("#startDate").val()=="" || $("#endDate").val()==""){
			alert("时间不能为空！");
			return;
		}
		if($.trim($("#event").val())==""){
			alert("请假事由不能为空！");
			return;
		}
		var startDate = $("#startDate").val();
		var endDate   = $("#endDate").val();
		var event	  = $.trim($("#event").val());
		var totalCount= $.trim($("#totalCount").text());
		$.post("../leave/addLeave",{startTime:startDate,endTime:endDate,event:event,totalCount:totalCount},function(res){
			if(res=="ok"){
				alert("提交请假条成功！");
				$("#content").load("../leave/showLeave");
				$("#title").text("请假列表查看");
			}else{
				alert("提交请假条失败！");
			}		
		});
	});

	$("#reset").click(function(){
		$("#content").load("../leave/showLeave");
		$("#title").text("请假列表查看");
	});
	
</script>
</html>