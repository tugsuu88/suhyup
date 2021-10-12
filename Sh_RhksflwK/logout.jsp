<%@ page import="java.lang.*, java.util.*" contentType="text/html;charset=euc-kr"%>

<%
	session.invalidate();
	//response.sendRedirect("/index.jsp");
%>

<script language="javascript">
	top.location.href="index.jsp";
</script>
