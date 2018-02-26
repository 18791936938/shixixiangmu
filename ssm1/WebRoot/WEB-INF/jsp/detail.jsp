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
  	<script type="text/javascript" src="lib/plug/jquery/jquery-1.3.2.min.js"></script>
  </head>
  <style type="text/css">
     body
     { 
        background-image:url('image/8.jpg');
        background-repeat:no-repeat;
        
     }
     
  	.group{
  		position:relative;
  		border:1px solid #4cae4c;
  		background-color:#4cae4c;
  		height:45px;
  		margin-top:-8px;
  		margin-left:-8px;
  		margin-right:-8px;
  	}
  	
  	.moreImg{
  		width:22%;
  		height:90%;
  		margin-left:10px;
  		margin-top:6px;
  		margin-bottom:6px;
  	}
  </style>
  <script type="text/javascript">
  var file = "${file}";
  var userId = "${file.userId}";
  var fileId = "${file.fileId}";
  getMoreImg();
  function getMoreImg(){
	  $.ajax({
	  		dataType : "json",
			type : "post",
			url : 'getMoreImg.do',
			data: {userId:userId,fileId:fileId},
			success : function(data, textStatus) {
			   if(!data.isError){
				   var dataArr = eval( data );
				   geneMoreImg(dataArr);
			   }else{
				   alert(data.message);
			   }
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(errorThrown);
			}
	 	});
  }
  
  /*获取统一作者的其他资源*/
  function geneMoreImg(data){
	  $("#moreImgDIV").empty();
	  for(one in data){
		  var obj = data[one];
		  var path = obj['path'];
		  $("#moreImgDIV").append("<img class='moreImg' src='" + path + "'/>");
	  }
	  getHistoryComment();
  }
  
  /*对资源进行评论*/
  function commentFile(){
	  var loginUserId = $("#loginUserId").val();
	  var text = $("#comment").val();
	  $.ajax({
	  		dataType : "json",
			type : "post",
			url : 'addComment.do',
			data: {userId:loginUserId,fileId:fileId,text:text},
			success : function(data, textStatus) {
				 if(!data.isError){
					 alert("评论成功!"); 
					 $("#comment").val("");
					 getHistoryComment();
				 }else{
					 alert(data.message);
				 }
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(errorThrown);
			}
	 	});
  }
  
  /*获取历史评论记录*/
  function getHistoryComment(){
	  $.ajax({
	  		dataType : "json",
			type : "post",
			url : 'queryHistoryComment.do',
			data: {fileId:fileId},
			success : function(data, textStatus) {
				 if(!data.isError){
					 geneHistoryCommentView(data);
				 }else{
					 alert(data.message);
				 }
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(errorThrown);
			}
	 });
  }
  
  /*历史评论列表*/
  function geneHistoryCommentView(data){
	  $("#commentHistory").empty();
	  for(one in data){
		  var obj = data[one];
		  var userName = obj['userName'];
		  var text = obj['text'];
		  var date = formartDate(obj['date'],'yyyy-MM-dd HH:mm:ss');
		  $("#commentHistory").append("<div style='width:99%;border-top:1px solid #ccc;'><div style='font-weight:bold;margin-top:5px;color:#0066cc;'>" + userName + "</div><div style='margin-left:260px;margin-top:-19px;color:#708090;'>" + date + "</div><p>" + text + "</p></div><br/>");
	  }
  }
  
  function formartDate(time,format){
		var t = new Date(time);     
		var tf = function(i){
			return (i < 10 ? '0' : '') + i;
		};     
		return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a){         
			switch(a){             
				case 'yyyy':                 
					return tf(t.getFullYear());                 
					break;             
				case 'MM':                 
					return tf(t.getMonth() + 1);                 
					break;             
				case 'mm':                 
					return tf(t.getMinutes());                 
					break;             
				case 'dd':                 
					return tf(t.getDate());                 
					break;             
				case 'HH':                 
					return tf(t.getHours());                 
					break;             
				case 'ss':                 
					return tf(t.getSeconds());                 
					break;         
			}     
		}); 
  }
  function like(){
  	 var loginUserId = $("#loginUserId").val();
  	 if(loginUserId==''){
  	 	alert("请先登录");
  	 	window.location.href='logins.do';
  	 }else{
		  $.ajax({
		  		dataType : "json",
				type : "post",
				url : 'addLike.do',
				data: {fileId:fileId},
				success : function(data) {
					if(data.isError){
						alert('该用户已收藏！');
					}else{						
					 alert(data.message); 
					 $("#collectTimesId").text(data.data.toString());
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					window.location.href=window.location.href; 
				}
		 	}); 
	 	}
  }
  
   function goBack(){
   		window.location.href="index.do?username="+"${userName}";
   }
  </script>
  
  
  <body>
  <div class="group" id="header">
	  	<input type="hidden" id="loginUserId" value="${loginUserId}"/>
	  	<div style="margin-left:680px;">
    		<div style="height:20px;width:120px;margin-top:10px;margin-left:-540px;color:#fff;"><img style='width:32px;height:32px;' src="lib/plug/ajaxFileUpload/flag.png"/><div style="margin-top:-28px;margin-left:50px;">${userName}</div>
    	</div>
    	<div id="logout" style="margin-top:-16px;margin-left:120px;color:#fff;">
    				<a href="javascript:goBack()">返回</a>
    			</div>
	  </div>
  	<div id="wrapper" style="width:1100px;height:100%;margin:20px auto;">
  		<table id="container" style="width:1100px;height:100%">
  			<tr>
  				<td>
  					文件名称：<label style="font-size:14px;font-weight:bold;">${file.fileName}</label> 
  					<div>by <a href="javascript:void(0);" style="font-style:italic;">${userName}</a> ${uploadTime }   
	  					<div style="margin-left:450px;margin-top:-33px;">
	  						<a class="reg-btn" href="download.do?fileId=${file.fileId}">下 载</a>
	  					</div>
  					</div>
  				</td>
  			</tr>
  			<tr>
  				<td>
  					<div style="float: left;">
	  					<div style="width:550px;border:1px solid #ccc;">
	  						<img style="padding:10px;width:96%;" src="${file.downloadLink }"/>
	  					</div>
	  					<div style="margin-top:20px;">
	  						更多 <a href="javascript:void(0);">${userName}</a> 的文件
	  					</div>
	  					<div id="moreImgDIV" style="width:550px;height:100px;border:1px solid #ccc;">
	  					</div>
  					</div>
  					<div style="width:515px;float: right;">
	  					<div style="height:50px;margin-left:43px;">
	  						<a href="javascript:void(0)" onclick="like()"><img alt="收藏" src="lib/img/like.png" style="width:28px;height:28px;margin-left:10px;"><span id="collectTimesId">${file.collectTimes}</span></a>
	  						<a><img alt="浏览" src="lib/img/view.png" style="width:35px;height:28px;margin-top:-25px;">${file.viewTimes }人浏览</a>
							<span class="jiathis_style_32x32">
							    <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>
							    <a class="jiathis_counter_style"></a>
							</span>
							<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=1348112174875283" charset="utf-8"></script>
	  					</div>
	  					<div style="margin-left:33px;margin-top:-10px;">
	  						<textarea rows="4" cols="56" id="comment"></textarea>
	  						<div style="margin-top:10px;"><a class="reg-btn" style="margin-left:370px;" onclick="commentFile();">评 论</a></div>
	  						<div id="commentHistory" style="width:475px;height:350px;margin-top:15px;overflow-y:auto;">
	  						</div>
	  					</div>
  					</div>
  				</td>
  			</tr>
		</table>
  	</div>
  </body>
</html>