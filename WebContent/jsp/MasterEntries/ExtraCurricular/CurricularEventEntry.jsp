<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.curricularevent.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function inserteventdetails()
{
if(validflag)
	{
	if(check_ForParticularElements(document.curricularevententryform.yearofsession,"select",document.curricularevententryform.curricularcategory,"select"))
	{
		inc = 0;
		for(var x=0;x<document.curricularevententryform.eventname.length;x++)
		{
			if(document.curricularevententryform.eventname[x].value == "")
			{
				inc++;
			}
			else
			{
			}
		}
		if(inc >3)
		{
		alert("empty value not allowed");
		return false;
		}
		
		
		for(var x1=0;x1<document.curricularevententryform.check.length;x1++)
		{
			if(document.curricularevententryform.check[x1].checked)
			{
				document.curricularevententryform.eventname[x1].disabled =false;
				document.curricularevententryform.eventdate[x1].disabled =false;
				document.curricularevententryform.eventvenu[x1].disabled =false;
				document.curricularevententryform.yearofsession.disabled=false;
				document.curricularevententryform.curricularcategory.disabled=false;
			}
			else
			{
				document.curricularevententryform.eventname[x1].disabled =true;
				document.curricularevententryform.eventdate[x1].disabled =true;
				document.curricularevententryform.eventvenu[x1].disabled =true;
				document.curricularevententryform.yearofsession.disabled=true;
				document.curricularevententryform.curricularcategory.disabled=true;
			}
			
		}
		
		
	
	}  
	
	document.curricularevententryform.reqyearofsessionid.value = document.curricularevententryform.yearofsession.options[document.curricularevententryform.yearofsession.options.selectedIndex].value;
		document.curricularevententryform.reqcurricularcategoryid.value = document.curricularevententryform.curricularcategory.options[document.curricularevententryform.curricularcategory.options.selectedIndex].value;
		document.curricularevententryform.action="CurricularEventSubmit.jsp";
		document.curricularevententryform.submit();
	} 
	else
	{
	alert("Select any one the Extra Curricular Event option");
	
	}  
	document.curricularevententryform.reqyearofsessionid.value = document.curricularevententryform.yearofsession.options[document.curricularevententryform.yearofsession.options.selectedIndex].value;
}



var validflag  =false;
function checkfun(obj)
{

	chkid = obj.getAttribute("chkid");
	if(obj.checked)
	{ 
	if(document.curricularevententryform.yearofsession.value == "0")
	{  
	alert("Select Year Of Session");
	document.curricularevententryform.yearofsession.focus();
	document.curricularevententryform.check[chkid].checked=false;
	return false;
	}
	if(document.curricularevententryform.curricularcategory.value == "0")
	{  
	alert("Select Curricular Category");
	document.curricularevententryform.curricularcategory.focus();
	document.curricularevententryform.check[chkid].checked=false;
	return false;
	}
	if(document.curricularevententryform.eventname[chkid].value == "")
	{  
	alert("Extra Curricular Event should not be Empty");
	document.curricularevententryform.eventname[chkid].focus();
	document.curricularevententryform.check[chkid].checked=false;
	return false;
	}  
	if(document.curricularevententryform.eventdate[chkid].value == "")
	{  
	alert("Extra Curricular Event Date not be Empty");
	document.curricularevententryform.eventdate[chkid].focus();
	document.curricularevententryform.check[chkid].checked=false;
	return false;
	} 
	
	
	
	var checkoption="no";
	 	var checkoption1="no";
	 	
		if(document.curricularevententryform.check[chkid].checked)  
		{
			for(var k=0;k<document.curricularevententryform.check.length;k++)
			{
				if(chkid!=k)
					{
					if(document.curricularevententryform.check[k].checked)
						{
							if(document.curricularevententryform.eventname[chkid].value==document.curricularevententryform.eventname[k].value)
							{ 
							 checkoption="yes";
							}
						}
					}
				}
		}  
		if(checkoption=="yes")
		{
		alert("Same Fees Term Not Allowed");
		document.curricularevententryform.check[chkid].checked=false;
		document.curricularevententryform.eventname[chkid].focus();
		return false;
		}
		
		
	
	if(document.curricularevententryform.eventname[chkid].value != "" )
	{

  	   	 url = "checkDuplicate.jsp?tabname=curricularevent&fieldname1="+document.curricularevententryform.eventname[chkid].value+"&extracurricularcategoryid="+document.curricularevententryform.extracurricularcategoryid.value+"&sessionid="+document.curricularevententryform.yearofsession.options[document.curricularevententryform.yearofsession.options.selectedIndex].value;

	
  	 
 	   var req =initRequest();
 	   req.onreadystatechange = function()
 	   {
 		   if (req.readyState == 4)
 		   {   

 			   if (req.status == 200)
 			   {

  				  parseMessages1(req.responseXML,"LoadReply",chkid);

 			   }
 			   else if (req.status == 204)
 			   {

 			   }
 		   }
 	   };
 	   req.open("GET", url, true);
 	   req.send(null);
}
			
			
	
	 	   validflag  =true;
	
	}
	else
	{
		document.curricularevententryform.eventname[chkid].disabled=false;
		document.curricularevententryform.eventvenu[chkid].disabled=false;
		document.curricularevententryform.yearofsession.disabled=false;
		document.curricularevententryform.curricularcategory.disabled=false;
		  validflag  =false;
	}
	
} 

function parseMessages1(parseXML,check_var,chkid)
{
	   var rootobj=parseXML.getElementsByTagName("complaintdetails");
		var clength=rootobj[0].childNodes.length;
		var ask=rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
		
		if(ask=="true")
		{
		alert("Extra Curricular Event  Already Exist");
		document.curricularevententryform.eventname[chkid].value="";
		document.curricularevententryform.check[chkid].checked=false;
		
		}
		else
		{
					document.curricularevententryform.eventname[chkid].disabled=true;
					document.curricularevententryform.eventvenu[chkid].disabled=true;
					document.curricularevententryform.yearofsession.disabled=true;
					document.curricularevententryform.curricularcategory.disabled=true;
					
	
		}
		
}
	function Category(obj)
	{
	var asas=obj.value;
	if(check_ForParticularElements(document.curricularevententryform.yearofsession,"select"))
		{
				document.curricularevententryform.extracurricularcategoryid.value=asas;
	
	}
	}
function YearCategory(obj)
{
			var asas1=obj.value;
			document.curricularevententryform.yearsessionid.value=asas1;
		
	
}
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.curricularevent.entryrootpath") %></h2>
<form name="curricularevententryform" action="" method="post">
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery"%>

<%

String instituteid= null;
String today				= DateTime.showTime("calendar");
ArrayList eventCategoryList = null;
com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();

com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry curricularactivity = new com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry(); 

ArrayList sessionList = null;
String userid =null;
try
{
instituteid = (String)session.getValue("instituteid");
userid = (String)session.getValue("userid");
//eventCategoryList = extraCurricularQuery.listExtraCurricularCategoryList(instituteid,"A");
eventCategoryList = curricularactivity.get_All_Extracurricularactivity("A",userid,instituteid);
}catch(Exception e){}
%>
<table border=0 id="rounded-corner2" cellpadding=0 cellspacing=0 width="100%">

    

<tr class=tablebold><td> <%=bundle.getString("label.curricularevent.AcademicSession") %> : <select name="yearofsession" validate='Year Of Session' class="tablelight" onchange="YearCategory(this)">
<option  value='0'>-Select Session-</option>
 <%
  		 sessionList =  extraCurricularQuery.listYearofSession(instituteid);
        	if(sessionList!=null && sessionList.size()>0)  
			{
   		 	for (int i = 0, j = 1; i < sessionList.size(); i++) {
			
				HashMap sessionListMap=(HashMap)sessionList.get(i);
				String sessionid     = (String)sessionListMap.get("sessionid");
				String sessionname      = (String)sessionListMap.get("sessionname");
       		 out.println("<option value='"+sessionid+"' class=tablelight >"+sessionname+"</option>");
   		 }
			}
   		 %>
</select>
</td>
<td>
<%=bundle.getString("label.extracurricularactivity.curricularactivity") %> : <select name="curricularcategory" class="tablelight" validate='Curricular Category' onchange="Category(this)">
<option  value='0'>-Select Activity-</option>
 <%
 
String extracurricularcategoryid ="";	
	if(eventCategoryList!=null && eventCategoryList.size()>0)
	{
 	for (int i = 0, j = 1; i < eventCategoryList.size(); i++)
 	{
	
		HashMap eventCategoryListMap=(HashMap)eventCategoryList.get(i);
		String extracurricularactivityid     = (String)eventCategoryListMap.get("extracurricularactivityid");
		String extracurricularname      = (String)eventCategoryListMap.get("extracurricularname");
	 out.println("<option value='"+extracurricularactivityid+"' class=tablelight >"+extracurricularname+"</option>");
 }
	}
 /*String extracurricularcategoryid ="";	
        	if(eventCategoryList!=null && eventCategoryList.size()>0)
			{
   		 	for (int i = 0, j = 1; i < eventCategoryList.size(); i++)
   		 	{
			
				HashMap eventCategoryListMap=(HashMap)eventCategoryList.get(i);
				 extracurricularcategoryid     = (String)eventCategoryListMap.get("extracurricularcategoryid");
				String extcurricularcategoryname      = (String)eventCategoryListMap.get("extcurricularcategoryname");
       		 out.println("<option value='"+extracurricularcategoryid+"' class=tablelight >"+extcurricularcategoryname+"</option>");
   		 }
			}*/
   		 %>
</select>
</td></tr>
</table></td></tr>
</table>
<br>
<input type="hidden" name="extracurricularcategoryid" value="">
<table border=0 id="rounded-corner2" cellpadding=0 cellspacing=0 width="50%">
<tr><td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" ><%=bundle.getString("label.curricularevent.SL.No") %></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("label.curricularevent.EventName") %></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("label.curricularevent.Venue") %></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("label.curricularevent.EventDate") %></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("label.curricularevent.Chk") %></th>
        	 <th scope="col" class="rounded-q4" width="1%"></th>
        </tr>       
    </thead> 
    <tfoot>
    	<tr>
        	<td colspan=5 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
 <%
 for(int i=0,x=1,j=0;i<4;i++,j++)
	{
 %> <tr>
 	<td width="5%"><%=x++ %></td>
	 <td><input type="text" name="eventname" validate="Event name" size="50" class="tablelight" maxlength="150"/></td>
	 <td><input type="text" name="eventvenu" validate="Event Venu" size="20" class="tablelight" maxlength="100"/></td>
	 <td><input type="text" name="eventdate" validate="Event date" size="10" class="tablelight"  onfocus='this.blur()'/><input type='button' value='^' onclick=Calendar_Fun('<%= request.getContextPath()%>/js/Calendar/CalendarWindow.html','curricularevententryform.eventdate[<%=i%>]','0',event,'Not_Less_Than_CurrentDate',curricularevententryform.todaydate)>
	 	 <td colspan=1><input type="checkbox" name="check" chkid="<%=j%>" size="5" class="tablelight" onclick="checkfun(this)"/></td>
	 
	 </td>
	 <td></td>
	 </tr>
	 <%} %>
	 </tbody>
	 </table>
	</td><td width="30%">&nbsp;</td></tr></table>	 
	 <a href="./CurricularEventList.jsp?reqstatus=A" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.curricularevent.ViewCurricularEvent") %></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="inserteventdetails()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.curricularevent.Submit") %></strong><span class="bt_green_r"></span></a>
     <input type='hidden' name='todaydate' 	value='<%=today %>'/>
     	<input type=hidden name=reqcurricularcategoryid>
		<input type=hidden name=reqyearofsessionid>
		<input type=hidden name=eventoperation value="Insert">
		
				<input type=hidden name=yearsessionid value="">
		
</form> 
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>