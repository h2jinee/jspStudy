/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.47
 * Generated at: 2019-12-17 00:34:32 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.jquery;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class autoComplete_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("<meta charset=\"UTF-8\">\n");
      out.write("<title>ajax::jquery::autoComplete</title>\n");
      out.write("\n");
      out.write("<style>\n");
      out.write("div.wrapper{position: relative;}\n");
      out.write("ul#autoComplete{background-color: white; min-width: 159px; border: 1px solid gray; position: absolute; top: 22px; padding:0; margin:0;}\n");
      out.write("ul#autoComplete li{padding:0 10px; list-style:none; cursor:pointer;}\n");
      out.write("ul#autoComplete li.sel{background:lightseagreen; color:white;}\n");
      out.write("span.srchval{color:red;}\n");
      out.write("</style>\n");
      out.write("\n");
      out.write("<script src=\"");
      out.print(request.getContextPath());
      out.write("/jquery/jquery-3.4.1.js\"></script>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("$(function(){\n");
      out.write("\tvar $autoComplete = $(\"#autoComplete\");\n");
      out.write("\t$autoComplete.hide(); //페이지 최초 로딩 시 조회결과 ul태그는 안보임처리한다.\n");
      out.write("\t$(\"#srchName\").on('keyup', function(){\n");
      out.write("\t\tvar srchNameVal = $(this).val().trim();\n");
      out.write("\t\t\n");
      out.write("\t\t//공백 입력시 ajax요청 보내지 않음.\n");
      out.write("\t\tif(srchNameVal.length == 0) return;\n");
      out.write("\t\t\n");
      out.write("\t\t$.ajax({\n");
      out.write("\t\t\turl: \"");
      out.print(request.getContextPath());
      out.write("/jquery/autoComplete\",\n");
      out.write("\t\t\ttype: \"post\",\n");
      out.write("\t\t\t//data: \"srchName=\"+srchNameVal,\n");
      out.write("\t\t\tdata: {srchName: srchNameVal},//객체로 전달해도 jquery가 직렬화처리\n");
      out.write("\t\t\tsuccess: function(data){\n");
      out.write("\t\t\t\tconsole.log(data);\n");
      out.write("\t\t\t\t//조회된 결과가 없는경우\n");
      out.write("\t\t\t\tif(data.trim().length==0){\n");
      out.write("\t\t\t\t}\n");
      out.write("\t\t\t\t// 조회결과가 있는 경우\n");
      out.write("\t\t\t\telse{\n");
      out.write("\t\t\t\t\tvar dataArr = data.split(',');\n");
      out.write("\t\t\t\t\tvar html = \"\";\n");
      out.write("\t\t\t\t\t$.each(dataArr, (idx, val)=>{\n");
      out.write("\t\t\t\t\t\t// html += \"<li>\" + val + \"</li>\";\n");
      out.write("\t\t\t\t\t\thtml += \"<li>\" + val.replace(srchNameVal, '<span class=\"srchval\">'+ srchNameVal + '</span>') + \"</li>\"\n");
      out.write("\t\t\t\t\t});\n");
      out.write("\t\t\t\t\t $autoComplete.html(html);\n");
      out.write("\t\t\t\t\t\n");
      out.write("\t\t\t\t}\n");
      out.write("\t\t\t},\n");
      out.write("\t\t\terror: function(jqxhr, textStatus, errorThrown){\n");
      out.write("\t\t\t\tconsole.log(\"ajax처리실패!\", jqxhr, textStatus, errorThrown);\n");
      out.write("\t\t\t}\n");
      out.write("\t\t});\n");
      out.write("\t\t\n");
      out.write("\t});\n");
      out.write("});\n");
      out.write("</script>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\t<h1>ajax::jquery::autoComplete</h1>\n");
      out.write("\t<h2>친구 검색</h2>\n");
      out.write("\t<div class=\"wrapper\">\n");
      out.write("\t\t<input type=\"text\" id=\"srchName\" />\n");
      out.write("\t\t\n");
      out.write("\t\t<ul id=\"autoComplete\"></ul>\n");
      out.write("\t</div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
