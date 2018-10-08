package com.iGrandee.ExamManagement.Servlets;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



/**
 * Servlet implementation class for Servlet: ResultServlet
 *
 */
 public class OnlineExamServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet
 {

    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public OnlineExamServlet()
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
			String action		= request.getParameter("action");
			HttpSession session	= null;
			
			if(action.equals("examInstructions"))
			{
				try
				{
					String qsid		= request.getParameter("qsid");
					request.setAttribute("qsid",qsid);
	 				RequestDispatcher rd = getServletContext().getRequestDispatcher("/jsp/Student/ExamInstruction.jsp");
					rd.forward(request,response);
				}
				catch(Exception e)
				{

					e.printStackTrace();
				}
			}
			else if(action.equals("getPreviousQuestion"))
			{
				ExamDAO examDAO1 	= new ExamDAO();
				session				= request.getSession();
				String studentid  	= (String)session.getValue("studentid");
				String qsids		= request.getParameter("quesId");
				StringBuffer buffer = examDAO1.getPreviousQuestion(qsids,studentid);

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write("<countquestion>"+buffer.toString()+"</countquestion>");
			}
			else if(action.equals("loadExamInfo"))
			{
				ExamDAO examDAO 	= new ExamDAO();
				String qsid			= request.getParameter("qsid");
				StringBuffer buffer = examDAO.getExamInstructionList(qsid);

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write("<examdetails>"+buffer.toString()+"</examdetails>");
			}
			else if(action.equals("getTotalQuesCount"))
			{
				ExamDAO examDAO 	= new ExamDAO();
				session				= request.getSession();
				String studentid  	= (String)session.getValue("studentid");
				String qsid			= request.getParameter("qsid");
				StringBuffer buffer = examDAO.getTotalQuestionCount(qsid,studentid);

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write("<countquestion>"+buffer.toString()+"</countquestion>");
			}
		}
		catch(Exception de)
		{
			de.printStackTrace();
		}
	}
}
