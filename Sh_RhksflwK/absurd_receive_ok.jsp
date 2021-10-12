<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page contentType="text/html;charset=euc-kr" %>
<%
	int PAGE=Integer.parseInt(Converter.nullchk(request.getParameter("PAGE")));
	int thid=Integer.parseInt(Converter.nullchk(request.getParameter("thid")));
	String sh_buseo_from=Converter.nullchk(request.getParameter("buseo_from"));
	String sh_buseo_to=Converter.nullchk(request.getParameter("buseo_to"));
	String sh_status="반송";
	DataSource ds = null;
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt=null;

	try{		
		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();

		String sql = "";
		
		sql="insert into sh_finance_history(sh_no,sh_finance_no,sh_buseo_from,sh_buseo_to,sh_indate,sh_status) values";
		sql+="(seq_sh_finance_history.nextval,?,?,?,sysdate,?)";

		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement(sql);

		pstmt.setInt(1,thid);
		pstmt.setString(2,sh_buseo_from);
		pstmt.setString(3,sh_buseo_to);
		pstmt.setString(4,sh_status);
		pstmt.executeUpdate();
		
		if(sh_buseo_to.equals("감사실") || sh_buseo_to.equals("감사부")){
			sql="update sh_financetrouble set buseo=?,code=?,junbuseo='' where thid=? and code<>'답변완료'";
			//sql="update financetrouble set buseo='" + sh_buseo_to + "',code='" + sh_status + "',junbuseo='' where thid=" + thid;
		}
		else{
			sql="update sh_financetrouble set buseo=?,code=? where thid=? and code<>'답변완료'";
		}
		
		pstmt=conn.prepareStatement(sql);

		pstmt.setString(1,sh_buseo_to);
		pstmt.setString(2,sh_status);
		pstmt.setInt(3,thid);
		pstmt.executeUpdate();
		
		conn.commit();
		conn.setAutoCommit(true);
	}catch (Exception e){
		conn.rollback();
		conn.setAutoCommit(true);
		System.out.println("[ERROR] 오류사항 확인필요");
	}
	finally{
		if(pstmt!=null){
			pstmt.close();
		}
		if(conn!=null)	conn.close();
	}
	
%>
<script language="javascript">
<!--
  	alert("<%=sh_buseo_to%> 로 반송되었습니다.");
	self.location = "absurd.jsp?PAGE=<%=PAGE%>";
//-->
</script>
