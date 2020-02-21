/**
 * 分页插件
 * @param curr        当前页
 * @param lastPage	  起始页
 * @param firstPage   末尾页
 * @parem pageSize    页大小
 * @returns
 */
var pageInfo = null;
var pageNum = 1;
var pageSize=null;
function page(pageCount){
	var curr = pageNum;
	$("#pageparent").remove();
	if(pageInfo.lastPage<1){
		return "";
	}
	var sum = pageInfo.lastPage<pageCount?pageInfo.lastPage:pageCount;
	var max =pageInfo.lastPage;
	var $page =$(`<!-- 分页 -->
		<div class="row text-center" id="pageparent">
			<nav>
				<ul class="pagination" id="page">
					
				</ul>
			</nav>
		</div>`);
	var $last=`<li><a title="首页" href="javascript:void(0)" data-id="`+pageInfo.firstPage+`" class="curr" aria-label="Previous"> <span
		aria-hidden="true">&laquo;</span>
		</a></li>`;
		$page.find(" #page").append($last);
		for(var a=1;a<=sum;a++){
			if(curr-curr/2<1){
				var $a = `<li><a data-id="`+a+`" class="curr" href="javascript:void(0)">`+a+`</a></li>`;
			}else if(curr+curr/2>=max){
				var $a = `<li><a data-id="`+(max-sum+a)+`" class="curr" href="javascript:void(0)">`+(max-sum+a)+`</a></li>`;
			}else{
				var $a = `<li><a data-id="`+(curr-(curr/2+1)+a)+`" class="curr" href="javascript:void(0)">`+(curr-(curr/2+1)+a)+`</a></li>`;
			}
			$page.find(" #page").append($a);
			}
		/*var $select = `<li><input type="text" style="width:50px;" id="pageCount" /><button class="btn" id="goPpage">跳转</button></li>`;
		$page.find(" #page").append($select);*/
		var $last=`<li><a title="尾页" href="javascript:void(0)" data-id="`+pageInfo.lastPage+`" class="curr" aria-label="Next"> <span
						aria-hidden="true">&raquo;</span>
					</a></li>`;
		$page.find(" #page").append($last);
		$page.find("#page>li>a:contains("+curr+")").css({"font-weight":"bold","color":"blue","background-color":"#d7d6e2"});
		return $page;
}


//翻页
/**
 * pageMethod为方法
 */
/*var pageMethod=null;
$(document).on("click",".curr",function(){
	pageNum = $(this).attr("data-id");
	if(pageNum==pageInfo.pageNum){
		return;
	}
	pageMethod;
});*/

/*$(document).on("click","#goPage",function(){
	
	if(!isNaN($("#pageCount"))){
		if($("#alertDialog")!=undefined){
			showAlertDialog("输入格式错误！");
			return;
		}else{
			alert("输入格式错误！");
			return;
		}
	}
	if($("#pageCount").val()>pageInfo.lastPage||$("#pageCount").val()<pageInfo.firstPage){
		if($("#alertDialog")!=undefined){
			showAlertDialog("输入页数错误！");
			return;
		}else{
			alert("输入页数错误！");
			return;
		}
	}
	pageMethod;
});*/

