<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#content{
		height: 600px;
	}
	th,td{
		height: 50px;
		line-height: 50px;
		text-align: center;
	}
	th{
		font-size: 20px;
	}
	td{
		font-size: 18px;
	}
</style>
</head>
<body>
	<div class="continer">
		<div class="col-md-12" style="height: 50px;margin-top: 20px;">
			<div class="col-md-5">
				<label class="col-md-4">开始年份：</label>
				<div class="col-md-8">
					<input type="text" id="startYear"/>
				</div>
			</div>
			<div class="col-md-5">
				<label class="col-md-4">截至年份：</label>
				<div class="col-md-8">
					<input type="text" id="endYear"/>
				</div>
			</div>
			<div class="col-md-2">
				<input type="button" value="查询"/>
			</div>
		</div>
		<div class="col-md-12" style="height: 450px;border-top: 2px solid;">
			<table class="table table-default">
				<thead>
					<tr>
						<th>编号</th>
						<th>总计金额</th>
						<th>年份</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
		</div>
		<div id="page"></div>
	</div>
</body>
<script type="text/javascript">
	pageNum = 1;
	pageSize= 7;
	var startYear=0;
	var endYear=0;
	var pip = `${sessionScope.evo.positionId}`;
	var departmentId = `${sessionScope.evo.departmentId}`;
	if(pip==0||pip==4){
		show(`year/all/`+pageNum+`/`+pageSize+`/0/0`);
		$("#title").text("年度报销统计——总统计");
	}else if(pip==1){
		show(`year/department/`+pageNum+`/`+pageSize+`/0/0/`+departmentId);
		$("#title").text("年度报销统计——${sessionScope.evo.departmentName}统计");
	}
	function show(data){
		$.getJSON("/JBOA/api/person/counts/"+data,function(res){
			pageInfo = res;
			$(".info").remove();
			$.each(pageInfo.list,function(i,obj){
				var $tr = `<tr class="info">
								<td>`+(pageNum*pageSize+(i+1)-pageSize)+`</td>
								<td>￥`+obj.moneySUM+`</td>
								<td>`+obj.year+`</td>
								<td><a class="a iin">查看</a></td>
							</tr>`;
				$("tbody").append($tr);
			});
			$("#page").html(page(5));
		});
	}

	$("input[type='button']").click(function(){
		var startYears=$("#startYear").val();
		var endYears  =$("#endYear").val();
		if(isNaN(startYears)||isNaN(endYears)){
			alert("格式错误！");
			return;
		}
		 if(startYear!=""&&endYear!=""&&parseInt(startYears)>parseInt(endYears)){
			alert("开始年份要小于截止年份");
			return;
		}
		startYear =startYears==""?0:startYears;
		endYear   = endYears==""?0:endYears;
		if(pip==0||pip==4){
			show(`year/all/`+pageNum+`/`+pageSize+`/`+startYear+`/`+endYear);
			
		}else if(pip==1){
			show(`year/department/`+pageNum+`/`+pageSize+`/`+startYear+`/`+endYear+`/`+departmentId);
		}
	});

	//翻页
	$(document).off("click",".curr").on("click",".curr",function(){
		pageNum = $(this).attr("data-id");
		if(pageNum==pageInfo.pageNum){
			return;
		}
		if(pip==0||pip==4){
			show(`year/all/`+pageNum+`/`+pageSize+`/`+startYear+`/`+endYear);
			
		}else if(pip==1){
			show(`year/department/`+pageNum+`/`+pageSize+`/`+startYear+`/`+endYear+`/`+departmentId);
		}
	});

	$(document).off("click",".iin").on("click",".iin",function(){
		var startYear =$(this).parent().prev().text();
		window.sessionStorage.setItem("startYear",startYear);
		$("#content").load("/JBOA/api/person/YearCountInfo");
	});
	
</script>
</html>