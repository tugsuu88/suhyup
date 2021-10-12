<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="/inc/requestSecurity.jsp" %>


<%
	String minwon_type = request.getParameter("minwon_type");
	
	if(minwon_type == null) minwon_type="";
	String mid = request.getParameter("sh_mid");

	if(mid == null) mid="0";
	int sh_mid = Integer.parseInt(mid);

	String name = request.getParameter("sg_name");
	if(name == null) name="";

	String passwd = request.getParameter("sg_pass");
	if(passwd == null) passwd="";

	String tel = request.getParameter("sg_tel");
	if(tel == null) tel="";

	String telephone = Converter.nullchk(request.getParameter("telephone"));

	try {
		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt=null;
		
		Context ic = new InitialContext();

		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");

		conn = ds.getConnection();

		String sql = "";

		//flagÃß°¡ leehanna 2011.12.19
		//E:¹Î¿øÃ¶È¸, C:Á¢¼öÃë¼Ò
		if("E".equals(minwon_type)){
			
			String text1 = "¹Î¿ø Ã¶È¸ ÇÏ¼Ì½À´Ï´Ù.";
			sql  = " update sh_chungtak ";
			sql += " set code = ? ";
			sql += " , abandon_date = sysdate ";
			sql += " , text1 = '"+text1+"'";
			sql += " where thid = '"+sh_mid+"'";
			System.out.println(sql);
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,"Ã¶È¸¿Ï·á");
		}else if("C".equals(minwon_type)){
			sql  = " delete sh_chungtak ";
			sql += " where thid = '"+sh_mid+"'";
			
			pstmt=conn.prepareStatement(sql);
		}

		pstmt.executeUpdate();

		pstmt.close();

		conn.close();

	}catch (Exception e){

		//out.println(e.toString());

	}


%>
	<form method="post" action="chungtak_list.jsp" name="d">
		<input type="hidden" name="sg_name" value="<%=name%>" />
	    <input type="hidden" name="sg_pass" value="<%=passwd%>" />
	    <input type="hidden" name="sg_tel" value="<%=tel%>" />
		<input type="hidden" name="telephone" value="<%=telephone%>" />
 		</form>
 		
	<script type="text/javascript">
        <!--
           	alert("Ã³¸®µÇ¾ú½À´Ï´Ù.");
			document.d.submit();
	     //-->
       </script>


