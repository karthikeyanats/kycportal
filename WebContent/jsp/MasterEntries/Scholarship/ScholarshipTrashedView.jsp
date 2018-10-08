<jsp:useBean id="scholar_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery" />
<jsp:useBean id="scholarBean" scope="page"
	class="com.iGrandee.MasterEntries.Scholarship.ScholarBean" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html>
<head>
<title><%=bundle.getString("label.scholarship.trashlisttitle") %> </title>

<link rel="stylesheet" type="text/css" href="../../../jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>

<script language="JavaScript">

function resetfun()
{
document.ScholarTrashedform.deptname.value="";
document.ScholarTrashedform.descryption.value="";

}
function trashFun(obj)
{
	var Deptid=obj.getAttribute("Deptid");
	var departmentname=obj.getAttribute("departmentname");
	var description=obj.getAttribute("description");
	document.ScholarTrashedform.action= "DepartmentTrashPriview.jsp?Deptid="+Deptid+"&departmentname="+departmentname+"&description="+description;
	document.ScholarTrashedform.submit();
}
function TrashListview()
{
document.ScholarTrashedform.action= "DepartmantTrashListview.jsp";
document.ScholarTrashedform.submit();
}
function deleteFun(obj)
{
if(confirm("Do you want to Delete the Scholarship...?"))
{
	document.ScholarTrashedform.scholarid_hidden.value = obj.getAttribute("scholarid");
	//alert("Scholarship ID>>>>>>"+document.ScholarTrashedform.scholarid_hidden.value);
	document.ScholarTrashedform.scholarname_hidden.value=obj.getAttribute("scholarname");
	document.ScholarTrashedform.scholardesc_hidden.value=obj.getAttribute("scholardescription");
	document.ScholarTrashedform.action= "ScholarDelete.jsp";
	document.ScholarTrashedform.submit();

}
else
{}
}
function restoreFun(obj)
{
if(confirm("Do you want to Restore the Scholarship...?"))
{
	document.ScholarTrashedform.scholarid_hidden.value = obj.getAttribute("scholarid");
	//alert("CommunityID>>>>>>"+document.ScholarTrashedform.scholarid_hidden.value);
	document.ScholarTrashedform.scholarname_hidden.value=obj.getAttribute("scholarname");
	document.ScholarTrashedform.scholardesc_hidden.value=obj.getAttribute("scholardescription");
	document.ScholarTrashedform.action= "ScholarRestore.jsp";
	document.ScholarTrashedform.submit();

}
else
{}
}
</script>
</head>

<body>
<form name="ScholarTrashedform" method="post" action="">

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
         <h2><%=bundle.getString("label.scholarship.trashlistrootpath") %></h2>
     
<%@ page import="java.io.*,java.util.*"%>

<form name="ScholarTrashedform" method="post" action="">

	<input type=hidden name=scholarid_hidden>
	<input type=hidden name=scholarname_hidden>
	<input type=hidden name=scholardesc_hidden>
	

<table id="rounded-corner" border=0 summary="Community List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.scholarship.slno") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.scholarship.scholarshipname") %></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.scholarship.description") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.scholarship.dateofcreation") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.scholarship.delete") %></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.scholarship.restore") %></th>
            
                      
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="5" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery"%>
		<%
			com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery  ScholarshipEntry = new com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery();
     		String instituteid = null;
     		ArrayList ScholarshipTrashedList = null;
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  ScholarshipTrashedList=ScholarshipEntry.get_All_ScholarshipnameTrashList(instituteid);
    	  

    	ArrayList archivalDetails = new ArrayList();
    	 if(ScholarshipTrashedList!=null && ScholarshipTrashedList.size()>0)
			{
    		 for (int i = 0, j = 1; i < ScholarshipTrashedList.size(); i++) {

				HashMap ScholarshipTrashedListMap=(HashMap)ScholarshipTrashedList.get(i);

				String scholarid       	= (String)ScholarshipTrashedListMap.get("scholarshipid");
				String scholarname 		  	= (String)ScholarshipTrashedListMap.get("scholarshipname");
				String scholardescription  	= (String)ScholarshipTrashedListMap.get("scholarshipdescription");
				String dateofcreation      	= (String)ScholarshipTrashedListMap.get("dateofcreation");
				String scholarstatus      		= (String)ScholarshipTrashedListMap.get("scholarshipstatus");

				%>
				<tr>
				    	 <td valign=top><%=j++ %></td>
				            <td valign=top><%=scholarname %></td>
            <%
				if(scholardescription.equals(""))
				{
					//scholardescription = "-";
				out.print("<td class='tablelight'>-</td>");
				}
				else{
						String []count=null;
					  String des_temp=scholardescription+"";
					   count=des_temp.split(" ");
						if((count.length-1)>15)
						{
							out.print("<td class='tablelight' ");
							String des_tempnew="";
							for(int s=0;s<15;s++)
							{
								des_tempnew+=count[s]+" ";
							}%>					   
							<div>
							<%=des_tempnew%><a href="index.htm" onclick="return hs.htmlExpand(this)">
						[<font color="red">More..</font>]
					</a>  
					<div class="highslide-maincontent">
						<h3></h3>
						<%=(scholardescription+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
					</div>
						</div>
						<% }
						else
						{
							out.print("<td class='tablelight' valign=top>"+scholardescription+"</td>");

						}
						}
				%>     				            

				            <td valign=top><%=dateofcreation %></td>
				            <td valign=top><a href="#" ahrefname="scholarhref=<%=i%>" scholarid="<%=scholarid%>" scholarname="<%=scholarname %>" scholardescription="<%=scholardescription %>" scholarstatus="<%=scholarstatus %>"  onclick="deleteFun(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_logout.png" alt="delete" title="Delete" border="0" /></a></td>
				            <td valign=top><a href="#" ahrefname="scholarhref=<%=i%>" scholarid="<%=scholarid%>" scholarname="<%=scholarname %>" scholardescription="<%=scholardescription %>" scholarstatus="<%=scholarstatus %>"  onclick="restoreFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/16-undo1.png" alt="restore" title="Restore" border="0" /></a></td>

				        </tr>
								<%
				    		 }
							}
				    	 	else{
				    	 		out.println("<tr align='center' class='tablebold'><td colspan='9'><font color='red'>Data Not Found</font></td></tr>");
				    	 	}
				     }catch(Exception e){}

     %>			
			
	   </tbody>
</table>
	<a href="./ScholarshipCreation.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.scholarship.addnewitem") %></strong><span class="bt_green_r"></span></a>
     <a href="./ScholarshipList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.scholarship.viewallscholarship") %> </strong><span class="bt_blue_r"></span></a>
     
	
</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>