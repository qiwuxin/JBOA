<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改报销单</title>
<style type="text/css">
.box {
	padding: 0;
}
#content {
	height: 650px;
}
#moneySum {
	color: red;
}


.img {
	width: 80px;
}

button {
	background: url('/img_server/submit.gif') no-repeat;
	background-size: 100% 100%;
	border: 0px;
	outline: none;
	height: 25px;
	width: 80px;
}
.table>tbody>tr>td {
	height: 50px;
	padding: 0px;
}
td,th{
	text-align: center;
}
input[name='imgfile']{
	opacity: 0;
}
.table>tbody>tr>td>input,.table>tbody>tr>td>div>input {
	margin-top: 10px;
}
.imgfilediv{
	height: 50px;
	background: url('/img_server/add.gif') no-repeat;
	background-size: 20% 80%;
	background-position: center;
}
.table>tbody>tr>td {
	height: 50px;
	padding: 0px;
}
.add {
	background: url('/img_server/add.gif') no-repeat;
	background-size: 100% 100%;
	background-position: center;
	width: 50px;
	height: 50px;
	border: 0px;
	outline: none;
}

.remove {
	background: url('/img_server/shanc.png') no-repeat;
	background-size: 100% 100%;
	background-position: center;
	margin-top:5px;
	width: 40px;
	height: 40px;
	border: 0px;
	outline: none;
}
.btn {
	background: url('/img_server/submit.gif') no-repeat;
	background-size: 100% 100%;
	border: 0px;
	outline: none;
	height: 25px;
	width: 80px;
	line-height: 5px;
	margin-left: 100px;
	color: white;
	font-weight: 900;
}
.col-md-12 {
	margin-bottom: 10px;
}

.file {
	width: 150px;
}

.preview {
	display: inline-block;
	width: 150px;
	position: relative;
	background-image: url(images/abcc.png);
	background-repeat: no-repeat;
	background-size: cover;
}
</style>
</head>
<body>
	<div class="continer text-left" id="reimburseId" data-id="${rvo.reimburseId }">
		<h4 style="font-weight: bold; line-height: 40px; padding-left: 30px;">
			报销管理——修改报销单<span
				style="float: right;margin-right:10px ;font-weight: bold; font-size: 10px" id="departmentId" data-id="${rvo.departmentId }">${rvo.createTime }</span>
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
		<div class="col-md-12" id="nextDealMan" data-id="${sessionScope.evo.pid }">
			<div class="col-md-6 box">
				<label class="col-md-3">总金额：</label> <label class="col-md-4"><span
					id="moneySum">${rvo.totalCount }</span>￥</label>
			</div>
		</div>
		<div class="col-md-12" style="border-top: 1px dashed; height: 300px;overflow-y: scroll;">
			<table class="table table-default">
				<tr>
					<th>费用说明</th>
					<th>费用金额</th>
					<th>单据凭证</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${rvo.reims }" var="reim">
					<tr>
						<td><input type="text" name="desc" value="${reim.desc }" /></td>
						<td><input type="text" name="subTotal" value="${reim.subTotal }" /></td>
						<td><div class="imgfilediv"
						style="background : url('${reim.pictureName}') no-repeat;
						background-size : auto 100%;
						background-position : center">
								<input type="file" class="file" name="imgfile" data-id="${reim.pictureName}" />
							</div></td>
						<td><button class="remove"></button></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
		<div class="col-md-12">
			<span class="col-md-1"
				style="padding: 0; height: 150px; line-height: 150px">事由：</span>
			<div class="col-md-11">
				<textarea class="col-md-12" style="height: 150px;" id="event">${rvo.event }</textarea>
			</div>
		</div>
		<div class="col-md-12">
			<button class="btn" id="review">返回</button>
			<button class="btn" id="save">保存</button>
			<button class="btn" id="submit">提交</button>
		</div>
	</div>
</body>
<script type="text/javascript">
	$("tr:last").find("td").eq(3).find("button").addClass("add").removeClass(
			"remove");
	//新增消费报销记录
	$(document).on("click", ".add", function() {
		var $this = $(this).parent().parent().clone(true);
		$this.find("td").find("button").addClass("remove").removeClass("add");
		$(this).parent().parent().find("td").find("input").val("");
		$(this).parent().parent().before($this);
	});
	//删除消费报销记录
	$(document).off("click", ".remove").on("click", ".remove", function() {
		$(this).parent().parent().remove();
	});
	//返回
	$(document).off("click", "#review").on("click", "#review", function() {
		$("#content").load("../reimburse/applyList");
		$("#title").text("报销单列表查看");
	});
	
	//保存
	$(document).off("click", "#save").on("click", "#save", function() {
		var reim = {};
		json(reim);
		reim["statusId"] = 1;
		$.ajax("/JBOA/api/person/Reims/Reim", {
			type : "put",
			dataType : "json",
			contentType : "application/json;charset=UTF-8",//非常重要
			data : JSON.stringify(reim),
			success : function(res) {
				alert("保存" + res);
			}
		});
	});

	//提交
	$(document).off("click", "#submit").on("click", "#submit", function() {
		var reim = {};
		json(reim);
		reim["statusId"] = 2;
		$.ajax("/JBOA/api/person/Reims/Reim", {
			type : "put",
			dataType : "json",
			contentType : "application/json;charset=UTF-8",//非常重要
			data : JSON.stringify(reim),
			success : function(res) {
				alert("提交" + res);
			}
		});
	});
	
	var $this = null;
	$(document).off("change", "input[type='file']").on("change",
			"input[type='file']", function() {
				$this = $(this);
				var fr = new FileReader();//读取文件
				var file = this.files[0];//选择第一个文件
				var _temp = file.name.match(/\.jpg|\.png|\.gif|\.bmp/i);
				if (!_temp) {
					this.value = "";
					alert("目前只支持jpg,png,bmp,gif格式图片文件");
					return false;
				} else if (file.size > (1024 * 1024)) {
					this.value = "";
					alert("目前只支持小于1M大小图片文件");
					return false;
				}
				fr.readAsDataURL(file);//读取文件
				//操作文件事件
				fr.onload = function() {
					base64Data1 = this.result;//获得base编码字符串格式
					//$("#preShow").attr("src", base64Data1);//显示图片
					$this.parent().css({
						"background" : "url('" + base64Data1 + "') no-repeat",
						"background-size" : "auto 100%",
						"background-position" : "center",
					});
					$this.attr("data-id", base64Data1);
					$this.css("opacity", "0")
				};

				return base64Data1;
	});

	//装填数据
	function json(reim) {
		reim["reimburseId"] =$("#reimburseId").attr("data-id");
		reim["typeId"] = 2;
		reim["createMan"] = employeeId;
		reim["createTime"] = null;
		reim["departmentId"] = $("#departmentId").attr("data-id");
		reim["nextDealMan"] = $("#nextDealMan").attr("data-id");
		reim["event"] = $("#event").val();
		reim["totalCount"] = $("#moneySum").text();
		var reiminfos = [];
		for (var i = 0; i < $("input[name='desc']").length; i++) {
			var reiminfo = {};
			reiminfo["id"] =0 ;
			reiminfo["mainId"] = $("#reimburseId").attr("data-id");
			reiminfo["desc"] = $("input[name='desc']").eq(i).val();
			reiminfo["subTotal"] = $("input[name='subTotal']").eq(i).val();
			reiminfo["pictureName"] = $("input[name='imgfile']").eq(i).attr(
					"data-id");
			reiminfos.push(reiminfo);
		}
		reim["reiminfos"] = reiminfos;
	}
	</script>
</html>