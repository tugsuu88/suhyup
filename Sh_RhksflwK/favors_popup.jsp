<%@ page language="java"	import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%><%@ page contentType="text/html;charset=euc-kr"%><jsp:useBean id="FrontBoard" scope="request"	class="Bean.Front.Common.FrontBoradType1" /><jsp:useBean id="FrontDbUtil" scope="request"	class="Bean.Front.Common.FrontDbUtil" /><%
	String mid = request.getParameter("thididx");	if(mid == null) mid="0";	int sh_mid = Integer.parseInt(mid);	// 	System.out.println("mid = " + mid);// 	System.out.println("sh_mid = " + sh_mid);
	String name = "";
	String addr = "";
	String tel = "";
// 	String branch = "";	String sg_zip = "";
	String addr2 = "";
	String address = "";
	
	try {	
	
		DataSource ds = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		PreparedStatement pstmt=null;

		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();
		
		String sql = "";	
		sql = " select sg_name, sg_zip, sg_addr1, sg_addr2, sg_tel from sh_chungtak " ;
		sql += " where thid = '"+sh_mid+"'";

		stmt=conn.createStatement();
		rs = stmt.executeQuery(sql);
		 
		if(rs.next()){
			name = rs.getString("sg_name");			if(name != null && !name.equals("")){				name = name.replaceAll("<", "&lt;").replaceAll(">", "&gt;");			}						sg_zip = rs.getString("sg_zip");						tel = rs.getString("sg_tel");			if(tel == null) tel="";			if(tel != null && !tel.equals("")){				tel = tel.replaceAll("<", "&lt;").replaceAll(">", "&gt;");			}			
			addr = rs.getString("sg_addr1");
			if(addr == null) addr="";			if(addr != null && !addr.equals("")){				addr = addr.replaceAll("<", "&lt;").replaceAll(">", "&gt;");			}			addr2 = rs.getString("sg_addr2");
			if(addr2 == null) addr2="";			if(addr2 != null && !addr2.equals("")){				addr2 = addr2.replaceAll("<", "&lt;").replaceAll(">", "&gt;");			}
			address = addr + addr2;
		}

		rs.close();
		conn.close();
		
	}
	catch(Exception e){
		out.println(e.toString());
	}
%><html><head><title>Untitled Document</title><meta http-equiv="Content-Type" content="text/html; charset=euc-kr"><LINK href="img/style.css" type=text/css rel=stylesheet></head><body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">	<table width="500" border="0" cellspacing="0" cellpadding="0">		<tr>			<td background="img/popup_top.gif" height="75"				style="padding: 50 0 0 26" class="white" valign="top">민원인 상세정보</td>		</tr>		<tr>			<td background="img/popup_bg.gif" align="center">				<table width="472" border="0" cellspacing="0" cellpadding="0"					class="popup_outline">					<tr>						<td height="30" style="padding-left: 10;" class="bluesky"							width="90">성명</td>						<td><%=name%></td>					</tr>					<tr>						<td colspan="2" height="1" bgcolor="#d9e8f3"></td>					</tr>					<tr>						<td height="30" style="padding-left: 10;" class="bluesky">주소</td>						<td>[<%=sg_zip %>]&nbsp;<%=address%></td>					</tr>					<tr>						<td colspan="2" height="1" bgcolor="#d9e8f3"></td>					</tr>					<tr>						<td height="30" style="padding-left: 10;" class="bluesky">휴대폰</td>						<td><%=tel%></td>					</tr>					<tr>						<td colspan="2" height="1" bgcolor="#d9e8f3"></td>					</tr>					<%-- 
        <tr>           <td height="30" style="padding-left:10;" class="bluesky">이메일</td>          <td><%=branch%></td>        </tr>         --%>				</table>			</td>		</tr>		<tr>			<td><img src="img/popup_bottom.gif" width="500" height="20"></td>		</tr>		<tr>			<td bgcolor="e5e5e5" align="center" height="40"><img				src="img/popup_close.gif" width="67" height="18"				onClick="javascript:window.close();" style="cursor: hand" alt="닫기"></td>		</tr>	</table></body></html>