<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feesstructure.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function addStandard()
{
	if(document.feesstructureyearform.standardname.value == "")
	{
	alert("Standard Name should not be empty");
	document.feesstructureyearform.standardname.focus();
	return false;
	}
	if(check_ForParticularElements(document.feesstructureyearform.standardboard,"select"))
	{
		document.feesstructureyearform.action="StandardSubmit.jsp";
		document.feesstructureyearform.submit();
	}
}
function listStandard()
{
if(check_ForParticularElements(document.feesstructureyearform.yearofsession,"select",document.feesstructureyearform.standardboard,"select"))
	{
	document.feesstructureyearform.yearofsessionid.value = document.feesstructureyearform.yearofsession.options[document.feesstructureyearform.yearofsession.options.selectedIndex].value;
	document.feesstructureyearform.yearofsessionname.value = document.feesstructureyearform.yearofsession.options[document.feesstructureyearform.yearofsession.options.selectedIndex].text;
	
	document.feesstructureyearform.boardid.value = document.feesstructureyearform.standardboard.options[document.feesstructureyearform.standardboard.options.selectedIndex].value;
	document.feesstructureyearform.boardname.value = document.feesstructureyearform.standardboard.options[document.feesstructureyearform.standardboard.options.selectedIndex].text;
	
	
		document.feesstructureyearform.action="./FeesStructureLoadStandard.jsp";
		document.feesstructureyearform.submit();
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

    <h2><%=bundle.getString("label.feesstructure.rootpath")%></h2>
<form name="feesstructureyearform" action="" method="post">

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.feesstructure.FeesStructure-Selection")%></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.feesstructure.MandatoryFields")%></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
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
    <tr><td colspan=2><table id="rounded-corner1" width="100%" border=0>
    	<tr>
    	<td class="tablebold"><%=bundle.getString("label.feesstructure.AcademicSession")%><font color="red">*</font>&nbsp;&nbsp;:</td><td><select name="yearofsession" class=tablelight validate="Academic Year"> <option>-Select Academic Year- </option>
        <%
   			
        	if(yearofsessionList!=null && yearofsessionList.size()>0)
			{
	   		 	for (int i = 0, j = 1; i < yearofsessionList.size(); i++) {
				
					HashMap yearofsessionListMap=(HashMap)yearofsessionList.get(i);
					String yearofsessionid     = (String)yearofsessionListMap.get("sessionid");
					String yearofsession      = (String)yearofsessionListMap.get("sessionname");
					out.println("<option value='"+yearofsessionid+"' class=tablelight >"+yearofsession+"</option>");
	   			}
			}
   		 %>
        </select></td>
        <td class="tablebold"><%=bundle.getString("label.feesstructure.Board-Medium")%> <font color="red">*</font>&nbsp;&nbsp;: </td><td><select name="standardboard" class=tablelight > <option>-Select Board-Medium- </option>
        <%
   			
        	if(BoardList!=null && BoardList.size()>0)
			{
   		 	for (int i = 0, j = 1; i < BoardList.size(); i++) {
			
				HashMap boardListMap=(HashMap)BoardList.get(i);
				String boardid     = (String)boardListMap.get("boardid");
				String boardname      = (String)boardListMap.get("boardname");
				String mediumid      = (String)boardListMap.get("mediumid");
				String mediumname      = (String)boardListMap.get("mediumname");
       		 out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");
   		 }
			}
   		 %>
        </select></td>
    </tr>	
    </table></td></tr>
    </tbody>
</table>

     <a href="#" onclick=listStandard() class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.feesstructure.ListStandard")%> </strong><span class="bt_blue_r"></span></a>
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