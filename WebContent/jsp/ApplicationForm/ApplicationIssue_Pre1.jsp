<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.applicationissue.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function Issue()
{
		if(check_ForParticularElements(document.ApplicantSearch.sessionname,"select",document.ApplicantSearch.boardname,"select")){
		document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
		document.ApplicantSearch.req_sessionstatus.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("status");
		document.ApplicantSearch.req_boardid.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.req_boardname.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].text;
	
		document.ApplicantSearch.action="ApplicationIssue.jsp";
		document.ApplicantSearch.submit();
		}
}

function Report()
{
		if(check_ForParticularElements(document.ApplicantSearch.sessionname,"select",document.ApplicantSearch.boardname,"select")){
		document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
		document.ApplicantSearch.req_sessionstatus.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("status");
		document.ApplicantSearch.req_boardid.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.req_boardname.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].text;
		document.ApplicantSearch.action="ApplicationReport.jsp";
		document.ApplicantSearch.submit();
		}
}

function Issue1()
{

	if(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value =="00")
	{
		alert("Select Academic Year");
		document.ApplicantSearch.sessionname.focus();
		return false;
	}
	
	if(document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value =="00")
	{
		alert("Select Board");
		document.ApplicantSearch.boardname.focus();
		return false;
	}
	
		document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
		document.ApplicantSearch.req_sessionstatus.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("status");
		document.ApplicantSearch.req_boardid.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.req_boardname.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].text;
	
		document.ApplicantSearch.action="ApplicationIssue.jsp";
		document.ApplicantSearch.submit();
}

function Report1()
{

	if(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value =="00")
	{
		alert("Select Academic Year");
		document.ApplicantSearch.sessionname.focus();
		return false;
	}
	
	if(document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value =="00")
	{
		alert("Select Board");
		document.ApplicantSearch.boardname.focus();
		return false;
	}
		document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
		document.ApplicantSearch.req_sessionstatus.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("status");
		document.ApplicantSearch.req_boardid.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.req_boardname.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].text;
		document.ApplicantSearch.action="ApplicationReport.jsp";
		document.ApplicantSearch.submit();
}

</script>
</head>
<body>
<form name="ApplicantSearch" action="" method="post">
<input type=hidden name=req_sessionid>
<input type=hidden name=req_sessionname>
<input type=hidden name=req_sessionstatus>
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

    <h2><%=bundle.getString("label.applicationissue.rootpath")%></h2>
   <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.ApplicationQuery"%>
  
	<%
    try
    {	
    com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	
	com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
		ArrayList valueList = null;
	
	    String instituteid = null;
	    ArrayList BoardList = null;

	 		
			//String temp=applicationQuery.receiptNo();

	    	  instituteid = (String)session.getValue("instituteid");
	    	  ArrayList yearList = applicationQuery.listYearofSession(instituteid);
	    	  BoardList = standardQuery.listBoard(instituteid);
	    
		//out.println("temp-->"+temp);
	%>

<table id="rounded-corner" border=0   width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.applicationissue.ApplicationIssue")%></th>

            <th scope="col" class="rounded-q4" width="20%"><font color=red>*</font> <%=bundle.getString("label.applicationissue.MandatoryFields")%></th>
            
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
	<td colspan=2> <table border=0 cellpadding=5 width="100%">
	<tr>
	<td class=tablebold>
		<%=bundle.getString("label.applicationissue.AcademicYear")%><font color=red>*</font>&nbsp;&nbsp;
		<b>:</b>&nbsp;&nbsp;
		<select name=sessionname validate='Academic Year' class=tablelight>
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
					out.println("<option value='"+sessionid+"' status='"+session_status+"'>"+yearofsession+"</option>");
				}
			}

			%>
		</select>

		</td>
	<td class=tablebold align=left><%=bundle.getString("label.applicationissue.Board")%><font color=red>*</font>&nbsp;&nbsp;
		<b>:</b>&nbsp;&nbsp;
		<select name=boardname validate='Board' class=tablelight>
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

	     }catch(Exception e){}
			%>
		</select>
</td>
</tr></table></td>

	</tr>
    
    
    
    
    	
    </tbody>
</table>

<a href="#" class="bt_blue" onclick="Report()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.applicationissue.Report")%></strong><span class="bt_blue_r"></span></a>
<a href="#" class="bt_green" onclick="Issue()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.applicationissue.Submit")%></strong><span class="bt_green_r"></span></a>

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