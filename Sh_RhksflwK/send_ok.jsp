<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>
<%@ page contentType="text/html;charset=euc-kr" %>
<%
	int PAGE=Integer.parseInt(Converter.nullchk(request.getParameter("PAGE")));
	int thid=Integer.parseInt(Converter.nullchk(request.getParameter("thid")));
	
	String sh_buseo_from =Converter.nullchk(request.getParameter("buseo_from"));
	String sh_buseo_to=Converter.nullchk(request.getParameter("buseo"));
	String sh_status="이첩";
	String admintel="02-2240-3383";
	DataSource ds = null;
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt=null;
	
	
	try{
		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();

		String mobile=FrontBoard.OnlyOne("Select sh_mobile from sh_minwon_admin where sh_buseo = '" + sh_buseo_to + "'");

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

		SmsMgr sm=new SmsMgr();
		boolean issms=sm.exqute(admintel,mobile,"전자민원이 접수되었습니다. 확인바랍니다.");
		//20080617 수정
		if(sh_buseo_to.equals("금융소비자보호부")){
			sql="update sh_financetrouble set buseo=?,code=?,junbuseo='Y' where thid=? and code<>'답변완료'";
		}
		else{
			sql="update sh_financetrouble set buseo=?,code=? where thid=? and code<>'답변완료'";
		}
		//20080617 수정 끝
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
  	alert("<%=sh_buseo_to%> 을로(로) 이첩되었습니다.");
	self.location = "finance.jsp?PAGE=<%=PAGE%>";
//-->
</script>
