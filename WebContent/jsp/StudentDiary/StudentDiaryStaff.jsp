<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.StudentDiary.StudentDiaryQuery" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.StudentDiary.StudentDiaryBean" />
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Community | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">
function addcommunity()
{
	if(document.communityform.communityname.value == "")
	{
	alert("Community Name should not be empty");
	document.communityform.communityname.focus();
	return false;
	}
	else
	{
		document.communityform.action="CommunitySubmit.jsp";
		document.communityform.submit();
	}
	
	
	
	
}
function openCalander(idx)
{
	if(document.f1.user_finishing_date.length >= 1)
		Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','0',event,'Not_Greater_Than_CurrentDate',document.communityform.server_date.value);
	else
		Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','0',event,'Not_Greater_Than_CurrentDate',document.communityform.server_date.value);
}
function savedetails()
{
document.communityform.action="StudentList.jsp";
document.communityform.submit();
}
function newDiary()
{
if(document.communityform.year.value==0)
{
alert("Select Year Of session");
return false;
}
if(document.communityform.standars.value==0)
{
alert("Select Standard ");
return false;
}
if(document.communityform.sections.value==0)
{
alert("Select Sections ");
return false;
}
if(document.communityform.subject1.value==0)
{
alert("Select Subject ");
return false;
}

document.communityform.action="StudentnewDiary.jsp";
document.communityform.submit();
}
function standardcombo(obj)
{  
elementobj		= document.getElementById("standars");
if(document.communityform.standars.value==0)
{

optionDelete(document.getElementById("year"),"1");
}
document.communityform.standardname.value=document.communityform.standars.options[document.communityform.standars.selectedIndex].text;

}
function sectioncombo(obj)
{
var sectionname=obj.value;
if(document.communityform.sections.value==0)
{
optionDelete(document.getElementById("year"),"1");
optionDelete(document.getElementById("standars"),"1");

}
document.communityform.sectionname.value=document.communityform.sections.options[document.communityform.sections.selectedIndex].text;

}
function subjectcombo(obj)
{
if(document.communityform.subject1.value==0)
{
optionDelete(document.getElementById("year"),"1");
optionDelete(document.getElementById("standars"),"1");
optionDelete(document.getElementById("sections"),"1");

}document.communityform.subjectname.value=document.communityform.subject1.options[document.communityform.subject1.selectedIndex].text;

}
function yearcombo(obj)
{
document.communityform.year.value=document.communityform.year.options[document.communityform.year.selectedIndex].text;
}

function LoadDiary()
{
if(document.communityform.year.value==0)
{
alert("Select Year Of session");
return false;
}
if(document.communityform.standars.value==0)
{
alert("Select Standard ");
return false;
}
if(document.communityform.sections.value==0)
{
alert("Select Sections ");
return false;
}
if(document.communityform.subject1.value==0)
{
alert("Select Subject ");
return false;
}
			document.communityform.action="StudentExistingDiary.jsp";
			document.communityform.submit();


}
function getDiaryCombo(obj,names)
{var ids=obj.value;
  	   	 var url = "getDiaryCombos.jsp?ids="+ids+"&names="+names;
  	    //alert(url);
 	   var req =initRequest();
 	   req.onreadystatechange = function()
 	   {
 		   if (req.readyState == 4)
 		   {
 			   if (req.status == 200)
 			   {

  				  parseMessages(req.responseXML,"LoadReply",names);

 			   }
 			   else if (req.status == 204)
 			   {

 			   }
 		   }
 	   };
 	   req.open("GET", url, true);
 	   req.send(null);
 	}
 	
 
function parseMessages(parseXML,check_var,names)
{
var elementobj;
var clength;
	   var rootobj=parseXML.getElementsByTagName("complaintdetails");
		 clength=rootobj[0].childNodes.length;
		 //alert("len"+clength);
		var ask=rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
		var ask1=rootobj[0].childNodes.item(0).childNodes.item(1).firstChild.nodeValue;
		//alert(ask+ask1);
	//alert(ask+ask1);	
	
	
if(names=="standard")
{
for(var i=0;i<clength;i++)
{
  elementobj		= document.getElementById("standars");
optionDelete(elementobj,"1");
elementobj.options[elementobj.options.length] = new Option(rootobj[0].childNodes.item(0).childNodes.item(1).firstChild.nodeValue,rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue);

}
}
else if(names=="section")
{
for(var j=0;j<clength;j++)
{
elementobj		= document.getElementById("sections");
optionDelete(elementobj,"1");

elementobj.options[elementobj.options.length] = new Option(rootobj[0].childNodes.item(0).childNodes.item(1).firstChild.nodeValue,rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue);
}
}
else if(names=="subject")
{
for(var j=0;j<clength;j++)
{
elementobj		= document.getElementById("subject");
optionDelete(elementobj,"1");

//alert(rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue);

elementobj.options[elementobj.options.length] = new Option(rootobj[0].childNodes.item(0).childNodes.item(1).firstChild.nodeValue,rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue);
document.communityform.subjectscheduleid.value=rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
}
}
}
</script>
</head>
<body>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page import="java.io.*,java.util.*"%>

<%


String date_str="";
String studentdiaryid="";
String subject="";
String sectionid="";
String sectionname="";
String standardid="";
String standardname="";
String sessionname="";
String sessionid="";
date_str = datebeans.showTime("");
ArrayList standards=new ArrayList();

ArrayList subjects=new ArrayList();
ArrayList sections=new ArrayList();
ArrayList yearofsession=new ArrayList();


HashMap newsubjects=new HashMap();
HashMap newsections=new HashMap();
HashMap newstandards=new HashMap();
HashMap newyearofsession=new HashMap();


String userid=(String)session.getValue("userid");

yearofsession=query_object.getAllYearsFaculty(userid);

%>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>Master Entries / Student Diary</h2>
<form name="communityform" action="" method="post">
    
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr><td align="right" class="tablelight"><a href="StudentDiaryPage.jsp">StudentDiaryPage</a></td></tr>
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
        	<th scope="col" class="rounded" width="100%">Student Diary</th>
        	<th scope="col" class="rounded-q4" width="10" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
  <table id="rounded-corner" border=0 summary="Department List" width="100%">


    <thead>   
    <tr>
    <td class="tablebold">Year Of Session </td><td class="tablelight"><select name="year" id="year" onchange="getDiaryCombo(this,'standard');yearcombo(this)">
    <option value="0">--Select Year Of Session--</option>
     <%
    
    for(int i=0;i<yearofsession.size();i++)
    {//sessionid, sessionname
    	newyearofsession=(HashMap)yearofsession.get(i);
    	sessionid=(String)newyearofsession.get("sessionid");
    	sessionname=(String)newyearofsession.get("sessionname");
    	    out.println("<option  value='"+sessionid+"'>"+sessionname+"</option>");

    }
    %>
    </select>
    </td>
    <td class="tablebold">Standard </td><td class="tablelight"><select name="standars" id="standars" onchange="getDiaryCombo(this,'section');standardcombo(this)">
    <option value="0">--Select Standard--</option>
     <%
    
   
    %>
    </select>
    </td>
    <tr>
     <td class="tablebold">Section </td><td class="tablelight"><select name="sections" id="sections" onchange="getDiaryCombo(this,'subject');sectioncombo(this)">
    <option value="0">--Select Section--</option>
     <%
    
   
    %>
    </select>
    </td>
    
    <td class="tablebold">Subject </td><td colspan="3" class="tablelight"><select name="subject1" id="subject" onchange="getDiaryCombo(this,'tables');subjectcombo(this)" >
    <option value="0">--Select Subject--</option>
    <%
    
   
    %>
    </select>
    </td>
    </tr>
    
    
    </thead>
</table>


     <a href="#" class="bt_blue" onclick="newDiary()"><span class="bt_blue_lft"></span><strong>Create New Diary </strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green"  onclick="LoadDiary()"><span class="bt_green_lft"></span><strong>Load Existing Diary</strong><span class="bt_green_r"></span></a>
    <input type=hidden name=server_date value="<%= date_str %>">
        <input type=hidden name=standardname value="">
        <input type=hidden name=sectionname value="">
        <input type=hidden name=subjectname value="">
                        <input type=hidden name=subjectscheduleid value="">
                
        
    
     </td>
     </tr>
     </TABLE>
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>