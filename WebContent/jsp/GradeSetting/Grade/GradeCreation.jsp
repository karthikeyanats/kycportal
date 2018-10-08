<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.gradecreation.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function backfun()
{
		document.gradeForm.action="../Scale/ScaleList.jsp";
		document.gradeForm.submit();		
}
function goLessonCreation(obj)
{
    document.gradeForm.reqgradeid.value = obj.getAttribute("gradeid");
    document.gradeForm.reqgradename.value = obj.getAttribute("gradename");
	document.gradeForm.action="../Lesson/LessonCreation.jsp";
	document.gradeForm.submit();
}
var validflag  =false;

function checkfun(obj)     
{
	chkid = obj.getAttribute("chkid"); 
	var checkoption		= "no";

	if(obj.checked)
	{
		if(!check_ForParticularElements(document.gradeForm.gradename[chkid],"text")){
			document.gradeForm.check[chkid].checked=false;
			document.gradeForm.gradename[chkid].disabled=false;
			return;
		}
	else{
		
				if(document.gradeForm.check[chkid].checked)  
				{
					
					for(var k=0;k<document.gradeForm.check.length;k++)
					{
						if(chkid!=k)
							{
								if(document.gradeForm.check[k].checked)
									{
										if(document.gradeForm.gradename[chkid].value==document.gradeForm.gradename[k].value)
										{ 
										 	checkoption="yes";   
										}
									}
							}
						}
				}
			
			//}	
	
		}
		if(checkoption=="yes")
		{
			alert("Same Grade Name Not Allowed");
			document.gradeForm.check[chkid].checked=false;
			document.gradeForm.gradename[chkid].focus();
			return false;
		}

		if(checkoption=="no")
		{
			checkDuplicate(document.gradeForm.gradename[chkid].value,"duplicategradename",chkid);
			validflag  =true;
		}
		}
		else
		{
			document.gradeForm.gradename[chkid].disabled=false;	
		}

}
function checkDuplicate(givenstring,flag,chkid)
{      
	   var url = "";
	   var date = new Date();

	   if(flag=="duplicategradename")
	   {
	   	   url = "GradeInfo.jsp?action=duplicategradenameentry&gradename="+givenstring+"&reqscaleid="+document.gradeForm.reqscaleid.value+"&date="+date;
	   } 
	  
	   var req =initRequest();
	   req.onreadystatechange = function()
	   {
		   if (req.readyState == 4)
		   {
			   if (req.status == 200)
			   {
				   if(flag=="duplicategradename",chkid)
				  {
				  	parseMessages(req.responseXML,flag,chkid)  
				  }
			  }
			} 
		};
	   req.open("GET", url, true);
	   req.send(null);
	}   
	   
	function parseMessages(xmlObj,flag,chkid)
	{  
		if(flag=="duplicategradename")
		{			           
		
				var rootObj=xmlObj.getElementsByTagName("duplicate");
				var cNode_1=rootObj[0].childNodes.length;
		 		for(var i=0;i<parseInt(cNode_1);i++)
				{
					var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
				}
				if(temp=="true")
				{
					alert("Grade Name already exists"); 
					validflag=false;
					document.gradeForm.gradename[chkid].focus();
					document.gradeForm.check[chkid].checked=false;
					return false;
				}
				else
				{
				   	validflag=true;
	   				document.gradeForm.gradename[chkid].disabled=true;
				}
			} 
	}
function addGrade()
{      

	if(validflag)
	{
		for(var x1=0;x1<document.gradeForm.check.length;x1++)
		{
			if(document.gradeForm.check[x1].checked)
			{
				document.gradeForm.gradename[x1].disabled =false;
			}
			else
			{
				document.gradeForm.gradename[x1].disabled=true;
			}
			
		}

		if(confirm("Do you want to submit the Grade(s)...?")){
		document.gradeForm.action="./GradeSubmit.jsp";
		document.gradeForm.submit();
		}
} 
else
{
alert("Select Any one Grade");
}

}     
function editgrade(obj)
{
if(confirm("Do you want to Update the Grade...?"))
	{
		document.gradeForm.reqgradeid.value = obj.getAttribute("gradeid");
		document.gradeForm.action="./GradeEdit.jsp";
		document.gradeForm.submit();
	}
}

function trashgrade(obj)
{
	if(confirm("Do you want to Trash the Grade...?"))
	{
			var gradeid=obj.getAttribute("gradeid"); 
			var gradename=obj.getAttribute("gradename");
			document.gradeForm.EditStatus.value="T";
			document.gradeForm.gradeid.value=gradeid;
			document.gradeForm.reqgradename.value=gradename;
			document.gradeForm.action="./GradeDetails.jsp";
			document.gradeForm.submit(); 		
	}
}   
  
function TrashListfun()
{
document.gradeForm.action="./GradeTrashList.jsp";
document.gradeForm.submit();
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

    <h2><%=bundle.getString("label.gradecreation.entryrootpath") %></h2>
<form name="gradeForm" action="" method="post">
     <input type="hidden" name="EditStatus" value="">

  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.GradeSetting.GradeScaleQuery"%>

     <%
     
     com.iGrandee.GradeSetting.GradeScaleQuery  gradescaleQuery = new com.iGrandee.GradeSetting.GradeScaleQuery();
     String instituteid = null;

     String reqboardid = null;
     String boardname = null;
     String scalename = null;
     String scaleid = null;
     String reqgroupstatus = null;
     ArrayList gradeList = null;

     
     try
     {
    	 reqboardid 		= request.getParameter("reqboardid");
    	 boardname	 		= request.getParameter("reqboardname");
    	 scalename 		= request.getParameter("reqscalename");
    	 scaleid 		= request.getParameter("reqscaleid");
    	 reqgroupstatus 	= request.getParameter("reqgroupstatus");
    	 instituteid 		= (String)session.getValue("instituteid");
    	 gradeList 		= gradescaleQuery.listGrade(scaleid,instituteid,"A");
    	  

    }catch(Exception e){}
    
    %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.gradecreation.SelectedInfo") %></th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
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
	    			<td><a class=tablebold><%=bundle.getString("label.gradecreation.BoardName") %></a></td><td class=tablebold>:</td><td><%=boardname %></td>
	    			<td><a class=tablebold><%=bundle.getString("label.gradecreation.StandardName") %></a></td><td class=tablebold>:</td><td><%=scalename %></td>
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
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.gradecreation.SL.No") %></th>
        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.gradecreation.SubjectName") %></th>
        	<th scope="col" class="rounded" width="10%"><%=bundle.getString("label.gradecreation.Chk") %></th>
        	  <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.gradecreation.Edit") %></th>
        	
        	<th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.gradecreation.Trash") %></th>
       	</tr>
    </thead>
    <tfoot>
    	<tr> 
        	<td colspan=4 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody> 
   <%
   int sno=1;
   if(gradeList!=null && gradeList.size()>0)
	{
	   ////gradeid, gradename, , gradeypename
	 	for (int i1 = 0; i1 < gradeList.size(); i1++,sno++) {
	
		HashMap gradeListMap=(HashMap)gradeList.get(i1);
		String gradeid     = (String)gradeListMap.get("gradeid");
		String gradename      = (String)gradeListMap.get("gradename");
	%>
	<tr>
	<td><%=sno %></td>
	<td><%=gradename%></td>
	<!-- <td><a href="#"  gradename="<%=gradename %>" gradeid="<%=gradeid %>" onclick="goLessonCreation(this)"><%=gradename %></a></td>-->
	<td>-</td>
	<td><a href="#"  gradename="<%=gradename %>"  gradeid="<%=gradeid %>" onclick="editgrade(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Edit" border="0" /></a></td>
		<td><a href="#"  gradename="<%=gradename %>"  gradeid="<%=gradeid %>" onclick="trashgrade(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="Trash" border="0" /></a></td>
	
	</tr>
	<% 	
	
	 }
	}
   
   for(int x=0;x<5;x++,sno++)
   {%>
	 <tr>
	 <td><%=sno %></td>
	  <td><input type="text" name="gradename" validate="Grade Name" size="30" maxlength="50" class="tablelight" ></td>
	 <td><input type="checkbox" name="check" chkid="<%=x%>" size="5" class="tablelight" onclick="checkfun(this)"/></td>
	 	<td>-</td>
	 	<td>-</td>
	 </tr>
   <%}   
              
   %>   

    </tbody>
</table>

     <a href="#back" name="back" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.gradecreation.BackToStandardList") %> </strong><span class="bt_blue_r"></span></a>
          <a href="#trashli" name="trashlist" class="bt_blue" onclick="TrashListfun()" ><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.gradecreation.TrashList") %> </strong><span class="bt_blue_r"></span></a>
     
          <a href="#" class="bt_green" onclick="addGrade()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.gradecreation.Submit") %></strong><span class="bt_green_r"></span></a>
          
     
     <input type="hidden" name="reqscaleid" value="<%=scaleid %>">
     <input type="hidden" name="reqscalename" value="<%=scalename %>">
     <input type="hidden" name="reqboardid" value="<%=reqboardid %>">
     <input type="hidden" name="reqboardname" value="<%=boardname %>">
     <input type="hidden" name="reqgroupstatus" value="<%=reqgroupstatus %>">
     <input type="hidden" name="reqgradename" >
     <input type="hidden" name="reqgradeid" >
     <input type="hidden" name="gradetypeid" > 
     <input type="hidden" name="gradeid" value="">
    
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->
   



    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>
