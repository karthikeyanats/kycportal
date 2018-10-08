// Decompiled by DJ v3.7.7.81 Copyright 2004 Atanas Neshkov  Date: 12/8/2010 12:38:33 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   DBBeanHelper.java

package com.iGrandee.Common.util;

import java.io.PrintStream;
import java.sql.*;

public class DBBeanHelper
{

    public DBBeanHelper()
    {
    }

    public int insert(Connection connection, String queryString)
    {
        Statement stmt = null;
        ResultSet rs = null;
        int result = 0;
        Connection con = connection;
        try
        {
            stmt = con.createStatement();
            result = stmt.executeUpdate(queryString);
            stmt.close();
        }
        catch(SQLException se)
        {
            System.out.println("SQL Error while creating record. |ErrorMessage|" + se.getMessage() + "|SQLState|" + se.getSQLState() + "|Vendor Specific Error Code|" + se.getErrorCode());
        }
        return result;
    }

    public ResultSet fetch(Connection connection, String queryString)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection con = connection;
        try
        {
            stmt = con.createStatement();
            rs = stmt.executeQuery(queryString);
        }
        catch(SQLException se)
        {
            System.out.println("SQL Error while creating record. |ErrorMessage|" + se.getMessage() + "|SQLState|" + se.getSQLState() + "|Vendor Specific Error Code|" + se.getErrorCode());
        }
        return rs;
    }

    public int update(Connection connection, String queryString)
    {
        Statement stmt = null;
        ResultSet rs = null;
        int result = 0;
        Connection con = connection;
        try
        {
            stmt = con.createStatement();
            result = stmt.executeUpdate(queryString);
            stmt.close();
        }
        catch(SQLException se)
        {
            System.out.println("SQL Error while creating record. |ErrorMessage|" + se.getMessage() + "|SQLState|" + se.getSQLState() + "|Vendor Specific Error Code|" + se.getErrorCode());
        }
        return result;
    }
}