/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.47
 * Generated at: 2019-12-16 04:04:48 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.jquery.text;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class text_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<title>ajax::jquery::text</title>\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath());
      out.write("/jquery/jquery-3.4.1.js\"></script>\r\n");
      out.write("<style>\r\n");
      out.write("#mydiv{\r\n");
      out.write("\twidth: 300px;\r\n");
      out.write("\tmin-height: 100px;\r\n");
      out.write("\tborder: 1px solid red;\r\n");
      out.write("\tmargin: 30px 10px;\r\n");
      out.write("}\r\n");
      out.write("</style>\r\n");
      out.write("<script>\r\n");
      out.write("$(function(){\r\n");
      out.write("\tconsole.log(\"jquery loaded!!!!!!!!!!!!!!!!\");\r\n");
      out.write("\t$('#btn1').click(function(){\r\n");
      out.write("\t\t$.ajax({\r\n");
      out.write("\t\t\turl: \"sample.txt\", //상대주소는 현재주소기준으로 작성된다. http://localhost:9090/ajax/jquery/text/text/sample.jsp\r\n");
      out.write("\t\t\ttype: \"GET\", //기본값은 GET\r\n");
      out.write("\t\t\tdataType: \"text\", //text, html, script, xml, json 생략하면 서버 응답메세지에 따라 결정(생략해도 무방하다는 뜻)\r\n");
      out.write("\t\t\tbeforeSend: function(){\r\n");
      out.write("\t\t\t\tconsole.log(\"beforeSend: </before>ajax send 전처리 함수!!\")\r\n");
      out.write("\t\t\t},\r\n");
      out.write("\t\t\tsuccess: function(data){\r\n");
      out.write("\t\t\t\tconsole.log(\"success: ajax처리 성공!\");\r\n");
      out.write("\t\t\t\tconsole.log(data);\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t//$(\"#mydiv\").text(data);\r\n");
      out.write("\t\t\t\t$(\"#mydiv\").html(data);\r\n");
      out.write("\t\t\t},\r\n");
      out.write("\t\t\terror: function(jqxhr, textStatus, errorThrown){\r\n");
      out.write("\t\t\t\tconsole.log(\"error: ajax처리 실패!\");\r\n");
      out.write("\t\t\t\tconsole.log(jqxhr, textStatus, errorThrown);\r\n");
      out.write("\t\t\t},\r\n");
      out.write("\t\t\tcomplete: function(){\r\n");
      out.write("\t\t\t\tconsole.log(\"complete: ajax처리 완료!\");\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t});\r\n");
      out.write("\t});\r\n");
      out.write("});\r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t<h1>ajax::jquery::text</h1>\r\n");
      out.write("\t<button id=\"btn1\">sample.txt ajax로 요청하기</button>\r\n");
      out.write("\t<div id=\"mydiv\"></div>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
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
