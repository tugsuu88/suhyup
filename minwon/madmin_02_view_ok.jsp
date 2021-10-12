<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page import="oracle.jdbc.driver.OracleResultSet" %>
<%@ page import="oracle.sql.CLOB" %>
<%@ page contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="Board" scope="session" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<%
	String PAGE=Converter.nullchk(request.getParameter("PAGE"));

	try{	
		
		int mid=Integer.parseInt(Converter.nullchk(request.getParameter("mid")));
		
		String answer=Converter.nullchk(request.getParameter("answer"));
		answer = answer.replaceAll("'", "\'");
		answer = answer.replaceAll("&", "&amp;");
		answer = answer.replaceAll("\'", "&quot;");
		answer = answer.replaceAll("<", "&lt;");
		answer = answer.replaceAll(">", "&gt;");
		answer = answer.replaceAll("-", "");
		
		String min_gubun=Converter.nullchk(request.getParameter("min_gubun"));
		String result=Converter.nullchk(request.getParameter("result"));
		String replyname=(String)session.getAttribute("name");
		String mobile=Converter.nullchk(request.getParameter("mobile"));
		String conresult="";
		String admintel="02-2240-3382";
		
		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt=null;
	
		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();

		String sql = "";
		
		conn.setAutoCommit(false);

		SmsMgr sm=new SmsMgr();
		boolean issms=sm.exqute(admintel,mobile,"���ϲ��� �����Ͻ� �ο��� ���� �亯�� ��ϵǾ����ϴ�.");
		
		sql="update sh_minwon set answer_fname=?,result=?,status=?,answer=?,minwon_gubun=?,answer_date=sysdate where mid=?";

		pstmt=conn.prepareStatement(sql);

		pstmt.setString(1,replyname);
		pstmt.setString(2,result);
		pstmt.setString(3,"�亯�Ϸ�");
		pstmt.setString(4,answer);
		pstmt.setString(5,min_gubun);
		pstmt.setInt(6,mid);
		pstmt.executeUpdate();

		pstmt.close();
		conn.commit();
		conn.close();

	}catch (Exception e){
		out.println(e.toString());
	}
	
	
%>
<script language="javascript">
<!--
  	alert("���� �Ǿ����ϴ�.");
	self.location = "madmin_02.jsp?PAGE=<%=PAGE%>";
//-->
</script>
