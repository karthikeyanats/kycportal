<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>

<script type="text/javascript">
function editExamname(obj)
{

document.examnameviewform.examnameid_hidden.value = obj.getAttribute("examnameid");

	document.examnameviewform.examname_hidden.value=obj.getAttribute("examname");
	document.examnameviewform.examnameremarks_hidden.value=obj.getAttribute("examnameremarks");
	document.examnameviewform.createdby_hidden.value=obj.getAttribute("createdby");
	document.examnameviewform.action="ExamnameUpdate.jsp";
	document.examnameviewform.submit();
}
function trashFun(obj)
{
if(confirm("Do you want to trash the Examname Details..?"))
{
	document.examnameviewform.examnameid_hidden.value = obj.getAttribute("examnameid");
	//alert("ExamnameID>>>>>>"+document.examnameviewform.examnameid_hidden.value);
	document.examnameviewform.examname_hidden.value=obj.getAttribute("examname");
	document.examnameviewform.examnameremarks_hidden.value=obj.getAttribute("examnameremarks");
	document.examnameviewform.createdby_hidden.value=obj.getAttribute("createdby");
	document.examnameviewform.action= "ExamnameTrash.jsp";
	document.examnameviewform.submit();
}
else
{}
}

function deactiveFun(obj)
{
if(confirm("Do you want to Deactivate the Examname Details..?"))
{
	document.examnameviewform.examnameid_hidden.value = obj.getAttribute("examnameid");
	//alert("ExamnameID>>>>>>"+document.examnameviewform.examnameid_hidden.value);
	document.examnameviewform.examname_hidden.value=obj.getAttribute("examname");
	document.examnameviewform.examnameremarks_hidden.value=obj.getAttribute("examnameremarks");
	document.examnameviewform.createdby_hidden.value=obj.getAttribute("createdby");
	document.examnameviewform.action= "ExamnameDeactivateList.jsp";
	document.examnameviewform.submit();
}
else
{}
}

function goBack()
{
	document.examnameviewform.action= "ReportIndexView.jsp";
	document.examnameviewform.submit();
}

	function printfun()
	{
	window.open("PrintPreviewExamnameView.jsp?&req_sessionname="+document.examnameviewform.req_sessionname.value+"&req_sessionid="+document.examnameviewform.req_sessionid.value+"&req_sessionstatus="+document.examnameviewform.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
	}
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
    <div class="main_content">


<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle1.getString("label.reports.reportsexamname")%></h2>
<form name="examnameviewform" action="" method="post">
<input type=hidden name=examnameid_hidden>
<input type=hidden name=examname_hidden>
<input type=hidden name=examnameremarks_hidden>
<input type=hidden name=createdby_hidden>

<input type=hidden name=req_sessionid value=<%=request.getParameter("req_sessionid") %>>
<input type=hidden name=req_sessionname value='<%=request.getParameter("req_sessionname") %>'>
<input type=hidden name=req_sessionstatus value=<%=request.getParameter("req_sessionstatus") %>>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%"><%=bundle1.getString("label.schedule.selectedinfo")%></th>
            <th scope="col" class="rounded-q4" width="10%"></th>
            
        </tr>
    </thead>
 <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
	<tr>
	<td colspan=2>
	<table width=100%>
	<tr>
		<td class=tablebold align=left width=40%>
		<%=bundle1.getString("label.schedule.academicyear")%></td>
		<td align=left class=tablebold>:</td>
		<td><%=request.getParameter("req_sessionname") %></td>	
		</tr>
		</table></td>
		</tr>
	<%
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
	{
		out.print("<table class=tablehead >");
	out.print("<tr><td class='tablebold' >"+bundle1.getString("label.schedule.archivaldetails")+"</td><td>:</td><td valign=top class='tablelight' align=left width='40%'><h2>"+bundle1.getString("label.schedule.archivalmessage1")+"</h2></td></tr>");
	out.print("</table>");
	}
	%>
	
    </tbody>
</table>
<br>
<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle1.getString("label.schedule.slno")%></th>
            <th scope="col" class="rounded" width="25%"><%=bundle1.getString("label.schedule.examname")%></th>
            <th scope="col" class="rounded" width="35%"><%=bundle1.getString("label.schedule.examremarks")%></th>
            <th scope="col" class="rounded-q4" width="25%"><%=bundle1.getString("label.schedule.dateofcreation")%></th>
            <!--  <th scope="col" class="rounded" width="10%">Edit</th>
            <th scope="col" class="rounded" width="10%">Action</th>
            <th scope="col" class="rounded-q4" width="10%">Trash</th>-->
                      
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="3" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.ResourceBundle,java.util.HashMap,com.iGrandee.Exam.ExamnameEntry"%>

     <%
     com.iGrandee.Exam.ExamnameEntry  examnameEntry = new com.iGrandee.Exam.ExamnameEntry();
     String instituteid = null;
     ArrayList LoadExamnameList = null;
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  //LoadExamnameList=examnameEntry.listExamname(instituteid);
    	  LoadExamnameList=examnameEntry.LoadExamnameList(request.getParameter("req_sessionid"));
    	  
    	

    	ArrayList archivalDetails = new ArrayList();
    	 if(LoadExamnameList!=null && LoadExamnameList.size()>0)
			{
    		 for (int i = 0, j = 1; i < LoadExamnameList.size(); i++) {
			
				HashMap ExamnameListMap=(HashMap)LoadExamnameList.get(i);
				
				String examnameid       	= (String)ExamnameListMap.get("examnameid");
				String examname 		  	= (String)ExamnameListMap.get("examname");
				String examnameremarks  	= (String)ExamnameListMap.get("remarks");
				String dateofcreation      	= (String)ExamnameListMap.get("dateofcreation");
				String createdby      	= (String)ExamnameListMap.get("createdby");
				
				
				
				%>
				
				<tr>
        	 <td valign=top><%=j++ %></td>
            <td valign=top><%=examname %></td>
            
            <%
				if(examnameremarks.equals("-"))
				{
					//examnameremarks = "-";
				out.print("<td  valign=top class='tablelight'>-</td>");
				}
				else{
						String []count=null;
					  String des_temp=examnameremarks+"";
					   count=des_temp.split(" ");
						if((count.length-1)>15)
						{
							out.print("<td class='tablelight' ");
							String des_tempnew="";
							for(int s=0;s<15;s++)
							{
								des_tempnew+=count[s]+" ";
							}%>					   
							<div>
							<%=des_tempnew%><a href="index.htm" onclick="return hs.htmlExpand(this)">
						[<font color="red">More..</font>]
					</a>  
					<div class="highslide-maincontent">
						<h3></h3>
						<%=(examnameremarks+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
					</div>
						</div>
						<% }
						else
						{
							out.print("<td  valign=top class='tablelight' valign=top>"+examnameremarks+"</td>");

						}
						}
				%>
            <td valign=top><%=dateofcreation %></td>
            <!--  <td><a href="#" ahrefname="examnamehref=<%=i%>" examnameid="<%=examnameid%>" examname="<%=examname %>" examnameremarks="<%=examnameremarks %>" createdby="<%=createdby %>" onclick="editExamname(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="" border="0" /></a></td>
            <td><a href="#" ahrefname="examnamehref=<%=i%>" examnameid="<%=examnameid%>" examname="<%=examname %>" examnameremarks="<%=examnameremarks %>" createdby="<%=createdby %>" onclick="deactiveFun(this)" class="ask">Deactivate</a></td>
            <td><a href="#" ahrefname="examnamehref=<%=i%>" examnameid="<%=examnameid%>" examname="<%=examname %>" examnameremarks="<%=examnameremarks %>" createdby="<%=createdby %>" onclick="trashFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="" border="0" /></a></td>-->
            
        </tr>
				<%
    		 }
			}
    	 	else{
     			//out.println("<tr><td colspan=9 align=center>Data not found</td></tr>");
    	 		out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>"+bundle1.getString("label.schedule.datanotfound")+"</font></td></tr>");
    	 	}
     }catch(Exception e){}
          
     %>
    	
    </tbody>
</table>


<a href="#" class="bt_blue" onClick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		<%if(LoadExamnameList.size()>0){%> 
				<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong><%=bundle1.getString("label.schedule.print")%></strong><span class="bt_green_r"></span></a>
		<%} %>	
	<!--  <a href="./ExamnameEntry.jsp" class="bt_green"><span class="bt_green_lft"></span><strong>Add new item</strong><span class="bt_green_r"></span></a>
     <a href="./ExamnameDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>View Deactivated Examname List</strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong>Trashed items</strong><span class="bt_red_r"></span></a>-->

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>