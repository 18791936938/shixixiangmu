<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <script type="text/javascript">
  function CloseWin(){
	  window.opener=null;        
	  window.open('','_self');       
	  window.close();         
      } 
   </script>
  <style type="text/css">
      * { font-family:"微软雅黑","黑体","宋体";}
      h1 {display:block; font-size:24px; line-height:30px; padding:20px 20px 10px 20px; margin:0; color:#333; text-align:center;}
      h3 {display:block; padding:0; margin:0; color:#333; text-align:center;}
      .backtotop {display:block; line-height:20px; padding:5px; margin:auto; text-align:center;} 
   </style>
  
   <body>
        
     <div class="container-fluid">
		<div class="row">
			<div class="col-md-offset-2 col-md-8 col-xs-offset-1 col-xs-10">
				<div class="row">
					<h1 class="text-center padding-2x"><strong>《用户协议》</strong></h1>
					<p>在您接受网站服务之前，请务必仔细阅读本条款并同意本协议。</p>
					<p>用户直接或通过各类方式（如站外引用等）间接使用本网站服务和数据的行为，都将被视作已无条件接受本协议所涉全部内容；若用户对本协议的任何条款有异议，请停止使用本网站所提供的全部服务。</p>
					
					<h3><strong>第一条</strong></h3>
					<p>
						用户以各种方式使用本网站服务和数据（包括但不限于发表、宣传介绍、转载、浏览及利用本网站内容或本网站用户发布内容）的过程中，必须遵循以下原则：
					</p>
					<p>1. 遵守中华人民共和国相关的法律和法规, 包括但不仅限于《中华人民共和国著作权法》 ，《全国人大常委会关于维护互联网安全的决定》 ；</p>
					<p>2. 不得以任何方式利用本网站直接或间接从事违反中国法律、以及社会公德的行为；</p>
					<p>3. 不得干扰、损害和侵犯本网站的各种合法权利与利益；</p>
					<p>4. 不得利用本网站进行任何可能对互联网的正常运转造成不利影响的行为；</p>
					<p>5. 不得违反本网站以及与之相关的网络服务的协议、指导原则、管理细则等；</p>
					<p>对于违反上述原则的用户，本网站有权采取一切必要手段制止该等违反要求的行为，包括但不限于对违规内容予以删除、对用户限制访问、取消注册等。</p>
					
					<h3><strong>第二条</strong></h3>
					<p>1. 本网站仅为用户发布的内容提供存储空间，本网站不对用户发表、转载的内容提供任何形式的保证：不保证内容满足您的要求，不保证本网站的服务不会中断。因网络状况、通讯线路、第三方网站或管理部门的要求等任何原因而导致您不能正常使用本网站，本网站不承担任何法律责任。</p>
					<p>2. 用户在本网站发表的内容（包含但不限于本网站目前各产品功能里的内容）仅表明其个人的立场和观点，并不代表本网站的立场或观点。</p>
					<p>3. 本网站的用户，在本网站的各个产品内作为内容的发表者，需自行对所发表内容负责，因所发表内容引发的一切纠纷，由该内容的发表者承担全部法律及连带责任。本网站不承担任何法律及连带责任。</p>
					<p>4. 用户在本网站发布侵犯他人知识产权或其他合法权益的内容，本网站有权予以删除，并保留移交司法机关处理的权利。</p>
					<p>5. 在本网站出现的所有内容，包括但不限于文字、照片、图形、图表和美术作品、视频、音乐和声音、名称、图标、商标和服务标志，均为本网站及其关联方、内容提供者、许可方所有的财产，受版权、商标和其他法律保护。未经本网站及其关联方、内容提供者、许可方的书面允许，任何人不得修改、复制、转载、散发、散布、出售、发表、广播或传播本网站的任何内容。</p>
					<p>6. 本网站及其关联方未阅览或监视链接到本网站的任何网站，因此对任何该等链接网站的内容不承担责任。您访问该等网站需自行承担风险。</p>
					<p>7. 个人或单位如认为本网站上存在侵犯自身合法权益的内容，应准备好具有法律效应的证明材料，及时与本网站取得联系，以便本网站迅速做出处理。</p>

					<h3><strong>第三条</strong></h3>
					<p>1. 用户注册本账号，制作、发布、传播信息内容的，应当使用真实身份信息及个人资料，不得以虚假、冒用的居民身份信息、企业注册信息、组织机构代码信息进行注册；若用户的个人资料有任何变动，用户应及时更新。</p>
					<p>2. 用户可自行编辑注册信息中的账号名称、头像、简介等，但应遵守“七条底线”以及相关管理规定，不得含有违法和不良信息。</p>
					<p>3. 如用户违反前述约定，依据相关法律、法规及国家政策要求，乐自天成公司有权随时采取不予注册、通知限期改正、注销登记用户账号、中止或终止用户对本服务的使用等措施。如果用户冒用、关联机构或社会名人注册账号名称，乐自天成公司有权注销用户该账号，并向互联网信息内容主管部门报告。</p>
					<p>4. 用户可自行编辑注册信息中的账号名称、头像、简介等，但应遵守“七条底线”以及相关管理规定，不得含有违法和不良信息。</p>
					<p>5. 由于本服务的存在前提是用户在申请开通本服务的过程中所提供的帐号，则用户不应将其帐号、密码转让或出借予他人使用。如用户发现其帐号或本服务遭他人非法使用，应立即通知乐自天成公司。因黑客行为或用户的保管疏忽导致帐号、密码及本服务遭他人非法使用，乐自天成公司有权拒绝承担任何责任。</p>
					<p>6. 用户同意乐自天成公司在提供本服务过程中以各种方式投放各种商业性广告或其他任何类型的商业信息（包括但不限于在乐自天成公司网站的任何页面上投放广告），并且，用户同意接受乐自天成公司通过电子邮件或其他方式向用户发送商品促销或其他相关商业信息。</p>
					<p>7. 用户知悉、理解并同意授权乐自天成公司及其关联公司可非独家、可转授权地使用用户通过本发布的内容，前述内容包括但不限于文字、图片、视频等。具体来说，可能会包括：</p>
					<p>7.1 将前述内容通过本自身或其他第三方技术、网络等在乐自天成公司选择的网络平台、应用程序或产品中，以有线或无线网，通过免费或收费的方式在不同终端（包括但不限于电脑、手机、互联网电视、机顶盒及其他上网设备等）以不同形式（包括但不限于点播、直播、下载等）进行网络传播或电信增值服务等；</p>
					<p>7.2 将前述内容复制、翻译、编入乐自天成公司当前已知或以后开发的作品、媒体或技术中，用于本相关用途开发或推广宣传等；</p>
					<p>7.3 将前述内容授权给电台、电视台、网络媒体、运营商平台等与乐自天成公司有合作的媒体或运营商播放、传播，用于本相关推广宣传等；</p>
					<p>7.4 其他乐自天成公司及其关联公司出于善意或另行取得您授权的使用行为；</p>
					<p>7.5 用户对乐自天成公司及其关联公司的前述授权并不改变用户发布内容的所有权及知识产权归属，也并不影响用户行使其对发布内容的合法权利；</p>
					<p>7.6 乐自天成公司将尽最大的商业努力合理使用用户的授权内容，但并不代表乐自天成公司及其关联公司承诺一定会使用。</p>
					<p>8. 用户在使用本服务的过程中应文明发言，并依法尊重其它用户的人格权与身份权等人身权利，共同建立和谐、文明、礼貌的网络社交环境。</p>
					<p>9. 用户在使用本服务过程中，必须遵循以下原则：</p>
					<p>9.1 不得违反中华人民共和国法律法规及相关国际条约或规则；</p>
					<p>9.2 不得违反与网络服务、本服务有关的网络协议、规定、程序及行业规则；</p>
					<p>9.3 不得违反法律法规、社会主义制度、国家利益、公民合法权益、公共秩序、社会道德风尚和信息真实性等“七条底线”要求；</p>
					<p>9.4 不得进行任何可能对互联网或移动网正常运转造成不利影响的行为；</p>
					<p>9.5 不得上传、展示或传播任何不实虚假、冒充性的、骚扰性的、中伤性的、攻击性的、辱骂性的、恐吓性的、种族歧视性的、诽谤诋毁、泄露隐私、成人情色、恶意抄袭的或其他任何非法的信息资料；</p>
					<p>9.6 不得以任何方式侵犯其他任何人依法享有的专利权、著作权、商标权等知识产权，或姓名权、名称权、名誉权、荣誉权、肖像权、隐私权等人身权益，或其他任何合法权益；</p>
					<p>9.7 不得以任何形式侵犯新浪或乐自天成公司的权利和/或利益或作出任何不利于新浪或本公司的行为；</p>
					<p>9.8 不得从事其他任何影响本平台正常运营、破坏本平台经营模式或其他有害本平台生态的行为。</p>
					<p>9.9 不得为其他任何非法目的而使用本服务。</p>
					<p>10 乐自天成公司针对某些特定的本服务的使用通过各种方式（包括但不限于网页公告、系统通知、私信、短信提醒等）作出的任何声明、通知、警示等内容视为本协议的一部分，用户如使用该等本服务，视为用户同意该等声明、通知、警示的内容。</p>
					<p>11 乐自天成公司有权对用户使用本服务的行为及信息进行审查、监督及处理，包括但不限于用户信息（账号信息、个人信息等）、发布内容（位置、文字、图片、音频、视频、商标、专利、出版物等）、用户行为（构建关系、@信息、评论、私信、参与话题、参与活动、营销信息发布、举报投诉等）等范畴。如乐自天成公司发现、或收到第三方举报或投诉用户在使用本服务时违反本协议第四条使用规则相关规定，乐自天成公司或其授权的主体有权依据其合理判断要求用户：
					</p><p>a. 限期改正;</p>
					<p>b. 不经通知直接采取一切必要措施以减轻或消除用户不当行为造成的影响，并将尽可能在处理之后对用户进行通知。上述必要措施包括但不限于更改、屏蔽或删除相关内容，警告违规账号，限制或禁止违规账号部分或全部功能，暂停、终止、注销用户使用本服务的权利等。</p>
					<p>12 如用户在使用本服务的过程中遇到其它用户上传违法侵权等内容，可直接点击"举报"按键进行举报，相关人员会尽快核实并进行处理；&nbsp;如涉及姓名权、名称权、名誉权、荣誉权、肖像权、隐私权等人身权益纠纷的处理，根据《最高人民法院关于审理利用信息网络侵害人身权益民事纠纷案件适用法律若干问题的规定》，请参照站方有关公告所公示的方式进行处理；&nbsp;如用户认为上述方法无法解决遇到的问题、或用户觉得有必要向司法行政机关寻求帮助的，请用户尽快向相关机关反馈，乐自天成公司将依法配合司法机关的调查取证工作。</p>
					
					<h2><strong>附则</strong></h2>
					<p>对用户协议的解释、修改及更新权均属于本网站所有。</p>
					<input type="button" class="backtotop" value="关闭" onclick="CloseWin();">
				</div>
			</div>
		</div>
	</div>
  </body>
</html>
