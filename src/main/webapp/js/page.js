
/**
 * 分页插件
 * @param curr        当前页
 * @param lastPage	  起始页
 * @param firstPage   末尾页
 * @returns
 */
function page( curr, lastPage, firstPage){
	$("#pageparent").remove();
	var sum = lastPage<5?lastPage:5;
	var max =lastPage;
	var $page =$(`<!-- 分页 -->
		<div class="row text-center" id="pageparent">
			<nav>
				<ul class="pagination" id="page">
					
				</ul>
			</nav>
		</div>`);
	var $last=`<li><a title="首页" href="javascript:void(0)" data-id="`+firstPage+`" class="curr" aria-label="Previous"> <span
		aria-hidden="true">&laquo;</span>
		</a></li>`;
		$page.find(" #page").append($last);
		for(var a=1;a<=sum;a++){
			if(curr-2<1){
				var $a = `<li><a data-id="`+a+`" class="curr" href="javascript:void(0)">`+a+`</a></li>`;
			}else if(curr+2>=max){
				var $a = `<li><a data-id="`+(max-sum+a)+`" class="curr" href="javascript:void(0)">`+(max-sum+a)+`</a></li>`;
			}else{
				var $a = `<li><a data-id="`+(curr-3+a)+`" class="curr" href="javascript:void(0)">`+(curr-3+a)+`</a></li>`;
			}
			$page.find(" #page").append($a);
			}
		var $last=`<li><a title="尾页" href="javascript:void(0)" data-id="`+lastPage+`" class="curr" aria-label="Next"> <span
						aria-hidden="true">&raquo;</span>
					</a></li>`;
		$page.find(" #page").append($last);
		$page.find("#page>li>a:contains("+curr+")").css({"font-weight":"bold","color":"blue","background-color":"#d7d6e2"});
		return $page;
}