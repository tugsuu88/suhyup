<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page contentType="text/html;charset=euc-kr" %>
<%
	int PAGE=Integer.parseInt(Converter.nullchk(request.getParameter("PAGE")));
	int mid=Integer.parseInt(Converter.nullchk(request.getParameter("mid")));
	String sh_buseo_from = Converter.nullchk(request.getParameter("buseo_from"));
	String sh_buseo_to = Converter.nullchk(request.getParameter("buseo_to"));
	String sh_status="�ݼ�";
	
	try{		
		String sql = "";
		if(sh_buseo_to.equals("�����")){
			sql="update sh_minwon set buse_name=?,status=?,junbuseo='' where mid=? and status<>'�亯�Ϸ�'";
			//sql="update financetrouble set buseo='" + sh_buseo_to + "',code='" + sh_status + "',junbuseo='' where thid=" + thid;
		}
		else{
			sql="update sh_minwon set buse_name=?,status=? where mid=? and status<>'�亯�Ϸ�'";
		}

		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,sh_buseo_to);
	}catch (Exception e){
		conn.rollback();
		conn.setAutoCommit(true);
	finally{
<script language="javascript">