<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page import="oracle.jdbc.driver.OracleResultSet" %>
<%@ page import="oracle.sql.CLOB" %>
<%@ page contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="Board" scope="session" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<%
	String PAGE=Converter.nullchk(request.getParameter("PAGE"));

	try{	
		int thid=Integer.parseInt(Converter.nullchk(request.getParameter("thid")));
		
		String text1=Converter.nullchk(request.getParameter("text1"));
		text1 = text1.replaceAll("'", "\'");
		text1 = text1.replaceAll("&", "&amp;");
		text1 = text1.replaceAll("\'", "&quot;");
		text1 = text1.replaceAll("<", "&lt;");
		text1 = text1.replaceAll(">", "&gt;");
		text1 = text1.replaceAll("-", "");
		String tel=Converter.nullchk(request.getParameter("tel"));
		String result=Converter.nullchk(request.getParameter("result"));
		String replyname=(String)session.getAttribute("name");
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
		boolean issms=sm.exqute(admintel,tel,"귀하께서 제기하신 민원에 대한 답변이 등록되었습니다");

		sql="update sh_financetrouble set replyname=?,result=?,code=?,time2=sysdate where thid=?";

		pstmt=conn.prepareStatement(sql);

		pstmt.setString(1,replyname);
		pstmt.setString(2,result);
		pstmt.setString(3,"답변완료");
		pstmt.setInt(4,thid);
		pstmt.executeUpdate();
		
		sql = " update sh_financetrouble set text1=empty_clob() where thid = " + thid;
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		
		sql = " select text1 from sh_financetrouble where thid = " + thid +" for update ";
		pstmt = conn.prepareStatement(sql);
		
//		pstmt.executeUpdate();
		
		rs = pstmt.executeQuery();

		while (rs.next())
		{
			CLOB clob = ((OracleResultSet)rs).getCLOB(1); 

		    Board.writeClob( clob ,text1);
		}
		pstmt.close();
		conn.commit();
		conn.close();

	}catch (Exception e){
		out.println(e.toString());
	}
	
	
%>
<script language="javascript">
<!--
  	alert("수정 되었습니다.");
	self.location = "finance.jsp?PAGE=<%=PAGE%>";
//-->
</script>
