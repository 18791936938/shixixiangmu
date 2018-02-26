<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>权限管理</title>
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

</style>
<script type="text/javascript">
jQuery(document).ready(function($) {
	$("#userContainer").hide();
	$("#closeUser").hide();
	
	$("#fileContainer").hide();
	$("#closeFile").hide();
	
	getUserList();
	getFileList();
});

function openUser(){
	$("#userContainer").show();
	$("#closeUser").show();
	$("#openUser").hide();
}

function closeUser(){
	$("#userContainer").hide();
	$("#closeUser").hide();
	$("#openUser").show();
}

function openFile(){
	$("#fileContainer").show();
	$("#closeFile").show();
	$("#openFile").hide();
}

function closeFile(){
	$("#fileContainer").hide();
	$("#closeFile").hide();
	$("#openFile").show();
}

/*获取用户列表*/
function getUserList(){
	$("#userTable").empty();
	$.ajax({
  		dataType : "json",
		type : "post",
		url : 'getUserList.do',
		success : function(data, textStatus) {
		   if(!data.isError){
			  var tableStr = "<thead style='background:#99ccff;'><tr><th style='padding:5px;'>用户名</th><th>状态</th><th>操作</th></tr></thead><tbody>"; 
			  for(one in data){
				  var userId = data[one]['userId'];
				  var userName = data[one]['userName'];
				  if (userName != "admin"){
					  var status = data[one]['status'];
					  var statusStr = "";
					  var operate = "";
					  if (status == "0"){
						  statusStr = "启用";
						  operate = "<a href='#' onclick='forbidUser(\"" + userId + "\");'>禁用</a>";
					  }else if (status == "1"){
						  statusStr = "禁用";
						  operate = "<a href='#' onclick='activeUser(\"" + userId + "\");'>启用</a>";
					  }
					  tableStr += "<tr><td style='border:1px solid #99ccff;padding:5px;'> " + userName + "</td><td style='border:1px solid #99ccff;'>" + statusStr + "</td><td style='border:1px solid #99ccff;'>" + operate +"</td></tr>";
				  }
			  }
			  tableStr += "</tbody>";
			  $("#userTable").append(tableStr);
		   }else{
			  alert(data.message);
		   }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(errorThrown);
		}
	});
}

/*禁用用户*/
function forbidUser(userId){
	$.ajax({
  		dataType : "json",
		type : "post",
		url : 'forbidUser.do?userId=' + userId,
		success : function(data, textStatus) {
		   if(!data.isError){
			  alert("禁用成功！");
			  getUserList();
		   }else{
			  alert(data.message);
		   }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(errorThrown);
		}
	});
}

/*启用用户*/
function activeUser(userId){
	$.ajax({
  		dataType : "json",
		type : "post",
		url : 'activeUser.do?userId=' + userId,
		success : function(data, textStatus) {
		   if(!data.isError){
			  alert("启用成功！");
			  getUserList();
		   }else{
			  alert(data.message);
		   }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(errorThrown);
		}
	});
}


/*获取文件列表*/
function getFileList(){
	$("#fileTable").empty();
	$.ajax({
  		dataType : "json",
		type : "post",
		url : 'getFileList.do',
		success : function(data, textStatus) {
		   if(!data.isError){
			  var tableStr = "<thead style='background:#99ccff;'><tr><th style='padding:5px;'>文件名</th><th>上传人</th><th>上传时间</th><th>操作</th></tr></thead><tbody>"; 
			  for(one in data){
				  var fileId = data[one]['fileId'];
				  var fileName = data[one]['fileName'];
				  var userName = data[one]['userName'];
				  var uploadTime = data[one]['uploadTime'];
				  var path = data[one]['path'];
				  var operate = "<a href='#' onclick='viewImg(\"" + path + "\");'>查看</a>&nbsp;&nbsp;&nbsp;<a href='#' onclick='deleteFile(\"" + fileId + "\");'>删除</a>";
				  tableStr += "<tr><td style='border:1px solid #99ccff;padding:5px;'> " + fileName + "</td><td style='border:1px solid #99ccff;'>" + userName + "</td><td style='border:1px solid #99ccff;'>" + uploadTime + "</td><td style='border:1px solid #99ccff;'>" + operate +"</td></tr>";
			  }
			  tableStr += "</tbody>";
			  $("#fileTable").append(tableStr);
		   }else{
			  alert(data.message);
		   }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(errorThrown);
		}
	});
}

/*查看文件*/
function viewImg(path){
	window.open ("html/view.html?path=" + path,"查看","height=500,width=700,top=100,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no");
}

/*删除文件*/
function deleteFile(fileId){
	$.ajax({
  		dataType : "json",
		type : "post",
		url : 'deleteFile.do?fileId=' + fileId,
		success : function(data, textStatus) {
		   if(!data.isError){
			  alert("删除成功！");
			  getFileList();
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
    	<div style="margin-left:20px;margin-top:20px;font-weight:bold;">
    		用户管理
    	</div>
    	<div style="margin-top:-28px;margin-left:1020px;">
    		<button id="openUser" type="button" onclick="openUser();">展开</button>
    		<button id="closeUser" type="button" onclick="closeUser();">关闭</button>
    	</div>
    </div>
    <div id="userContainer" style="width:1096px;margin:0 auto;">
    	<table id="userTable" style="width:100%;border-collapse:collapse;text-align:center;">
    	</table>
    </div>
    
    <div style="background-color:#F9D978;height:32px;line-height:32px;width:1100px;margin:0 auto;">
    	<div style="margin-left:20px;margin-top:20px;font-weight:bold;">
    		文件管理
    	</div>
    	<div style="margin-top:-28px;margin-left:1020px;">
    		<button id="openFile" type="button" onclick="openFile();">展开</button>
    		<button id="closeFile" type="button" onclick="closeFile();">关闭</button>
    	</div>
    </div>
    <div id="fileContainer" style="width:1096px;margin:0 auto;">
    	<table id="fileTable" style="width:100%;border-collapse:collapse;text-align:center;">
    	</table>
    </div>
</body>
</html>