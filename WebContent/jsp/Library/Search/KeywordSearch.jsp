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
<title><%=bundle.getString("label.keywordsearch.entrytitle") %></title>

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>

<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>     

<script language="JavaScript">
function optionselect(obj)
{
var status=obj.value;
	if(status=="Book")
	{
		document.MainForm.flage.value="Book";
		document.MainForm.submit();
	
	}
	else
	{
		document.MainForm.flage.value="Journal";
		document.MainForm.submit();
	}
}
function submitfun()
{
if(document.MainForm.selectoption[0].checked)
{
var values=Trim(document.MainForm.typedbookname.value);
var len1=values.length;

		if(len1>=3)
		{
		if(check_ForParticularElements(document.MainForm.typedbookname,"text"))
		{
			if(values.charAt(0)=="%" && values.charAt(1)=="%" && values.charAt(2)=="%")
			{
				alert("Invalid Charcters");
				document.MainForm.typedbookname.focus();
				return false;
			}
		document.MainForm.action= "KeywordSearchList.jsp";
		document.MainForm.submit(); 
		}
		}
		else
		{ 
			alert("Enter atleast Three Letters");
			document.MainForm.typedbookname.focus();
		}
}
else 
{
var values=Trim(document.MainForm.typedjournalname.value);
var len2=values.length;
		if(len2>=3)
		{
		if(check_ForParticularElements(document.MainForm.typedjournalname,"text"))
		{
			if(values.charAt(0)=="%" && values.charAt(1)=="%" && values.charAt(2)=="%")
			{
				alert("Invalid Charcters");
				document.MainForm.typedbookname.focus();
				return false;
			}		
		document.MainForm.action= "KeywordSearchList.jsp";
		document.MainForm.submit();	
		}
		}
		else
		{ 
			alert("Enter atleast Three Letters");
			document.MainForm.typedjournalname.focus();
			
		}

}

		

}

function submitfun()
{
//if(document.MainForm.selectoption[0].checked)
{
var values=Trim(document.MainForm.typedbookname.value);
var len1=values.length;

		if(len1>=3)
		{
		if(check_ForParticularElements(document.MainForm.typedbookname,"text"))
		{
			if(values.charAt(0)=="%" && values.charAt(1)=="%" && values.charAt(2)=="%")
			{
				alert("Invalid Characters");
				document.MainForm.typedbookname.focus();
				return false;
			}
		document.MainForm.action= "KeywordSearchList.jsp";
		document.MainForm.submit(); 
		}
		}
		else
		{ 
			alert("Enter atleast Three Letters");
			document.MainForm.typedbookname.focus();
		}
}


}

</script>
</head>

<body>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.Search.Search" /> 
<%@ page import="java.util.HashMap,java.text.NumberFormat,java.util.Locale"%>
<% 	java.util.ResourceBundle bundle1 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");%>
<%



ArrayList BookList_book=new ArrayList();
ArrayList BookList_journal=new ArrayList();

String sessionid=session.getValue("sessionid")+"";
String instituteid=session.getValue("instituteid")+""; 
String flage=request.getParameter("flage")+"";



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

    out.print("<h2>"+bundle.getString("label.keywordsearch.entryrootpath")+"</h2>");


%>	  
<input type="hidden" name="flage" value="<%=flage %>">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	<tr>
		<td>

    <table  border=0  width="100%">
    <tr>
    <td align="center" colspan=6 class="tablebold">
    <%
    if(flage==null || flage.equals("null") || flage.equalsIgnoreCase("NULL"))
    {
    %>
    <input type="radio" name="selectoption" value="Book" checked onclick="optionselect(this)" style=visibility:hidden>
    <!--  <font size=3><%=bundle.getString("label.keywordsearch.Book") %></font>&nbsp;
    <input type="radio" name="selectoption" value="Journal" onclick="optionselect(this)"><font size=3><%=bundle.getString("label.keywordsearch.Journal") %></font>
    -->
    <%
    }
    else
    {
    	if(flage.equals("Book"))
    	{
    		out.print("<input type='radio' name='selectoption' value='Book' checked onclick='optionselect(this)'><font size=3>"+bundle.getString("label.keywordsearch.Book")+"</font>&nbsp;&nbsp;");
    		out.print("<input type='radio' name='selectoption' value='Journal'  onclick='optionselect(this)'><font size=3>"+bundle.getString("label.keywordsearch.Journal")+"</font>");

    	}
    	else if(flage.equals("Journal"))
    	{
    		out.print("<input type='radio' name='selectoption' value='Book'  onclick='optionselect(this)'><font size=3>"+bundle.getString("label.keywordsearch.Book")+"</font>&nbsp;&nbsp;");
    		out.print("<input type='radio' name='selectoption' value='Journal' checked onclick='optionselect(this)'><font size=3>"+bundle.getString("label.keywordsearch.Journal")+"</font>");

    	}
    }
    %>
    </td>
    </tr>
  
    </table>
       </br>
    
   
</table>
<%
if(flage.equals("null") ||flage.equalsIgnoreCase("NULL") || flage.equals("Book") )
{

	
%>
<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr> 
        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.keywordsearch.simplebooksearch") %></th>
        	<th scope="col" class="rounded" width="1%"> </th>
        	 <th scope="col" class="rounded" width="20%"> </th>
        	<th scope="col" class="rounded" width="20%"> </th>
        	<th scope="col" class="rounded" width="1%"> </th>
      	    <th scope="col" class="rounded-q4" width="20%"></th>
      	
        </tr>
    </thead>
    <tbody>
    <tr >
    <td class="tablebold" width="20%" align="center"><%=bundle.getString("label.keywordsearch.enterkeyword")%> </td><td class="tablebold" width="1%">:</td><td width="20%" class="tablelight" colspan=4><input type="text" name="typedbookname" validate="Keyword" maxlength='100' value=""></td>
    </tr>
    </tbody>
    <tfoot>
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    </table>
    <br>
  

  
		
	<%	}

else if(flage.equals("Journal"))
{
	
		%>   
		<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr> 
        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.keywordsearch.simplejournalsearch") %></th>
        	<th scope="col" class="rounded" width="1%"> </th>
        	 <th scope="col" class="rounded" width="20%"> </th>
        	<th scope="col" class="rounded" width="20%"> </th>
        	<th scope="col" class="rounded" width="1%"> </th>
      	    <th scope="col" class="rounded-q4" width="20%"></th>
        	
        </tr>
    </thead>
    <tbody>
    <tr >
    <td class="tablebold" width="20%" align="center"><%=bundle.getString("label.datewisebooksearch.JournalName")%> </td><td class="tablebold" width="1%">:</td><td width="20%" class="tablelight" colspan=4><input type="text" name="typedjournalname" validate="Journal Name " maxlength='100' value=""></td>
    </tr>
    </tbody>
    <tfoot>
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
</table>
    <br>

  <%
    
}  
%>
     <a href="#" class="bt_green" onclick="submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.datewisebooksearch.SearchBook")%></strong><span class="bt_green_r"></span></a>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>