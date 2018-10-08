<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardBean,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

<%
		String instituteid 			= null;
		String userid 				= null;
		String[] staffcategory		= null;
		int rows 					= 0;
		int insert					= 0;
		String return_file 			= "";
		String message				= "";
		String staffcategoryoperation 	= "";
		String subjectduplicate		= "";
		com.iGrandee.StaffList.StaffCategoryBean  staffcategoryBean 	= new com.iGrandee.StaffList.StaffCategoryBean();
		com.iGrandee.StaffList.StaffCategoryQuery  staffQuery	= new com.iGrandee.StaffList.StaffCategoryQuery();
		
		try
		{
			
			instituteid 		= (String)session.getValue("instituteid");
			userid 				= (String)session.getValue("userid");
			staffcategoryoperation 	= request.getParameter("staffcategoryoperation");
			
			if(staffcategoryoperation.equals("insert") && staffcategoryoperation!=null)
			{
				staffcategory 	= request.getParameterValues("staffcategory");
		
				for(int x=0;x<staffcategory.length;x++)
				{
					String feess=staffcategory[x]+"";
					if(!feess.equals(""))
					{
						staffcategoryBean.setStaffcategoryname(staffcategory[x]);
						staffcategoryBean.setCreatedby(userid);
						staffcategoryBean.setInstituteid(instituteid);
						insert = staffQuery.insertFeesHead(staffcategoryBean);
						
						if(insert == 1000){
							subjectduplicate	+= staffcategory[x]+",";
						}
						else{
							rows				+= insert;
						}
						
					}
				}
			
				return_file = request.getContextPath()+"/jsp/Staff/staffcategorycreation.jsp";
				if(rows >0)
					message = "Successfully StaffCategory Inserted.";
				else
					message = "StaffCategory Insertion Failed.";
					
				if(subjectduplicate != null && subjectduplicate.length()>2){
					message	+= " The Following StaffCategory already exists. "+subjectduplicate.substring(0,subjectduplicate.length()-1);
				}
				
			}
			else if (staffcategoryoperation.equals("updatestatus"))
			{
				//staffcategoryBean.setStaffcategoryoperation("updatefeeshead");
			
			}else if (staffcategoryoperation.equals("updatestaffcategory"))
			{
				
				staffcategory = request.getParameterValues("staffcategory");
				
				for(int x=0;x<staffcategory.length;x++)
				{
					if(!staffcategory[x].equals(""))
					{
						staffcategoryBean.setStaffcategoryname(staffcategory[x]);
						staffcategoryBean.setCreatedby(userid);
						staffcategoryBean.setStaffcategoryid(instituteid);
						staffcategoryBean.setStaffcategoryoperation("updatestaffcategory");
						
						insert= staffQuery.updateStaffcategory(staffcategoryBean);
						
						if(insert == 1000){
							subjectduplicate	+= staffcategory[x]+",";
						}
						else{
							rows				+= insert;
						}
						
						
					}
				}
				if(rows >0)
					message = "Successfully StaffCategory Updated.";
				else
					message = "StaffCategory Updation failed.";
				
				if(subjectduplicate != null && subjectduplicate.length()>2)
					message	+= " The Following StaffCategory already exists. "+subjectduplicate.substring(0,subjectduplicate.length()-1);
				
				
				
				return_file = request.getContextPath()+"/jsp/Staff/staffcategoryview.jsp";
			
			}
			
			response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+rows+"&returnurl="+return_file);
		
		}catch(Exception e){e.printStackTrace();}

%>

