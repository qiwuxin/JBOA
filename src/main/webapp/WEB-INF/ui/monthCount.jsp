<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#content {
	height: 1000px;
}
</style>
</head>
<body>
	<div class="continer">
		<div class="col-md-12">
			<button class="btn btn-default" id="outElx">导出表格</button>
			<button class="btn btn-default" onclick="outExcel()">java代码导出表格</button>
		</div>
		<div class="col-md-12">
			<table class="table table-default">
				<caption>报销统计表</caption>
				<thead>
					<tr>
						<th>编号</th>
						<th><c:if test="${sessionScope.evo.positionId==1 }">姓名</c:if><c:if 
						test="${sessionScope.evo.positionId==0||sessionScope.evo.positionId==4 }">部门</c:if></th>
						<th>报销总金额</th>
						<th>年份</th>
						<th>月份</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
		<div class="col-md-12">
			<button onclick="zhu()">柱状图</button>
			<button onclick="bing()">饼状图</button>
			<button onclick="xian()">折线图</button>
		</div>
		<div class="col-md-12" id="myChart" style="height: 500px"></div>
	</div>
</body>
<script type="text/javascript" src="/JBOA/js/echarts.js"></script>
<script type="text/javascript">
var datas =new Array(); 
var startYear = window.sessionStorage.getItem("startYear");
var startMonth = window.sessionStorage.getItem("startMonth");
	var pip = `${sessionScope.evo.positionId}`;
	
	if(pip==0){
		show(`department/1/10/`+startYear+`/`+startMonth+`/`+startMonth+`/0`);
		$("#title").text(startYear+"年"+startMonth+"月月度报销统计——总统计");
	}else if(pip==1){
		show(`employee/1/20/`+startYear+`/`+startMonth);
		$("#title").text(startYear+"年"+startMonth+"月月度报销统计——${sessionScope.evo.departmentName}统计");
	}


	function show(data){
		$.getJSON("/JBOA/api/person/counts/month/"+data,function(res){
			pageInfo = res;
			$(".info").remove();
			$.each(pageInfo.list,function(i,obj){
				var json = {};
				var $tr=`<tr class="info">`;
				if(pip==0||pip==4){
					$tr+=`<td>`+obj.departmentId+`</td>
						  <td>`+obj.departmentName+`</td>`;
					json["name"]=obj.departmentName;
				}else if(pip==1){
					$tr+=`<td>`+obj.employeeId+`</td>
					      <td>`+obj.employeeName+`</td>`;
					json["name"]=obj.employeeName;
				}
				$tr+=`<td>`+obj.moneySUM+`</td>
					  <td>`+obj.year+`</td>
					  <td>`+obj.month+`</td>
					 </tr>`;
					 json["value"]=obj.moneySUM;
				$("tbody").append($tr);
				datas.push(json);
			});
			 
	       
	        
		});
	}

	$("#outElx").click(function(){
		 var str =document.getElementsByTagName("table")[0].outerHTML; 

     	var worksheet = $("#title").text();
         var uri = 'data:application/vnd.ms-excel;base64,';
    
         //下载的表格模板数据
         let template = `<html xmlns:o="urn:schemas-microsoft-com:office:office" 
         xmlns:x="urn:schemas-microsoft-com:office:excel" 
         xmlns="http://www.w3.org/TR/REC-html40">
         <head><meta charset='utf-8' /><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>
           <x:Name>`+worksheet+`</x:Name>
           <x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet>
           </x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]-->
           </head><body>`+str+`</body></html>`;
         //下载模板
         window.location.download = "学生成绩表.xls";
         window.location.href = uri + base64(template);
	});

	//输出base64编码
    function base64 (s) { return window.btoa(unescape(encodeURIComponent(s))) }
    
	//柱状图
	function zhu(){
		var name = new Array();
		var money = new Array();
		$.each(datas,function(i,obj){
			name.push(obj["name"]);
			money.push(obj["value"]);
		});
		//基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('myChart'));
		
		// 指定图表的配置项和数据
		var option = {
		    title: {
		        text: '柱状示意图——月度报表'
		    },
		    tooltip: {},
		    legend: {
		        data:['报销金额']
		    },
		    xAxis: {
		        data: name
		    },
		    yAxis: {},
		    series: [{
		        name: '报销金额',
		        type: 'bar',
		        barWidth : 30,
		        data: money
		    }]
		};
		
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}

	//饼状图
	function bing(){
		//基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('myChart'));
		
		// 指定图表的配置项和数据
		var option = {
		    title: {
		        text: '饼状示意图——月度报表'
		    },
		    tooltip: {},
		    
		    series: [{
		        name: '访问量',
		        type: 'pie',
		        radius:'60%',
		        data: datas
		    }]
		};
		
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}

	//折线图
	function xian(){
		var name = new Array();
		var money = new Array();
		$.each(datas,function(i,obj){
			name.push(obj["name"]);
			money.push(obj["value"]);
		});
		//基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('myChart'));
		
		// 指定图表的配置项和数据
		var option = {
		    title: {
		        text: '折线示意图——月度报表'
		    },
		    tooltip: {},
		    legend: {
		        data:['金额']
		    },
		    xAxis: {
		        data: name
		    },
		    yAxis: {},
		    series: [{
		        name: '报销金额',
		        type: 'line',
		        data: money
		    }]
		};
		
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}


	//后台导入Excel
	function outExcel(){
		var tbTitles = [$("th").eq(0).text(),$("th").eq(1).text(),$("th").eq(2).text(),$("th").eq(3).text(),$("th").eq(4).text()];
		var items = [];
		for(var i=0;i<$(".info").length;i++){
			var temp = {};
			temp["employeeId"]=$(".info").eq(i).find("td").eq(0).text();
			temp["employeeName"]=$(".info").eq(i).find("td").eq(1).text();
			temp["money"]=$(".info").eq(i).find("td").eq(2).text();
			temp["year"]=$(".info").eq(i).find("td").eq(3).text();
			temp["month"]=$(".info").eq(i).find("td").eq(4).text();
			temp["moneySUM"]=null;
			temp["departmentId"]=null;
			temp["departmentName"]=null;
			items.push(JSON.stringify(temp));
		}
		$.ajax("/JBOA/api/person/counts/excel",{
			type:"post",
			dataType : "json",
			dataType:"text",
			data : {
				"counts":items,
				"fileName":$("#title").text(),
				"tbTitles":tbTitles
			},
			success : function(res) {
				alert("导出" + res);
			}
		});
	}
		 
</script>
</html>