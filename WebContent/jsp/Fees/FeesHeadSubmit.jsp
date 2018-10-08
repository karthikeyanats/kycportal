<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardBean,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

<%
		String instituteid 			= null;
		String userid 				= null;
		String[] feesheadname		= null;
		int rows 					= 0;
		int insert					= 0;
		String return_file 			= "";
		String message				= "";
		String feesheadoperation 	= "";
		String subjectduplicate		= "";
		com.iGrandee.Fees.FeesHeadQuery  feesheadQuery 	= new com.iGrandee.Fees.FeesHeadQuery();
		com.iGrandee.Fees.FeesHeadBean feesheadBean 	= new com.iGrandee.Fees.FeesHeadBean(); 
		
		try
		{
			
			instituteid 		= (String)session.getValue("instituteid");
			userid 				= (String)session.getValue("userid");
			feesheadoperation 	= request.getParameter("feesheadoperation");
			
			if(feesheadoperation.equals("insert") && feesheadoperation!=null)
			{
				feesheadname 	= request.getParameterValues("feesheadname");
		
				for(int x=0;x<feesheadname.length;x++)
				{
					String feess=feesheadname[x]+"";
					if(!feess.equals(""))
					{
						feesheadBean.setFeesheadname(feesheadname[x]);
						feesheadBean.setCreatedby(userid);
						feesheadBean.setInstituteid(instituteid);
						insert = feesheadQuery.insertFeesHead(feesheadBean);
						
						if(insert == 1000){
							subjectduplicate	+= feesheadname[x]+",";
						}
						else{
							rows				+= insert;
						}
						
					}
				}
			
				return_file = request.getContextPath()+"/jsp/Fees/FeesHead.jsp";
				if(rows >0)
					message = "Successfully FeesHead Inserted.";
				else
					message = "Fees Head Insertion Failed.";
					
				if(subjectduplicate != null && subjectduplicate.length()>2){
					message	+= " The Following Fees Head already exists. "+subjectduplicate.substring(0,subjectduplicate.length()-1);
				}
				
			}
			else if (feesheadoperation.equals("updatestatus"))
			{
				//feesheadBean.setFeesoperation("updatefeeshead");
			
			}else if (feesheadoperation.equals("udpatefeeshead"))
			{
				
				feesheadname = request.getParameterValues("feesheadname");
				
				for(int x=0;x<feesheadname.length;x++)
				{
					if(!feesheadname[x].equals(""))
					{
						feesheadBean.setFeesheadname(feesheadname[x]);
						feesheadBean.setCreatedby(userid);
						feesheadBean.setFeesheadid(instituteid);
						feesheadBean.setFeesoperation("updatefeeshead");
						
						insert= feesheadQuery.updateFeeshead(feesheadBean);
						
						if(insert == 1000){
							subjectduplicate	+= feesheadname[x]+",";
						}
						else{
							rows				+= insert;
						}
						
						
					}
				}
				if(rows >0)
					message = "Successfully Fees Head Updated.";
				else
					message = "FeesHead Updation failed.";
				
				if(subjectduplicate != null && subjectduplicate.length()>2)
					message	+= " The Following Fees Head already exists. "+subjectduplicate.substring(0,subjectduplicate.length()-1);
				
				
				
				return_file = request.getContextPath()+"/jsp/Fees/FeesHeadView.jsp";
			
			}
			
			response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+rows+"&returnurl="+return_file);
		
		}catch(Exception e){e.printStackTrace();}

%>

