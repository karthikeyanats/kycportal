<jsp:useBean id="religion_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Religion.ReligionQuery" />
<jsp:useBean id="religionBean" scope="page"
	class="com.iGrandee.MasterEntries.Religion.ReligionBean" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html>
<head>
<title><%=bundle.getString("label.religion.deactivelistlisttitle") %> </title>

<LINK rel=stylesheet href="../../css/kyccss.css">
<link rel="stylesheet" type="text/css" href="../../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="../jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="../../../js/Validation.js"></SCRIPT>

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>
<script language="JavaScript">
function ActiveFun(obj)
{
if(confirm("Do you want Activate Religion...?"))
{
	document.ReligionDeactivatedListForm.religionid_hidden.value = obj.getAttribute("religionid");
	//alert("CommunityID>>>>>>"+document.ReligionDeactivatedListForm.religionid_hidden.value);
	document.ReligionDeactivatedListForm.religionname_hidden.value=obj.getAttribute("religionname");
	document.ReligionDeactivatedListForm.religiondescription_hidden.value=obj.getAttribute("religiondescription");
	//document.ReligionDeactivatedListForm.createdby_hidden.value=obj.getAttribute("createdby");
	//alert("Created BY>>>>>>"+document.ReligionDeactivatedListForm.createdby_hidden.value);
	document.ReligionDeactivatedListForm.action= "ReligionActivate.jsp";
	document.ReligionDeactivatedListForm.submit();
}
else
{}
}
</script>
</head>
<body>
<form name="ReligionDeactivatedListForm" method="post" action="">

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
         <h2><%=bundle.getString("label.religion.deactivelistrootpath") %></h2>
     
<%@ page import="java.io.*,java.util.*"%>

<form name="ReligionDeactivatedListForm" method="post" action="">
<input type=hidden name=religionid_hidden>
<input type=hidden name=religionname_hidden>
<input type=hidden name=religiondescription_hidden>
<input type=hidden name=createdby_hidden>

<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.religion.slno") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.religion.religionname") %></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.religion.description") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.religion.dateofcreation") %></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.religion.active") %></th>
          </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
	<tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Religion.ReligionQuery"%>

     <%
	     	com.iGrandee.MasterEntries.Religion.ReligionQuery  religionQuery = new com.iGrandee.MasterEntries.Religion.ReligionQuery();
     		String instituteid = null;
     		ArrayList LoadDeactivatedReligionList = null;
     	try
     	{
    	  instituteid = (String)session.getValue("instituteid");
    	  LoadDeactivatedReligionList=religionQuery.DeactivatedReligionList(instituteid);
    	
    	//ArrayList archivalDetails = new ArrayList();
    	 if(LoadDeactivatedReligionList!=null && LoadDeactivatedReligionList.size()>0)
			{
    		 for (int i = 0, j = 1; i < LoadDeactivatedReligionList.size(); i++) {
			
				HashMap DeactivatedReligionListMap=(HashMap)LoadDeactivatedReligionList.get(i);
				
				String religionid       	= (String)DeactivatedReligionListMap.get("religionid");
				String religionname	  	= (String)DeactivatedReligionListMap.get("religionname");
				String religiondescription	= (String)DeactivatedReligionListMap.get("religiondescription");
				String dateofcreation      	= (String)DeactivatedReligionListMap.get("dateofcreation");
				//String createdby      		= (String)DeactivatedCommunityListMap.get("createdby");
		%>
		<tr>
        	 <td valign=top><%=j++ %></td>
            <td valign=top><%=religionname %></td>
           <%
				if(religiondescription.equals(""))
				{
					//religiondescription = "-";
				out.print("<td class='tablelight'>-</td>");
				}
				else{
						String []count=null;
					  String des_temp=religiondescription+"";
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
						<%=(religiondescription+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
					</div>
						</div>
						<% }
						else
						{
							out.print("<td class='tablelight' valign=top>"+religiondescription+"</td>");

						}
						}
				%>				            

            <td valign=top><%=dateofcreation %></td>
            <td valign=top><a href="#" ahrefname="religionhref=<%=i%>" religionid="<%=religionid%>" religionname="<%=religionname %>" religiondescription="<%=religiondescription %>"  onclick="ActiveFun(this)" class="ask"><%=bundle.getString("hlink.religion.active") %></a></td>
            <!--<td><a href="#" ahrefname="religionhref=<%=i%>" religionid="<%=religionid%>" religionname="<%=religionname %>" religiondescription="<%=religiondescription %>"  onclick="trashFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="" border="0" /></a></td> -->
        </tr>
			<%
    			 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");    	 		
    	 	}
    	 }catch(Exception e){}
          
     %>
    	</tbody>
	</table>
		<a href="./ReligionCreation.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.religion.addnewitem") %></strong><span class="bt_green_r"></span></a>
     	<a href="./ReligionView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.religion.viewallreligion") %></strong><span class="bt_blue_r"></span></a>
     	<a href="./ReligionTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.religion.trashlist") %></strong><span class="bt_red_r"></span></a>
	</div><!-- end of right content-->
  </div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>