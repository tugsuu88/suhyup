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

		

	String name = request.getParameter("name");

	if(name == null) name="";

	

	String passwd = request.getParameter("passwd");

	if(passwd == null) passwd="";

	

	String tel = request.getParameter("tel");

	if(tel == null) tel="";
	
	
String telephone = request.getParameter("telephone");
	

	

	try {	



		DataSource ds = null;

		Connection conn = null;

		ResultSet rs = null;

		PreparedStatement pstmt=null;



		Context ic = new InitialContext();

		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");

		conn = ds.getConnection();

		

		String sql = "";	

		//flag�߰� leehanna 2011.12.19
		//E:�ο�öȸ, C:�������
		if("E".equals(minwon_type)){
			sql  = " update sh_financetrouble ";
			sql += " set code = ? ";
			sql += " , abandon_date = sysdate ";
			sql += " where thid = '"+sh_mid+"'";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,"öȸ�Ϸ�");
		}else if("C".equals(minwon_type)){
			sql  = " delete sh_financetrouble ";
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

		<form method="post" action="budget_list.jsp" name="d">

			<input type="hidden" name="name" value="<%=name%>" />

		    <input type="hidden" name="passwd" value="<%=passwd%>" />

		    <input type="hidden" name="tel" value="<%=tel%>">
			
<INPUT TYPE="hidden" NAME="telephone" value="<%=telephone%>" />
  		</form>

		<script type="text/javascript">

	        <!--

	           	alert("ó���Ǿ����ϴ�.");

				document.d.submit();

		     //-->

        </script>

