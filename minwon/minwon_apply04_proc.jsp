<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page contentType="text/html;charset=euc-kr" %>

<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="../inc/requestSecurity.jsp" %>

<%
	String minwon_type = request.getParameter("minwon_type");
	if(minwon_type == null) minwon_type="";

	String mid = request.getParameter("sh_mid");
	if(mid == null) mid="0";

	int sh_mid = Integer.parseInt(mid);

	String telephone = Converter.nullchk(request.getParameter("telephone"));

	String name = request.getParameter("name");
	if(name == null) name="";

	String mobile = "";
	
	String sh_han_1 = request.getParameter("sh_han_1");
	if(sh_han_1 == null) sh_han_1="";

	String sh_han_2 = request.getParameter("sh_han_2");
	if(sh_han_2 == null) sh_han_2="";

	String sh_han_3 = request.getParameter("sh_han_3");
	if(sh_han_3 == null) sh_han_3="";

	if(sh_han_1.equals("")){
		mobile =  request.getParameter("mobile");
	}
	else{
		mobile = sh_han_1 + "-" + sh_han_2 + "-" + sh_han_3;
	}
	if(mobile == null) mobile ="";

	String passwd = request.getParameter("passwd");
	if(passwd == null) passwd="";

	try {	

		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		PreparedStatement pstmt=null;
		
		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();

		String sql = "";	
		
		//flag추가 leehanna 2011.12.19
		//E:민원철회, C:접수취소
		if("E".equals(minwon_type)){
			sql  = " update sh_minwon ";
			sql += " set status = ? ";
			sql += " , abandon_date = sysdate ";
			sql += " where mid = '"+sh_mid+"'";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,"철회완료");
		}else if("C".equals(minwon_type)){
			sql  = " delete sh_minwon ";
			sql += " where mid = '"+sh_mid+"'";
			
			pstmt=conn.prepareStatement(sql);
		}		

		pstmt.executeUpdate();
		pstmt.close();
		conn.close();

	}catch (Exception e){
		out.println(e.toString());
	}
%>


		<form method="post" action="minwon_apply06.jsp" name="d">                                  
		    <input type="hidden" name="sh_mid" value="<%=sh_mid%>" />
		    <input type="hidden" name="name" value="<%=name%>" />
		    <input type="hidden" name="mobile" value="<%=mobile%>" />
		    <input type="hidden" name="passwd" value="<%=passwd%>" /> 
			<input type="hidden" name="telephone" value="<%=telephone%>" />
		</form>

		<script type="text/javascript">
			<!--
			alert("처리되었습니다.");
       		document.d.submit();
			//-->
        </script>	