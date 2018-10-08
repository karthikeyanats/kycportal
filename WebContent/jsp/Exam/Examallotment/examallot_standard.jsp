<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.examallot.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>
function loadStandards()
{
	if(check_ForParticularElements(document.stdallotmentform.sessionid,"select",document.stdallotmentform.boardid,"select")){
			document.stdallotmentform.submit();
		}
}
var checkflag = false;
var a=0;
function chkval(obj)
{
	if(obj.checked)
		a++;
	else
		a--;


}
	

function allocatefun()
{
		var test=false;
			
			
		if(document.stdallotmentform.chk.length==undefined)
		{
			if(document.stdallotmentform.chk.checked==true)
			{
				if(confirm("Are you sure want to allot the Exam?"))
				{
				document.stdallotmentform.action="./Examallotmentsubmit.jsp";
    	  		document.stdallotmentform.submit();
    	  		}
			}
			else
			{
				alert("Select CheckBox")
			}
		}
		else
		{
  		for(i=0;i<document.stdallotmentform.chk.length;i++)
  		{
  			if(document.stdallotmentform.chk[i].checked==true)
  			{
  			        test=true;
  			}

  		}
  		if(test==true )
		{
			if(confirm("Are you sure want to allot the Exam?"))
			{
    	   	document.stdallotmentform.action="./Examallotmentsubmit.jsp";
    	  	document.stdallotmentform.submit();
    	  	}

        }
        else
        {
			alert("Select CheckBox")
		}
	}

}

function backfun()
{
  	document.stdallotmentform.action="./Examallotment.jsp";
   	document.stdallotmentform.submit();
}
</script>
</head>
<body>
<div id="main_container">
<div class="header"><%@ include	file="../../include/userheader.jsp"%></div>
 
<div class="main_content"><%@ include file="../../include/header.jsp"%>

<div class="center_content">

<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("label.examallot.rootpath")%></h2>

<form name='stdallotmentform' method='post'>
	
	
	<input type=hidden name=req_boardid value=""/>
	
	
<%@ page
	language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> <%@ page
	language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>

	<%
		ExamAllotmentQuery exallot	= new ExamAllotmentQuery(); 
		
		String instituteid			= "";
		String sessionname="";
		String examname="";
		String boardid="";
		String boardname="";
		String examnameid="";
		String sessionid="";
		String standardscheduleid="";
		String standardname="";
		String groupname="";
		
		boolean flag=false;
		ArrayList StandardGroupList = null;
	try{
		instituteid			= (String)session.getValue("instituteid").toString();
		boardid=request.getParameter("req_boardid");
		examnameid=request.getParameter("req_examnameid");
		//out.println("examnameid---->>"+examnameid);
		examname=request.getParameter("req_examname");
		sessionname=request.getParameter("req_sessionname");
		sessionid=request.getParameter("req_sessionid");
	}catch(Exception e){}
	%>

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.examallot.selected")%> </th>
		            <th scope="col" class="rounded-q4" width="20%"></th>        
		        </tr>
		    </thead>
		    
		        <tfoot>
		    	<tr>
		        	<td class="rounded-foot-left"><em></em></td>
		        	<td class="rounded-foot-right">&nbsp;</td>
		       </tr>
		    </tfoot>
		
		<br>
		
		<tr><td colspan="2"><table border=0 align=center id="rounded-corner1" width="100%">
		<tr>
			<td class=tablebold width="25%"><%=bundle.getString("label.examallot.academic")%></td>
			<td class=tablebold width="2%">:</td>
			<td>
			<%=session.getValue("sessionname")%>	
			</td>

				<td class=tablebold><%=bundle.getString("label.examallot.board")%></td>
				<td class=tablebold width="2%">:</td>
		<td class='tablelight' width='30%'><%=request.getParameter("req_boardname")%></td>
		</tr>
		<tr>
			<td class=tablebold width="25%"><%=bundle.getString("label.examallot.examname")%></td><td class=tablebold width="2%">:</td>
		<td class='tablelight'><%=examname %></td>
		

		
		</tr>
		</table>
		</td></tr>
		</table>
					
		<tfoot>
			<tr>
		   		<td colspan="4" class="rounded-foot-left"><em></em></td>
		   		<td class="rounded-foot-right">&nbsp;</td>
		  	</tr>
		</tfoot>
			


<table id="rounded-corner" border=0 summary="Standard List" width="100%" align="center">
   <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.examallot.SL.No")%></th>
            <th scope="col" class="rounded" width="70%"><%=bundle.getString("label.examallot.standardname")%></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.examallot.Action")%></th>
        </tr>
    </thead>
   <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
  <tbody>
   <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>

     <%
     	com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examallotmentQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
     	   	  
    	  StandardGroupList = examallotmentQuery.loadgroupedStandardsforexamallotment(examnameid,sessionid,boardid);
    	  //System.out.println("StandardList>>>>"+StandardGroupList);
    	int count=0;
    	  ArrayList archivalDetails = new ArrayList();
    	  int k=0;
    	 if(StandardGroupList!=null && StandardGroupList.size()>0)
			{
    		 for (int i = 0, j = 1; i < StandardGroupList.size(); i++) 
    		 {
				HashMap StandardListMap=(HashMap)StandardGroupList.get(i);
				standardscheduleid      = (String)StandardListMap.get("standardscheduleid");
				String examstdschid= (String)StandardListMap.get("examstandschid");
				 standardname      = (String)StandardListMap.get("standardname");
				 groupname      = (String)StandardListMap.get("groupname");
				 
				 if(groupname!=null)
					 standardname = standardname+" - "+groupname;
				 
				if (examstdschid==null)
				examstdschid="";
				if(examstdschid!="")
				{
				out.print("<tr><td>"+(i+1)+"</td><td>"+standardname+"</td><input type=hidden value='"+standardscheduleid+" '>");
				out.println("<td align='left'>Allotted</td></tr>");
				}
				else
				{
					out.print("<tr><td>"+(i+1)+"</td><td>"+standardname+"</td>");
					out.println("<td align='left'><input type='checkbox' name='chk' value="+standardscheduleid+"@"+count+" onclick=chkval(this)></td></tr>");
				}
					
				
			}
		}
		else
		  {
			  out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>Data Not Found</font></td></tr>");
		  }
				
								
	%>
    	
    </tbody>  
</table> 

 <a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
 <%
 if(StandardGroupList!=null && StandardGroupList.size()>0)
	{
 %>
 <a href="#" class="bt_green" onclick='allocatefun()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.examallot.allot")%></strong><span class="bt_green_r"></span></a>
 <%
 	}
 %>
	<input type=hidden name=req_examnameid1 value="<%=examnameid %>"/>

</table>
</form>

</div>
<!-- end of right content--></div>
<!--end of center content -->

<div class="clear"></div>
</div>
<!--end of main content--> 
<%@ include file="../../include/footer.jsp"%>
</div>
</body>
</html>