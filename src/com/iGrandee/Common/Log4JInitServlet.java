// Decompiled by DJ v3.7.7.81 Copyright 2004 Atanas Neshkov  Date: 10/20/2010 12:55:48 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   Log4JInitServlet.java

package com.iGrandee.Common;

import java.io.File;
import java.io.PrintStream;
import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.PropertyConfigurator;

public class Log4JInitServlet extends HttpServlet
{

    public Log4JInitServlet()
    {
    }

    public void init(ServletConfig config)
        throws ServletException
    {
        //System.out.println("Log4JInitServlet is initializing log4j");
        String log4jLocation = config.getInitParameter("log4j-properties-location");
        ServletContext sc = config.getServletContext();
        //System.out.println("log4jLocation-->"+log4jLocation);
        if(log4jLocation == null)
        {
            //System.err.println("*** No log4j-properties-location init param, so initializing log4j with BasicConfigurator");
            BasicConfigurator.configure();
        } else
        {
            String webAppPath = sc.getRealPath("/");
            String log4jProp = (new StringBuilder(String.valueOf(webAppPath))).append(log4jLocation).toString();
            File yoMamaYesThisSaysYoMama = new File(log4jProp);
            if(yoMamaYesThisSaysYoMama.exists())
            {
                //System.out.println((new StringBuilder("Initializing log4j with: ")).append(log4jProp).toString());
                PropertyConfigurator.configure(log4jProp);
            } else
            {
                //System.err.println((new StringBuilder("*** ")).append(log4jProp).append(" file not found, so initializing log4j with BasicConfigurator").toString());
                BasicConfigurator.configure();
            }
        }
        super.init(config);
    }

    private static final long serialVersionUID = 1L;
}