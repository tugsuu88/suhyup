<%@ page language="java"
	String mid = request.getParameter("thididx");
	String name = "";
	String addr = "";
	String tel = "";
// 	String branch = "";
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
			name = rs.getString("sg_name");
			addr = rs.getString("sg_addr1");
			if(addr == null) addr="";
			if(addr2 == null) addr2="";
			address = addr + addr2;
		}

		rs.close();
		conn.close();
		
	}
	catch(Exception e){
		out.println(e.toString());
	}
%>
        <tr> 