// Decompiled by DJ v3.7.7.81 Copyright 2004 Atanas Neshkov  Date: 12/8/2010 12:38:38 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   IGSTFatalException.java

package com.iGrandee.Common.util;

import java.io.PrintStream;

public class IGSTFatalException extends Exception
{

    public IGSTFatalException(String message)
    {
        System.out.println("EXC " + message);
    }
}