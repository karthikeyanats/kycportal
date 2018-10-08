<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<% 	
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>



<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.admisionreport.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

function Report()
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
		document.ApplicantSearch.action="RegistrationReport.jsp";
		document.ApplicantSearch.submit();
}

function goBack()
{
		document.ApplicantSearch.action="RegistrationProcessList_Pre.jsp";
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

    <h2><%=bundle.getString("label.admisionreport.rootpath")%></h2>
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

<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.admisionreport.title")%></th>
      		<th scope="col" class="rounded-q4" width="20%" align=right><font color=red>*</font> <%=bundle.getString("label.applicationissue.MandatoryFields")%></th>
         </tr>
    </thead>
 <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
	<tr>
	<td colspan=2><table border=0 cellpadding=0 width="100%">
	<tr>
	<td class=tablebold>
		&nbsp;&nbsp;<%=bundle.getString("label.admisionreport.AcademicYear")%> &nbsp;<font color=red>*</font>&nbsp;&nbsp;
		<b>:</b>&nbsp;&nbsp;
		<select name=sessionname class=tablelight>
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
	<td class=tablebold align=right><%=bundle.getString("label.admisionreport.Board-Medium")%>&nbsp;<font color=red>*</font>&nbsp;&nbsp;
		<b>:</b>&nbsp;&nbsp;
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

	     }catch(Exception e){}
			%>
		</select>
</td>
	</tr>
  </table>
</td></tr></tbody></table>
<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.admisionreport.Back")%></strong><span class="bt_blue_r"></span></a>
<a href="#" class="bt_green" onclick="Report()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.admisionreport.View")%></strong><span class="bt_green_r"></span></a>


     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>