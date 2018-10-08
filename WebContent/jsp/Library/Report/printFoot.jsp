<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java" import="java.util.ResourceBundle,java.util.Date,com.iGrandee.Registration.InstitutionQurey"%>
<%
ResourceBundle footBundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

			
<table width=100% border=0>
	<tr class='tablelight'>	
	<td align=left width=100%>
			<font color='#000000'><b><%=footBundle.getString("label.applicationreport.CreatedBy")%></b>
	</td>
	<td>&nbsp;</td>
	<td align=right  width=100%>
			<font color='#000000'><b><%=footBundle.getString("label.applicationreport.Signature")%></b>
	</td>
	</tr>
</table>
</td></tr>
<tr><td>
<table>
	<tr class='tablelight'>	
	<td align=left width=100%>
			<font color='#000000'><%=session.getValue("userfullname")%>
	</td>

	</tr>
</table>

			</table>
		


     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->



</div>

    </form>
	
</body>
</html>