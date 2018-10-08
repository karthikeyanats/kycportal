<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Fees Collected | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">

function loadStudent()
{
if(check_ForParticularElements(document.feescollectionpreform.rollnumbertext,"text"))
	{
		document.feescollectionpreform.action="./FeesCollectionParentView.jsp";
		document.feescollectionpreform.submit();
	}
}
</script>
</head>
<body>
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

    <h2>Fees / Fees Collected</h2>
<form name="feescollectionpreform" action="" method="post">

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
        	<th scope="col" class="rounded" width="100%">Roll No. Entry</th>
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
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

     <%
     
     com.iGrandee.Fees.FeesHeadQuery  feesheadQuery = new com.iGrandee.Fees.FeesHeadQuery();  
     com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();

     String instituteid = null;
     ArrayList yearofsessionList = null;
     ArrayList BoardList = null;
     
     
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  yearofsessionList = feesheadQuery.listYearofSession(instituteid);
    	  BoardList = standardQuery.listBoard(instituteid);

    }catch(Exception e){}
    
    %>
    <tr><td><td><table id="rounded-corner1" width="100%">
    	<tr>
    	<td>
	    	<table border="0" cellpadding="0" cellspacing="0" width="50%" align="center">
	    	<tr><td>
		    	Roll Number <font color="red">*</font>
		    	&nbsp;&nbsp;
		    	<input type=text name="rollnumbertext" class=tablelight onkeydown="if(event.keyCode==13) return loadStudent();"/> 
	       </td></tr></table>
	    </td>
	    </tr>
     
    </table></td><td></td></tr>
    </tbody>
</table>

     <a href="#" onclick=loadStudent() class="bt_blue"><span class="bt_blue_lft"></span><strong>View </strong><span class="bt_blue_r"></span></a>
     <input type=hidden name="boardid">
	<input type=hidden name="boardname">
	<input type=hidden name="yearofsessionname">
	<input type=hidden name="yearofsessionid">
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>