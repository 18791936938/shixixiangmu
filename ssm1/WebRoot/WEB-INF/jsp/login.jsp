<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>登陆</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link href="lib/res/ui/css/screen.css?v=3.9" media="screen, projection" rel="stylesheet" type="text/css" >
    <link rel="stylesheet" type="text/css" href="lib/res/ui/css/base.css?v=3.9">
    <link rel="stylesheet" type="text/css" href="lib/res/passport/css/login.css?v=3.9">
  	<script type="text/javascript" src="lib/plug/jquery/jquery-1.11.2.js"></script>
  	
  </head>
  
  <script type="text/javascript">
  		/*用户登陆*/
  		var code;
  		function createCode() {
  			code = "";
  			var codeLength = 4; //验证码的长度
  			var checkCode = document.getElementById("checkCode");
  			var codeChars = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
  			 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
  			 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //所有候选组成验证码的字符，当然也可以用中文的
  			for (var i = 0; i < codeLength; i++) 
  			{
  			    var charNum = Math.floor(Math.random() * 52);
  			    code += codeChars[charNum];
  			}
  			if (checkCode) 
  			{
  			    checkCode.className = "code";
  			    checkCode.innerHTML = code;
  			}
  		}
  		function validateCode(){
  			var inputCode = document.getElementById("inputCode").value;
  			
  			if (inputCode.length <= 0) 
  			{
  			    alert("请输入验证码！");
  			    return false;
  			}
  			if (inputCode != code) 
  			 {
  			     alert("验证码输入有误！");
  			     return false;
  			 }
  			             
  		   } 
		function goLogin(){
			var username = $("#username").val();
			var password = $("#password").val();
			var inputCode = $("#inputCode").val();
			if (username == "" && password != ""){
				alert("账户不能为空！");
				return false;
			}
			if (password == "" && username != ""){
				alert("密码不能为空！");
				return false;
			}
			if (password == "" && username == ""){
				alert("请输入登陆信息！");
				return false;
			}
			if (inputCode == "") 
  			{
  			    alert("请输入验证码！");
  			    return false;
  			}
			
			$.ajax({
		  		dataType : "json",
				type : "post",
				url : 'goLogin.do',
				data : {username:username,password:password},
				success : function(data, textStatus) {
				   if(!data.isError){
					   window.location = "index.do?username=" + username;
				   }else{
					   alert(data.message);
				   }
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert(errorThrown);
				}
		 	});
		} 
		window.onload=createCode;
  </script>
  <style type="text/css">
     body{
	    /* background:#F98A53; */
	    background:url("image/wind.gif");
        } 
     #denglu {
          background:url("image/bg.jpg");
          opacity:0.6;
          filter:alpha(opacity=60); /* 针对 IE8 以及更早的版本 */
      }
      #denglu:hover {
          opacity:1.0;
          filter:alpha(opacity=100); /* 针对 IE8 以及更早的版本 */
      } 
      
     #inputCode{
         width:100px;
         float:left;
         }
     #images{
        float:left;
        }
     .code {
          !important;
          background:url("image/code_bg.jpg");
          float:left;
          /* width:250px; */
          font:italic bolder 25px arial; 
          text-align:center; 
          letter-spacing:3px;
          vertical-align:middle;
     } 
      p {color:#FF4500;}
  </style>
  
  <body>
    <div class="logina-logo" style="height: 45px"><img src="image/cam.png" class="img-responsive" alt=""/></div>
        <div id="denglu" class="logina-main main clearfix" style="height:400px; padding:0;" >
            <div class="tab-con" id="logina-main" style="height:300px;width:500px;">
                    <div id='login-error' class="error-tip"></div>
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody>
                            <tr>
                                <th>账户</th>
                                <td width="245">
                                    <input id="username" type="text" name="username" placeholder="请输入账户" autocomplete="off" value=""></td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <th>密码</th>
                                <td width="245">
                                    <input id="password" type="password" name="password" placeholder="请输入密码" autocomplete="off">
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <th>验证码</th>
                                <td>
                                    <div id="yanzheng" class="fm-item pos-r">
	                                   <input type="text" value="" maxlength="110" id="inputCode" class="i-text yzm" placeholder="请输入验证码！" onblur="validateCode()"> 
	                                   
	                                   <div class="code" id="checkCode" style="height:30px;width:94px;border:0;padding:2px 3px;" onclick="createCode()" ></div>                                         
                                    </div>
                                
                                </td>
                            </tr>
                            <tr class="find" style="color:red;">
                                <th></th>
                                <td>
                                    <div>
                                        <label class="checkbox" for="chk11"><input style="height: auto;" id="chk11" type="checkbox" name="remember_me" >记住我</label>
                                        <a href="passport/forget-pwd"  style="color:red;">忘记密码？</a>
                                    </div>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <th></th>
                                <td width="245"><input id="loginBtn" class="confirm" type="button" value="登  录" onclick="goLogin();"></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
            </div>
            <div class="reg" style="height:300px;width:240px;">
                <p>还没有账号？<br>赶快免费注册一个吧！</p>
                <a class="reg-btn" href="regist.do">立即免费注册</a>
            </div>
        </div> 
  </body>
</html>
