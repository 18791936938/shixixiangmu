<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>账号设置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link href="lib/res/ui/css/screen.css?v=3.9" media="screen, projection" rel="stylesheet" type="text/css" >
    <link rel="stylesheet" type="text/css" href="lib/res/ui/css/base.css?v=3.9">
    <link rel="stylesheet" type="text/css" href="lib/res/passport/css/login.css?v=3.9">
  	<script type="text/javascript" src="lib/plug/jquery/jquery-1.11.2.js"></script>
  	
  	
  	<style type="text/css">
  		.main .tab-cons{position:relative;width:400px; font-size:14px; padding:40px 0; z-index:5;}
		.main .tab-cons th{width:100px; padding-right:20px; text-align:right; font-weight:normal; color:#333;}
		.main .tab-cons td{padding:12px 0;}
		.main .tab-cons input{border-radius:3px; width:300px; height:35px; box-sizing:border-box;}             
		.main .tab-cons .tip img{display:none; margin:-7px 8px 0 0;}
		.main .tab-cons .tip{display: block;width:160px; height:50px; color:#666; line-height:24px; padding:0 0 0 125px; margin:0 0 -30px 0;}
		.main .tab-cons .tip-error{background:url(../images/tip-error.png) no-repeat 0 5px;}
		.main .tab-cons .tip-right{background:url(../images/tip-right.png) no-repeat 0 5px;}
		              
		.main .tab-cons .test input:first-child{width:170px; margin-right:5px;}
		.main .tab-cons .test input:last-child{width:151px; font-size:12px;}
		.main .tab-cons .confirm{height:40px; line-height:40px; font-size:16px;font-family: "微软雅黑","黑体","宋体"}
		.main .tab-cons .vd input{width:205px; margin-right:10px;}
	
		#loginTd input{width:120px;border-radius:3px; height:35px; box-sizing:border-box;line-height:35px; font-size:16px;font-family: "微软雅黑","黑体","宋体"}
  	    
  	</style>
  </head>
  
  <script type="text/javascript">
  		/*修改密码*/
		function resetPwd(){
			var currentPwd = $("#currentPwd").val();
			var newPwd = $("#newPwd").val();
			var confirmPwd = $("#confirmPwd").val();
			
			if ("" === currentPwd){
				alert("当前密码不能为空！");
				return false;
			}else if (currentPwd.length<6){
				alert("当前密码长度不能小于6位！");
				return false;
			}
			if ("" === newPwd){
				alert("新密码不能为空！");
				return false;
			}else if (newPwd.length<6){
				alert("新密码长度不能小于6位！");
				return false;
			}
			if ("" === confirmPwd){
				alert("确认密码不能为空！");
				return false;
			}else if (confirmPwd.length<6){
				alert("确认密码长度不能小于6位！");
				return false;
			}
			
			if (newPwd != confirmPwd){
				alert("新密码和确认密码不一致！");
				return false;
			}
			
			$.ajax({
		  		dataType : "json",
				type : "post",
				url : 'editAccount.do',
				data : {currentPwd:currentPwd,newPwd:newPwd,confirmPwd:confirmPwd},
				success : function(data, textStatus) {
				   if(!data.isError){
					alert(data.message);
				   	if("10000" === data.status){				   		
					   window.location = 'logout.do';
				   	}
				   }else{
					   alert(data.message);
				   }
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert(errorThrown);
				}
		 	});
		}
		
		function resetPwd1(){
			var nickName = $("#nickName").val();
			var sex = $("input[name=sex]:checked").val();
			var hobby = $("#hobby").val();
			var occupation = $("#occupation").val();
			
			if ("" === nickName){
				alert("昵称不能为空！");
				return false;
			}
			
			if ("" === hobby){
				alert("爱好不能为空！");
				return false;
			}
			if ("" === occupation){
				alert("职业不能为空！");
				return false;
			}
			
			var birthday = ($("#year").val()?$("#year").val().toString():"") 
						 + ($("#month").val()?$("#month").val().toString():"")
						 + ($("#day").val()?$("#day").val().toString():"");
			
			
			$.ajax({
		  		dataType : "json",
				type : "post",
				url : 'editPersonalInfo.do',
				data : {nickName:nickName,hobby:hobby,occupation:occupation,sex:sex,birthday:birthday},
				success : function(data, textStatus) {
				   if(!data.isError){
					alert(data.message);
				   	if("10000" === data.status){				   		
					   window.location = 'personalCenter.do?userId='+data.data.userId+'&userName='+data.data.userName;
				   	}
				   }else{
					   alert(data.message);
				   }
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert(errorThrown);
				}
		 	});
		}
		
		
		function cancel(){
			window.location='viewAccount.do';		
			}
  </script>
  
  <body style="background-image:url('image/p21.jpg')">
     <div style="height: 80px;width: 100%;margin-bottom: 100px;">
        </div>
        <div class="logina-main main clearfix" style="margin-top:100px;margin-right:100px;width:700px;height:1000px;">
            <div class="tab-cons" style="margin: 0px auto;">
            <th style="color: #00baff"><img src="image/p71.jpg" width="50px" height="50px"/>个人资料</th>
            <hr style=" width:110%; display:inline-block" />
                    	<table border="0" cellspacing="0" cellpadding="0">
                        <tbody >
                            <tr>
                                <td><img src="image/p9.jpg" width="50px" height="50px"/>昵称</td>
                                <td width="245">
                                    <input id="nickName" name="nickName" placeholder="请输入昵称" type="text" autocomplete="off" value="${request.user}">
                                </td>
                            </tr>
                            <tr>
                                <td><img src="image/p9.jpg" width="50px" height="50px"/>性别</td>
                                <td width="245" style="text-align: left;">
                                	<label>
                                    	<input type="radio" name="sex" value="男" checked="checked" style="width: 15px;">男
                                    </label>
                                    <label>
                                		<input type="radio" name="sex" value="女" style="width: 15px;">女
                                	</label>
                                </td>
                            </tr>
                            <tr>
                                <td width="25%"><img src="image/p9.jpg" width="50px" height="50px"/>生日</td>
                                <td width="75%">
                                    <input id="year"  name="year" type="text" placeholder="年" style="width: 60px;" maxlength="4" autocomplete="off" value="${birthday}">
                                    <input id="month"  name="month" type="text" placeholder="月" style="width: 30px;margin-left: 5px;" maxlength="2" autocomplete="off" value="${birthday}">
                                    <input id="day"  name="day" type="text" placeholder="日" style="width: 30px;margin-left: 5px;" maxlength="2" autocomplete="off" value="${birthday}">
                                    <span style="color: #999;margin-left: 5px;">(该信息其他人不可修改)</span>
                                </td>
                            </tr>
                            
                            <tr>
                                <td width="25%"><img src="image/p9.jpg" width="50px" height="50px"/>爱好</td>
                                <td width="75%">
                                    <input id="hobby"  name="hobby" type="text" placeholder="请输入爱好" autocomplete="off" value="${hobby}">
                                </td>
                            </tr>
                            <tr>
                                <td width="25%"><img src="image/p9.jpg" width="50px" height="50px"/>职业</td>
                                <td width="75%">
                                    <input id="occupation" type="text" name="confirmPwd" placeholder="请输入职业" autocomplete="off" value="${occupation}">
                                </td>
                            </tr>
                            <tr>
                                <td width="245" colspan="3" style="text-align: right;" id="loginTd">
                                	<input id="resetPwdId1" class="confirm" type="button" value="保  存" onclick="resetPwd1();">
                                	<input class="confirm" type="button" value="取  消" onclick="cancel();">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div id='login-error' class="error-tip"></div>
                    	<th><img src="image/p71.jpg" width="50px" height="50px"/>密码设置</th>
            			<hr style=" width:110%; display:inline-block" />
                    	<table border="0" cellspacing="0" cellpadding="0" style="height:236px;width:400px;">
                        <tbody>
                            <tr>
                                <th><img src="image/p01.png" width="20px" height="20px"/>当前密码</th>
                                <td width="245">
                                    <input id="currentPwd" type="password" name="currentPwd" placeholder="请输入当前密码" autocomplete="off" value=""></td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <th><img src="image/p01.png" width="30px" height="30px"/>新密码</th>
                                <td width="245">
                                    <input id="newPwd" type="password" name="newPwd" placeholder="请输入新密码" autocomplete="off" value="">
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <th><img src="image/p01.png" width="20px" height="20px"/>确认密码</th>
                                <td width="245">
                                    <input id="confirmPwd" type="password" name="confirmPwd" placeholder="请输入确认密码" autocomplete="off" value="">
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td width="245" colspan="3" style="text-align: right;" id="loginTd">
                                	<input id="resetPwdId" class="confirm" type="button" value="保  存" onclick="resetPwd();">
                                	<input class="confirm" type="button" value="取  消" onclick="cancel();">
                                </td>
                            </tr>
                        </tbody>
                    </table>       
               </div>
               
         </div>
         
  </body>
</html>
