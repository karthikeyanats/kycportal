<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
java.util.ResourceBundle bundle  =java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student Promotion | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

var a=0;
function chkval(obj)
{
	if(obj.checked)
		a++;
	else
		a--;


}
		
function promoFun(result)
{
		//alert("result-->"+result);
		
		var test=false;
		document.approvalForm.promoResult.value  		= result;	
		document.approvalForm.promoSessionName.value  	= document.approvalForm.promoSession.options[document.approvalForm.promoSession.options.selectedIndex].text
		//document.approvalForm.promoBoardName.value  	= document.approvalForm.promoBoard.options[document.approvalForm.promoBoard.options.selectedIndex].text
		document.approvalForm.promoStandardName.value  	= document.approvalForm.promoStandard.options[document.approvalForm.promoStandard.options.selectedIndex].text
		var stdIdTotAllSeats  	= document.approvalForm.promoStandard.options[document.approvalForm.promoStandard.options.selectedIndex].value
		document.approvalForm.promoStandardSchedId.value = stdIdTotAllSeats.split("@")[0];
		//document.approvalForm.totalSeats.value = stdIdTotAllSeats.split("@")[1];
		//document.approvalForm.allocatedSeats.value = stdIdTotAllSeats.split("@")[2];
		
		var totalSeats = stdIdTotAllSeats.split("@")[1];
		var allocatedSeats = stdIdTotAllSeats.split("@")[2];
		
//alert(document.approvalForm.promoStandardSchedId.value);
//alert(document.approvalForm.totalSeats.value);
//alert(document.approvalForm.allocatedSeats.value);
		//document.approvalForm.promoSectionName.value  	= document.approvalForm.promoSection.options[document.approvalForm.promoSection.options.selectedIndex].text
		//document.approvalForm.promoSecSchedId.value  	= document.approvalForm.promoSection.options[document.approvalForm.promoSection.options.selectedIndex].value
		
		if(result == "Pass")
		{
			var confirmResult = "Promote";
		}
		if(result == "Fail")
		{
			var confirmResult = "DePromote";
		}
		
		if(document.approvalForm.chk.length==undefined)
		{
			if(document.approvalForm.chk.checked==true)
			{
				if(document.approvalForm.promoSession.value=="00")
				{
					alert("Select Academic Year")
					document.approvalForm.promoSession.focus();
					return				
				}
				
				/*else if(document.approvalForm.promoBoard.value=="00")
				{
					alert("Select Board")
					document.approvalForm.promoBoard.focus();
					return
				
				}*/
				else if(document.approvalForm.promoStandard.value=="0")
				{
					alert("Select Standard")
					document.approvalForm.promoStandard.focus();
					return
				
				}
				/*else if(document.approvalForm.promoSection.value=="0")
				{
					alert("Select Section")
					document.approvalForm.promoSection.focus();
					return				
				}*/
				
				if(parseInt(totalSeats) >= parseInt(allocatedSeats)+1)
				{
					if(confirm("Do you want to "+confirmResult+" the Selected Student(s)..?"))
					{
					document.approvalForm.action="./StudPromotePreview.jsp";
	    	  		document.approvalForm.submit();
	    	  		}
    	  		}
    	  		else
    	  		{
    	  			var availSeats;
    	  			if(parseInt(totalSeats)-parseInt(allocatedSeats) < 0)
    	  				availSeats = 0;
    	  			else
    	  				availSeats = parseInt(totalSeats)-parseInt(allocatedSeats);

    	  			alert("Promotion exceeds Total Seats"+ '\n\n' + "Total Seats:"+parseInt(totalSeats)+ '\n\n' + "Available Seats :"+availSeats+'\n\n' + "Allocated Seats :"+allocatedSeats);
    	  		}										
			}
			else
			{
				alert("Select CheckBox")
			}
		}
		else
		{
  		for(i=0;i<document.approvalForm.chk.length;i++)
  		{
  			if(document.approvalForm.chk[i].checked==true)
  			{
  			        test=true;
  			}

  		}
  		if(test==true )
		{
				if(document.approvalForm.promoSession.value=="00")
				{
					alert("Select Academic Year")
					document.approvalForm.promoSession.focus();
					return				
				}
				
				/*else if(document.approvalForm.promoBoard.value=="00")
				{
					alert("Select Board")
					document.approvalForm.promoBoard.focus();
					return
				
				}*/
				else if(document.approvalForm.promoStandard.value=="0")
				{
					alert("Select Standard")
					document.approvalForm.promoStandard.focus();
					return
				
				}
				/*else if(document.approvalForm.promoSection.value=="0")
				{
					alert("Select Section")
					document.approvalForm.promoSection.focus();
					return				
				}*/
				
				var totAlltSeats = parseInt(allocatedSeats);
				
		  		for(i=0;i<document.approvalForm.chk.length;i++)
		  		{
		  			if(document.approvalForm.chk[i].checked==true)
		  			{
		  			        test=true;
		  			        totAlltSeats = totAlltSeats+1;
		  			}
		
		  		}
		  		if(test==true )
				{
					if(parseInt(totalSeats) >= parseInt(totAlltSeats))
					{
							if(confirm("Do you want to "+confirmResult+" the Selected Student(s)..?"))
							{
			    	   		document.approvalForm.action="./StudPromotePreview.jsp";
			    	  		document.approvalForm.submit();
			    	  		}
				    }
		    	  	else
		    	  	{
		    	  			var availSeats;
		    	  			if(parseInt(totalSeats)-parseInt(allocatedSeats) < 0)
		    	  				availSeats = 0;
		    	  			else
		    	  				availSeats = parseInt(totalSeats)-parseInt(allocatedSeats);
		
		    	  			alert("Promotion exceeds Total Seats"+ '\n\n' + "Total Seats:"+parseInt(totalSeats)+ '\n\n' + "Available Seats :"+availSeats+'\n\n' + "Allocated Seats :"+allocatedSeats);
		    	  	}		
		
		
		        }

        }
        else
        {
			alert("Select CheckBox")
		}
	}
}

function selectallfun()
{

	if(document.approvalForm.chk.length == null)
	{
		document.approvalForm.chk.checked=true;
	}
	else
	{
		for(var x=0;x<document.approvalForm.chk.length;x++)
		{
			document.approvalForm.chk[x].checked=true;
		}

	}
}
function deselectallfun()
{
	if(document.approvalForm.chk.length == null)
	{
		document.approvalForm.chk.checked=false;
	}
	else
	{
		for(var x=0;x<document.approvalForm.chk.length;x++)
		{
			document.approvalForm.chk[x].checked=false;
		}

	}
}

function goBack()
{
	document.approvalForm.action="StudPromoSelect.jsp";
	document.approvalForm.submit();
}
 
 var xmlHttp;
  

	function initRequest()
	{		
	   if(window.XMLHttpRequest)
	   {
		   return new XMLHttpRequest();
	   }
	   else
	   if (window.ActiveXObject)
	   {
		   isIE = true;
		   return new ActiveXObject("Microsoft.XMLHTTP");
	   }
	}	 
	 
	function loadStandard(boardid)
	{
		//var req=initRequest();
		var sessionid = document.approvalForm.promoSession.options[document.approvalForm.promoSession.options.selectedIndex].value
		var url="getAction.jsp?Action=loadStandard&sessionid="+sessionid+"&boardid="+boardid;
		var req =initRequest();
		req.onreadystatechange = function() // Callback function
		{
			if (req.readyState == 4)
			{
				if (req.status == 200)
				{
					var rootObject=req.responseXML.getElementsByTagName("standardList");
					var cNode_1=rootObject[0].childNodes.length;
					if(document.approvalForm.promoStandard!=null)
					{
						for(var i=document.approvalForm.promoStandard.options.length-1;i>-1;i--)
						{
								document.approvalForm.promoStandard.options[i]=null;
						}
					} 
					document.approvalForm.promoStandard.options[document.approvalForm.promoStandard.options.length] = new Option("-Select Standard-",0);
					if(cNode_1!=0) 
					{
						for(var i=0;i<parseInt(cNode_1);i++)
						{
							var stdSchedId=rootObject[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
	 						var stdName=rootObject[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
	 						var totSeats=rootObject[0].childNodes.item(i).childNodes.item(2).firstChild.nodeValue;
	 						var allcSeats=rootObject[0].childNodes.item(i).childNodes.item(3).firstChild.nodeValue
	 						//var location=rootObject[0].childNodes.item(i).childNodes.item(2).firstChild.nodeValue;
	 						document.approvalForm.promoStandard.options[document.approvalForm.promoStandard.options.length] = new Option(stdName,stdSchedId+"@"+totSeats+"@"+allcSeats); 						
	  				   	}
					}
					else
					{
					}
				}
			}
		}
		req.open("GET", url, true);
		req.send(null);
	}

	function loadSection(secSchedId)
	{
		//var req=initRequest();
		var url="getAction.jsp?Action=loadSection&secSchedId="+secSchedId;
		var req =initRequest();
		req.onreadystatechange = function()  {// Callback function
			if (req.readyState == 4){
				if (req.status == 200){
					var rootObject=req.responseXML.getElementsByTagName("sectionList");
					var cNode_1=rootObject[0].childNodes.length;
	 				if(document.approvalForm.promoSection!=null){
						for(var i=document.approvalForm.promoSection.options.length-1;i>-1;i--){
							document.approvalForm.promoSection.options[i]=null;
						}
					}
					document.approvalForm.promoSection.options[document.approvalForm.promoSection.options.length] = new Option("-Select Section-",0);
					if(cNode_1!=0){
						for(var i=0;i<parseInt(cNode_1);i++){
							var secSchedId=rootObject[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
	 						var secName=rootObject[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
	  						document.approvalForm.promoSection.options[document.approvalForm.promoSection.options.length] = new Option(secName,secSchedId);
						}
					}
					else{}
				}
			}
		}
		req.open("GET", url, true);
		req.send(null);
	}	 
</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="approvalForm" action="" method="post">
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

    <h2>Enrollment / Student Enrollment / Student Promotion</h2>


<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="100%">Selected Information </th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>


	 <%
	 	com.iGrandee.Promotion.PromotionQuery  promotionQuery = new com.iGrandee.Promotion.PromotionQuery();
	 	com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
	 	com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();	

		String Regno=null;
		String applicantName=null;
		String applicationNo=null;
		String studentallocationid="";
		String dateofallocation=null;
		String promotionStatus=null;
		
		String rollNo="";
		int rollNoNote = 0;
		String sessionid=request.getParameter("req_sessionid");
 		String boardid=request.getParameter("req_boardid");
 		//out.println("boardid==>"+boardid);
 		String stdscheduleid=request.getParameter("course");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("req_sessionname");
		String boardName=request.getParameter("req_boardname");
		String courseName=request.getParameter("standardnamegp");
		String secName=request.getParameter("req_sectionname");
		String secSchedId=request.getParameter("req_sectionpubid");
		//out.println("secSchedId-->"+secSchedId+"secName-->"+secName);
		ArrayList registeredList= null;
		ArrayList sectionList= null;

		//out.println("<script>alert('"+sessionid+"')</script>");
		//out.println("<script>alert('"+stdscheduleid+"')</script>");
		//out.println("<script>alert('"+secSchedId+"')</script>");
		//registeredList	=	(ArrayList)registrationQuery.displayAllocatedDetails(sessionid,stdscheduleid,secSchedId);
		//out.println(secSchedId);
		registeredList	=	(ArrayList)promotionQuery.displayToPromoteDetails(secSchedId);
		sectionList		=	(ArrayList)registrationQuery.listSections(stdscheduleid);
	    String instituteid = null;
	    ArrayList BoardList = null;
	    try
	    {
	    	instituteid = (String)session.getValue("instituteid");
	    	BoardList = standardQuery.listBoard(instituteid);
	    }catch(Exception e){}
		//ArrayList yearList = registrationQuery.listYearofSessiontoPromote(sessionid);
		ArrayList yearList = registrationQuery.listActiveYearofSession(instituteid);
		ArrayList standardList = registrationQuery.listStandard(sessionid,boardid);
       %>

			<br>

<tr><td colspan="2" ><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%">Academic Year</td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=yearofsession %></td>
	<td class=tablebold>Board </td><td class=tablebold width='2%'>:</td><td  colspan=2  class=tablelight><%=boardName %></td>
</tr>
<tr><td class=tablebold width="25%">Standard</td><td class=tablebold width='2%'>:</td><td class=tablelight><%=courseName %></td>
<td class=tablebold width="25%">Section</td><td class=tablebold width='2%'>:</td><td class=tablelight><%=secName%></td>
</tr>
</table>
</td></tr>
</table>

<table border=0 cellpadding=5 cellspacing=0 align=center width="80%" rules=groups>
<% 
		if(registeredList.size()!=0)
		{
			int checkCount = 0;
			for(int i=0;i<registeredList.size();i++)
			{
				//count=count+1;
				HashMap map			=	(HashMap)registeredList.get(i);
				promotionStatus		=	(String) map.get("promotionstatus");
				if(promotionStatus.equals("NotPromoted"))
				{
					checkCount++;
				}
			}
			out.print("<br>");
			if(checkCount>0)
			{		
		%>
		<table border=0 cellpadding=3 cellspacing=0 width="100%" align=center>
		<tr><td align=right>
		<a href="javascript:void(0)" onclick=selectallfun() class=tablebold>Select All</a> &nbsp;
		<a href="javascript:void(0)" onclick=deselectallfun() class=tablebold>Deselect All</a>
		
		</td></tr>
		</table>
		<% 
		}
		}
		else
		{
			out.print("<br>");
		}
%>
<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="7%">Sl.No</th>
            <th scope="col" class="rounded" width="20%">Applicant Name</th>
            <th scope="col" class="rounded" width="15%">Application No.</th>
            <th scope="col" class="rounded" width="20%">Roll No.</th>
            <th scope="col" class="rounded" width="25%">Date of Allocation</th>
            <th scope="col" class="rounded-q4" width="15%">Check</th>            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="5" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
  


	<%
	 int count=0;
	boolean flag = false;
	//out.print("registeredList-->"+registeredList.size());
	if(registeredList.size()!=0)
	{
		for(int i=0;i<registeredList.size();i++)
		{
			count=count+1;
			HashMap map				=	(HashMap)registeredList.get(i);
			applicantName			=	(String) map.get("applicantname");
			applicationNo			=	(String) map.get("applicationno");
			studentallocationid		=	(String) map.get("studentallocationid");
			rollNo					=	(String) map.get("rollno");
			dateofallocation 		=	(String) map.get("dateofallocation");
			promotionStatus	=	(String) map.get("promotionstatus");
			
			if(rollNo==null){
				rollNo = "<font color=red><i>-NYG-</i></font>";
				rollNoNote = rollNoNote+1;
			}

			out.print("<tr><td>"+(i+1)+"</td><td>"+applicantName+"</td><td>"+applicationNo+"</td><td>"+rollNo+"</td><td>"+dateofallocation+"</td>");
			//out.println("<td align='left'><input type='checkbox' name='chk' value="+studentallocationid+"@"+count+" onclick=chkval(this)></td></tr>");
			if(promotionStatus.equals("NotPromoted"))
			{
				flag = true;
				out.println("<td align='left'><input type='checkbox' name='chk' value="+studentallocationid+"@"+count+" onclick=chkval(this)></td></tr>");
				
			}
			else
			{				
				//out.println("<td align='left'><input type='checkbox' name='chk' value="+studentallocationid+"@"+count+" onclick=chkval(this)></td></tr>");
				//out.print("<td align='left'><input type='checkbox' disabled></td></tr>");
				out.print("<td >"+promotionStatus+"</td></tr>");
			}

		}
	}
	else
	  {
		  out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
	  }


	%>
</table>
</table>

					<% 
					if(rollNoNote>0)
					{
					%>
					<br>
					<tr>
					<td valign=top colspan=2>
						<b>Note: </b></td><td>&nbsp;</td><td>NYG - Not Yet Generated</td>
					</tr>  
					<br>
					<%}%>

<br>
<% 
if(flag)
{
%>						
						
<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="80%">Promote / De-Promote To </th>
            <th scope="col" class="rounded-q4" width="20%"><font color=red>*</font> <%=bundle.getString("label.common.mandatory") %></th>     
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
				<td class=tablebold>Academic Year<font color="red">*</font></td>
				<td class=tablebold width='2%'>:</td>
				<td>
					<select name=promoSession class=tablelight onchange=loadStandard(<%=boardid%>)>
						<option value="00">-Select Academic-</option>
						<%
							for(int s=0;s<yearList.size();s++)
							{
								HashMap map=(HashMap)yearList.get(s);
								String promoSessionid=(String)map.get("sessionid");
								String promoYearofsession=(String)map.get("sessionname");
								//String session_status=(String)map.get("status");
								if(request.getParameter("req_sessionid") != null)
								{
									if(request.getParameter("req_sessionid").equals(promoSessionid))
										out.println("<option value='"+promoSessionid+"'>"+promoYearofsession+"</option>");
									else
										out.println("<option value='"+promoSessionid+"'>"+promoYearofsession+"</option>");
								}
								else
								{
									out.println("<option value='"+promoSessionid+"'>"+promoYearofsession+"</option>");
								}
							}
						%>
					</select>
				</td>

				<!--  <td class=tablebold>Board <font color="red">*</font></td>
				<td>
					<select name=promoBoard class=tablelight onchange=loadStandard(this.value)>
						<option value="00">-Select Board-</option>
						<%
					      	if(BoardList!=null && BoardList.size()>0)
							{
			  		 			for (int i = 0, j = 1; i < BoardList.size(); i++) 
			  		 			{
									HashMap boardListMap=(HashMap)BoardList.get(i);
									String promoboardId     = (String)boardListMap.get("boardid");
									String promoboardName      = (String)boardListMap.get("boardname");
									String promomediumId      = (String)boardListMap.get("mediumid");
									String promomediumName      = (String)boardListMap.get("mediumname");
									
									if(promoboardId.equals(boardid))
									{
										out.println("<option value='"+promoboardId+"' class=tablelight >"+promoboardName+"-"+promomediumName+"</option>");
									}
									else
									{
										out.println("<option value='"+promoboardId+"' class=tablelight >"+promoboardName+"-"+promomediumName+"</option>");
									}
									
									//out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");
						  		 }
							}
						%>
					</select>
				</td>
			</tr>
			<tr>-->
				<td class=tablebold>Standard <font color="red">*</font></td>
				<td class=tablebold width='2%'>:</td>
				<td >
					<select name="promoStandard" class=tablelight >
						<option value="0"> -- Select Standard -- </option>
					</select>
				</td>
				
				<!--  <td class=tablebold>Section <font color="red">*</font></td>
				<td >
					<select name="promoSection" class=tablelight >
						<option value="none"> -- Select Section -- </option>
					</select>
				</td>-->
			</tr>
			
				

</table>
</td></tr>
</table>

											
<%
//out.print("registeredList.size()-->"+registeredList.size());
 if(registeredList.size()!=0)
      {
%>
	
		<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_red" onclick="promoFun('Fail')"><span class="bt_red_lft"></span><strong>DePromote</strong><span class="bt_red_r"></span></a>
		<a href="#" class="bt_green" onclick="promoFun('Pass')"><span class="bt_green_lft"></span><strong>Promote</strong><span class="bt_green_r"></span></a>
		
	<%
	}
	}
	else
	{
	%>
	<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

	<%
	}
	%>

		<input type=hidden name=req_sessionid value='<%=sessionid%>'>
		<input type=hidden name=req_boardid value='<%=boardid%>'>
<input type='hidden' name='user_mode' value='none'>
<input type='hidden' name='stdscheduleid' value='<%=stdscheduleid%>'>
<input type='hidden' name='sectionSchedId' value='<%=secSchedId%>'>

<input type='hidden' name='studentallocationid' value='<%=studentallocationid%>'>


		<input type=hidden name=promoSessionName>
		<input type=hidden name=promoBoardName value='<%=boardName%>'>
		<input type=hidden name=promoStandardName>
		<input type=hidden name=promoStandardSchedId>
		<!--  <input type=hidden name=totalSeats>
		<input type=hidden name=allocatedSeats>-->
		
		<input type=hidden name=promoSectionName>
		<input type=hidden name=promoSecSchedId>
		<input type=hidden name=promoResult>
		
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>