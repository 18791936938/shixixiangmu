<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心</title>
	<link rel="stylesheet" type="text/css" href="lib/css/login.css">
	<link rel="stylesheet" type="text/css" media="screen" href="lib/plug/jqUploader/style.css"/>
	<link rel="stylesheet" type="text/css" href="lib/plug/jquery.lazyload/style.css">
  	<script type="text/javascript" src="lib/plug/jquery/jquery-1.3.2.min.js"></script>
  	<script type="text/javascript" src="lib/plug/jquery.lazyload/js/jquery.lazyload.min.js"></script>
  	<script type="text/javascript" src="lib/plug/jquery.lazyload/js/blocksit.min.js"></script>
</head>
<style>
	.group{
  		position:relative;
  		border:1px solid #4cae4c;
  		background-color:#4cae4c;
  		height:45px;
  		margin-top:0px;
  		margin-left:-8px;
  		margin-right:-8px;
  	}
	.button{
		width: 90px;
		line-height: 23px;
		text-align: center;
		font-weight: bold;
		color: #fff;
		text-shadow:1px 1px 1px #333;
		border-radius: 5px;
		margin:0 20px 20px 0;
		position: relative;
		overflow: hidden;
	}
	
	.button.green{
		border:1px solid #64c878;
		box-shadow: 0 1px 2px #b9ecc4 inset,0 -1px 0 #6c9f76 inset,0 -2px 3px #b9ecc4 inset;
		background: -webkit-linear-gradient(top,#90dfa2,#84d494);
		background: -moz-linear-gradient(top,#90dfa2,#84d494);
		background: linear-gradient(top,#90dfa2,#84d494);
	}
</style>
<script type="text/javascript">
var userId = "${userId}";
var userName = "${userName}";
jQuery(document).ready(function($) {
	loadImgStyle();
});

/*加载图片布局*/
	function loadImgStyle(){
		loadImg();
		$("img.lazy").lazyload({		
			load:function(){
				$('#container').BlocksIt({
					numOfCol:5,
					offsetX: 8,
					offsetY: 8
				});
			}
		});	
		$(window).scroll(function(){
			// 当滚动到最底部以上50像素时， 加载新内容
			if ($(document).height() - $(this).scrollTop() - $(this).height()<100){
				$('#container').append($("#test").html());		
				$('#container').BlocksIt({
					numOfCol:5,
					offsetX: 8,
					offsetY: 8
				});
				$("img.lazy").lazyload();
			}
		});
		
		//window resize
		var currentWidth = 1000;
		$(window).resize(function() {
			var winWidth = $(window).width();
			var conWidth;
			if(winWidth < 660) {
				conWidth = 440;
				col = 2
			} else if(winWidth < 880) {
				conWidth = 660;
				col = 3
			} else if(winWidth < 1000) {
				conWidth = 880;
				col = 4;
			} else {
				conWidth = 1000;
				col = 5;
			}
			
			if(conWidth != currentWidth) {
				currentWidth = conWidth;
				$('#container').width(conWidth);
				$('#container').BlocksIt({
					numOfCol: col,
					offsetX: 8,
					offsetY: 8
				});
			}
		});
	}
	
	/*加载图片*/
	function loadImg(){
		$.ajax({
	  		dataType : "json",
			type : "post",
			url : 'queryCollectByUserId.do?userId=' + userId,
			success : function(data, textStatus) {
			   if(!data.isError){
				   var dataArr = eval( data );
				   $("#fileSize").empty();
				   $("#fileSize").append(dataArr.length);
				   showImg(dataArr);
			   }else{
				   alert(data.message);
			   }
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(errorThrown);
			}
 		});
	}
	
	/*展示图片*/
	function showImg(data){
		var loginUserId = $("#userId").val();
		$("#container").empty();
		for(one in data){
			var id = data[one]['id'];
			var path = data[one]['path'];
			var name = data[one]['name'];
			var desc = data[one]['desc'];
			var userName = data[one]['userName'];
			$("#container").append("<div class='grid'><div class='imgholder'><img class='lazy' src=" + path + "  width='175'/></div><div style='margin-top:5px;'>作者：" + userName + "</div><div class='meta' style='margin-top:10px;'><a href='javascript:void(0);' class='collect' style='margin-left:-30px;' onclick='deleteCollect(\"" + id + "\");'>删除</a><a style='margin-left:85px;' href='detail.do?imgId=" + id + "&loginUserId=" + loginUserId + "' target='_blank'>点击查看>>></a></div></div>");
		}
	}

	/*删除收藏*/
	function deleteCollect(id){
		$.ajax({
	  		dataType : "json",
			type : "post",
			url : 'deleteCollectByFileId.do?id=' + id,
			success : function(data, textStatus) {
			   if(!data.isError){
				   alert("删除成功！");
				   loadImgStyle();
			   }else{
				   alert(data.message);
			   }
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(errorThrown);
			}
 		});
	}
	function setAccount(){
		window.location = "viewAccount.do?userId=" + userId;
	}
</script>

<body>
	 <div class="group" id="header">
    	<input id="userId" type="hidden" value="${userId}"/>
    	<div style="margin-left:680px;">
    		<div style="height:20px;width:180px;margin-top:10px;margin-left:-540px;color:#fff;">
    			<img style='width:32px;height:32px;' src="lib/plug/ajaxFileUpload/flag.png"/>
    			<div style="margin-top:-28px;margin-left:50px;">${userName}</div>
    			<div id="logout" style="margin-top:-16px;margin-left:120px;color:#fff;">
    				<a href="index.do">退出</a>
    			</div>
    		</div>
    	</div>
    </div>
    <div style="background-color:#F9D978;height:32px;line-height:32px;width:1100px;margin:0 auto;">
    	<div style="margin-left:20px;margin-top:20px;">
    		共收藏  <span id="fileSize" style="font-weight:bold;color:#35BFFF;"></span> 个文件
    	</div>
    	<div style="margin-top:-30px;margin-left:1000px;">
    		<button type="button" class="button green" onclick="setAccount()">账号设置</button>
    	</div>
    </div>
    
    <div id="container" style="margin-top:10px;">
	</div>
</body>
</html>