<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>UI设计资源分享网</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    

	<link rel="stylesheet" type="text/css" href="lib/css/login.css">
	<link rel="stylesheet" type="text/css" media="screen" href="lib/plug/jqUploader/style.css"/>
	<link rel="stylesheet" type="text/css" href="lib/plug/jquery.lazyload/style.css">
  	<script type="text/javascript" src="lib/plug/jquery/jquery-1.3.2.min.js"></script>
  	<script type="text/javascript" src="lib/plug/jquery.lazyload/js/jquery.lazyload.min.js"></script>
  	<script type="text/javascript" src="lib/plug/jquery.lazyload/js/blocksit.min.js"></script>
  	<script type="text/javascript" src="lib/plug/ajaxFileUpload/ajaxfileupload.js"></script>
  </head>
	
  <style type="text/css">
  	.group{
  		position:relative;
  		border:1px solid #4cae4c;
  		background-color:#4cae4c;
  		height:45px;
  		margin-top:0px;
  		margin-left:-8px;
  		margin-right:-8px;
  	}
  		
  		
  	/*登录  开始*/
	.theme-popover-mask {
		z-index: 1;
		position:absolute; 
		top:0;
		left:0;
		width:100%;
		height:1000px;
		background:#000;
		-moz-opacity:0.5; /*Firefox私有，透明度50%*/
		opacity:0.5;/*其他，透明度50%*/
		filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
		-khtml-opacity: 0.5; 
		display:none
	}
	
	.theme-popover {
		z-index:2;
		position:absolute;
		top:50%;
		left:50%;
		width:400px;
		height:260px;
		margin:120px 0 0 -200px;
		border-radius:5px;
		border:solid 2px #666;
		background-color:#f5f5f5;
		display:none;
		box-shadow: 0 0 10px #666;
	}
	
	.theme-poptit {
		border-bottom:1px solid #ddd;
		padding:12px;
		position: relative;
	}
	
	.theme-popbod {
		padding:40px 15px;
		color: #444;
		height: 175px;
	}
	.theme-poptit .close {
		float:right;
		color:#999;
		padding:5px;
		margin:-2px -5px -5px;
		font:bold 14px/14px simsun;
		text-shadow:0 1px 0 #ddd
	}
	.theme-poptit .close:hover {
		color:#444;
	}

	.dform {
		padding:35px 70px 80px;
		text-align: left;
	}
	.dform .ipt_error {
		background-color:#FFFFCC;
		border-color:#FFCC66
	}
	.dform-tip {
		display:none;
		background-color:#080;
		color:#fff;
		line-height:42px;
		margin-top:10px;
	display:;
		font-size: 14px;
	}
	.dform-tip-errer {
		background-color: #CF301A;
	}
	.dform-tip a {
		display: inline-block;
		padding: 0 20px;
		margin-left:10px;
		background-color: #FFE924;
		color: #CF301A;
	}
	.dform-login {
		padding:0;
		height: 270px;
		overflow: hidden;
	}
	.dform-login iframe {
		height: 260px;
		margin-top: -180px;
	}
	.theme-signin {
		margin: -50px -20px -50px 90px;
		text-align:left;
		font-size: 14px;
	}
	.ipt {
		border: solid 1px #d2d2d2;
		border-left-color: #ccc;
		border-top-color: #ccc;
		border-radius: 2px;
		box-shadow: inset 0 1px 0 #f8f8f8;
		background-color: #fff;
		padding: 4px 6px;
		height: 21px;
		line-height: 21px;
		color: #555;
		width: 250px;
		vertical-align: baseline;
	}
	.ipt-mini {
		width: 140px;
		padding: 1px 3px;
	}
	.ipt:focus {
		border-color: #95C8F1;
		box-shadow: 0 0 4px #95C8F1;
	}
  </style>	
	  
  <script type="text/javascript">
	/* 登录弹出 */
	var userId = "${userId}";
	var userName = "${userName}";
	jQuery(document).ready(function($) {
  		if (userId == ""){
  			$("#uploadBtn").hide();
  			$("#privilegeBtn").hide();
  			$("#logout").hide();
  			$("#personalCenterBtn").hide();
  		}else{
  			$("#loginBtn").hide();
  			$("#registBtn").hide();
  			$("#uploadBtn").show();
  			$("#logout").show();
  			$("#personalCenterBtn").show();
  			//超管展示权限管理按钮
  			if (userName == "admin"){
  				$("#privilegeBtn").show();
  			}else{
  				$("#privilegeBtn").hide();
  			}
  		}
		
		$("#fileToUpload").val("");
		$("#fileName").val("");
		$("#fileDesc").val("");
		$("#continueUpload").hide();
		$('.theme-login').click(function(){
			var bodyHeight = $("#noticeBody").height();
			$('.theme-popover-mask').css("height",bodyHeight);
			$('.theme-popover-mask').fadeIn(100);
			$('.theme-popover').slideDown(200);
		});
		$('.theme-poptit .close').click(function(){
			$('.theme-popover-mask').fadeOut(100);
			$('.theme-popover').slideUp(200);
		});
		
		upload();
	});
  
    /*上传*/
	function upload(){
		$("#buttonUpload").click(function(){    
			var fileName = $("#fileName").val();
			var fileDesc = $("#fileDesc").val();
			var fileUploadName = $("#fileToUpload").val();
			
			if (fileName == ""){
				alert("请填写文件名称！");
				return false;
			}
			else if (fileDesc == ""){
				alert("请填写文件描述！");
				return false;
			}
			else if (fileUploadName == ""){
				alert("请选择上传文件！");
				return false;
			}
		     //加载图标   
		     $("#loading").ajaxStart(function(){
		    	$("#fileToUpload").hide();
		    	$("#buttonUpload").hide();
		    	$("#fileNameDIV").hide();
		    	$("#fileDescDIV").hide();
		        $(this).show();
		     }).ajaxComplete(function(){
		    	$("#fileToUpload").show();
		    	$("#buttonUpload").show();
		    	$("#fileNameDIV").show();
		    	$("#fileDescDIV").show();
		        $(this).hide();
		     });
		    //上传文件
		    var userId = $("#userId").val();
		    $.ajaxFileUpload({
		        url : 'upload.do',//处理图片脚本
		        secureuri : false,
		        fileElementId :'fileToUpload',//file控件id
		        dataType : 'json',
		        data : {fileName:fileName,fileDesc:fileDesc,userId:userId},
		        success : function (data, status){
		           if (!data.isError){
		        	   $("#startUpload").hide();
		        	   $("#continueUpload").show();
		        	   loadImgStyle();
		           }else{
		        	   alert(data.message);
		           }
		        },
		        error: function(data, status, e){
		            //alert(e);
		        }
			});
			return false;
		}); 
		
		loadImgStyle();
	}
  
	/*控制上传内部显示*/
	function showUploadForm(){
		$("#startUpload").show();
		$("#continueUpload").hide();
		$("#fileToUpload").val("");
		$("#fileName").val("");
		$("#fileDesc").val("");
	}
  
  	
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
			url : 'getImgData.do',
			success : function(data, textStatus) {
			   if(!data.isError){
				   var dataArr = eval( data );
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
  			$("#container").append("<div class='grid'><div class='imgholder'><img class='lazy' src=" + path + "  width='175'/></div><div style='margin-top:5px;'>名称："+name+" 作者：" + userName + "</div><div style='margin-top:10px;' class='meta'><a href='javascript:void(0);' class='collect' style='margin-left:-30px;' onclick='collect(\"" + id + "\");'>收藏</a><a style='margin-left:85px;' href='detail.do?imgId=" + id + "&loginUserId=" + loginUserId + "' target='_blank'>点击查看>>></a></div></div>");
  		}
  		
  		//控制收藏按钮是否展示
  		if (userId == ""){
  			$("a.collect").hide();
  		}else{
  			$("a.collect").show();
  		}
  	}
  	
  	/*收藏*/
  	function collect(id){
  		$.ajax({
	  		dataType : "json",
			type : "post",
			url : 'addCollect.do?fileId=' + id + "&userId=" + userId,
			success : function(data, textStatus) {
			   if(!data.isError){
				  alert("收藏成功!");
			   }else{
				   alert(data.message);
			   }
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(errorThrown);
			}
	 	});
  	}
  	function search(){
  		var searchName = $("#search").val();
  		$.ajax({
	  		dataType : "json",
			type : "post",
			url : 'getImgData.do?searchName='+searchName,
			success : function(data, textStatus) {
			   if(!data.isError){
				   var dataArr = eval( data );
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
  	function selectTime(){
  		var searchName = $("#search").val();
  		$.ajax({
	  		dataType : "json",
			type : "post",
			url : 'getImgData.do?searchName='+searchName+'&selectTime=1',
			success : function(data, textStatus) {
			   if(!data.isError){
				   var dataArr = eval( data );
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
  	function selectHot(){
  		var searchName = $("#search").val();
  		$.ajax({
	  		dataType : "json",
			type : "post",
			url : 'getImgData.do?searchName='+searchName+'&selectHot=1',
			success : function(data, textStatus) {
			   if(!data.isError){
				   var dataArr = eval( data );
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
  </script>
  <body>
    <div class="group" id="header">
    	<input id="userId" type="hidden" value="${userId}"/>
    	<div style="margin-left:680px;">
    		<div style="height:20px;width:280px;margin-top:10px;margin-left:-540px;color:#fff;">
    			<img style='width:32px;height:32px;' src="lib/plug/ajaxFileUpload/flag.png"/>
    			<div style="margin-top:-28px;margin-left:50px;">${userName}</div>
    			<div id="logout" style="margin-top:-16px;margin-left:240px;color:#fff;">
    				<a href="logins.do">退出</a>
    			</div>
    		</div>
    		<div style="margin-top:-20px;margin-left:-100px;">
    			<input type="text"  style="width:180px;" id="search" name="search"/>
    			<div style="margin-top:-25px;margin-left:190px;"><input type="button" value="查询" onclick="search()"></div>
    		</div>
    		<table style="margin-top:-32px;margin-left:220px;">
    			<tr>
    				<td>
    				 	<a class="reg-btn" id="loginBtn" href="login.do" >登 陆</a>
    				</td>
    				<td>
    					<a class="reg-btn" id="registBtn" href="regist.do" >注 册</a>
    				</td>
    				<td>
    					<a class="reg-btn theme-login" href="javascript:void(0)" id="uploadBtn" >上 传</a>
    				</td>
    				<td>
    					<a class="reg-btn" href="personalCenter.do?userId=${userId}&userName=${userName}" id="personalCenterBtn" target='_blank'>个人中心</a>
    				</td>
    				<td>
    					<a class="reg-btn" href="privilege.do?userId=${userId}&userName=${userName}" id="privilegeBtn" target='_blank'>权限管理</a>
    				</td>
    			</tr>
    		</table>
    	   
    		<!-- 上传弹窗 -->
    		<div style="width:120px;">
				<div class="theme-popover">
					<div class="theme-poptit">
	          			<a href="javascript:;" title="关闭" class="close">×</a>
	          			<span style="font-size:16px;font-weight:bold;margin-left:15px;">上传文件</span>
	     			</div>
	     			<div class="theme-popbod dform">
	     				<div id="startUpload" style="margin-left:25px;">
	     					<img id="loading" src="lib/plug/jquery.lazyload/images/loding.gif" style="display:none;">
	     					<div id="fileNameDIV">名称：<input type="text" id="fileName" style="width:150px;"/></div>
	     					<div id="fileDescDIV">描述：<input id="fileDesc" type="text" style="width:150px;margin-top:5px;"/></div>
	     					<input id="fileToUpload" type="file" size="20" name="fileToUpload" style="margin-top:5px;" accept="image/*"/>
        					<a id="buttonUpload" class="reg-btn" style="margin-top:20px;margin-left:45px;">上 传</a>
	     				</div>
	     				<div id="continueUpload">
	     					<div style='margin-top:30px;margin-left:-10px;'><img src='lib/plug/ajaxFileUpload/success.png' style='margin-top:-10px;'/><div style='margin-top:-40px;margin-left:65px;'>上传成功！</div></div><a style='margin-left:150px;margin-top:-25px;' class='reg-btn' onclick='showUploadForm();'>继续上传</a>
	     				</div>
	     			</div>
				</div>
				<div class="theme-popover-mask" style='filter:alpha(opacity=50);'></div>
			</div>
    	</div>
    </div>
  	
  	<div id="wrapper" style="width:1100px;height:100%;margin:20px auto;">
  		<div>
  			<a id="sortTime" href="javascript:void(0);" onclick="selectTime()" style="margin-left:15px;font-weight:bold;">时间</a>
  			<a id="sortHot" href="javascript:void(0);"  onclick="selectHot()"  style="margin-left:15px;font-weight:bold;">热度</a>
  		</div>
  		<div id="container">
		</div>
  	</div>
  </body>
</html>
