<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>

<%@ page contentType="text/html;charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<%
	int PAGE = Integer.parseInt(Converter.nullchk(request.getParameter("PAGE")));
	int mid = Integer.parseInt(Converter.nullchk(request.getParameter("mid")));
	String sh_buseo_from = Converter.nullchk(request.getParameter("buseo_from"));
	String sh_buseo_to = Converter.nullchk(request.getParameter("buseo"));
	String sh_johap = Converter.nullchk(request.getParameter("sh_johap"));
	
	String sh_status = "��ø";
	String admintel = "02-2240-3383";
	
	String sh_bupin = "";	
	
	if("�����".equals(sh_buseo_to) || "�ع����ý�(�߾�ȸ)".equals(sh_buseo_to)){
		sh_bupin = "1";
	}else if("�����".equals(sh_buseo_to) || "�����Һ��ں�ȣ��".equals(sh_buseo_to)){
		sh_bupin = "2";
	}else if("�ع����ý�(����)".equals(sh_buseo_to)){
		sh_bupin = "3";
	}else{
		sh_bupin = "0";
	}
	
	if("ȸ������".equals(sh_buseo_to)) {
		sh_buseo_to = sh_buseo_to + "(" + sh_johap + ")";
	}
	
	
// 	System.out.println("mid == " + mid);
// 	System.out.println("sh_buseo_to == " + sh_buseo_to);
// 	System.out.println("sh_bupin == " + sh_bupin);

	DataSource ds = null;
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt=null;

	try{
		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();

		String mobile = FrontBoard.OnlyOne("Select sh_mobile from sh_minwon_admin where sh_buseo = '" + sh_buseo_to + "'");
		String midstr = FrontBoard.OnlyOne("select nvl(max(sh_no),0)+1 from sh_minwon_history");
		
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
		
		boolean bSuccess = false;	//DB�۾� ���� ����
		String TableName = " sh_minwon ";
		bSuccess = FrontBoard.DataModify(mid, sh_bupin, TableName);
		
		
// 		String TableName = " sh_ifbs_main ";
// 		String InsertTemplete = "(sh_no, sh_site, sh_class, sh_ismain, sh_inuser, sh_indate )";
// 		String ValuesString = " (SEQ_SH_IFBS_MAIN.NEXTVAL, '" + sh_site + "', ?, 'N', 'super', sysdate) ";
// 		bSuccess = MainProp.AddData(TableName, InsertTemplete, ValuesString, selValue[i]);
		
		
// 		Vector vtsheet   = new Vector();
// 		vtsheet.addElement("update sh_minwon set mid = '"+mid+"' where bupin ="+sh_bupin);
//         vtsheet.addElement(mid);
//         vtsheet.addElement(sh_bupin);
// 		String Result = FrontBoard.DataProcess(vtsheet);
// 		System.out.println(Result);
// 		System.out.println(vtsheet);
		

		

		//20080617 ����
		if(sh_buseo_to.equals("�����Һ��ں�ȣ��")){
			sql="update sh_minwon set buse_name=?,status=?,junbuseo='Y' where mid=? and status<>'�亯�Ϸ�'";
		}
		else{
			sql="update sh_minwon set buse_name=?,status=? where mid=? and status<>'�亯�Ϸ�'";
		}
		//20080617 ���� ��

		pstmt=conn.prepareStatement(sql);

		pstmt.setString(1,sh_buseo_to);
		pstmt.setString(2,sh_status);		
		pstmt.setInt(3,mid);
		pstmt.executeUpdate();

		
		if(bSuccess){
			SmsMgr sm=new SmsMgr();
			boolean issms=sm.exqute(admintel,mobile,"���ڹο��� �����Ǿ����ϴ�. Ȯ�ιٶ��ϴ�.");
			
			conn.commit();
			conn.setAutoCommit(true);
		}
		
	}catch (Exception e){
		conn.rollback();
		conn.setAutoCommit(true);
		System.out.println("[ERROR] �������� Ȯ���ʿ�");
	}
	finally{
		if(pstmt!=null){
			pstmt.close();
		}
		if(conn!=null)	conn.close();
	}

%>
<script type="text/javascript">
  	alert("<%=sh_buseo_to%> ����(��) ��ø�Ǿ����ϴ�.");
	self.location = "madmin_01.jsp?PAGE=<%=PAGE%>";
</script>