<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ArrayList"%>
<html>
<head>
<title><%=bundle.getString("label.departmentwisebookjournal.entrytitle") %></title>

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">

</script>     

<script language="JavaScript">

	

function nextpage(obj)
{
var count=obj.getAttribute("count");
var rackid=obj.getAttribute("rackid");
var booktype=obj.getAttribute("booktype");
var rackname=obj.getAttribute("rackname");
if(booktype=="bookMaster")
{
		document.MainForm.department.value=rackid;
		document.MainForm.departmentname.value=rackname;
		document.MainForm.count.value=count;
		document.MainForm.flage.value="DepartmentWise";
		document.MainForm.flage_temp.value="Book";
		document.MainForm.action= "BookSearch.jsp";
		document.MainForm.submit(); 
		
		
}
else if(booktype=="Journal")
{		
		document.MainForm.department.value=rackid;
		document.MainForm.departmentname.value=rackname;
		document.MainForm.count.value=count;
		document.MainForm.flage.value="DepartmentWise";
		document.MainForm.flage_temp.value="Journal";
		document.MainForm.action= "JournalSearch.jsp";
		document.MainForm.submit();
		
}

}

</script>
</head>

<body>

	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.BooksorJournal.BookSearch" />
<%@ page import="java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale"%>
<%
ArrayList List=new ArrayList();
String sessionid=session.getValue("sessionid")+"";
String instituteid=session.getValue("instituteid")+"";
List=query_object.getBookJournalCount(instituteid,sessionid); 

%>
<form name="MainForm" method="post" action="">
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
    <%

    out.print("<h2>"+bundle.getString("label.departmentwisebookjournal.entryrootpath")+"</h2>");
%>
<input type="hidden" name="flage">
<input type="hidden" name="department">
<input type="hidden" name="departmentname">
<input type="hidden" name="flage_temp">
<input type="hidden" name="count">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	<tr>
		<td>


	
 

</table>
 	<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr> 
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.departmentwisebookjournal.SL.No") %></th>
        	<th scope="col" class="rounded" width="60%"><%=bundle.getString("label.departmentwisebookjournal.Department") %> </th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.departmentwisebookjournal.Books") %> </th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.departmentwisebookjournal.Journals") %> </th>
        	
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    <tbody>
		   <%
		   try
		   {
			   int bookcount_final=0;
		  	   int journalcount_final=0;
			   HashMap  ListMap=new HashMap();
			   ArrayList duplicate_rack=new ArrayList();
			   if(List!=null && List.size()>0)
			   {	int bookcount=0;
			  		 int journalcount=0;
					   String temptxt="";      

				   for(int i=0,j=1;i<List.size();i++)
				   {
					   ListMap=(HashMap)List.get(i);
					   String rackid=ListMap.get("rackid")+"";
					   

					   if(!duplicate_rack.contains(rackid))
					   {
						   out.print("<tr valign='top'><td class='tablelight' width='5%'>"+j+"</td>");
						   out.print("<td class='tablelight'>"+ListMap.get("rackname")+"</td>");
						   for(int x=0;x<List.size();x++)
						   {	
							  HashMap ListMapnew=(HashMap)List.get(x);
							   String rackidin=ListMapnew.get("rackid")+"";
							   String booktype=ListMapnew.get("booktype")+"";
							   String bookmasterid=ListMapnew.get("bookmasterid")+"";
							   if(rackid.equals(rackidin))
							   {
								   if(booktype.equals("bookMaster"))
								   {
									   bookcount++;
									   bookcount_final++;
									   
								   }else  if(booktype.equals("Journal"))
								   {
									   journalcount++;
									   journalcount_final++;
								   }
								   else
								   {
									  	 bookcount=0;
									   	journalcount=0;
								   }
							   }
						   }
						   if(bookcount>0) 
						   {
						   out.print("<td class='tablelight'><a href='#' booktype='bookMaster' rackid='"+rackid+"' rackname='"+ListMap.get("rackname")+"' count='"+bookcount+"' onclick='nextpage(this)'><font size=4> "+bookcount+" </font></td>");
						   }
						   else
						   {
							out.print("<td class='tablelight'>"+bookcount+"</td>");

						   }
						   if(journalcount>0)
						   {
							   out.print("<td class='tablelight'><a href='#'  booktype='Journal' rackid='"+rackid+"'  rackname='"+ListMap.get("rackname")+"' count='"+journalcount+"' onclick='nextpage(this)'><font size=4>  "+journalcount+"</font> </td></tr>");

						   }
						   else
						   {
							   out.print("<td class='tablelight'>"+journalcount+"</td></tr>");

						   }
						   duplicate_rack.add(rackid);
						   j++;
					   }
					  }
				   out.print("<tr><td></td><td class='tablebold' align='right'>Total</td><td>"+bookcount_final+"</td><td>"+journalcount_final+"</td></tr>");


			   }
			   else
			   {
				   out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>Data Not Found</font></td></tr>");
				   //out.print("<tr><td colspan=4 align='center'>Data Not Found</tr>");
			   }
			   
		   }
		   catch(Exception e)
		   {
			   System.out.println(e);
		   }
		   %> 
		 </tbody>
	</table>
		

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>