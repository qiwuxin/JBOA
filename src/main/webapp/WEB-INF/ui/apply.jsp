<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增报销单</title>
<style type="text/css">
.box {
	padding: 0;
}

#moneySum {
	color: red;
}

.img {
	width: 80px;
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

.col-md-12 {
	margin-bottom: 10px;
}

#content {
	height: 600px;
}

#reims {
	height: 250px;
	overflow-y: scroll;
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
</style>
</head>
<body>
	<div class="continer text-left">
		<h4 style="font-weight: bold; line-height: 40px; padding-left: 30px;">报销管理——报销单信息</h4>
		<div class="col-md-12">
			<div class="col-md-3 box">
				<label class="col-md-3 box">编号：</label><label class="col-md-6 box">${user.employeeId }</label>
			</div>
			<div class="col-md-3 box">
				<label class="col-md-3 box">姓名：</label><label class="col-md-6 box">${user.employeeName }</label>
			</div>
			<div class="col-md-3 box">
				<label class="col-md-3 box">部门：</label><label class="col-md-6 box">${user.departmentName }</label>
			</div>
			<div class="col-md-3 box">
				<label class="col-md-3 box">职位：</label><label class="col-md-6 box">${user.positionName }</label>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-6 box">
				<label class="col-md-3">总金额：</label> <label class="col-md-4"><span
					id="moneySum">0</span>￥</label>
			</div>
		</div>
		<div id="reims" class="col-md-12" style="border-top: 1px dashed;">
			<table class="table table-default">
				<tr>
					<th>费用说明</th>
					<th>费用金额</th>
					<th>单据凭证</th>
					<th>操作</th>
				</tr>
				<tr>
					<td><input type="text" name="desc" /></td>
					<td><input type="text" name="subTotal" /></td>
					<td>
						<div class="imgfilediv">
							<input type="file" style="width: 100%;height: 50px;" name="imgfile" />
						</div>
					</td>
					<td><button class="add"></button></td>
				</tr>
			</table>
		</div>
		<div class="col-md-12">
			<span class="col-md-1"
				style="padding: 0; height: 150px; line-height: 150px">事由：</span>
			<div class="col-md-11">
				<textarea class="col-md-12" style="height: 150px;" id="event"></textarea>
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
	//新增消费报销记录
	$(document).off("click", ".add").on("click", ".add", function() {
		if ($("input").val().length < 1) {
			alert("不能为空！");
			return;
		}
		totalNum();
		var $this = $(this).parent().parent().clone(true);
		$this.find("td").find("button").addClass("remove").removeClass("add");
		$(this).parent().parent().find("td").find("input").val("");
		$(this).parent().parent().find("td").find("div").removeAttr("style"); 
		$(this).parent().parent().find("td").find("div").find("input").prop("data-id", "");
		$(this).parent().parent().before($this);

	});
	//删除消费报销记录
	$(document).off("click", ".remove").on("click", ".remove", function() {
		$(this).parent().parent().remove();
		totalNum();
	});
	$(document).off("change","input[name='subTotal']").on("change","input[name='subTotal']",function(){
		totalNum();
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
			type : "post",
			dataType : "json",
			contentType : "application/json;charset=UTF-8",//非常重要
			data : JSON.stringify(reim),
			success : function(res) {
				alert("保存" + res);
				$("#content").load("../reimburse/applyList");
				$("#title").text("报销单列表查看");
			}
		});
	});

	//提交
	$(document).off("click", "#submit").on("click", "#submit", function() {
		var reim = {};
		json(reim);
		reim["statusId"] = 2;
		$.ajax("/JBOA/api/person/Reims/Reim", {
			type : "post",
			dataType : "json",
			contentType : "application/json;charset=UTF-8",//非常重要
			data : JSON.stringify(reim),
			success : function(res) {
				alert("提交" + res);
				$("#content").load("../reimburse/applyList");
				$("#title").text("报销单列表查看");
			}
		});
	});

	function json(reim) {
		reim["reimburseId"] = 0;
		reim["typeId"] = 2;
		reim["createMan"] = employeeId;
		reim["createTime"] = null;
		reim["departmentId"] = 0;
		reim["nextDealMan"] = 0;
		reim["event"] = $("#event").val();
		reim["totalCount"] = $("#moneySum").text();
		var reiminfos = [];
		for (var i = 0; i < $("input[name='desc']").length; i++) {
			var reiminfo = {};
			reiminfo["id"] =0 ;
			reiminfo["mainId"] = 0;
			reiminfo["desc"] = $("input[name='desc']").eq(i).val();
			reiminfo["subTotal"] = $("input[name='subTotal']").eq(i).val();
			reiminfo["pictureName"] = $("input[name='imgfile']").eq(i).attr(
					"data-id");
			reiminfos.push(reiminfo);
		}
		reim["reiminfos"] = reiminfos;
	}
	var base64Data1 = "";
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

	function totalNum() {
		var moneySum = 0;
		for (var i = 0; i < $("input[name='subTotal']").length; i++) {
			var subTotal = parseFloat($("input[name='subTotal']").eq(i).val());
			if (isNaN(subTotal)) {
				subTotal = 0;
			}
			moneySum += subTotal;
		}
		$("#moneySum").text(moneySum);
	}
</script>
</html>