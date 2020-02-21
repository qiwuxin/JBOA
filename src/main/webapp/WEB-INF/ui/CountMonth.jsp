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
			<div class="col-md-3">
				<label class="col-md-4" style="padding: 0">选择年份</label>
				<div class="col-md-8"><input type="text" id="startYear"/></div>
			</div>
			<div class="col-md-4">
				<label class="col-md-4">开始月份</label>
				<div class="col-md-8"><input type="text" id="startMonth"/></div>
			</div>
			<div class="col-md-4">
				<label class="col-md-4">截止月份</label>
				<div class="col-md-8"><input type="text" id="endMonth"/></div>
			</div>
			<div class="col-md-1">
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
						<th>月份</th>
						<c:if test="${sessionScope.evo.positionId==1 }">
							<th>部门</th>
						</c:if>	
						<th>操作</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
		<div class="col-md-12" id="page"></div>
	</div>
</body>
<script type="text/javascript">
	pageNum = 1;
	pageSize= 7;
	var startYear=0;
	var startMonth=0;
	var endMonth=0;
	var pip = `${sessionScope.evo.positionId}`;
	var departmentId = `${sessionScope.evo.departmentId}`;
	if(pip==0||pip==4){
		show(`month/all/1/7/0/0/0`);
		$("#title").text("月度报销统计——总统计");
	}else if(pip==1){
		show(`month/department/`+pageNum+`/`+pageSize+`/0/0/0/`+departmentId);
		$("#title").text("月度报销统计——${sessionScope.evo.departmentName}统计");
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
								<td>`+obj.month+`</td>`;
				if(pip==1){
					$tr	+=`<td>`+obj.departmentName+`</td>`;
				}
				$tr	+=`<td><a class="a iin">查看</a></td>
							</tr>`;
				$("tbody").append($tr);
			});
			$("#page").html(page(5));
		});
	}

	$("input[type='button']").click(function(){
		var startYears=$("#startYear").val();
		var startMonths  =$("#startMonth").val();
		var endMonths  =$("#endMonth").val();
		if(isNaN(startYears)||isNaN(startMonths)||isNaN(endMonths)){
			alert("格式错误！");
			return;
		}
		 if(startYear!=""&&startMonths!=""&&endMonths!=""&&parseInt(startMonths)>parseInt(endMonths)){
			alert("开始月份要小于截止月份");
			return;
		}
		startYear    =startYears==""?0:startYears;
		startMonth   = startMonths==""?0:startMonths;
		endMonth   = endMonths==""?0:endMonths;
		if(pip==0||pip==4){
			show(`month/all/`+pageNum+`/`+pageSize+`/`+startYear+`/`+startMonth+`/`+endMonth);
			
		}else if(pip==1){
			show(`month/department/`+pageNum+`/`+pageSize+`/`+startYear+`/`+startMonth+`/`+endMonth+`/`+departmentId);
		}
	});

	//翻页
	$(document).on("click",".curr",function(){
		pageNum = $(this).attr("data-id");
		if(pageNum==pageInfo.pageNum){
			return;
		}
		if(pip==0||pip==4){
			show(`month/all/`+pageNum+`/`+pageSize+`/`+startYear+`/`+startMonth+`/`+endMonth);
			
		}else if(pip==1){
			show(`month/department/`+pageNum+`/`+pageSize+`/`+startYear+`/`+startMonth+`/`+endMonth+`/`+departmentId);
		}
	});

	$(document).off("click",".iin").on("click",".iin",function(){
		
		var startYear = $(this).parent().parent().find("td").eq(2).text();
		var startMonth = $(this).parent().parent().find("td").eq(3).text();
		//alert(startMonth+"==="+startYear);
		window.sessionStorage.setItem("startYear",startYear);
		window.sessionStorage.setItem("startMonth",startMonth);
		$("#content").load("/JBOA/api/person/MonthCountInfo");
	});
</script>
</html>