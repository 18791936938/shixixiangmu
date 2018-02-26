<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();

String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>注册</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="lib/plug/jquery/jquery-1.11.2.js"></script>
  	<script type="text/javascript" src="lib/plug/jquery//jquery-1.8.3.min.js"></script>
  </head>
   
   <script type="text/javascript">
   function enableSubmit(bool){
       if(bool)$("#submit").removeAttr("disabled");
       else $("#submit").attr("disabled","disabled");
       }
     function v_submitbutton(){
       if($("#agree").attr("checked")!="checked") {
         enableSubmit(false);
         $(".readagreement-wrap").css("outline","1px solid #f99");
         return;
         }else{$(".readagreement-wrap").css("outline","1px solid #9f9");}
       for(f in flags) if(!flags[f]) {enableSubmit(false); return;}
       enableSubmit(true);
       }
     function onReadAgreementClick(){
       return;
       if($("#agree").attr("checked")){
         $("#agree").removeAttr("checked");
         }else{
            $("#agree").attr("checked","checked");
            }
       v_submitbutton();
       }
     var flags = [false,false,false,false];
     //邮箱验证，网上找到的正则
     var RegEmail = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
     function lineState(name,state,msg){
       if(state=="none"){$("#line_"+name+" .input div").attr("class","none"); return;}
       if(state=="corect"){$("#line_"+name+" .input div").attr("class","corect");return;}
       $("#line_"+name+" .input span").text(msg);$("#line_"+name+" .input div").attr("class","error");
       }
     function v_useremail(){
       var useremail = $("#useremail").val();
       if(!RegEmail.test(useremail)) {lineState("useremail","error","邮箱格式不正确"); flags[0]=false;enableSubmit(false);}
        else{lineState("useremail","corect","");flags[0] = true;}
       v_submitbutton();
       }
     function v_repeat(){
       if(!flags[2]) {lineState("repeat","none",""); return;}
       if($("#password").val()!=$("#repeat").val()) {lineState("repeat","error","密码不一致"); flags[3]=false;}
        else{
          lineState("repeat","corect","");
          flags[3] = true;
          }
        v_submitbutton();
        }
      function v_username(){
          var username = $("#username").val();
          if(username.length==0) {lineState("username","error","不得为空"); flags[1]=false;}
           else{
             if(username.length>32) {lineState("username","error","必须少于32个字符"); flags[1]=false;}
               else{lineState("username","corect",""); flags[1] = true;}
             }
          v_submitbutton();
          }
        function v_password(){
          var username = $("#username").val();
          var password = $("#password").val();
          if(password.length<6) {lineState("password","error","必须多于或等于6个字符"); flags[2]=false;}
           else{
            if(password.length>16){lineState("password","error","必须少于或等于16个字符"); flags[2]=false;}
             else{
               lineState("password","corect","");
               flags[2] = true;
               }if (username == password ){
				alert("密码不能和用户名相同！");
				return false;
			 }
            }
          v_repeat();
          v_submitbutton();
          }
        function goRegist(){
        	    var username = $("#username").val();
				var password = $("#password").val();
				var useremail = $("#useremail").val();
				$.ajax({
			  		dataType : "json",
					type : "post",
					url : 'goRegist.do',
					data : {username:username,password:password,useremail:useremail},
					success : function(data, textStatus) {
					   if(!data.isError){
						   alert("注册成功！请登录！");
						   window.location = "login.do";
					   }else{
						   alert(data.message);
					   }
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						alert(errorThrown);
					}
			 	});
			}
        function open_win(){
            if($("#agree").attr("checked")!="checked") $("#agree").trigger("click");
            window.open("manual.do","_blank","width=400, height=400")
        }
   </script>
   
   <style type="text/css">
      * { font-family:"微软雅黑","黑体","宋体";}
      body {background:url("image/rain1.gif");}
      #zhuce {
          opacity:0.6;
          filter:alpha(opacity=60); 
      }
      #zhuce:hover {
          opacity:1.0;
          filter:alpha(opacity=100); /* 针对 IE8 以及更早的版本 */
      }
      #top h1 {font-size:40px; line-height:40px; padding:20px; text-align:center; color:#333}
     .form-bak {width:800px; height:400px; margin:40px auto; background:#eee; border-radius:10px; box-shadow:0 2px 8px #999;}
     
     .left {float:left; width:500px; height:400px;}
     .line {width:100%; height:80px; margin:16px 0 0 0;}
     .info {float:left; height:100%; width:200px;}
     .info strong, .info span {display:block; text-align:right;}
     .info strong {font-size:24px; line-height:36px; margin-top:10px; color:#333; }
     .info span {font-size:12px; line-height:24px; color:#666;}
     .input input {background:none; border:none; outline:none; font-size:18px; line-height:40px; height:60px; width:260px; padding:9px 0 9px 9px; border-radius:10px;}
     .input {float:right; width:278px; height:58px; background:#f6f6f6; border:1px solid #999; border-radius:10px; box-shadow:inset 0 2px 5px #999; margin:10px 0; position:relative; }
     .error,.corect {height:20px; width:20px; position:absolute; top:19px; right:9px; background:url("js/ICON_20.svg") no-repeat 0 -20px;}
     .error span {display:block; position:absolute; top:30px; right:20px; background:#fcc; border:1px solid #f33; font-size:12px; line-height:16px; color:#600; padding:6px 10px 4px 10px; border-radius:5px; opacity:.8; white-space:nowrap; overflow:hidden;}
     .corect {background-position:0 0;}
     .corect span{display:none;}
     .none {display:none;}

     .right {float:right; width:260px; height:360px; margin:20px 0 0 0; border-left:1px solid #ccc;}
     input[type=submit] {background:none; border:none; outline:none; margin:0; padding:0; cursor:pointer;
                         font-size:40px; height:200px; width:200px; background:#369; margin:20px 30px 0 30px; color:#eee;}
     input[type=submit]:disabled {background:#999; cursor:no-drop;}
     .right div { margin:0 30px; width:200px; height:30px; line-height:30px; text-align:center;}
     .readagreement-wrap {margin:20px 30px!important; outline:1px solid #f99;}
   </style>
  
  <body>
    <div class="logina-main main clearfix" style="height:500px; width:860px; margin:10px auto;">
      <div class="tab-con" style="height:500px; width:850px;">
        <div id="top"><h1>用户注册</h1></div>
        <div class="form-bak" id="zhuce">
            <div class="left">
              <div class="line" id="line_username">
                <div class="info">
                  <strong>用户名</strong>
                  <span class="tips">只能由数字、文字或下划线组成<br />最多32个字符</span>
                </div>
                <div class="input">
                  <input type="text" name="username" id="username" placeholder="请输入账户" onblur="v_username();" onkeyup="v_username();" />
                  <div class="none">
                   <span></span>
                  </div>
               </div>
             </div>
             <div class="line" id="line_password">
               <div class="info">
                 <strong>密码</strong>
                 <span class="tips">6至16个字符<br />可由英文、数字及标点符号组成</span>
               </div>
               <div class="input">
                 <input type="password" name="password" id="password" placeholder="请输入密码" onblur="v_password();" onkeyup="v_password();" />
                 <div class="none">
                   <span></span>
                 </div>
               </div>
             </div>
             <div class="line" id="line_repeat">
               <div class="info">
                 <strong>确认密码</strong>
                 <span class="tips">再次输入密码</span>
               </div>
               <div class="input">
                 <input type="password" name="repeat" id="repeat" placeholder="请再次输入密码" onblur="v_repeat();" onkeyup="v_repeat();" />
                 <div class="none">
                   <span></span>
                 </div>
               </div>
             </div>
             <div class="line" id="line_useremail">
                <div class="info">
                  <strong>邮箱</strong>
                  <span class="tips">请输入常用的邮箱<br />用来找回密码、接受订单通知等</span>
                </div>
                <div class="input">
                  <input type="text" name="useremail" id="useremail" placeholder="请输入邮箱" onblur="v_useremail();" onkeyup="v_useremail();"/>
                  <div class="none">
                   <span></span>
                  </div>
                </div>
              </div>
          </div>
          <div class="right">
            <input type="submit" id="submit" value="注册" disabled="disabled" onclick="goRegist();"/>
            <div class="readagreement-wrap" onclick="onReadAgreementClick();">
              <input type="checkbox" name="agree" id="agree" onchange="v_submitbutton();"/>
              <input type="button" id="readagreement" value="同意《用户使用协议》" onclick="open_win()"/>
                                     
            </div>
            <div>已经拥有账号，<a href="login.do">直接登录</a></div>
          </div>
      </div>
    </div>
  </div>
       
 </body>
</html>