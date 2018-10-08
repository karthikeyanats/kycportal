<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">

function loadStandard()
{
	document.standardForm.reqboardid.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].value;
	document.standardForm.reqboardname.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].text;
	
	document.standardForm.action="StandardList.jsp";
	document.standardForm.submit();
}
function goSubject(obj)
{

	document.standardForm.reqboardid.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].value;
	document.standardForm.reqboardname.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].text;
	document.standardForm.reqstandardid.value = obj.getAttribute("standardid");
	document.standardForm.reqstandardname.value = obj.getAttribute("standardname");
	document.standardForm.reqgroupstatus.value = obj.getAttribute("groupstatus");
	document.standardForm.action="../Subject/SubjectCreation.jsp";
	document.standardForm.submit();
	

}
function categoryEdit(obj)
{
if(confirm("Do you want to Update the StaffCategory...?"))
{
var staffcategoryid=obj.getAttribute("staffcategoryid");
var categoryname=obj.getAttribute("categoryname");


	document.standardForm.staffcategoryid.value=staffcategoryid;
	document.standardForm.categoryname.value=categoryname;
	document.standardForm.action="categoryEdit.jsp";
	document.standardForm.submit();
} 
else
{}
}
function categoryTrash(obj)
{

				url = "../StudentPromotion/getAction.jsp?Action=getStaffCategory&staffcategoryid="+obj.getAttribute("staffcategoryid");
	
				var req=null;
			
				try
				  {
				  // Firefox, Opera 8.0+, Safari
				  req=new XMLHttpRequest();
				  }
				catch (e)
				  {
				  // Internet Explorer
				  try
				    {
				    req=new ActiveXObject("Msxml2.XMLHTTP");
				    }
				  catch (e)
				    {
				    req=new ActiveXObject("Microsoft.XMLHTTP");
				    }
				  }
				  //alert(req)
				
						req.onreadystatechange = function()
						{
						//	alert(req.readyState)
							if (req.readyState == 4)
							   {
								//   alert(req.status)
							  		 if(req.status == 200)
									 {
					              			var parseXML=req.responseXML;
				
											var rootObj=parseXML.getElementsByTagName("checkNumber");
											var cNode_1=rootObj[0].childNodes.length;
											var username=null;
											var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
											//var finalValue=rootObj[0].childNodes[0].selectSingleNode("finalValue").text;

											if(finalValue=="1")
											{
												alert("StaffCategory was allocated. You cant Trash")
											}
											else
											{
												if(confirm("Do you want To Trash the StaffCategory...?"))
												{
												var staffcategoryid=obj.getAttribute("staffcategoryid");
												var categoryname=obj.getAttribute("categoryname");
												
												document.standardForm.staffcategoryid_temp.value=staffcategoryid;
												document.standardForm.staffcategoryname_temp.value=categoryname;
												document.standardForm.action="StaffcategoryAction.jsp?mode_of_operation=staffcategorytrash";
												document.standardForm.submit();
												}
											}
			
									  }
								   	 else if (req.status == 204)
								     {
									 }
							   	}
					   };
					req.open("GET",url,true);
					req.send(null);
					
					
}
function categoryDeactive(obj)
{
	url = "../StudentPromotion/getAction.jsp?Action=getStaffCategory&staffcategoryid="+obj.getAttribute("staffcategoryid");

	
				var req=null;
			
				try
				  {
				  // Firefox, Opera 8.0+, Safari
				  req=new XMLHttpRequest();
				  }
				catch (e)
				  {
				  // Internet Explorer
				  try
				    {
				    req=new ActiveXObject("Msxml2.XMLHTTP");
				    }
				  catch (e)
				    {
				    req=new ActiveXObject("Microsoft.XMLHTTP");
				    }
				  }
				  //alert(req)
				
						req.onreadystatechange = function()
						{
						//	alert(req.readyState)
							if (req.readyState == 4)
							   {
								//   alert(req.status)
							  		 if(req.status == 200)
									 {
					              			var parseXML=req.responseXML;
				
											var rootObj=parseXML.getElementsByTagName("checkNumber");
											var cNode_1=rootObj[0].childNodes.length;
											var username=null;
											var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
											//var finalValue=rootObj[0].childNodes[0].selectSingleNode("finalValue").text;

											if(finalValue=="1")
											{
												
												alert("StaffCategory was allocated. You cant Deactivate")
											}
											else
											{
												if(confirm("Do you want to  Deactivate the  Staff Category...?"))
												{
												var staffcategoryid=obj.getAttribute("staffcategoryid");
												var categoryname=obj.getAttribute("categoryname");
												
												document.standardForm.staffcategoryid_temp.value=staffcategoryid;
												document.standardForm.staffcategoryname_temp.value=categoryname;
												document.standardForm.action="StaffcategoryAction.jsp?mode_of_operation=staffdeactive";
												document.standardForm.submit();												
												}
											}
			
									  }
								   	 else if (req.status == 204)
								     {
									 }
							   	}
					   };
					req.open("GET",url,true);
					req.send(null);

}
function TrashListview()
{
document.standardForm.action="staffcategoryTrashList.jsp"; 
	document.standardForm.submit();       
}
function DeactiveView()
{
document.standardForm.action="staffcategoryDeactiveList.jsp";
	document.standardForm.submit();       
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

    <h2>Staff / StaffCategory / StaffCategory View</h2>
    <form name="standardForm" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

     <%
     
     com.iGrandee.StaffList.StaffCategoryQuery  staffcategoryQuery = new com.iGrandee.StaffList.StaffCategoryQuery();
     String instituteid = null;
     ArrayList staffcategoryList = null;
     String reqboardid = null;
     
     try
     {
    	 instituteid = (String)session.getValue("instituteid");
    	  staffcategoryList = staffcategoryQuery.liststaffcategory(instituteid,"A");
     
    }catch(Exception e){}
    
    %>
    
    


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%">SL.No</th>
            <th scope="col" class="rounded" width="30%">StaffCategory Name</th>
            <th scope="col" class="rounded" width="20%">Date of Creation</th>
              <th scope="col" class="rounded"  width="15%" >Edit</th>
              <th scope="col" class="rounded"  width="15%" >Trash</th>
              <th scope="col" class="rounded-q4"  width="10%" >Deactivate</th>
            
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="5" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>

     <%
     try
     {
    	 
    	 if(staffcategoryList!=null && staffcategoryList.size()>0)
			{
		 	for (int i = 0, j = 1; i < staffcategoryList.size(); i++) {
			
				HashMap categoryListMap=(HashMap)staffcategoryList.get(i);
				String staffcategoryid     = (String)categoryListMap.get("staffcategoryid");
				String categoryname      = (String)categoryListMap.get("categoryname");
				String dateofcreation      = (String)categoryListMap.get("dateofcreation");
				%>
				<tr>
				<td width="2%"><%= j++ %></td>
				<td><%=categoryname %></td>
				<td><%= dateofcreation %></td>
				<td><a href="#" staffcategoryid="<%=staffcategoryid%>" categoryname="<%=categoryname%>" onclick="categoryEdit(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Edit" border="0" /></a></td>
            <td><a href="#" class="ask" staffcategoryid="<%=staffcategoryid%>" categoryname="<%=categoryname%>" onclick="categoryTrash(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="Trash" border="0" /></a></td>
				            <td><a href="#" class="ask" staffcategoryid="<%=staffcategoryid%>" categoryname="<%=categoryname%>" onclick="categoryDeactive(this)">Deactivate</a></td>
				
				</tr>
				<%
		 }
			}
		 	else
		 	{
		 		out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
		 		//out.println("<tr><td colspan=6 align=center>Data not found</td></tr>");
		 	}
     }catch(Exception e){e.printStackTrace();}
          
     %>
    	
    </tbody>
</table>
	<input type="hidden" name="staffcategoryid" value="">
		<input type="hidden" name="categoryname" value="">
	
<input type="hidden" name="staffcategoryid_temp" value="">
		<input type="hidden" name="staffcategoryname_temp" value="">
	<a href="./staffcategorycreation.jsp" class="bt_green"><span class="bt_green_lft"></span><strong>Add New Item</strong><span class="bt_green_r"></span></a>
<a href="#" onclick="DeactiveView()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Deactivate List </strong><span class="bt_blue_r"></span></a>
		
		  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong>TrashList</strong><span class="bt_red_r"></span></a>

  
        
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>

