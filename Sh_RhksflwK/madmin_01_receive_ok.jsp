<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ page contentType="text/html;charset=euc-kr"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	response.setContentType("text/html; charset=euc-kr");
%>
<%
	int PAGE=Integer.parseInt(Converter.nullchk(request.getParameter("PAGE")));
	int mid=Integer.parseInt(Converter.nullchk(request.getParameter("mid")));
	String sh_buseo_from = Converter.nullchk(request.getParameter("buseo_from"));
	String sh_buseo_to = Converter.nullchk(request.getParameter("buseo_to"));
// 	System.out.println(sh_buseo_to);
	
	String sh_status = "반송";
	
	String sh_bupin = "";
	if("감사실".equals(sh_buseo_to)){
		sh_bupin = "1";
	}else if("감사부".equals(sh_buseo_to)){
		sh_bupin = "2";
	}else{
		sh_bupin = "0";
	}
	
// 	System.out.println("sh_bupin == " + sh_bupin);

	DataSource ds = null;
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt=null;

	try{		
		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();

		
		String midstr = FrontBoard.OnlyOne("SELECT NVL(MAX(SH_NO),0)+1 FROM SH_MINWON_HISTORY");
		
		String sql = "";
		
		sql="insert into sh_minwon_history(sh_no,sh_minwon_no,sh_buseo_from,sh_buseo_to,sh_indate,sh_status) values";
		sql+="('"+midstr+"', ?, ?, ?, sysdate, ?)";

		conn.setAutoCommit(false);
		pstmt=conn.prepareStatement(sql);

		pstmt.setInt(1,mid);
		pstmt.setString(2,sh_buseo_from);
		pstmt.setString(3,sh_buseo_to);
		pstmt.setString(4,sh_status);
		pstmt.executeUpdate();
		
		boolean bSuccess = false;	//DB작업 성공 여부
		String TableName = " sh_minwon ";
		bSuccess = FrontBoard.DataModify(mid, sh_bupin, TableName);
		
		if(sh_buseo_to.equals("감사실") || sh_buseo_to.equals("감사부")){
			sql="update sh_minwon set buse_name=?,status=?,junbuseo='' where mid=? and status<>'답변완료'";
			//sql="update financetrouble set buseo='" + sh_buseo_to + "',code='" + sh_status + "',junbuseo='' where thid=" + thid;
		}
		else{
			sql="update sh_minwon set buse_name=?,status=? where mid=? and status<>'답변완료'";
		}
		
		pstmt=conn.prepareStatement(sql);

		pstmt.setString(1,sh_buseo_to);
		pstmt.setString(2,sh_status);
		pstmt.setInt(3,mid);
		pstmt.executeUpdate();
		
// 		System.out.println("bSuccess = " + bSuccess);
		
		if(bSuccess){
			conn.commit();
			conn.setAutoCommit(true);
		}else{
			System.out.println("[ERROR] 오류사항 확인필요");
		}
		
		
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
	self.location = "madmin_01.jsp?PAGE=<%=PAGE%>";
//-->
</script>
