<%!
	private String nodeName(Class c) {
	    if (c.isArray())
	        throw new IllegalArgumentException(
	            "Arrays have no associated preferences node.");
	    String className = c.getName();
	    int pkgEndIndex = className.lastIndexOf('.');
	    if (pkgEndIndex < 0)
	        return "/<unnamed>";
	    String packageName = className.substring(0, pkgEndIndex);
	    return "/" + packageName.replace('.', '/');
	}
%>
<%
	final java.util.ResourceBundle bundle = java.util.ResourceBundle.getBundle("resources.serversetup");
	String REG_KEY=bundle.getString("productName");
	Class<com.igst.license.Info> classname = com.igst.license.Info.class;
	java.util.prefs.Preferences userRoot = java.util.prefs.Preferences.userRoot().userNodeForPackage(classname);
	userRoot.remove(REG_KEY);
	//System.out.println(REG_KEY + " = "+ userRoot.get(REG_KEY, REG_KEY + " was not found."));
	String value = userRoot.get(REG_KEY,null); 
	//userRoot = java.util.prefs.Preferences.userRoot().node(nodeName(classname)+"/"+"TsixeLicenses");
	//userRoot.remove(REG_KEY);
	//System.out.println(REG_KEY + " = "+ userRoot.get(REG_KEY, REG_KEY + " was not found."));
	//value+= userRoot.get(REG_KEY,null);
	response.setContentType("text/xml"); 
	response.setHeader("Cache-Control", "no-cache");
	response.getWriter().write("<LicenseKey><Status>" + value + "</Status></LicenseKey>");		
%>