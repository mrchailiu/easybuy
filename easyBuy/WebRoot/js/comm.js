$(function(){
	
	//所有div显示鼠标样式为手指状
	$('div,a,input[type=button]').css('cursor','pointer');
	//隐藏所有图片边框
	$('img').css('border','0px');
	//设置logo图链接
	$("img").click(function(){
		if($(this).attr("src")=="images/logo.png"){
			location.href="crm/index.jsp";
		}
	});
	
	
	$("a").click(function(){
		if($(this).attr("href") == ""){
			//替换所有未填写href属性的a标签
			$(this).attr("href","javascript:void(0);");
			return false;
		}
	});
	
	//滚动固定搜索栏
	$(window).scroll(function(){
		if($(this).scrollTop()>=100){
			$(".search").addClass("fixedNav");
		}else{
			$(".search").removeClass("fixedNav");
		}
	});
	
});