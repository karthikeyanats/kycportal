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

function openCalander(idx)
{
	if(document.f1.user_finishing_date.length >= 1)
		Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','0',event,'Not_Greater_Than_CurrentDate',document.communityform.server_date.value);
	else
		Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','0',event,'Not_Greater_Than_CurrentDate',document.communityform.server_date.value);
}

function ReplyDiary(obj)
{
var diaryallocationid=obj.getAttribute("names")
document.communityform.action="StudentDiaryReply.jsp?diaryallocationid="+diaryallocationid;
document.communityform.submit();
}


function submitFun()
{
  	   	 var url = "StudentDiaryDetailSearch.jsp?startdate="+document.communityform.startdate.value+"&enddate="+document.communityform.enddate.value;
  	   	 alert(url);
 	   var req =initRequest();
 	   req.onreadystatechange = function()
 	   {
 		   if (req.readyState == 4)
 		   {

 			   if (req.status == 200)
 			   {

  				  parseMessages(req.responseXML,"LoadReply");

 			   }
 			   else if (req.status == 204)
 			   {

 			   }
 		   }
 	   };
 	   req.open("GET", url, true);
 	   req.send(null);
 	}
 	
 
function parseMessages(parseXML,check_var)
{
	   var root_obj=parseXML.getElementsByTagName("complaintdetails");
		var tabobj		= document.getElementById("rounded-corner1");
		
var tbobj		= document.createElement("tbody");
node_len 		= root_obj[0].childNodes.length;

if(node_len>0)
{
for(var i=0;i<node_len;i++)
{
				//deleteTableRows("rounded-corner1");

tr = document.createElement("tr");
tr.height 		= "20";
tr.align="left";

td			 	= document.createElement("td");
td.className	= "tablelight";
td.align="center";
td.innerHTML 	= i+1;
td.width 		= 5;

tr.appendChild(td);


td			 	= document.createElement("td");
td.align="center";

td.className	= "tablelight";
td.innerHTML 	= "<a>"+root_obj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue+"</a>";
td.width 		= "20";

tr.appendChild(td);

td			 	= document.createElement("td");
td.align="center";

td.className	= "tablelight";
td.innerHTML 	= "<a>"+root_obj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue+"</a>";
td.width 		= "20";
tr.appendChild(td);

td			 	= document.createElement("td");
td.align="center";

td.className	= "tablelight";
td.innerHTML 	= "<a  href='#' names='"+root_obj[0].childNodes[i].childNodes[2].childNodes[0].nodeValue+"'onclick='ReplyDiary(this)'>Student Reply</a>";
td.width 		= "20";
tr.appendChild(td);


tbobj.appendChild(tr);

tabobj.appendChild(tbobj);
		
		
}
}
}
function dataNotFound(){
				//deleteTableRows("rounded-corner1");

				var tabobj		= document.getElementById("rounded-corner1");
				var tbobj		= document.createElement("tbody");
				tr 				= document.createElement("tr");
				td			 	= document.createElement("td");
				td.colspan		= 6;
				td.className	= "tablelight";
				td.align		= "center";
				td.innerHTML 	= "No Data Found";
				tr.appendChild(td);

				tbobj.appendChild(tr);
				tabobj.appendChild(tbobj);
				//deleteTableRows("dynamictable");


			}



function viewDiary()
{
document.communityform.action="StudentDiaryView.jsp";
document.communityform.submit();
}
</script>
</head>
<body onload="dataNotFound()">
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page import="java.io.*,java.util.*"%>

<%

String date_str="";
date_str = datebeans.showTime("");



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

    <h2>Master Entries / Student Diary Update</h2>
<form name="communityform" action="" method="post">
    
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr><td align="right" class="tablelight"><a href="<%=request.getContextPath()%>/jsp/StudentDiary/StudentDiaryStaff.jsp">Back</a></td></tr>
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Student Diary Creation" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded" width="100%" colspan="2">Search</th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <tr>
    <td class=tablebold>Start Date
     <input type="text" class=tablelight name="startdate" >
    <input type="button" class="tablehead" value="^" onclick="Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','communityform.startdate','0',event,'Not_Greater_Than_CurrentDate',document.communityform.server_date);">
    </td>
    <td class=tablebold>End Date 
    <input type="text" class=tablelight name="enddate" >
    <input type="button" class="tablehead" value="^" onclick="Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','communityform.enddate','0',event,'Not_Greater_Than_CurrentDate',document.communityform.server_date);">
     </td>
    </tr>
</tbody>
</table>
  <table  border=0 id="rounded-corner1" summary="Department List" width="100%">
 

   
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10">Sl.No</th>
        	<th scope="col" class="rounded" width="20%">Diary Subject</th>
        	<th scope="col" class="rounded" width="10" >Submission Date</th>
             <th scope="col" class="rounded-q4" width="10" >Reply</th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    
    </tfoot>
    <%

%>

    </thead>
</table>



     <a href="#" class="bt_green" onclick="submitFun()"><span class="bt_green_lft"></span><strong>Search</strong><span class="bt_green_r"></span></a>
   
   <input type="hidden" name="server_date" value="<%=date_str %>"> 
  
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