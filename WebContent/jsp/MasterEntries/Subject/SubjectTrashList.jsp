<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.subject.subjecttrashlisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/popup.js"></script>

<script type="text/javascript">
function backfun()
{
		document.subjectForm.action="./SubjectCreation.jsp";
		document.subjectForm.submit();		
}
function Trashfun(obj)
{
var status=obj.getAttribute("editstatus");
var subjectid=obj.getAttribute("subjectid");
var statusword="";
if(status=="A")
{
		statusword="Restore the Subject...?";
}
else if(status=="X")
{
		statusword="Delete the Subject...?";
}
if(confirm("Do You Want to "+statusword))
{
		document.subjectForm.EditStatus.value=status;
		document.subjectForm.subjectid.value=subjectid;
		document.subjectForm.action="./SubjectEditSubmit.jsp";
		document.subjectForm.submit();		
}
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

    <h2><%=bundle.getString("label.subject.subjecttrashlistrootpath") %></h2>
<form name="subjectForm" action="" method="post">
  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Subject.SubjectQuery"%>

     <%
     
     com.iGrandee.MasterEntries.Subject.SubjectQuery  subjectQuery = new com.iGrandee.MasterEntries.Subject.SubjectQuery();
     String instituteid = null;
     ArrayList subjecttypeList = null;
     String reqboardid = null;
     String boardname = null;
     String standardname = null;
     String standardid = null;
     String reqgroupstatus = null;
     ArrayList subjectList = null;

     
     try
     {
    	 reqboardid = request.getParameter("reqboardid");
    	 boardname = request.getParameter("reqboardname");
    	 standardname = request.getParameter("reqstandardname");
    	 standardid = request.getParameter("reqstandardid");
    	 reqgroupstatus = request.getParameter("reqgroupstatus");
    	 instituteid = (String)session.getValue("instituteid");
    	  instituteid = (String)session.getValue("instituteid");
    	  subjecttypeList = subjectQuery.listSubjectType(instituteid);
    	  subjectList = subjectQuery.listTrashedSubject(standardid);
    }catch(Exception e){}
    
    %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5"></th>
        	<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.subject.SelectedInfo") %></th>
        	<th scope="col" class="rounded-q4" width="5" colspan=3></th>
            
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
	    <td></td>
	    <td>
	    	<table border=0 width="100%">
	    		<tr>
	    			<td><a class=tablebold><%=bundle.getString("label.subject.BoardName") %></a></td><td><%=boardname %></td>
	    			<td><a class=tablebold><%=bundle.getString("label.subject.StandardName") %></a></td><td><%=standardname %></td>
	    		</tr>
	    	</table>
	    </td>
	    <td></td>
  </tr>
    </tbody>
    </table>
    
    <br>
<table id="rounded-corner" border="0" summary="selectd Information" width="100%">
    <thead>
    	<tr>
    	   	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.subject.SL.No") %></th>
    	   	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.subject.SubjectName") %></th>
        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.subject.SubjectCode") %></th>
        	<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.subject.CreditHours") %></th>
        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.subject.SubjectType") %></th>
            <th scope="col" class="rounded" width="8%"><%=bundle.getString("label.subject.Delete") %></th>
            <th scope="col" class="rounded-q4" width="8%"><%=bundle.getString("label.subject.Restore") %></th>
        
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=6 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   <%
   if(subjectList!=null && subjectList.size()>0)
	{
	 	for (int i1 = 0,sno=1; i1 < subjectList.size(); i1++,sno++) {
		HashMap subjectListMap=(HashMap)subjectList.get(i1);
		String subjectid      = (String)subjectListMap.get("subjectid")+"";
		String subjectname      = (String)subjectListMap.get("subjectname")+"";
		if(subjectname.equals("") || subjectname.equals("null"))
			subjectname="-";
		String subjectcode      = (String)subjectListMap.get("subjectcode")+"";
		if(subjectcode.equals("") || subjectcode.equals("null"))
			subjectcode="-";
		String credithours      = (String)subjectListMap.get("credithours")+"";
		if(credithours.equals("") || credithours.equals("null"))
			credithours="-";
		String subjecttypeid      = (String)subjectListMap.get("subjecttypeid")+"";
		if(subjecttypeid.equals("") || subjecttypeid.equals("null"))
			subjecttypeid="-";
		String subjectypename      = (String)subjectListMap.get("subjectypename")+"";
		if(subjectypename.equals("") || subjectypename.equals("null"))
			subjectypename="-";
	%>
	<tr>
	<td><%=sno %> </td>
	 <td><%=subjectname %> </td>
	 <td><%=subjectcode %> </td>
	 <td><%=credithours %> </td>
	 <td><%=subjectypename %></td>
<td><a href="#Trash2"  subjectid='<%=subjectid %>' name="Trash2" onclick="Trashfun(this)"  editstatus='X'><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_logout.png" alt="delete" title="Delete" border="0" /></a></td>
	 <td><a href="#Trash1" name="Trash1" subjectid='<%=subjectid %>' onclick="Trashfun(this)"  editstatus='A' ><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/16-undo1.png" alt="restore" title="Restore" border="0" /></a></td>

	</tr>
	<% }
	}
	else
	{
		out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
		//out.println("<tr><td align=center colspan='7'>Data Not Found</td></tr>");
	}%>
	</tbody>
	</table>
     <a href="#back" name="back" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.subject.BacktoSubjectList") %> </strong><span class="bt_blue_r"></span></a>
     <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
      <input type="hidden" name="reqboardname" value="<%=boardname%>">
      <input type="hidden" name="reqstandardname" value="<%=standardname%>">
      <input type="hidden" name="reqstandardid" value="<%=standardid%>">
     <input type="hidden" name="EditStatus" value="">
     <input type="hidden" name="subjectid" value="" >
     
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>
