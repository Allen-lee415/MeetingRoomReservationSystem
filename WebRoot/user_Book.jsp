<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.ssh.hibernate.Meetingroominfo"%>

<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<title>欢迎使用会议室预约管理系统</title>
	<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
	<link rel="stylesheet" href="css/calendar.css" type="text/css" media="all" />
	<%String mrid=request.getParameter("id"); 
      String username=(String)session.getAttribute("username");
	%>
	
</head>

<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script language="javascript">
	//页面加载时div的隐藏函数
	
	//查询div的显示函数
	function showdivS(){		
		var divS=document.getElementById("divS");
		divS.style.display='inline';
		dispdivA();
		dispdivU();
	}			
	//查询div的隐藏函数
	function dispdivS(){		
		var divS=document.getElementById("divS");
		divS.style.display='none';
	}

</script>

<!--结合那个日历  -->
<style type="text/css">

</style>
<script type="text/javascript" src="js/calendar_jquery.js"></script>

<script type="text/javascript">
var daysInMonth = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);    //每月天数
var today = new Today();    //今日对象
var year = today.year;      //当前显示的年份
var month = today.month;    //当前显示的月份

//页面加载完毕后执行fillBox函数
$(function() {
    fillBox();//---->加载后实行这个函数，本函数填充单元格日期，然后执行getTasks获取所有的预约信息-->用buildTask显示小蓝条
});

//今日对象
function Today() {
    this.now = new Date();
    this.year = this.now.getFullYear();
    this.month = this.now.getMonth();
    this.day = this.now.getDate();
}

//根据当前年月填充每日单元格
function fillBox() {
    updateDateInfo();                   //更新年月提示
    $("td.calBox").empty();             //清空每日单元格

    var dayCounter = 1;                 //设置天数计数器并初始化为1
    var cal = new Date(year, month, 1); //以当前年月第一天为参数创建日期对象
    var startDay = cal.getDay();        //计算填充开始位置
    //计算填充结束位置
    var endDay = startDay + getDays(cal.getMonth(), cal.getFullYear()) - 1;

    //如果显示的是今日所在月份的日程，设置day变量为今日日期 
    var day = -1;
    if (today.year == year && today.month == month) {
        day = today.day;
    }

    //从startDay开始到endDay结束，在每日单元格内填入日期信息
    for (var i=startDay; i<=endDay; i++) {
        if (dayCounter==day) {
            $("#calBox" + i).html("<div class='date today' id='" + year + "-" + (month + 1) + "-" + dayCounter + "' onclick='openAddBox(this)'>" + dayCounter + "</div>");
        } else {
            $("#calBox" + i).html("<div class='date' id='" + year + "-" + (month + 1) + "-" + dayCounter + "' onclick='openAddBox(this)'>" + dayCounter + "</div>");
        }
        dayCounter++;
    }
    getTasks();                         //从服务器获取任务信息
}

//从服务器获取任务信息！！！！这个是那个显示所有预约的，然后给所有都buildTask
function getTasks() {
      // $.getJSON("minfo.do",               //服务器页面地址
  //    {
  //          action: "findByMonth",             //action参数
   //         month: year + "-" + (month + 1) //年月参数
   //     },
    //    function(json) {                    //回调函数
   //         //遍历JSON数组，建立任务信息
    //        $(json).each(function(i){
   //             buildTask(json[i].builddate, json[i].startTime, json[i].endTime);
    //        });
    //    }
  //  );
    var mrid=$("#mrid").val();
  
    var mon=year + "-" + (month + 1);
  	$.ajax({
		  type: "POST",
		  url: "minfo.do?action=findByMonthAndMrid&month="+mon+"&mrid="+mrid,
		  dataType: "json",
		  success : function(data){
			  $.each(data.list,function(i,value){
		      
		       	buildTask(value.date, value.meetingId,value.startTime, value.endTime); 
		     });
		     
		  }
		});
}

//根据日期、任务编号、任务内容在页面上创建任务节点
function buildTask(buildDate, meetingId,startTime, endTime) {
   $("#" + buildDate).parent().append("<div id='"+meetingId+"' class='task' onclick='editTask(this)'>" + startTime + "到"+ endTime+ "预约"+"</div>");
}//#buildDate是上边定义过id，每个格子第一条的id就是那个日期，取到这个后再网上找，添加div。

//判断是否闰年返回每月天数。。。。。。fillbox第七行调用，计算endDay用到
function getDays(month, year) {
    if (1 == month) {
        if (((0 == year % 4) && (0 != (year % 100))) || (0 == year % 400)) {
            return 29;
        } else {
            return 28;
        }
    } else {
        return daysInMonth[month];
    }
}

//显示上月日程
function prevMonth() {
    if ((month - 1) < 0) {
        month = 11;
        year--;
    } else {
        month--;
    }
    fillBox();              //填充每日单元格
}

//显示下月日程
function nextMonth() {
    if((month + 1) > 11) {
        month = 0;
        year++;
    } else {
        month++;
    }
    fillBox();              //填充每日单元格
}

//显示本月日程
function thisMonth() {
    year = today.year;
    month = today.month;
    fillBox();              //填充每日单元格
}

//更新年月提示。。。。。fillbox第一行先更新一下日期，最上面显示的那个日期
function updateDateInfo() {
    $("#dateInfo").html(year + "年" + (month + 1) + "月");
}

//打开新建任务box
function openAddBox(src) {//这个src作用没搞懂

    $("#taskDate").html(src.id);                    //设置新建日期
    $("#taskInfo").val("");                         //初始化新建任务内容
    var left = getLeft(src) + 15;                   //设置左边距
    var top = getTop(src) + 15;                     //设置顶边距
    $("#addBox").left(left).top(top).slideDown();   //显示新建任务box
}

//向服务器提交新任务信息
function addTask() {
   // var taskInfo = $("#taskInfo").val();                //获取任务信息
    //检查任务信息是否为空
    //if ($.trim(taskInfo)=="") {
      //  alert("请输入信息");
    //} else {
       //我写的
       //先根据username查出userId,然后在存入到meetinfo中
        var mrid=$("#mrid").val(); //上边那个查看本会议室的预约情况也使用到了这句
        var startHour=$("#startHour option:selected").val();
         var startMin=$("#startMin option:selected").val();
        var startTime = startHour+":"+startMin;
        
         var endHour=$("#endHour option:selected").val();
         var endMin=$("#endMin option:selected").val();
        var endTime=endHour+":"+endMin;
          var topic =　$("#topic").val();
          
        var buildDate = $("#taskDate").html();          //获取任务日期,上边那个函数打开div的时候给这个赋值 日期了
         
         
         
       uname=$("#username").val();
       	$.ajax({
		  type: "POST",
		  url: "userinfo.do?action=findByUserName&username="+uname,//下边添加的时候需要id
		  dataType: "json",
		  success : function(data){;
			var uid=data.userId;
			
        			$.post("minfo.do",                          //服务器页面地址
          			  {
			                action: "add",                      //action参数
			              //  taskInfo: taskInfo,                     //任务信息参数
			               // buildDate: buildDate                    //任务日期参数
			                date:buildDate,
			                startTime:startTime,
			                endTime: endTime,
			                topic:topic,
			                userid:uid,
			                mrid:mrid
			            },
           // function(taskId) {                          //回调函数
            //    buildTask(buildDate, taskId, taskInfo); //建立任务节点
            //    closeAddBox();                          //关闭新建任务box
            //}
             function(meetid){//这里就是调到这个函数，因为这是ajax，不刷新页面
         
               buildTask(buildDate, meetid,startTime, endTime);//这个meetid是给编辑删除服务的
               closeAddBox();
            }
        );
		    } });
		    
       
    }


//关闭新建任务box
function closeAddBox() {
    $("#addBox").slideUp();
}

//打开编辑任务box
function editTask(src) {
    alert(src.id);  //这个id没问题了，可以取到会议id
   // $("#taskId").val(src.id);             //对任务编号隐藏域赋值,把任务编号付给它
   $("#meetId").val(src.id);             //对任务编号隐藏域赋值,把任务编号付给它
   
    $.ajax({
		  type: "POST",
		  url: "minfo.do?action=findById&meetid="+src.id,
		  dataType: "json",
		  success : function(data){
			  $.each(data.minfo,function(i,value){
		        $("#startTimeEdit").val(value.startTime);
		        $("#endTimeEdit").val(value.endTime);
		        $("#topicEdit").val(value.topic);
		       	
		     });
		     
		  }
		});
   
   //alert(src.innerHTML);
   // $("#editTaskInfo").val(src.innerHTML);          //设置编辑内容
    var left = getLeft(src) + 15;                   //设置左边距
    var top = getTop(src) + 15;                     //设置顶边距
    $("#editBox").left(left).top(top).slideDown();  //显示编辑任务box
}

//删除任务
function delTask() {
    var taskId = $("#taskId").val();                //获取任务编号
    $.post("calendar.jsp",                          //服务器页面地址
        {
            action: "delTask",                      //action参数
            taskId: taskId                          //任务编号参数
        },
        function() {                                //回调函数
            $("#task" + taskId).remove();           //在页面删除任务节点
            closeEditBox();                         //关闭编辑box
        }
    );
}

//关闭编辑box
function closeEditBox() {
    $("#editBox").slideUp();
}

//更新任务信息
function updateTask() {
    var meetId = $("#meetId").val();                //任务编号
    var startTime = $("#startTimeEdit").val();        //任务内容
     var endTime = $("#endTimeEdit").val();
      var topic = $("#topicEdit").val();
    //检查任务信息是否为空
   // if ($.trim(startTime)=="") {
    //    alert("请输入任务信息。");
    //} elsiif {
      //  $.post("calendar.jsp",                      //服务器页面地址
     //       {
      //          action: "updateTask",               //action参数
      //          taskId: taskId,                     //年月参数
      //          taskInfo: taskInfo                  //任务信息参数
      //      },
      //      function() {                            //回调函数
      //          $("#task" + taskId).html(taskInfo); //更新页面任务内容
      //          closeEditBox();                     //关闭编辑box
      //      }
    //    );
    //}
     $.ajax({
		  type: "POST",
		  url: "minfo.do?action=updateByAjax&meetid="+meetId+"&startTime="+startTime+"&endTime="+endTime+"&topic="+topic,
		  dataType: "json",
		  success : function(){//可以之后加上更新成功的提示
			    closeEditBox();    
		       	
		 
		     
		  }
		});
}

//返回对象对页面左边距
function getLeft(src){
    var obj = src;
    var objLeft = obj.offsetLeft;
    while(obj != null && obj.offsetParent != null && obj.offsetParent.tagName != "BODY"){
        objLeft += obj.offsetParent.offsetLeft;
        obj = obj.offsetParent;
    }
    return objLeft;
}

//返回对象对页面上边距
function getTop(src){
    var obj = src;
    var objTop = obj.offsetTop;
    while(obj != null && obj.offsetParent != null && obj.offsetParent.tagName != "BODY"){
        objTop += obj.offsetParent.offsetTop;
        obj = obj.offsetParent;
    }
    return objTop;
}
</script>
<body>
<!-- Header -->
<div id="header">
	<div class="shell">
		<!-- Logo + Top Nav -->
		<div id="top">
			<h1><a href="#"><font face="黑体">会议室预约管理系统</font> </a></h1>
			<div id="top-navigation">
			    欢迎 <a href="#"><strong><%=username %></strong></a>
				<span>|</span>
				<a href="#">帮助</a>
				<span>|</span>
				<a href="#">个性化设置</a>
				<span>|</span>
				<a href="login.jsp">退出</a>
			</div>
		</div>
		<!-- End Logo + Top Nav -->
		
		<!-- Main Nav -->
		<div id="navigation">
			<ul>
			    <li><a href="firstPage.jsp"><span>首页</span></a></li>
			    <li><a href="#" class="active"><span>会议室预约</span></a></li>
			    <li><a href="myMinfo.do?action=queryByPageMyBook"><span>我的预约</span></a></li>
			    <li><a href="chartUser.jsp" ><span>查看统计图表</span></a></li>
			    
			</ul>
		</div>
		<!-- End Main Nav -->
	</div>
</div>
<!-- End Header -->

<!-- Container -->
<div id="container">
	<div class="shell">
		<!-- Small Nav -->
		<div class="small-nav">
			<a href="#">用户信息管理</a>
			<span>&gt;</span>
			用户信息列表
		</div>
		<!-- End Small Nav -->
		
		<br />
		<!-- Main -->
		<div id="main">
			<div class="cl">&nbsp;</div>
			
			<!-- Content -->
			<div id="content">
				
				<!-- Box -->
				<div class="box">
					<!-- Box Head -->
					<div class="box-head" >
						<h2 class="left">请选择日期进行预约</h2>
						<div class="right">
							<label>搜索记录</label>
							<input type="text" class="field small-field" />
							<input type="submit" class="button" value="搜索" />
						</div>
					</div>
					<!-- End Box Head -->	

					<!-- Calendar Table -->
					<div class="table" >
					 
					 
					 <h1>日程表</h1>
<form method="post"> 
<!-- 新建任务box -->
<div id="addBox">
    <div id="taskDate"> </div>
    <table>
   
    <tr><td width="200">开始时间：</td><td width="80"><select id="startHour"><option value="08">8</option>
                                                                <option value="09">9</option>
                                                                <option value="10">10</option>
                                                                <option value="11">11</option>
                                                                <option value="12">12</option>
                                                                <option value="13">13</option>
                                                                <option value="14">14</option>
                                                                <option value="15">15</option>
                                                                <option value="16">16</option>
                                                                <option value="17">17</option>
                                                             
                                                                </select>时</td>
    <td width="80"><select id="startMin"><option value="00">0</option>
                               <option value="10">10</option>
                              <option value="20">20</option>
                              <option value="30">30</option>
                              <option value="40">40</option>
                              <option value="50">50</option></select>分
  </td>
    
    </tr>
        <tr><td width="200">结束时间：</td><td width="80"><select id="endHour"><option value="08">8</option>
                                                               <option value="09">9</option>
                                                                <option value="10">10</option>
                                                                <option value="11">11</option>
                                                                <option value="12">12</option>
                                                                <option value="13">13</option>
                                                                <option value="14">14</option>
                                                                <option value="15">15</option>
                                                                <option value="16">16</option>
                                                                <option value="17">17</option>
                                                             
                                                                </select>时</td>
    <td width="80"><select id="endMin"><option value="10">0</option>
                               <option value="10">10</option>
                              <option value="20">20</option>
                              <option value="30">30</option>
                              <option value="40">40</option>
                              <option value="50">50</option></select>分
   </td>
    
    </tr>
      <tr><td width="200">会议主题：</td><td width="50" colspan="2"><input type="text" id="topic" size="20"></td></tr>
      </table> 
     
    <div class="taskBtn">
        <input type="button" value="预约会议室" onclick="addTask()">
        <input type="button" value="取消" onclick="closeAddBox()">
    </div>
</div>

<!-- 编辑任务box -->
<div id="editBox">
    <input type="hidden" id="meetId">
      开始时间：<input type="text" id="startTimeEdit" size="40">
     结束时间：<input type="text" id="endTimeEdit" size="40">
      会议主题：<input type="text" id="topicEdit" size="40">
    <div class="taskBtn">
        <input type="button" value="更新任务信息" onclick="updateTask()">
        <input type="button" value="删除该任务" onclick="delTask()">
        <input type="button" value="取消" onclick="closeEditBox()">
    </div>
</div>
</form>
<!-- 日历表格 -->
<table id="calTable">
<tr>
    <td colspan="7">
       <input type="hidden" value="<%=mrid%>" id="mrid"/>
      <input type="hidden" value="<%=username%>" id="username"/>
        <input type="button" value="上月" onclick="prevMonth()">
        <input type="button" value="本月" onclick="thisMonth()">
        <input type="button" value="下月" onclick="nextMonth()">
        <span id="dateInfo"></span>
    </td>
</tr>
<tr>
    <td class="day">周日</td>
    <td class="day">周一</td>
    <td class="day">周二</td>
    <td class="day">周三</td>
    <td class="day">周四</td>
    <td class="day">周五</td>
    <td class="day">周六</td>
</tr>
<tr>
    <td class="calBox sun" id="calBox0"></td>
    <td class="calBox" id="calBox1"></td>
    <td class="calBox" id="calBox2"></td>
    <td class="calBox" id="calBox3"></td>
    <td class="calBox" id="calBox4"></td>
    <td class="calBox" id="calBox5"></td>
    <td class="calBox sat" id="calBox6"></td>
</tr>
<tr>
    <td class="calBox sun" id="calBox7"></td>
    <td class="calBox" id="calBox8"></td>
    <td class="calBox" id="calBox9"></td>
    <td class="calBox" id="calBox10"></td>
    <td class="calBox" id="calBox11"></td>
    <td class="calBox" id="calBox12"></td>
    <td class="calBox sat" id="calBox13"></td>
</tr>
<tr>
    <td class="calBox sun" id="calBox14"></td>
    <td class="calBox" id="calBox15"></td>
    <td class="calBox" id="calBox16"></td>
    <td class="calBox" id="calBox17"></td>
    <td class="calBox" id="calBox18"></td>
    <td class="calBox" id="calBox19"></td>
    <td class="calBox sat" id="calBox20"></td>
</tr>
<tr>
    <td class="calBox sun" id="calBox21"></td>
    <td class="calBox" id="calBox22"></td>
    <td class="calBox" id="calBox23"></td>
    <td class="calBox" id="calBox24"></td>
    <td class="calBox" id="calBox25"></td>
    <td class="calBox" id="calBox26"></td>
    <td class="calBox sat" id="calBox27"></td>
</tr>
<tr>
    <td class="calBox sun" id="calBox28"></td>
    <td class="calBox" id="calBox29"></td>
    <td class="calBox" id="calBox30"></td>
    <td class="calBox" id="calBox31"></td>
    <td class="calBox" id="calBox32"></td>
    <td class="calBox" id="calBox33"></td>
    <td class="calBox sat" id="calBox34"></td>
</tr>
<tr>
    <td class="calBox sun" id="calBox35"></td>
    <td class="calBox" id="calBox36"></td>
    <td class="calBox" id="calBox37"></td>
    <td class="calBox" id="calBox38"></td>
    <td class="calBox" id="calBox39"></td>
    <td class="calBox" id="calBox40"></td>
    <td class="calBox sat" id="calBox41"></td>
</tr>
</table>
					 
					 
						
					</div>
					<!-- Table -->
					
				</div>
				<!-- End Box -->
				
				
			</div>
			<!-- End Content -->
			
			<!-- Sidebar -->
			<div id="sidebar">
				
				<!-- Box -->
				<div class="box">
					
					<!-- Box Head -->
					<div class="box-head">
						<h2>管理</h2>
					</div>
					<!-- End Box Head-->
						<!-- Manage Head -->
					<div class="box-content">
						<a onclick="showdiv()" class="add-button"><span>更改个人信息</span></a>
						<div class="cl">&nbsp;</div>
					
					
					<!-- Manage Head -->
						
						<!-- Sort -->
						<div class="sort">
							
						</div>
						<!-- End Sort -->
						
					</div>
				</div>
				<!-- End Box -->
			</div>
			<!-- End Sidebar -->
			
			<div class="cl">&nbsp;</div>			
		</div>
		<!-- Main -->
	</div>
</div>
<!-- End Container -->

<!-- Footer -->
<div id="footer">
	<div class="shell">
		<span class="left">&copy; 2010 - CompanyName</span>
		<span class="right">
			Design by <a href="http://chocotemplates.com" target="_blank" title="The Sweetest CSS Templates WorldWide">Chocotemplates.com</a>
		</span>
	</div>
</div>
<!-- End Footer -->
	
</body>
</html>