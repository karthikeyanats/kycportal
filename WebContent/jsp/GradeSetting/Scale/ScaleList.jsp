<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.scalecreation.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

function loadStandard()
{
	document.scaleForm.reqboardid.value = document.scaleForm.standardboard.options[document.scaleForm.standardboard.options.selectedIndex].value;
	document.scaleForm.reqboardname.value = document.scaleForm.standardboard.options[document.scaleForm.standardboard.options.selectedIndex].text;
	
	document.scaleForm.action="ScaleList.jsp";
	document.scaleForm.submit();
}
function trashfun(obj)
{
if(confirm("Do you want to Trash the Scale...?"))
	{
	document.scaleForm.reqboardid.value = document.scaleForm.standardboard.options[document.scaleForm.standardboard.options.selectedIndex].value;
	document.scaleForm.reqboardname.value = document.scaleForm.standardboard.options[document.scaleForm.standardboard.options.selectedIndex].text;

	document.scaleForm.action="./ScaleTrash.jsp?reqscaleid="+obj.getAttribute("scaleid");
	document.scaleForm.submit();
	}
}

function editfun(obj)
{
if(confirm("Do you want to Update the Scale...?"))
	{
	document.scaleForm.reqboardid.value = document.scaleForm.standardboard.options[document.scaleForm.standardboard.options.selectedIndex].value;
	document.scaleForm.reqboardname.value = document.scaleForm.standardboard.options[document.scaleForm.standardboard.options.selectedIndex].text;
	document.scaleForm.reqscaleid.value =obj.getAttribute("scaleid"); 
		//document.scaleForm.action="./ScaleEdit.jsp?reqscaleid="+obj.getAttribute("scaleid")+"&reqboardid="+document.scaleForm.reqboardid.value;
	document.scaleForm.action="./ScaleEdit.jsp";
	document.scaleForm.submit();
	}
}
function goGrade(obj)
{
	document.scaleForm.reqboardid.value = document.scaleForm.standardboard.options[document.scaleForm.standardboard.options.selectedIndex].value;
	document.scaleForm.reqboardname.value = document.scaleForm.standardboard.options[document.scaleForm.standardboard.options.selectedIndex].text;
	document.scaleForm.reqscaleid.value = obj.getAttribute("scaleid");
	document.scaleForm.reqscalename.value = obj.getAttribute("scalename");
	document.scaleForm.action="../Grade/GradeCreation.jsp";
	document.scaleForm.submit();
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

    <h2><%=bundle.getString("label.scalecreation.entryrootpath") %> </h2>
    <form name="scaleForm" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardQuery,com.iGrandee.GradeSetting.GradeScaleQuery"%>

     <%
     
     com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
     com.iGrandee.GradeSetting.GradeScaleQuery  gradescaleQuery = new com.iGrandee.GradeSetting.GradeScaleQuery();
     String instituteid = null;
     ArrayList BoardList = null;
     String reqboardid = null;
     
     try
     {
    	 instituteid = (String)session.getValue("instituteid");
    	  BoardList = standardQuery.listBoard(instituteid);
    	  //reqboardid = request.getParameter("reqboard");
    }catch(Exception e){}
    
    %>

<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="80%">Select Board - Medium </th>
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
	<tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
	<tr>
	<td align="right" class="tablebold"><%=bundle.getString("label.scalecreation.Board-Medium")%><font color=red>*</font></td>
	<td class=tablebold width='2%'>:</td>
		<td colspan=2 class="styleClass">
<select name="standardboard" class=tablelight onchange="loadStandard()"> <option>-Select Board-Medium- </option>
<%
   			
        	if(BoardList!=null && BoardList.size()>0)
			{
   		 	for (int i = 0, j = 1; i < BoardList.size(); i++) {
			
				HashMap boardListMap=(HashMap)BoardList.get(i);
				String boardid     = (String)boardListMap.get("boardid");
				String boardname      = (String)boardListMap.get("boardname");
				String mediumid      = (String)boardListMap.get("mediumid");
				String mediumname      = (String)boardListMap.get("mediumname");
				if(request.getParameter("reqboardid") != null)
		    	  {
		    	  	reqboardid = request.getParameter("reqboardid");
		    	  	if(reqboardid.equals(boardid))
		    	  	{
		          		 out.println("<option value='"+boardid+"' class=tablelight selected>"+boardname+"-"+mediumname+"</option>");
	    	  		}else
	    	  		{
		    	  	out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");
	    	  		}
		    	  	
		    	  }
				else{
       		 out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");}
   		 }
			}
   		 %></select>
	</td>
</tr>
</table>
</td></tr>
</table>
    
<br>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.scalecreation.SL.No") %></th>
            <th scope="col" class="rounded" width="50%"><%=bundle.getString("label.scalecreation.StandardName") %> </th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.scalecreation.Dateofcreation") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("hlink.scalecreation.edit") %></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("hlink.scalecreation.trash") %></th>
        
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>

     <%
     ArrayList scaleList = null;
     try
     {
    	 
    	//  instituteid = (String)session.getValue("instituteid");
    	  if(request.getParameter("reqboardid") != null)
    	  {
    	  	reqboardid = request.getParameter("reqboardid");
    		//out.println("reqboardid"+reqboardid);
    	  	//StandardList = standardQuery.listStandardList(instituteid,reqboardid,"A");
    	  	scaleList = gradescaleQuery.listScaleList(instituteid,reqboardid,"A");
    	  	
    	  }
    	 
    	//scaleid, standardname, boardid, boardname, mediumname, mediumid
    	 if(scaleList!=null && scaleList.size()>0)
			{
    		 for (int i = 0, j = 1; i < scaleList.size(); i++) {
			
				HashMap scaleListMap=(HashMap)scaleList.get(i);

				String scaleid       = (String)scaleListMap.get("scaleid");
				String scalename      = (String)scaleListMap.get("scalename");
				String stdcreateddate      = (String)scaleListMap.get("dateofcreation");
				
				%>
				
				<tr valign=top>
        	 <td><%=j++ %></td>
             <td><a href="#" scaleid="<%=scaleid %>" scalename="<%= scalename%>" onclick=goGrade(this)><%=scalename %></a></td>
            <td><%=stdcreateddate %> </td>
            <td><a href="#" scaleid="<%=scaleid %>" onclick="editfun(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Edit" border="0" /></a></td> 
			<td><a href="#" scaleid="<%=scaleid %>" onclick="trashfun(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="Trash" border="0" /> </a></td>
            
        </tr>
				<%
    		 }
			}
    	 	else{
    	 		if(request.getParameter("reqboardid") != null)
    	    	  {
    	 			out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
    	 			//out.println("<tr><td colspan=6 align=center>Data not found</td></tr>");	
    	    	  }
    	 		else
    	 		{
    	 			out.println("<tr><td colspan=5 align=center>Select Board-Medium</td></tr>");
    	 		}
     			    	 
    	 	}
     }catch(Exception e){e.printStackTrace();}
          
     %>
    	
    </tbody>
</table>

          <a href="./ScaleStatusList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.scalecreation.trashlist") %></strong><span class="bt_blue_r"></span></a>
     	<a href="./ScaleCreation.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.scalecreation.addnewitem") %></strong><span class="bt_green_r"></span></a>
     
     <input type="hidden" name="reqboardname"/>
     <input type="hidden" name="reqboardid"/>
     <input type="hidden" name="reqscaleid"/>
     <input type="hidden" name="reqscalename"/>
    
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>

