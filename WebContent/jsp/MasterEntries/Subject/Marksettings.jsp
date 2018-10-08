<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.subject.marksettingstitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/popup.js"></script>

<script type="text/javascript">
function checkonclick(obj)
{
	var i=obj.getAttribute("no");
	var clen=document.subjectForm.chk.length;
	var flags=false;
	if(obj.checked)
	{
		if(clen!=undefined)
			{
				if(document.subjectForm.chk[i].checked)	
					{
						var count=0;
						if(document.subjectForm.theoryinternalmin[i].value!="" || document.subjectForm.theoryinternalmax[i].value!="" )
							{
								if(!check_ForParticularElements(document.subjectForm.theoryinternalmin[i],"text",document.subjectForm.theoryinternalmax[i],"text"))
										{
											obj.checked=false;
											return false;
										}
							}
						if(document.subjectForm.theoryexternalmin[i].value!="" || document.subjectForm.theoryexternalmax[i].value!="" )
							{
								if(check_ForParticularElements(document.subjectForm.theoryexternalmin[i],"text",document.subjectForm.theoryexternalmax[i],"text")) 
									{
											count=1;
									}
									else
									{
											obj.checked=false;
											return false;
									}
							}
						if(document.subjectForm.practicalinternalmin[i].value!="" || document.subjectForm.practicalinternalmax[i].value!="")
							{
								if(!check_ForParticularElements(document.subjectForm.practicalinternalmin[i],"text",document.subjectForm.practicalinternalmax[i],"text"))
										{
											obj.checked=false;
											return false;
										}
							}
						if(document.subjectForm.practicalexternalmin[i].value!="" || document.subjectForm.practicalexternalmax[i].value!="")
							{
								if(check_ForParticularElements(document.subjectForm.practicalexternalmin[i],"text",document.subjectForm.practicalexternalmax[i],"text")) 
									{
										count=2;
									}
								else
									{
										obj.checked=false;
										return false;
									}
							}
						if(document.subjectForm.projectinternalmin[i].value!="" || document.subjectForm.projectinternalmax[i].value!="" )
							{
								if(!check_ForParticularElements(document.subjectForm.projectinternalmin[i],"text",document.subjectForm.projectinternalmax[i],"text"))
										{
											obj.checked=false;
											return false;
										}
							}
							if(document.subjectForm.projectexternalmin[i].value!="" || document.subjectForm.projectexternalmax[i].value!="" )
							{
								if(check_ForParticularElements(document.subjectForm.projectexternalmin[i],"text",document.subjectForm.projectexternalmax[i],"text")) 
										{
												count=3;
										}
										else
										{
											obj.checked=false;
											return false;
										}
							}
						if(count==0)
						{
							document.subjectForm.theoryexternalmin[i].focus();
							alert("Enter Any one Mark");
							obj.checked=false;
							return false;
						}
						flags=true;
					}
					if(flags)
					{
								document.subjectForm.theoryinternalmin[i].disabled=true;
								document.subjectForm.theoryinternalmax[i].disabled=true;
								document.subjectForm.theoryexternalmin[i].disabled=true;
								document.subjectForm.theoryexternalmax[i].disabled=true;
								document.subjectForm.practicalinternalmin[i].disabled=true;
								document.subjectForm.practicalinternalmax[i].disabled=true;
								document.subjectForm.practicalexternalmin[i].disabled=true;
								document.subjectForm.practicalexternalmax[i].disabled=true;
								document.subjectForm.projectinternalmin[i].disabled=true;
								document.subjectForm.projectinternalmax[i].disabled=true;
								document.subjectForm.projectexternalmin[i].disabled=true;
								document.subjectForm.projectexternalmax[i].disabled=true;
							}
					else
					{
							document.subjectForm.theoryinternalmin[i].disabled=false;
							document.subjectForm.theoryinternalmax[i].disabled=false;
							document.subjectForm.theoryexternalmin[i].disabled=false;
							document.subjectForm.theoryexternalmax[i].disabled=false;
							document.subjectForm.practicalinternalmin[i].disabled=false;
							document.subjectForm.practicalinternalmax[i].disabled=false;
							document.subjectForm.practicalexternalmin[i].disabled=false;
							document.subjectForm.practicalexternalmax[i].disabled=false;
							document.subjectForm.projectinternalmin[i].disabled=false;
							document.subjectForm.projectinternalmax[i].disabled=false;
							document.subjectForm.projectexternalmin[i].disabled=false;
							document.subjectForm.projectexternalmax[i].disabled=false;
					
					}
				}
		else
			{
				if(document.subjectForm.chk.checked)	
				{
						var count=0;
						if(document.subjectForm.theoryinternalmin.value!="" || document.subjectForm.theoryinternalmax.value!="" )
							{
								if(!check_ForParticularElements(document.subjectForm.theoryinternalmin,"text",document.subjectForm.theoryinternalmax,"text"))
										{
											obj.checked=false;
											return false;
										}
							}
						if(document.subjectForm.theoryexternalmin.value!="" || document.subjectForm.theoryexternalmax.value!="" )
							{
								if(check_ForParticularElements(document.subjectForm.theoryexternalmin,"text",document.subjectForm.theoryexternalmax,"text")) 
									{
											count=1;
									}
									else
									{
											obj.checked=false;
											return false;
									}
							}
						if(document.subjectForm.practicalinternalmin.value!="" || document.subjectForm.practicalinternalmax.value!="")
							{
								if(!check_ForParticularElements(document.subjectForm.practicalinternalmin,"text",document.subjectForm.practicalinternalmax,"text"))
										{
											obj.checked=false;
											return false;
										}
							}
						if(document.subjectForm.practicalexternalmin.value!="" || document.subjectForm.practicalexternalmax.value!="")
							{
								if(check_ForParticularElements(document.subjectForm.practicalexternalmin,"text",document.subjectForm.practicalexternalmax,"text")) 
									{
										count=2;
									}
								else
									{
										obj.checked=false;
										return false;
									}
							}
						if(document.subjectForm.projectinternalmin.value!="" || document.subjectForm.projectinternalmax.value!="" )
							{
								if(!check_ForParticularElements(document.subjectForm.projectinternalmin,"text",document.subjectForm.projectinternalmax,"text"))
										{
											obj.checked=false;
											return false;
										}
							}
							if(document.subjectForm.projectexternalmin.value!="" || document.subjectForm.projectexternalmax.value!="" )
							{
								if(check_ForParticularElements(document.subjectForm.projectexternalmin,"text",document.subjectForm.projectexternalmax,"text")) 
										{
												count=3;
										}
										else
										{
											obj.checked=false;
											return false;
										}
							}
						if(count==0)
						{
							document.subjectForm.theoryexternalmin.focus();
							alert("Enter Any one Mark");
							obj.checked=false;
							return false;
						}
						flags=true;
				}
				if(flags)
				{
						document.subjectForm.theoryinternalmin.disabled=true;
						document.subjectForm.theoryinternalmax.disabled=true;
						document.subjectForm.theoryexternalmin.disabled=true;
						document.subjectForm.theoryexternalmax.disabled=true;
						document.subjectForm.practicalinternalmin.disabled=true;
						document.subjectForm.practicalinternalmax.disabled=true;
						document.subjectForm.practicalexternalmin.disabled=true;
						document.subjectForm.practicalexternalmax.disabled=true;
						document.subjectForm.projectinternalmin.disabled=true;
						document.subjectForm.projectinternalmax.disabled=true;
						document.subjectForm.projectexternalmin.disabled=true;
						document.subjectForm.projectexternalmax.disabled=true;
				}
				else
				{
						document.subjectForm.theoryinternalmin.disabled=false;
						document.subjectForm.theoryinternalmax.disabled=false;
						document.subjectForm.theoryexternalmin.disabled=false;
						document.subjectForm.theoryexternalmax.disabled=false;
						document.subjectForm.practicalinternalmin.disabled=false;
						document.subjectForm.practicalinternalmax.disabled=false;
						document.subjectForm.practicalexternalmin.disabled=false;
						document.subjectForm.practicalexternalmax.disabled=false;
						document.subjectForm.projectinternalmin.disabled=false;
						document.subjectForm.projectinternalmax.disabled=false;
						document.subjectForm.projectexternalmin.disabled=false;
						document.subjectForm.projectexternalmax.disabled=false;
				}
			}
		}
		else
		{
			if(clen!=undefined)
			{
						document.subjectForm.theoryinternalmin[i].disabled=false;
						document.subjectForm.theoryinternalmax[i].disabled=false;
						document.subjectForm.theoryexternalmin[i].disabled=false;
						document.subjectForm.theoryexternalmax[i].disabled=false;
						document.subjectForm.practicalinternalmin[i].disabled=false;
						document.subjectForm.practicalinternalmax[i].disabled=false;
						document.subjectForm.practicalexternalmin[i].disabled=false;
						document.subjectForm.practicalexternalmax[i].disabled=false;
						document.subjectForm.projectinternalmin[i].disabled=false;
						document.subjectForm.projectinternalmax[i].disabled=false;
						document.subjectForm.projectexternalmin[i].disabled=false;
						document.subjectForm.projectexternalmax[i].disabled=false;
			}
			else
			{			
						document.subjectForm.theoryinternalmin.disabled=false;
						document.subjectForm.theoryinternalmax.disabled=false;
						document.subjectForm.theoryexternalmin.disabled=false;
						document.subjectForm.theoryexternalmax.disabled=false;
						document.subjectForm.practicalinternalmin.disabled=false;
						document.subjectForm.practicalinternalmax.disabled=false;
						document.subjectForm.practicalexternalmin.disabled=false;
						document.subjectForm.practicalexternalmax.disabled=false;
						document.subjectForm.projectinternalmin.disabled=false;
						document.subjectForm.projectinternalmax.disabled=false;
						document.subjectForm.projectexternalmin.disabled=false;
						document.subjectForm.projectexternalmax.disabled=false;
			}
		}
}
function addSubjectMarks()
{
	var flag=false;
	var clen=document.subjectForm.chk.length;
	if(clen!=undefined)
	{
		for(var i=0;i<clen;i++)
		{
			if(document.subjectForm.chk[i].checked)
			flag=true;
		}
	}
	else
	{
		if(document.subjectForm.chk.checked)
			flag=true;
	}
	if(flag)
	{
		if(confirm("Do you want to Set Mark for the selected Subject(s)...?"))
		{
			if(clen!=undefined)
				{
					for(var i=0;i<clen;i++)
					{
						if(!document.subjectForm.chk[i].checked)
						{
							document.subjectForm.theoryinternalmin[i].disabled=true;
							document.subjectForm.theoryinternalmax[i].disabled=true;
							document.subjectForm.theoryexternalmin[i].disabled=true;
							document.subjectForm.theoryexternalmax[i].disabled=true;
							document.subjectForm.practicalinternalmin[i].disabled=true;
							document.subjectForm.practicalinternalmax[i].disabled=true;
							document.subjectForm.practicalexternalmin[i].disabled=true;
							document.subjectForm.practicalexternalmax[i].disabled=true;
							document.subjectForm.projectinternalmin[i].disabled=true;
							document.subjectForm.projectinternalmax[i].disabled=true;
							document.subjectForm.projectexternalmin[i].disabled=true;
							document.subjectForm.projectexternalmax[i].disabled=true;
							document.subjectForm.chk[i].disabled=true;
							document.subjectForm.subjectids[i].disabled=true;
						}
						else
						{
							document.subjectForm.theoryinternalmin[i].disabled=false;
							document.subjectForm.theoryinternalmax[i].disabled=false;
							document.subjectForm.theoryexternalmin[i].disabled=false;
							document.subjectForm.theoryexternalmax[i].disabled=false;
							document.subjectForm.practicalinternalmin[i].disabled=false;
							document.subjectForm.practicalinternalmax[i].disabled=false;
							document.subjectForm.practicalexternalmin[i].disabled=false;
							document.subjectForm.practicalexternalmax[i].disabled=false;
							document.subjectForm.projectinternalmin[i].disabled=false;
							document.subjectForm.projectinternalmax[i].disabled=false;
							document.subjectForm.projectexternalmin[i].disabled=false;
							document.subjectForm.projectexternalmax[i].disabled=false;
						}
					}
				}
				else
				{
					if(!document.subjectForm.chk.checked)
					{
						document.subjectForm.theoryinternalmin.disabled=true;
						document.subjectForm.theoryinternalmax.disabled=true;
						document.subjectForm.theoryexternalmin.disabled=true;
						document.subjectForm.theoryexternalmax.disabled=true;
						document.subjectForm.practicalinternalmin.disabled=true;
						document.subjectForm.practicalinternalmax.disabled=true;
						document.subjectForm.practicalexternalmin.disabled=true;
						document.subjectForm.practicalexternalmax.disabled=true;
						document.subjectForm.projectinternalmin.disabled=true;
						document.subjectForm.projectinternalmax.disabled=true;
						document.subjectForm.projectexternalmin.disabled=true;
						document.subjectForm.projectexternalmax.disabled=true;
						document.subjectForm.chk.disabled=true;
						document.subjectForm.subjectids.disabled=true;
						
					}
					else
					{
						document.subjectForm.theoryinternalmin.disabled=false;
						document.subjectForm.theoryinternalmax.disabled=false;
						document.subjectForm.theoryexternalmin.disabled=false;
						document.subjectForm.theoryexternalmax.disabled=false;
						document.subjectForm.practicalinternalmin.disabled=false;
						document.subjectForm.practicalinternalmax.disabled=false;
						document.subjectForm.practicalexternalmin.disabled=false;
						document.subjectForm.practicalexternalmax.disabled=false;
						document.subjectForm.projectinternalmin.disabled=false;
						document.subjectForm.projectinternalmax.disabled=false;
						document.subjectForm.projectexternalmin.disabled=false;
						document.subjectForm.projectexternalmax.disabled=false;
					}
				}
			document.subjectForm.action="./subjectMarkSubmit.jsp";
			document.subjectForm.submit();
		}
	}
	else
	{
		alert("Select atleast One Subject ");
	}
}

function gotoSubjectCreation()
{
	document.subjectForm.action="../Subject/SubjectCreation.jsp";
	document.subjectForm.submit();
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

    <h2><%=bundle.getString("label.subject.marksettingsheadingpath") %></h2>
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
     String reqsubjectid = null;

     
     try
     {
    	 boardname = request.getParameter("reqboardname");
    	 standardname = request.getParameter("reqstandardname");
    	 standardid = request.getParameter("reqstandardid");
    	 reqgroupstatus = request.getParameter("reqgroupstatus");
    	  instituteid = (String)session.getValue("instituteid");
    	  subjecttypeList = subjectQuery.listSubjectType(instituteid);
    	  subjectList = subjectQuery.listSubjectMark(standardid);
    	  
    	 // BoardList = subjectQuery.listBoard(instituteid);
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
    
    <br><br>
    <div class="myScrollingDiv">
    <table border="1" cellpadding="5" cellspacing="0" width="100%">
    <tr class=tableheading><td rowspan=3 width="1%"><%=bundle.getString("label.subject.SL.No") %></td><td rowspan=3><%=bundle.getString("label.subject.SubjectName") %></td><td colspan=4 align=center><%=bundle.getString("label.subject.Theory") %></td><td colspan=4 align=center><%=bundle.getString("label.subject.Practical") %></td><td colspan=4 align=center><%=bundle.getString("label.subject.Project") %></td><td rowspan=3><%=bundle.getString("label.subject.Chk") %></td></tr>
    <tr class=tableheading>
    <td colspan="2" align=center><%=bundle.getString("label.subject.Internal") %></td><td colspan="2" align=center><%=bundle.getString("label.subject.External") %></td>
    <td colspan="2" align=center><%=bundle.getString("label.subject.Internal") %></td><td colspan="2" align=center><%=bundle.getString("label.subject.External") %></td>
    <td colspan="2" align=center><%=bundle.getString("label.subject.Internal") %></td><td colspan="2" align=center><%=bundle.getString("label.subject.External") %></td>
  
    </tr>
    <tr>
    <td><%=bundle.getString("label.subject.Min") %></td><td><%=bundle.getString("label.subject.Max") %></td><td><%=bundle.getString("label.subject.Min") %></td><td><%=bundle.getString("label.subject.Max") %></td>
    <td><%=bundle.getString("label.subject.Min") %></td><td><%=bundle.getString("label.subject.Max") %></td><td><%=bundle.getString("label.subject.Min") %></td><td><%=bundle.getString("label.subject.Max") %></td>
    <td><%=bundle.getString("label.subject.Min") %></td><td><%=bundle.getString("label.subject.Max") %></td><td><%=bundle.getString("label.subject.Min") %></td><td><%=bundle.getString("label.subject.Max") %></td>

    </tr>
    <%
    if(subjectList!=null && subjectList.size()>0)
	{int inc=1;
	//theoryinternalmin, theoryinternalmax, theoryexternalmin, theoryexternalmax,
	//practicalinternalmin,	practicalinternalmax, practicalexternalmin, practicalexternalmax, 
	//projectinternalmin,projectinternalmax, projectexternalmin, projectexternalmax

	 	for (int i1 = 0; i1 < subjectList.size(); i1++) {
	
		HashMap subjectListMap=(HashMap)subjectList.get(i1);
		String subjectid     = (String)subjectListMap.get("subjectid");
		String subjectname      = (String)subjectListMap.get("subjectname");
		String subjectcode      = (String)subjectListMap.get("subjectcode");
		String subjecttype      = (String)subjectListMap.get("subjecttype");
		String theoryinternalmin      = (String)subjectListMap.get("theoryinternalmin");
		String theoryinternalmax      = (String)subjectListMap.get("theoryinternalmax");
		String theoryexternalmin      = (String)subjectListMap.get("theoryexternalmin");
		String theoryexternalmax      = (String)subjectListMap.get("theoryexternalmax");
		if(theoryinternalmin ==null)
			theoryinternalmin = "";
		if(theoryinternalmax ==null)
			theoryinternalmax = "";
		if(theoryexternalmin ==null)
			theoryexternalmin = "";
		if(theoryexternalmax ==null)
			theoryexternalmax = "";
		
		String practicalinternalmin      = (String)subjectListMap.get("practicalinternalmin");
		String practicalinternalmax      = (String)subjectListMap.get("practicalinternalmax");
		String practicalexternalmin      = (String)subjectListMap.get("practicalexternalmin");
		String practicalexternalmax      = (String)subjectListMap.get("practicalexternalmax");
		
		
		if(practicalinternalmin ==null)
			practicalinternalmin = "";
		if(practicalinternalmax ==null)
			practicalinternalmax = "";
		if(practicalexternalmin ==null)
			practicalexternalmin = "";
		if(practicalexternalmax ==null)
			practicalexternalmax = "";
		
		String projectinternalmin      = (String)subjectListMap.get("projectinternalmin");
		String projectinternalmax      = (String)subjectListMap.get("projectinternalmax");
		String projectexternalmin      = (String)subjectListMap.get("projectexternalmin");
		String projectexternalmax      = (String)subjectListMap.get("projectexternalmax");
		if(projectinternalmin ==null)
			projectinternalmin = "";
		if(projectinternalmax ==null)
			projectinternalmax = "";
		if(projectexternalmin ==null)
			projectexternalmin = "";
		if(projectexternalmax ==null)
			projectexternalmax = "";
		out.println("<tr><td>"+(inc++)+"</td><td><input type=hidden name='subjectids' value='"+subjectid+"'>"+subjectname+"</td>");
		out.println("<td><input type=text name=theoryinternalmin value='"+theoryinternalmin+"' size=3 maxlength=3 onkeypress=\"return onlyNumbers(event);\"></td>");
		out.println("<td><input type=text name=theoryinternalmax value='"+theoryinternalmax+"' size=3 maxlength=3 onkeypress=\"return onlyNumbers(event);\"></td>");
		out.println("<td><input type=text name=theoryexternalmin value='"+theoryexternalmin+"' size=3 maxlength=3 onkeypress=\"return onlyNumbers(event);\"></td>");
		out.println("<td><input type=text name=theoryexternalmax value='"+theoryexternalmax+"' size=3 maxlength=3 onkeypress=\"return onlyNumbers(event);\"></td>");
		
		out.println("<td><input type=text name=practicalinternalmin value='"+practicalinternalmin+"' size=3 maxlength=3 onkeypress=\"return onlyNumbers(event);\"></td>");
		out.println("<td><input type=text name=practicalinternalmax value='"+practicalinternalmax+"' size=3 maxlength=3 onkeypress=\"return onlyNumbers(event);\"></td>");
		out.println("<td><input type=text name=practicalexternalmin value='"+practicalexternalmin+"' size=3 maxlength=3 onkeypress=\"return onlyNumbers(event);\"></td>");
		out.println("<td><input type=text name=practicalexternalmax value='"+practicalexternalmax+"' size=3 maxlength=3 onkeypress=\"return onlyNumbers(event);\"></td>");
		
		out.println("<td><input type=text name=projectinternalmin value='"+projectinternalmin+"' size=3 maxlength=3 onkeypress=\"return onlyNumbers(event);\"></td>");
		out.println("<td><input type=text name=projectinternalmax value='"+projectinternalmax+"' size=3 maxlength=3 onkeypress=\"return onlyNumbers(event);\"></td>");
		out.println("<td><input type=text name=projectexternalmin value='"+projectexternalmin+"' size=3 maxlength=3 onkeypress=\"return onlyNumbers(event);\"></td>");
		out.println("<td><input type=text name=projectexternalmax value='"+projectexternalmax+"' size=3 maxlength=3 onkeypress=\"return onlyNumbers(event);\"></td>");
		out.print("<td><input type=checkbox name=chk class=tablelight no='"+i1+"' onclick='checkonclick(this)' value='"+subjectid+"'></td></tr>");
	
	 	
	 	}
	}
    else
    {
    	out.println("<tr><td colspan=15 align=center ><b><font color='red' >"+bundle.getString("label.datanotfound.apprsrc")+"</font></b></td></tr>");
    }
    %>
    </table>
    </div>

     <a href="#" onclick="gotoSubjectCreation()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.subject.BacktoSubjectCreation") %></strong><span class="bt_blue_r"></span></a>
     <% if(subjectList!=null && subjectList.size()>0){%>
     <a href="#" class="bt_green" onclick="addSubjectMarks()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.subject.Submit") %></strong><span class="bt_green_r"></span></a>
     <%} %>
     <input type="hidden" name="reqstandardid" value="<%=standardid %>">
     <input type="hidden" name="reqstandardname" value="<%=standardname %>">
     <input type="hidden" name="reqboardid" value="<%=reqboardid %>">
     <input type="hidden" name="reqboardname" value="<%=boardname %>">
     <input type="hidden" name="reqgroupstatus" value="<%=reqgroupstatus %>">
     
     <input type="hidden" name="reqsubjectname" >
     <input type="hidden" name="reqsubjectid" >
     
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>
