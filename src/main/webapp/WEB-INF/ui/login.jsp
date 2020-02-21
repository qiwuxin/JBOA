<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0px 0px;
	padding: 0px 0px;
}

body {
	background: #4BB8EF url("/img_server/bg.gif") repeat-x;
}

.img_1 {
	margin: 0px auto;
	width: 963px;
	margin-top: 144px;
}

.img_2 {
	margin: 0px auto;
	width: 963px;
	margin-top: -4px;
	position: relative;
}

.formpadd {
	top: 10px;
	left: 35%;
	position: absolute;
}

table tr {
	line-height: 26px;
}

.img_3 {
	width: 224px;
	margin: 0px auto;
	margin-top: 22px;
}

#verify {
	height: 34px;
	vertical-align: top;
	font-size: 16px;
}

#code_img {
	width: 100px;
	height: 40px;
	cursor: pointer;
	vertical-align: top;
}
</style>
</head>
<div class="img_1">
	<img src="/img_server/login_01.gif" />
</div>
<div class="img_2">
	<img src="/img_server/login_02.gif" />
	<form action="/JBOA/c/person/giam" method="post" class="formpadd">
		<table>
			<tr>
				<td>工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号</td>
				<td><input type="text" name="employeeId"></td>
				<td><span class="sp1"></span></td>
			</tr>
			<tr>
				<td>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码</td>
				<td><input type="password" name="password"></td>
				<td><span class="sp2"></span></td>
			</tr>
			<tr>
				<td>验证码:</td>
				<td><input type="text" name="verification"></td>
				<td><span class="sp3"></span></td>
			</tr>
			<tr>
				<td colspan="2" style="padding-top: 3px;"><span id="verify"></span>
					<canvas width="100" height="40" id="verifyCanvas"></canvas> <img
					id="code_img"> <input type="image"
					src="/img_server/login_sub.gif"
					style="position: relative; top: 5px; left: 20px;"
					onclick="yanzhen()" /></td>
			</tr>
		</table>
	</form>
</div>
<div class="img_3">
	<img src="/img_server/copyright.gif" />
</div>
</body>
<script src="/JBOA/js/jquery-1.12.4.js"></script>
<script>
	var nums = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", 'A', 'B',
			'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
			'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b',
			'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
			'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' ];
	var yanzm = "";
	drawCode();

	// 绘制验证码
	function drawCode() {
		var canvas = document.getElementById("verifyCanvas"); //获取HTML端画布
		var context = canvas.getContext("2d"); //获取画布2D上下文
		context.fillStyle = "cornflowerblue"; //画布填充色
		context.fillRect(0, 0, canvas.width, canvas.height); //清空画布
		context.fillStyle = "white"; //设置字体颜色
		context.font = "25px Arial"; //设置字体
		var rand = new Array();
		var x = new Array();
		var y = new Array();
		yanzm = "";
		for (var i = 0; i < 5; i++) {
			rand[i] = nums[Math.floor(Math.random() * nums.length)]
			x[i] = i * 16 + 10;
			y[i] = Math.random() * 20 + 20;
			context.fillText(rand[i], x[i], y[i]);
			yanzm += rand[i];
		}
		//画3条随机线
		for (var i = 0; i < 3; i++) {
			drawline(canvas, context);
		}

		// 画30个随机点
		for (var i = 0; i < 30; i++) {
			drawDot(canvas, context);
		}
		convertCanvasToImage(canvas)
	}

	// 随机线
	function drawline(canvas, context) {
		context.moveTo(Math.floor(Math.random() * canvas.width), Math
				.floor(Math.random() * canvas.height)); //随机线的起点x坐标是画布x坐标0位置，y坐标是画布高度的随机数
		context.lineTo(Math.floor(Math.random() * canvas.width), Math
				.floor(Math.random() * canvas.height)); //随机线的终点x坐标是画布宽度，y坐标是画布高度的随机数
		context.lineWidth = 0.5; //随机线宽
		context.strokeStyle = 'rgba(50,50,50,0.3)'; //随机线描边属性
		context.stroke(); //描边，即起点描到终点
	}
	// 随机点(所谓画点其实就是画1px像素的线，方法不再赘述)
	function drawDot(canvas, context) {
		var px = Math.floor(Math.random() * canvas.width);
		var py = Math.floor(Math.random() * canvas.height);
		context.moveTo(px, py);
		context.lineTo(px + 1, py + 1);
		context.lineWidth = 0.2;
		context.stroke();
	}
	// 绘制图片
	function convertCanvasToImage(canvas) {
		document.getElementById("verifyCanvas").style.display = "none";
		var image = document.getElementById("code_img");
		image.src = canvas.toDataURL("image/png");
		return image;
	}

	// 点击图片刷新
	document.getElementById('code_img').onclick = function() {
		$('#verifyCanvas').remove();
		$('#verify').after(
				'<canvas width="100" height="40" id="verifyCanvas"></canvas>')
		drawCode();
	}
	$(function() {

		$(".formpadd")
				.submit(
						function() {
							var userNumber = $("[name=jobNumber]").val();
							var userPwd = $("[name=password]").val();
							var verification = $("[name=verification]").val();

							if (userNumber == "") {
								$(".sp2").text("");
								$(".sp3").text("");
								$(".sp1").css({
									"font-size" : "10px",
									"color" : "red"
								});
								$(".sp1").text("工号不能为空！");
								return false;
							} else if (userPwd == "") {
								$(".sp1").text("");
								$(".sp3").text("");
								$(".sp2").css({
									"font-size" : "10px",
									"color" : "red"
								});
								$(".sp2").text("密码不能为空！");
								return false;
							} else if (verification == "") {
								$(".sp1").text("");
								$(".sp2").text("");
								$(".sp3").css({
									"font-size" : "10px",
									"color" : "red"
								});
								$(".sp3").text("验证码不能为空！");
								return false;
							} else if (verification.toLowerCase() != yanzm
									.toLowerCase()) {
								$(".sp1").text("");
								$(".sp2").text("");
								$(".sp3").css({
									"font-size" : "10px",
									"color" : "red"
								});
								$(".sp3").text("验证码错误！");
								$('#verifyCanvas').remove();
								$('#verify')
										.after(
												'<canvas width="100" height="40" id="verifyCanvas"></canvas>')
								drawCode();
								return false;
							}
							return true;
						});
	});
</script>
</html>