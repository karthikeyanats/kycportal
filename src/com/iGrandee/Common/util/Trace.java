// Decompiled by DJ v3.7.7.81 Copyright 2004 Atanas Neshkov  Date: 12/8/2010 12:38:43 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   Trace.java

package com.iGrandee.Common.util;

import java.io.PrintStream;
import java.sql.SQLException;
import java.util.Date;

public class Trace
{

    public Trace()
    {
    }

    public static void trace(String param)
    {
        writeTrace(param);
    }

    public static void traceEnd(String param)
    {
        writeTrace("-" + param);
        iIndent -= 2;
    }

    public static void traceStart(String param)
    {
        iIndent += 2;
        writeTrace("+" + param);
    }

    private static void writeTrace(String param)
    {
        String s = (new Date()).toString() + ": " + pad.substring(0, iIndent + 1) + param;
        System.err.println(s);
    }

    public static void printSQLException(SQLException sqle)
    {
        traceStart("Exception SQLException");
        String sqlMessage = sqle.getMessage();
        String sqlState = sqle.getSQLState();
        int vendorCode = sqle.getErrorCode();
        trace("Exception occurred:");
        trace("Message: " + sqlMessage);
        trace("SQL state: " + sqlState);
        trace("Vendor code: " + vendorCode);
        traceEnd("Exception SQLException");
    }

    public static void printThrowable(Throwable t)
    {
        traceStart("Exception Throwable");
        trace(t.getMessage());
        trace(t.toString());
        traceEnd("Exception Throwable");
    }

    public static void printClassNotFoundException(ClassNotFoundException cnfe)
    {
        traceStart("Exception ClassNotFoundException");
        trace(cnfe.toString());
        traceEnd("Exception ClassNotFoundException");
    }

    private static int iIndent = -2;
    private static String pad = new String("              ");
    private static final boolean bEnabled = true;
    private static final boolean bFile = false;

}