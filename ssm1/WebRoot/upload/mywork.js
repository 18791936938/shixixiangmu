$(function(){
	var massagespan=$("#responsetext");
	
	pageJs.pageInitProject();
	
	var issaleflag=$("#isSaleFlag").val();
	var startDate=$("#startDate").val();
	var endDate=$("#endDate").val();
	var currDate=$("#currDate").val();
	if(issaleflag=="0"){
		$("#vacationTypes").show();
		$("#startDates").show();
		$("#endDates").show();
		$("#words").hide();
		$("#workTypes").hide();
		$("#projectShow").hide();
		$("#approveeMpIds").hide();
		$("#workDeptIds").hide();
		$("#marks").show();
	}else if(issaleflag=="1"){
		$("#vacationTypes").show();
		$("#startDates").show();
		$("#endDates").show();
		$("#words").show();
		$("#workTypes").show();
		$("#projectShow").show();
		$("#approveeMpIds").show();
		$("#workDeptIds").show();
		$("#marks").show();
	}
	if(dateCompare(currDate,startDate) && dateCompare(endDate,currDate)){
		$("#vacationType").attr("disabled","true");
		$("#startDate").attr("disabled","true");
		$("#workType").attr("disabled","true");
		$("#workprojid").attr("disabled","true");
		$("#approveeMpId").attr("disabled","true");
		$("#workDeptId").attr("disabled","true");
		$("#mark").attr("disabled","true");
//		if(dateCompare(endDate,currDate)){
//	    	alert("结束日期必须大于等于今天");
//	    	e.stopPropagation()
//	    	return false;
//	    } 
	}
	if(dateCompare(currDate,endDate)){
		$("#myvacationform").find('input,textarea,select,ul').attr('disabled',true)
	}
	
	
	 $(".chooseProject").find(".addmore").click(function(){
		  if($("#workType").val()!="1"){
			  alert("非项目报工不能选择报工项目！");
			  return false;
		  }
		  
	  })
	  $(".chooseDepartment").find(".addmore").click(function(){
		  if($("#workType").val()!="2"){
			  alert("非部门报工不能选择报工部门！");
			  return false;
		  }
		  
	  })
//	if($("#workType").val()="0"){
//		getFreeApprovInfo($(this).val());
//	}
	$("#btn-back").on('click',function(e){
		 $.ajax({
			   url: webContext +'/util/filterAjaxBase64/encodeAjaxUrl',
				cache: false,
				type:"post",
				data: {url:'/mywork/myvacation/myvacationindex'},  
				success: function(data) {
					 window.location.href=webContext+"/forward/"+data.encodeurl;
				}
		   }); 
		 return false;
	})

	$("#myvacationform").on('submit',function(e){
		
		  var startDate=$("#startDate").val();
		  var endDate=$("#endDate").val();
		  var currDate=$("#currDate").val();
		
		if(dateCompare($("#startDate").val(),$("#endDate").val())){
			alert("开始日期不能大于结束日期");
			e.stopPropagation();
			return false;
		}
		if(compareDate(currDate,startDate)){
	    	alert("开始日期必须大于今天");
	    	e.stopPropagation()
	    	return false;
	    } 
		var id = $("#id").val();
		var  suburl=webContext+'/mywork/myvacation/updatemyvacation';
		var chechflag=false;
        if(id==""){
        	suburl=webContext+'/mywork/myvacation/insertmyvacation';
        }
      	 
        jQuery.ajax({
    		url: suburl,
    		data: $('#myvacationform').serialize(),
    		type: "post",
    		dataType : "json",
    		success: function(data)
    		{
    			//成功
    			if(data.success==true){
    				$("#id").val(data.msg);
					
    				massagespan.text("操作成功").css("color","green");
    				
    			}else{
    				if(data.error!=""){
    					massagespan.text(data.error).css("color","red");
    				}else{
    					massagespan.text("操作失败").css("color","red");
    				}
    				
    				setTimeout(function(){
    					massagespan.text(data.msg);
    				},3000);
    				
    			}
    			
    		},error:function(data){
    			console.error(data);
    			massagespan.text("操作失败").css("color","red");
    			setTimeout(function(){
    				massagespan.text(data.msg);
    			},3000);
    		}
        
        
      });
        return false; 
	});
	
});

function dateCompare(startdate,enddate){
		if(startdate.length>0&&enddate.length>0){
			aDate  =  startdate.split("-")  
		    oDate1  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0]);
		    aDate  =  enddate.split("-")  
		    oDate2  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0]);
		    var iDays=0
		    if(oDate2<oDate1){
		    	return 1;   
		    }
		}
	   return 0;
	}
function compareDate(startdate,enddate){
	if(startdate.length>0&&enddate.length>0){
		aDate  =  startdate.split("-")  
	    oDate1  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0]);
	    aDate  =  enddate.split("-")  
	    oDate2  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0]);
	    var iDays=0
	    if(oDate2<=oDate1){
	    	return 1;   
	    }
	}
   return 0;
}

function getFreeApprovInfo(userId){
	jQuery.ajax({
		url:webContext+'/mywork/mission/selectProjectInfoById',
		type:'post',
		data:{
			userId:userId
		},
		beforeSend:function(){
		},
		complete:function(){
		},
		success:function(data){
			var d=data.data;
			$("#workProjId").val(d.WORKPROJNAME);
		}
	});
}
