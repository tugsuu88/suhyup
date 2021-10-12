<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page contentType="text/html;charset=euc-kr" %><% request.setCharacterEncoding("euc-kr"); %><% response.setContentType("text/html; charset=euc-kr"); %>
<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/><jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />
<%

	String no = request.getParameter("sh_no");
	if(no == null) no="0";
	int sh_no = Integer.parseInt(no);		

	try {	

		DataSource ds = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();
		
		String sql = "";	
		
		sql  = " delete from sh_minwon_admin ";
		sql += " where sh_no = '"+sh_no+"'";

		stmt=conn.createStatement();
		rs = stmt.executeQuery(sql);

		rs.close();
		conn.close();		
		
	}catch (Exception e){
		out.println(e.toString());
	}			if(request.getParameter("sh_buseo").equals("회원조합")) {		
%>	
	<script language="javascript">	
	<!--	
	  	alert("삭제 되었습니다.");	
		self.location = "administrator_02.jsp";	
	//-->	
	</script><% } else { %>	<script language="javascript">		<!--		  	alert("삭제 되었습니다.");			self.location = "administrator.jsp";		//-->		</script><% } %>