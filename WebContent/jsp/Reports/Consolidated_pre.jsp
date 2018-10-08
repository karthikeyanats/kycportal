<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Consolidated Report | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">

function viewCons(){

		if(check_ForParticularElements(document.ApplicantSearch.boardname,"select")){
		document.ApplicantSearch.req_boardid.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.req_boardname.value  =document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].text;
		document.ApplicantSearch.action="./ConsolidatedView.jsp";
		document.ApplicantSearch.submit();
		}
}

</script>
</head>
<body>
<form name="ApplicantSearch" action="" method="post">

<input type=hidden name=req_boardid>
<input type=hidden name=req_boardname>


<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>
	<%
		ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.reports.reportsconsolidatedreport")%></h2>
   <%@ page import="java.util.ArrayList,java.util.ResourceBundle,java.util.HashMap,com.iGrandee.Application.ApplicationQuery"%>

  
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
     
        	<th scope="col" class="rounded-company" width=85%><%=bundle.getString("label.schedule.consolidatedreport")%></th>
          	<th scope="col" class="rounded-q4" WIDTH=15%></th>
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
    <table border=0>
    <tr>   
		<td width='30%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%></td>
		<td width='1%' class='tablebold'>:</td>
		<td width='40%' class='tablelight'><%=session.getValue("sessionname") %></td>
		
		<td class=tablebold align=right width=30%><%=bundle.getString("label.schedule.board")%>&nbsp;</td>
		<td width='1%' class='tablebold'>:</td>
		<td width=30% align=left>
		<select name=boardname validate="Board Name" class=tablelight>
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
		</table>
		</td>
		</tr>
   
    </tbody>
</table>

<a href="#" class="bt_green" onclick="viewCons()"><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.view")%></strong><span class="bt_green_r"></span></a>


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