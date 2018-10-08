package com.iGrandee.ExamManagement.Servlets;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



/**
 * Servlet implementation class for Servlet: ResultServlet
 *
 */
 public class ResultServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet
 {

    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public ResultServlet()
	{
		super();
	}

	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			ResultDAO resultDAO = new ResultDAO();
			String action=request.getParameter("action");
			HttpSession session	= null;
			
			if(action.equals("loadAnswerDetails"))
			{
				session				= request.getSession();
				String studentid  	= (String)session.getValue("studentid");
				String qsid			= request.getParameter("qsid");
				StringBuffer buffer = resultDAO.loadAnswerDetails(studentid,qsid);

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><result>"+buffer.toString()+"</result>");
			}
			else if(action.equals("getExamName"))
			{
				String userid		= request.getParameter("userid");
				String qsid			= request.getParameter("qsid");
				StringBuffer buffer = resultDAO.getExamName(userid,qsid);

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write("<exam>"+buffer.toString()+"</exam>");
			}
		}
		catch(Exception de)
		{
			de.printStackTrace();
		}
	}
}
