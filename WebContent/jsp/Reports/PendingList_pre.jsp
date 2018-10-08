<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.feesreport.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript">
function pendingList(obj)
{
 	//if(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value =="00")
	//{
		//alert("Select Academic Year");
		//document.ApplicantSearch.sessionname.focus();
		//return false;
	//}
	
	if(document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value =="00")
	{
		alert("Select Board");
		document.ApplicantSearch.boardname.focus();
		return false;
	}
		//document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		//document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
		document.ApplicantSearch.req_boardid.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.req_boardname.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].text;
		if(obj.getAttribute("feereport")=="Pending")
			document.ApplicantSearch.action="FeesPendingConsView.jsp";
		else
			document.ApplicantSearch.action="FeesPaidConsView.jsp";
		document.ApplicantSearch.submit();
}

function goBack(){
		document.ApplicantSearch.action="./FinanciarReportIndexView.jsp";
		document.ApplicantSearch.submit();
}
</script>
</head>
<body>
<form name="ApplicantSearch" action="" method="post">
<input type=hidden name=req_sessionid value=<%=request.getParameter("req_sessionid") %>>
<input type=hidden name=req_sessionname value='<%=request.getParameter("req_sessionname") %>'>
<input type=hidden name=req_sessionstatus value=<%=request.getParameter("req_sessionstatus") %>>

<input type=hidden name=req_boardid>
<input type=hidden name=req_boardname>


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

    <h2><%=bundle1.getString("label.feesreport.rootpathforreport")%> </h2>
   <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.ApplicationQuery"%>

  
	<%
    com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	
	com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
		ArrayList valueList = null;
		
		ArrayList yearList = null;
	    ArrayList BoardList = null;
	     try
	     {
	    	 String instituteid = null;
	    	  instituteid = (String)session.getValue("instituteid");
	    	  BoardList = standardQuery.listBoard(instituteid);
	    	  yearList = applicationQuery.listYearofSession(instituteid);
	    }catch(Exception e){}
	%>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%"><%=bundle1.getString("label.feesreport.FeesReport")%></th>
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
	<td class=tablebold  align=right>
		<%=bundle1.getString("label.feesreport.AcademicYear")%> :</td>
		
		<td align=left>
		<%=request.getParameter("req_sessionname")%>
		
		<!--  <select name=sessionname class=tablelight>
			<option value="00">-Select Academic Year-</option>
			<%
			if(yearList!=null && yearList.size()>0)
			{
				for(int s=0;s<yearList.size();s++)
				{
					HashMap map=(HashMap)yearList.get(s);
					String sessionid=(String)map.get("sessionid");
					String yearofsession=(String)map.get("sessionname");
					String session_status=(String)map.get("sessionstatus");
					out.println("<option value='"+sessionid+"'>"+yearofsession+"</option>");
				}
			}

			%>
		</select>-->

		</td>
	<td class=tablebold><%=bundle1.getString("label.feesreport.Board")%></td>
	<td width="1%" class=tablebold>:</td>
	<td  align=left>
		<select name=boardname class=tablelight>
			<option value="00">- Select Board-Medium -</option>
			<%

        	if(BoardList!=null && BoardList.size()>0)
			{
	   		 	for (int i = 0, j = 1; i < BoardList.size(); i++) 
	   		 		{
					HashMap boardListMap=(HashMap)BoardList.get(i);
					String boardid     = (String)boardListMap.get("boardid");
					String boardname      = (String)boardListMap.get("boardname");
					String mediumid      = (String)boardListMap.get("mediumid");
					String mediumname      = (String)boardListMap.get("mediumname");
	       		 	out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");
	   		 		}
			}


			%>
		</select>
</td>
		

	</tr>

	<%
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
	{
	%>
	
	<tr class='tablebold' height='23'>
			<td  class='tablebold'  valign=top align=right><%=bundle1.getString("label.feesreport.ArchivalDetails")%> &nbsp;</td>
			
			<td   width=30% valign=top class='tablelight' align=left><h2><%=bundle1.getString("label.feesreport.ThisisanArchivedYear")%></h2></td>
	</tr>
	<%
	} 
	%>					    
    
   </table></tr> 
    
    	
    </tbody>
</table>
<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.feesreport.Back")%></strong><span class="bt_blue_r"></span></a>
<a href="#" class="bt_green" feereport="Paid" onclick="pendingList(this)"><span class="bt_green_lft"></span><strong><%=bundle1.getString("button.feesreport.PaidList")%></strong><span class="bt_green_r"></span></a>
<a href="#" class="bt_red" feereport="Pending" onclick="pendingList(this)"><span class="bt_red_lft"></span><strong><%=bundle1.getString("button.feesreport.PendingList")%></strong><span class="bt_red_r"></span></a>

	<!--<a href="#" class="bt_green" onclick="Issue()"><span class="bt_green_lft"></span><strong>Issue</strong><span class="bt_green_r"></span></a>
       <a href="#" class="bt_blue"><span class="bt_blue_lft"></span><strong>View all items from category</strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_red"><span class="bt_red_lft"></span><strong>Delete items</strong><span class="bt_red_r"></span></a>
		-->
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>