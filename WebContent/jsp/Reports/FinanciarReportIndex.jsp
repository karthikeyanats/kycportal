<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Report Index | Powered by i-Grandee</title>
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
	
    
		document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
		document.ApplicantSearch.req_sessionstatus.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("status");
	
		document.ApplicantSearch.action="FinanciarReportIndexView.jsp";
		document.ApplicantSearch.submit();
}

</script>
</head>
<body>
<form name="ApplicantSearch" action="" method="post">
<input type=hidden name=req_sessionid>
<input type=hidden name=req_sessionname>
<input type=hidden name=req_sessionstatus>


<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>


    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.reports.reports")%></h2>
   <%@ page import="java.util.ArrayList,java.util.ResourceBundle,java.util.HashMap,com.iGrandee.Application.ApplicationQuery"%>
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

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%" ><%=bundle.getString("label.reports.reporthead")%></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.schedule.mandatory")%></th>
            
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
	<td class=tablebold colspan=2 align=center>
		<%=bundle.getString("label.schedule.academicyear")%> :<font color=red>*</font>&nbsp;&nbsp;
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
		<% 
	     }catch(Exception e){}
		%>
		

	</tr>
     	
    </tbody>
</table>


<a href="#" class="bt_green" onclick="Report()"><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.submit")%></strong><span class="bt_green_r"></span></a>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>