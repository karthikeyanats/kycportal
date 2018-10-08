package com.iGrandee.ExamManagement.Servlets;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



/**
 * Servlet implementation class for Servlet: ExamServlet
 *
 */
 public class QuestionServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet
 {

    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public QuestionServlet()
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

			ExamDAO examDAO = new ExamDAO();
			String action=request.getParameter("action");


			if(action.equals("getQuestions"))
			{
				String questionSheetId=request.getParameter("qsId");
				StringBuffer buffer = examDAO.getQuestionBank(questionSheetId);

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><question>"+buffer.toString()+"</question>");
			}

			else if(action.equals("insertAnswerBatch"))
			{
				HttpSession session	= null;

				String questionSheetId	= request.getParameter("qsId");
				session					= request.getSession();
				String studentid  		= (String)session.getValue("studentid");
				String questionid		= request.getParameter("questionid");
				String answer			= request.getParameter("answer");
				String attempt			= request.getParameter("attempt");

				int inc=examDAO.insertAnswersUsingBatch(questionid,questionSheetId,answer,studentid,attempt);

				if(inc>0)
				{
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<exam><result>Inserted</result></exam>");
				}
				else
				{
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<exam><result>NotInserted</result></exam>");
				}


			}
		}
		catch(Exception de)
		{
			System.out.println("Exception thrown in QuestionServlet ------------> "+de.getMessage());
		}
	}
}
