<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.subject.updatetitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/popup.js"></script>

<script type="text/javascript">
function TrashSubjects()
{
if(confirm("Do you want to Trash the Subject...?"))
{
		document.subjectForm.EditStatus.value="T";
		document.subjectForm.action="./SubjectLessonDetails.jsp";
		document.subjectForm.submit();		
}
}
function backfun()
{
		document.subjectForm.action="./SubjectCreation.jsp";
		document.subjectForm.submit();		
}
	
	function addSubjects()
	{
	
		//alert(document.subjectForm.subjectname.value);
		//alert(document.subjectForm.subjectcode.value);
		//alert(document.subjectForm.credithours.value);
		//alert(document.subjectForm.subjecttype);
	
		if(!check_ForParticularElements(document.subjectForm.subjectname,"text",document.subjectForm.subjectcode,"text",document.subjectForm.subjecttype,"select")){
				
				//document.subjectForm.credithours,"text",
		}
		else{
			
			//if(numeric_Validation(document.subjectForm.credithours,"Credit Hour"))
			//{ 
				document.subjectForm.EditStatus.value="E";
				document.subjectForm.action="./SubjectEditSubmit.jsp";
				document.subjectForm.submit();			
			//}	
		}
	
	}
	
function checkDuplicate(givenstring,flag)
{
	   var url = "";
	   	   var date = new Date();

	   if(flag=="duplicatesubjectname")
	   {
 		   url = "SubjectInfo.jsp?action=duplicatesubjectname&subjectname="+givenstring+"&reqstandardid="+document.subjectForm.reqstandardid.value+"&reqsubjectid="+document.subjectForm.subjectid.value+"&date="+date;
	   }
	   if(flag=="duplicatesubjectcode")
	   {
 		   url = "SubjectInfo.jsp?action=duplicatesubjectcode&subjectcode="+givenstring+"&reqstandardid="+document.subjectForm.reqstandardid.value+"&reqsubjectid="+document.subjectForm.subjectid.value+"&date="+date;
	   }
	   var req =initRequest();
	   req.onreadystatechange = function()
	   {
		   if (req.readyState == 4)
		   {
  
			   if (req.status == 200)
			   {
				  if(flag=="duplicatesubjectname")
				  {
				  	parseMessages(req.responseXML,flag)
				  }
			  	  else if(flag=="duplicatesubjectcode")
				  {
				   parseMessages(req.responseXML,flag)
				  }
			  }
			}
		};
	   req.open("GET", url, true);
	   req.send(null);
	}
	function parseMessages(xmlObj,flag)
	{
		if(flag=="duplicatesubjectname")
		{
			var rootObj=xmlObj.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
	 		for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
			}
			if(temp=="true")
			{
				alert("Subject Name already exists");
				validflag="yes";
				document.subjectForm.subjectname.focus();
				document.subjectForm.check.checked=false;
				return false;
			}
			if(document.subjectForm.subjectcode.value == "")
			{
			alert("Subject Code should not be empty");
			document.subjectForm.subjectcode.focus();
			document.subjectForm.check.checked=false;
			return false;
			}
			else
			{
			checkDuplicate(document.subjectForm.subjectcode.value,"duplicatesubjectcode");
			}
			}
		if(flag=="duplicatesubjectcode")
		{
			var rootObj=xmlObj.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
	 		for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
			}
			if(temp=="true")
				{
					alert("Subject Code already exists");
					validflag="yes";
					document.subjectForm.subjectcode.focus();
					document.subjectForm.check.checked=false;
					return false;
				}
				else
				{
						document.subjectForm.EditStatus.value="E";
						document.subjectForm.action="./SubjectEditSubmit.jsp";
						document.subjectForm.submit();			
				}
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

    <h2><%=bundle.getString("label.subject.updaterootpath") %></h2>
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
     String subjectid = null;
     String reqgroupstatus = null;
     ArrayList subjectList = null;
     String subjectname ="";
     
     try
     {
    	 reqboardid = request.getParameter("reqboardid");
    	 boardname = request.getParameter("reqboardname");
    	 standardname = request.getParameter("reqstandardname");
    	 standardid = request.getParameter("reqstandardid");
    	 subjectid = request.getParameter("reqsubjectid");
    	 reqgroupstatus = request.getParameter("reqgroupstatus");
    	 instituteid = (String)session.getValue("instituteid");
    	  instituteid = (String)session.getValue("instituteid");
    	  subjecttypeList = subjectQuery.listSubjectType(instituteid);
    	  subjectList = subjectQuery.loadSubjectforsubjectid(standardid,subjectid);
    }catch(Exception e){}
    
    %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.subject.SelectedInfo") %></th>
        	<th scope="col" class="rounded-q4" width="10%"></th>
            
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
	  
	    <td colspan=2>
	    	<table border=0 width="100%">
	    		<tr>
	    			<td><a class=tablebold><%=bundle.getString("label.subject.BoardName") %></a></td><td class=tablebold>:</td><td><%=boardname %></td>
	    			<td><a class=tablebold><%=bundle.getString("label.subject.StandardName") %></a></td><td class=tablebold>:</td><td><%=standardname %></td>
	    		</tr>
	    	</table>
	    </td>
  </tr>
    </tbody>
    </table>
    
    <br>
<table id="rounded-corner" border="0" summary="selectd Information" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.subject.SubjectName") %></th>
        	<th scope="col" class="rounded" width="25%"><%=bundle.getString("label.subject.SubjectCode") %></th>
        	<!-- <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.subject.CreditHours") %></th> -->
        	<th scope="col" class="rounded-q4" width="35%"><%=bundle.getString("label.subject.SubjectType") %></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   <%
   if(subjectList!=null && subjectList.size()>0)
	{
	   ////subjectid, subjectname, subjecttypeid, subjectypename
	 	for (int i1 = 0; i1 < subjectList.size(); i1++) {
		HashMap subjectListMap=(HashMap)subjectList.get(i1);
		 subjectname      = (String)subjectListMap.get("subjectname");
		String subjectcode      = (String)subjectListMap.get("subjectcode");
		String credithours      = (String)subjectListMap.get("credithours");
		String subjecttypeid      = (String)subjectListMap.get("subjecttypeid");
		String subjectypename      = (String)subjectListMap.get("subjectypename");
	%>
	<tr>
	 <td><input type="text" name="subjectname" size="30" maxlength="50" class="tablelight" value="<%=subjectname %>" />
	 <input type="hidden" name="subjectid" size="30" maxlength="50" class="tablelight" value="<%=subjectid %>" /></td>
	 <td><input type="text" name="subjectcode" size="5"  maxlength="10" class="tablelight"  value="<%=subjectcode %>" /></td>
	 <!-- <td><input type="text" name="credithours" size="5"  maxlength="3" class="tablelight"  value="<%=credithours %>" onkeypress='checkNumber(event)' /></td> -->
	 <td><select name="subjecttype"  id="subjecttype" class="tablelight"><option value="0">-Select Subject Type-</option>
	 <%
	 

       	if(subjecttypeList!=null && subjecttypeList.size()>0)
			{
   		 	for (int i = 0; i < subjecttypeList.size(); i++) {
			
				HashMap subjecttypeListMap=(HashMap)subjecttypeList.get(i);
				String subjecttypeid1     = (String)subjecttypeListMap.get("subjecttypeid");
				String subjectypename1      = (String)subjecttypeListMap.get("subjectypename");
				if(subjecttypeid1.equals(subjecttypeid))
				out.println("<option value='"+subjecttypeid1+"' selected class=tablelight>"+subjectypename1+"</option>");
				else
					out.println("<option value='"+subjecttypeid1+"'  class=tablelight>"+subjectypename1+"</option>");
	    	 	}
			}	
	 	}
	}
   		 %></select></td>
	</tr>
	</tbody>
</table>
     <a href="#back" name="back" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.subject.BackToSubjectList") %> </strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="addSubjects()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.subject.Submit") %></strong><span class="bt_green_r"></span></a>
     <input type="hidden" name="reqboardid" value="<%=reqboardid%>">
      <input type="hidden" name="reqboardname" value="<%=boardname%>">
      <input type="hidden" name="reqstandardname" value="<%=standardname%>">
      <input type="hidden" name="reqstandardid" value="<%=standardid%>">
     <input type="hidden" name="EditStatus" value="">
     <input type="hidden" name="reqsubjectid" value="" >
     
     
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>
