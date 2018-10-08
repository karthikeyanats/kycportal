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
<title><%=bundle.getString("label.advancesearch.entrytitle") %></title>

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
  <SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
  
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
	var status=true;
	var values1=Trim(document.MainForm.searchValue1.value);
	var values2=Trim(document.MainForm.searchValue2.value);
	var values3=Trim(document.MainForm.searchValue3.value);
	if(document.MainForm.operator[1].checked)
	{
	
		if(values1=="" && values2=="" && values3=="")
		{
			alert("Enter the value for any one");
		}
		else
		{	if(values1!="")
			{
				if(values1.length>=3)
				{
					if(values1.charAt(0)=="%" && values1.charAt(1)=="%" && values1.charAt(2)=="%")
					{
						alert("Invalid Charcters");
						document.MainForm.searchValue1.focus();
						return false;
					}	
				}
				else
				{
				document.MainForm.searchValue1.focus();
				status=false;
				}
			}
			if(values2!="")
			{
				if(values2.length>=3)
				{
					if(values2.charAt(0)=="%" && values2.charAt(1)=="%" && values2.charAt(2)=="%")
					{
						alert("Invalid Charcters");
						document.MainForm.searchValue2.focus();
						return false;
					}	
				}
				else
				{
				document.MainForm.searchValue2.focus();
				status=false;
				}
			}
			if(document.MainForm.selectoption[0].checked)
			{
				if(values3!="")
				{
					if(values3.length>=3)
					{
						if(values3.charAt(0)=="%" && values3.charAt(1)=="%" && values3.charAt(2)=="%")
						{
							alert("Invalid Charcters");
							document.MainForm.searchValue3.focus();
							return false;
						}
					}
					else
					{
					document.MainForm.searchValue3.focus();
					status=false;
					}
				}
			}
			
		if(status)
		{
			document.MainForm.action= "AdvancedSearchList.jsp";
			document.MainForm.submit(); 
			}
			else
			{
			alert("Enter atleast Three characters");
			}
		}
	}
	else
	{
	var count=0;
		if(values1=="")
		{
			count++;
		}
		else
		{
				if(values1.length>=3)
				{	
						if(values1.charAt(0)=="%" && values1.charAt(1)=="%" && values1.charAt(2)=="%")
						{
							alert("Invalid Charcters");
							document.MainForm.searchValue1.focus();
							return false;
						}
				}
				else
				{
				document.MainForm.searchValue1.focus();
				status=false;
				}
		}
		if(values2=="")
		{
			count++;
		}
		else
		{
				if(values2.length>=3)
				{	
						if(values2.charAt(0)=="%" && values2.charAt(1)=="%" && values2.charAt(2)=="%")
						{
							alert("Invalid Charcters");
							document.MainForm.searchValue2.focus();
							return false;
						}
				}
				else
				{
				document.MainForm.searchValue2.focus();
				status=false;
				}
		}
		if(values3=="")
		{
			count++;
		}
		else
		{	if(document.MainForm.selectoption[0].checked)
			{
				if(values3.length>=3)
				{	
						if(values3.charAt(0)=="%" && values3.charAt(1)=="%" && values3.charAt(2)=="%")
						{
							alert("Invalid Charcters");
							document.MainForm.searchValue3.focus();
							return false;
						}
				}
				else
				{
				document.MainForm.searchValue3.focus();
				status=false
				}
			}
		}
		
		if(count=="3")
		{
					alert("Enter the value for any two fields");
					return false;
			
		}
		if(count=="2")
		{
					alert("Enter the value for any two fields");
					return false;
		
		}
		
		if(status)
		{
			document.MainForm.action= "AdvancedSearchList.jsp";
			document.MainForm.submit(); 
		}
		else
		{
			alert("Enter atleast Three characters");
		}
		
		
		
	}
	}

</script>

</head>

<body>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.BooksorJournal.BookSearch" />
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
<input type="hidden" name="flage" value="<%=flage %>">

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
    	  out.print("<h2>"+bundle.getString("label.advancesearch.entryrootpath")+"</h2>");
      %>  
    
   <table  border=0  width="100%">
    <tr>
    <td align="right" colspan=6 class="tablebold">
    <%
    if(flage==null || flage.equals("null") || flage.equalsIgnoreCase("NULL"))
    {
    %>
    <input type="radio" name="selectoption" value="Book" checked onclick="optionselect(this)"><font size=3><%=bundle.getString("label.simplesearch.Book") %></font>&nbsp;
    <input type="radio" name="selectoption" value="Journal" onclick="optionselect(this)"><font size=3><%=bundle.getString("label.simplesearch.Journal") %></font>
    <%
    }
    else
    {
    	if(flage.equals("Book"))
    	{
    		out.print("<input type='radio' name='selectoption' value='Book' checked onclick='optionselect(this)'><font size=3>"+bundle.getString("label.simplesearch.Book")+"</font>&nbsp;&nbsp;");
    		out.print("<input type='radio' name='selectoption' value='Journal'  onclick='optionselect(this)'><font size=3>"+bundle.getString("label.simplesearch.Journal")+"</font>");

    	}
    	else if(flage.equals("Journal"))
    	{
    		out.print("<input type='radio' name='selectoption' value='Book'  onclick='optionselect(this)'><font size=3>"+bundle.getString("label.simplesearch.Book")+"</font>&nbsp;&nbsp;");
    		out.print("<input type='radio' name='selectoption' value='Journal' checked onclick='optionselect(this)'><font size=3>"+bundle.getString("label.simplesearch.Journal")+"</font>");

    	}
    }
    %>
    </td>
    </tr>
  
    </table>
    

<TABLE BORDER=0  bgColor=white CELLSPACING=0 WIDTH=97% align=center HEIGHT=92% CELLPADDING=0 id="center_main_table">
  <TR VALIGN="TOP">
  <td>

<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>  
        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.advancesearch.entrytitle") %></th>
        	<th scope="col" class="rounded" width="1%"></th>
        	<th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded-q4" width="20%" ></th>
            
        </tr>
    </thead>
    <tbody>  
    
	<tr align="center">
		<td colspan='6' class=tablebold>
				
				<input type=radio name='operator' value="And"  checked>
				AND

				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type=radio name='operator' value="Or">
				OR

		</td>
	</tr>
	<tr height=30>
			<td class="tablebold" width='30%'>
			<%if(flage.equals("Journal"))
			{
			%>
				<%=bundle.getString("label.datewisebookissue.JournalName") %>	
			<%
			}
			else
			{%>
				<%=bundle.getString("label.receivedbook.Title") %>
			<% }%>
		</td>
			<td class=tablelight width='30%'>
				<select name="Like1" style="width:150px" class="labelfont">
					<option value="1">Start With</option>
					<option value="2">End With</option>
				</select>
			</td>

			<td class=tablelight width='30%' colspan=4>
				<input type='text'  name='searchValue1' value='' size='35%' maxlength='100'>
			</td>
		</tr>

<tr height=30>
		<td class="tablebold" width='30%'>
					<%=bundle.getString("label.datewisebooksearch.publisher") %>
		</td>
		<td class=tablelight width='30%'>
			<select name="Like2" style="width:150px" class="labelfont">
					<option value="1">Start With</option>
					<option value="2">End With</option>
			</select>
		</td>
		<td class=tablelight width='30%' colspan=4>
			<input type='text'  name='searchValue2' value='' size='35%' maxlength='100'>
		</td>

	</tr>

	<tr height=30>
		<td class="tablebold" width='30%'>
			<%if(flage.equals("Journal"))
			{
			%>
					 <%=bundle.getString("label.datewisebooksearch.volumeno") %>
			<%  
			}
			else
			{%> 
				  <%=bundle.getString("label.newarrivalbookmasterlist.Author") %>
			<% }%>		</td>
		
		<td class=tablelight width='30%'>
			<select name="Like3" style="width:150px" class="labelfont">
					<option value="1">Start With</option>
					<option value="2">End With</option>
			</select>
		</td>
		<td class=tablelight width='30%' colspan=4>
			<input type='text'  name='searchValue3' value='' size='35%' maxlength='100'>
		</td>

	</tr>
	
    </tbody>
    <tfoot> 
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
</table>
</td>
</TR>
	
</table>
<a href="#" class="bt_green" onclick="submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.datewisebooksearch.SearchBook")%></strong><span class="bt_green_r"></span></a>
        
</td></tr></table>
     

     
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>

<script language="JavaScript">




</script>	
</body>
</html>