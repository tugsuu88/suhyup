<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%	
		DataSource ds = null;
		Context ic = new InitialContext();
		String sql = "";
		conn.setAutoCommit(false);
		SmsMgr sm=new SmsMgr();
		sql="update sh_minwon set answer_fname=?,result=?,status=?,answer=?,minwon_gubun=?, sh_fileno=?, sh_file_name=?, answer_date=sysdate where mid=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,replyname);
		pstmt.setInt(8,mid);
		pstmt.close();
	}catch (Exception e){
<script language="javascript">