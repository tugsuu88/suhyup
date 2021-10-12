<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.text.*"%>
<%@ page import="oracle.jdbc.driver.*"%>
<%@ page import="oracle.sql.*"%>
<%@ page import="util.SysException"%>
<%@ page import="util.Converter"%>
<%@ page import="util.Converter"%>
<%@ page import="board.commodity.*"%>
<%@ page import="javax.servlet.jsp.JspWriter"%>


<%!


	/**
	 * �Ű�ǰ ó�� ��� ���� ���� ���θ� �����ϴ� �޼ҵ�
	 * TABLE : sh_commodity
	 *
	 * @param	sh_title		����
	 * @param	sh_content		����
	 * @param	sh_reg_writer	�ۼ���
	 * @param	sh_file_no		÷������ ��ȣ
	 * @param	filenames		÷�����ϵ�
	 * @param	sh_hit_cnt		��ȸ��
	 * @param	sh_reg_dt		��� ��¥
	 *
	 * @return boolean ���� ���忩�� ǥ��
	 *
	 */
	public boolean DataInsert(String sh_title, String sh_content, String sh_reg_writer, Vector filenames,JspWriter out)
	    throws Exception
	{
// 		out.println("****************************************");
		
		sh_title			= Converter.filterSqlInjection(sh_title);
		sh_content		= Converter.filterSqlInjection(sh_content);
		sh_reg_writer		= Converter.filterSqlInjection(sh_reg_writer);
		
		//DB���� OBJECT
		//DBConnectionPoolMgr dbMgr = null;
		DataSource ds = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
	
		try
		{	
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			con = ds.getConnection();			
			con.setAutoCommit(false);
			////////////////////////////////////////////////////////////////////////
			//�˷������ ��ȣ ���ϱ�
			sql = " SELECT seq_sh_commodity.nextval FROM DUAL ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
	        rs.next();
	        int sh_seq_no = rs.getInt(1);	//��ȣ

// 			out.println("sh_seq_noL : " + sh_seq_no );

	        ////////////////////////////////////////////////////////////////////////
			//����
			sql =  " INSERT INTO sh_commodity "
				+ " ( "
				+ " sh_seq_no, sh_title, sh_content, sh_reg_writer, sh_reg_dt "
				+ " ) "
				+ " VALUES ( "
				+ sh_seq_no + ", "								+ "'" + sh_title.replace('\'','`') +"', "
				+ "'" + sh_content + "', "
				+ "'" + sh_reg_writer + "', "
				+ "sysdate "
			    + " ) " ;
// 			out.println("DataMgr --> SQL : " + sql );
	    	
	    	pstmt = con.prepareStatement(sql);
	    	
	    	
	    	//String str = sh_content;
			//StringReader is = new StringReader(str);
			//pstmt.setCharacterStream(1, is, str.getBytes().length);     
	    	
			pstmt.executeUpdate(sql);
			////////////////////////////////////////////////////////////////////////
			Vector file = filenames;
// 			out.println("file.size(gggggggggg)[" + file.size()+"]" );
			
			for (int i = 0; i < file.size(); i++) {
				DataFileInfo tempBoard = (DataFileInfo)filenames.elementAt(i);
				
				//����
				sql =  " INSERT INTO sh_board_file3 "
					+ " ( "
					+ " file_no, sh_no, file_name, file_size "
					+ " ) "
					+ " VALUES ( "
					+ " seq_sh_board_file3.nextval, "
					+ sh_seq_no + ", "
					+ "'" + tempBoard.getFile_name() + "', "
					+ tempBoard.getFile_size()
					+ " ) ";
				//out.println("DataMgr --> SQL : " + sql );
				
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
			}
			////////////////////////////////////////////////////////////////////////
			
	    	con.commit();
	    	
			return true ;
		}
		catch (Exception e)
		{
			out.println("DataMgr --> DataInsert() : " + e.getMessage());
			out.println("DataMgr --> SQL : " + sql );
			con.rollback();
			
			return false;
		}
		finally
		{
			con.setAutoCommit(true);
			if(rs != null) {
	      		rs.close();
	   		}
	   		if(stmt != null) {
	      		stmt.close();
	   		}
	   		if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					out.println("DataMgr --> DataInsert() : " + e.getMessage());
				}
				pstmt = null;
			}
	
			if (con != null) {
				try {
					//con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					out.println("DataMgr --> DataInsert() : " + e.getMessage());
				}
			}
	   		//out.println("DB Connection Close");
		}
	}
	
	/**
	 * �ڷ�� ���� ���� ���θ� �����ϴ� �޼ҵ�
	 * TABLE : sh_commodity
	 *
	 * @param	sh_title		����
	 * @param	sh_content		����
	 * @param	sh_reg_writer	�ۼ���
	 * @param	sh_file_no		÷������ ��ȣ
	 * @param	filenames		÷�����ϵ�
	 * @param	sh_hit_cnt		��ȸ��
	 * @param	sh_reg_dt		��� ��¥
	 *
	 * @return boolean ���� �������� ǥ��
	 *
	 */
	public boolean DataModify(String sh_seq_no, String sh_title, String sh_content, String sh_reg_writer, Vector filenames,JspWriter out) throws Exception
	{
		
		sh_title			= Converter.filterSqlInjection(sh_title);
		sh_content			= Converter.filterSqlInjection(sh_content);
		sh_reg_writer		= Converter.filterSqlInjection(sh_reg_writer);
		
		//DBConnectionPoolMgr dbMgr = null;
		DataSource ds = null;
	    Connection con = null;
			PreparedStatement pstmt = null;
			Statement stmt = null;
			ResultSet rs = null;
		String sql = null;
	
		try
		{
			//dbMgr = DBConnectionPoolMgr.getInstance();
			//con = dbMgr.getConnection("mydb");
			
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			con = ds.getConnection();
			//stmt = con.createStatement();
			
			con.setAutoCommit(false);
			/////////////////////////////////////////////////////////////////////////
			//����
			sql =  " UPDATE sh_commodity "
				+ " SET "
				+ " sh_title = '" + sh_title + "', "
				+ " sh_content = '" + sh_content.replace('\'','`') + "', "
				+ " sh_reg_writer = '" + sh_reg_writer  + "', "
				+ " sh_reg_dt = sysdate "
				+ " WHERE sh_seq_no = " + sh_seq_no;
			//out.println("DataMgr --> sh_contents : " + sh_contents );
			
	    	pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
	
			/////////////////////////////////////////////////////////////////////////
			Vector file = filenames;
			DataFileInfo[] sFile = getDataFileInfo(sh_seq_no);
			//������ ��ϵ� ÷�������� �����ϴ� ���
			if(sFile.length > 0) {
				//����	
				for (int i = 0; i < file.size(); i++) {
					DataFileInfo tempBoard = (DataFileInfo)filenames.elementAt(i);
					if(tempBoard.getFile_no() != null && !tempBoard.getFile_no().equals("")) {	
						//����
						sql =  " UPDATE sh_board_file3 "
							+ " SET "
							//+ " file_name = '" + Converter.toKorean(tempBoard.getFile_name()) + "', "
							+ " file_name = '" + tempBoard.getFile_name() + "', "
							+ " file_size = " + tempBoard.getFile_size() 
							+ " WHERE sh_no = " + sh_seq_no
							+ " and file_no = " + tempBoard.getFile_no();
						//out.println("DataMgr --> SQL : " + sql );
						
						pstmt = con.prepareStatement(sql);
						pstmt.executeUpdate();
					} else {
						//����
						sql =  " INSERT INTO sh_board_file3 "
							+ " ( "
							+ " file_no, sh_no, file_name, file_size "
							+ " ) "
							+ " VALUES ( "
							+ " seq_sh_board_file3.nextval, "
							+ sh_seq_no + ", "
							//+ "'" + Converter.toKorean(tempBoard.getFile_name()) + "', "
							+ "'" + tempBoard.getFile_name() + "', "
							+ tempBoard.getFile_size()
							+ " ) ";
						//out.println("DataMgr --> SQL : " + sql );
						
						pstmt = con.prepareStatement(sql);
						pstmt.executeUpdate();
					}
				}
			} else {
				//������ ��ϵ� ÷�������� ���� ���
				//����
				for (int i = 0; i < file.size(); i++) {
					DataFileInfo tempBoard = (DataFileInfo)filenames.elementAt(i);
					
					//����
					sql =  " INSERT INTO sh_board_file3 "
						+ " ( "
						+ " file_no, sh_no, file_name, file_size "
						+ " ) "
						+ " VALUES ( "
						+ " seq_sh_board_file3.nextval, "
						+ sh_seq_no + ", "
						//+ "'" + Converter.toKorean(tempBoard.getFile_name()) + "', "
						+ "'" + tempBoard.getFile_name() + "', "
						+ tempBoard.getFile_size()
						+ " ) ";
					//out.println("DataMgr --> SQL : " + sql );
					
					pstmt = con.prepareStatement(sql);
					pstmt.executeUpdate();
				}
			}
			/////////////////////////////////////////////////////////////////////////
	    	con.commit();
	
			return true ;
		}
		catch (Exception e)
		{
			out.println("DataMgr --> DataModify() : " + e.getMessage());
			out.println("DataMgr --> SQL : " + sql );
			con.rollback();
			
			return false;
	    }
		finally
		{
			con.setAutoCommit(true);
			if(rs != null) {
	      		rs.close();
	   		}
	   		if(stmt != null) {
	      		stmt.close();
	   		}
	   		if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					out.println("DataMgr --> DataModify() : " + e.getMessage());
				}
				pstmt = null;
			}
	
			if (con != null) {
				try {
					//con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					out.println("DataMgr --> DataModify() : " + e.getMessage());
				}
			}
	   		//out.println("DB Connection Close");
		}
	}
	
	public void writeClob(Clob clob, String text) throws Exception {
		  Writer writer = null;
		  Reader reader = null;
		  try {
	
		   writer = ((oracle.sql.CLOB)clob).getCharacterOutputStream();
		   reader = new CharArrayReader(text.toCharArray());
		  
		   char[] buffer = new char[1024];
		   int read = 0;
		   while ( (read = reader.read(buffer,0,1024)) != -1){
		    writer.write(buffer, 0, read);
		   }
	
		  } catch (Exception exception) {
		   throw exception;
		  } finally {
		   if (reader != null) try { reader.close(); } catch (Exception exception) {}
		   if (writer != null) try { writer.close(); } catch (Exception exception) {}
		  }
		 } 
	
	
	/**
	 * �ڷ�� ���� ���� ���θ� �����ϴ� �޼ҵ�
	 * TABLE : sh_commodity, sh_board_file3
	 *
	 * @param	sh_seq_no	��ȣ
	 *	
	 * @return boolean ���� �������� ǥ��
	 *
	 */
	public boolean DataDel( String sh_seq_no,JspWriter out ) throws Exception
	{
		sh_seq_no	= Converter.filterSqlInjection(sh_seq_no);
		
		//DBConnectionPoolMgr dbMgr = null;
		DataSource ds = null;
		Connection con = null;
			PreparedStatement pstmt = null;
			Statement stmt = null;
			ResultSet rs = null;
		String sql = null;
	
		try
		{
			//dbMgr = DBConnectionPoolMgr.getInstance();
			//con = dbMgr.getConnection("mydb");
			
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			con = ds.getConnection();
			//stmt = con.createStatement();
			
			con.setAutoCommit(false);
			/////////////////////////////////////////////////////////////////////////
			//����
			sql = "Delete From sh_commodity "
				+ " WHERE sh_seq_no = " + sh_seq_no;
// 			out.println("DataMgr --> SQL : " + sql );
			
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			/////////////////////////////////////////////////////////////////////////
			sql = "Delete From sh_board_file3 "
				+ " WHERE sh_no = " + sh_seq_no;
			out.println("DataMgr --> SQL : " + sql );
			
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			/////////////////////////////////////////////////////////////////////////
			con.commit();
			
			return true;
		}
		catch (Exception e)
		{
			out.println("DataMgr --> DataDel() : " + e.getMessage());
			out.println("DataMgr --> SQL : " + sql );
			con.rollback();
			
			return false;
		}
		finally
		{
			con.setAutoCommit(true);
			if(rs != null) {
	      		rs.close();
	   		}
	   		if(stmt != null) {
	      		stmt.close();
	   		}
	   		if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					out.println("DataMgr --> DataDel() : " + e.getMessage());
				}
				pstmt = null;
			}
	
			if (con != null) {
				try {
					//con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					out.println("DataMgr --> DataDel() : " + e.getMessage());
				}
			}
	   		//out.println("DB Connection Close");
		}
	}
	
	public int getDataInfoCnt() throws Exception
	{
		return getDataInfoCnt( "", "" );
	}
	
	/**
	 * �˻� ���ڵ� �� ���� �����Ѵ�
	 * TABLE : sh_commodity
	 *
	 * @param	div			�˻�����
	 * @param	srchtxt		�˻���
	 *
	 * @return
	 *
	 */
	public int getDataInfoCnt(String div, String srchtxt) throws Exception
	{
		div			= Converter.filterSqlInjection(div);
		srchtxt		= Converter.filterSqlInjection(srchtxt);
		
		//DBConnectionPoolMgr dbMgr = null;
		DataSource ds = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
	
		try
		{
			//dbMgr = DBConnectionPoolMgr.getInstance();
			//con = dbMgr.getConnection("mydb");
			
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			con = ds.getConnection();
			//stmt = con.createStatement();
			///////////////////////////////////////////////////////////////
			sql =  " SELECT	count(*)"
				+ " FROM	sh_commodity"
				+ " WHERE sh_title is not null ";
			if(div != null && div.equals("title")) {
				sql  += " and	sh_title LIKE '%" +  Converter.toKorean(srchtxt) + "%'";
			} else if(div != null && div.equals("cont")) {
				sql  += " and	sh_content LIKE '%" +  Converter.toKorean(srchtxt) + "%'";
			}
			//out.println("DataMgr : getNotiInfoCnt -> " + sql );
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			for ( ; rs.next() ; )
			{
				return rs.getInt(1);					
			}  				     
			return 0;			
		}
		catch( Exception e)
	    {
	        throw new SysException(e,"getDataInfoCnt ����");
	    }
	    finally
	    {
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (rs != null) try { rs.close(); } catch(SQLException ex2) {}
			//if (con != null) dbMgr.returnConnection("mydb", con);
			if (con != null) con.close();
	    }	
	}
	
	public DataInfoLst getDataInfoLst( int range, int currpage ) throws Exception
	{
		return getDataInfoLst( range, currpage ,  "", "" );
	}
	
	/**
	 * �˻� ���ǿ� �´� ���ڵ带 ����Ʈ�� �ۼ��Ѵ�
	 * TABLE : sh_commodity
	 *
	 * @param	range		����
	 * @param	currpage	����������
	 * @param	div			�˻����� 
	 * @param	srchtxt		�˻���
	 * @param	sh_noti		�Խÿ���
	 *
	 * @return faqinfolst
	 *
	 */
	public DataInfoLst getDataInfoLst( int range, int currpage, String div, String srchtxt ) throws Exception
	{
		div			= Converter.filterSqlInjection(div);
		srchtxt		= Converter.filterSqlInjection(srchtxt);
		
		//DBConnectionPoolMgr dbMgr = null;
		DataSource ds = null;
		Connection con = null;
			PreparedStatement pstmt = null;
			Statement stmt = null;
			ResultSet rs = null;
		String sql = null;
		
		DataInfoLst datainfolst = new DataInfoLst();
	
		try
		{
			//dbMgr = DBConnectionPoolMgr.getInstance();
			//con = dbMgr.getConnection("mydb");
			
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			con = ds.getConnection();
			//stmt = con.createStatement();
			///////////////////////////////////////////////////////////////
			sql = " SELECT	sh_seq_no ";
			sql += " FROM	sh_commodity ";
			sql += " WHERE sh_title is not null ";
			if(div != null && div.equals("title")) {
				sql  += " and	sh_title LIKE '%" +  Converter.toKorean(srchtxt) + "%'";
			} else if(div != null && div.equals("cont")) {
				sql  += " and	sh_content LIKE '%" +  Converter.toKorean(srchtxt) + "%'";
			}
			sql += " ORDER BY sh_seq_no DESC ";
			//out.println("DataMgr : getDataInfoLst -> " + sql );
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// range �� currpage ���� ���� ����� �ۼ��Ѵ�.
			for( int i = 0 ; rs.next() ; i++ )
			{
				if ( i > range * (currpage - 1) - 1 && i < range * currpage )
				{
					DataInfo datainfo  = new DataInfo();
					datainfo = getDataInfo( rs.getString(1));
					datainfolst.addElement(datainfo);
				}
				if (i > range * currpage) break;
			}
	     	return datainfolst;
		}
		catch( Exception e)
	    {
	        throw new SysException(e,"getDataInfoLst ����");
	    }
	    finally
	    {
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (rs != null) try { rs.close(); } catch(SQLException ex2) {}
			//if (con != null) dbMgr.returnConnection("mydb", con);
			if (con != null) con.close();
	    }
	}
	
	/**
	 * �˻��� ����� �޾� ����� �ϴ� �÷��� ������ datainifo�� �����Ѵ�.
	 * TABLE : sh_commodity
	 *
	 * @param	sh_seq_no		��ȣ
	 *
	 * @return datainifo
	 *
	 */
	public DataInfo getDataInfo( String sh_seq_no ) throws Exception
	{
		sh_seq_no	= Converter.filterSqlInjection(sh_seq_no);
		
		//DBConnectionPoolMgr dbMgr = null;
		DataSource ds = null;
		Connection con = null;
			PreparedStatement pstmt = null;
			Statement stmt = null;
			ResultSet rs = null;
		String sql = null;
	
		DataInfo datainfo = new DataInfo();
	
		try
		{
			//dbMgr = DBConnectionPoolMgr.getInstance();
			//con = dbMgr.getConnection("mydb");
			
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			con = ds.getConnection();
			//stmt = con.createStatement();
			///////////////////////////////////////////////////////////////
			//�ڷ� ���ϱ�
			sql = "SELECT sh_seq_no, sh_title, sh_content, sh_reg_writer ,sh_hit_cnt, "
				+ " to_char(sh_reg_dt, 'YYYYMMDD'), to_char(sh_mod_dt, 'YYYYMMDD') "
				+ " FROM sh_commodity "
				+ " WHERE sh_seq_no = " + sh_seq_no;
			//out.println("DataMgr : getDataInfo -> " + sql );
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			for ( ; rs.next() ; )
			{
				datainfo.sh_seq_no = rs.getString(1);
				datainfo.sh_class = rs.getString(2);
				datainfo.sh_title = rs.getString(3);
				datainfo.sh_noti = rs.getString(4);
				datainfo.sh_div = rs.getString(5);
				datainfo.sh_contents = rs.getString(6);
				datainfo.sh_cnt = rs.getString(7);
				datainfo.sh_indate = rs.getString(8);
				datainfo.sh_inuser = rs.getString(9);
				datainfo.sh_update = rs.getString(10);
				datainfo.sh_upuser = rs.getString(11);
				
				return datainfo;
			}      
			
	       	return null; 
		}
		catch( Exception e)
	    {
	        throw new SysException(e,"getNotiInfo ����");
	    }
	    finally
	    {
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (rs != null) try { rs.close(); } catch(SQLException ex2) {}
			//if (con != null) dbMgr.returnConnection("mydb", con);
			if (con != null) con.close();
	    }
	}
	
	/**
	 * �˷������ ���� ��ȸ �� ��ȸ �� ����
	 * TABLE : sh_commodity
	 *
	 * @param	sh_seq_no		��ȣ
	 *
	 * @return boolean ���� �������� ǥ��
	 *
	 */
	public boolean updateDataCnt( String sh_seq_no ) throws Exception
	{
		sh_seq_no	= Converter.filterSqlInjection(sh_seq_no);
		
		//DBConnectionPoolMgr dbMgr = null;
		DataSource ds = null;
	    Connection con = null;
			PreparedStatement pstmt = null;
			Statement stmt = null;
			ResultSet rs = null;
		String sql = null;
	
		try
		{
			//dbMgr = DBConnectionPoolMgr.getInstance();
			//con = dbMgr.getConnection("mydb");
			
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			con = ds.getConnection();
			//stmt = con.createStatement();
			
			con.setAutoCommit(false);
			/////////////////////////////////////////////////////////////////////////
			//��ȸ �� ����
			sql =  " UPDATE sh_commodity "
				+ " SET "
				+ " sh_cnt = sh_seq_no + 1 "
				+ " WHERE sh_seq_no = " + sh_seq_no;
			//out.println("DataMgr : updateDataCnt --> " + sql );
			
	    	pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			/////////////////////////////////////////////////////////////////////////
	    	con.commit();
	
			return true ;
		}
		catch (Exception e)
		{
			//out.println("DataMgr --> updateDataCnt() : " + e.getMessage());
			//out.println("DataMgr --> SQL : " + sql );
			con.rollback();
			
			return false;
	    }
		finally
		{
			con.setAutoCommit(true);
			if(rs != null) {
	      		rs.close();
	   		}
	   		if(stmt != null) {
	      		stmt.close();
	   		}
	   		if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					//out.println("DataMgr --> updateDataCnt() : " + e.getMessage());
				}
				pstmt = null;
			}
	
			if (con != null) {
				try {
					//con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					//out.println("DataMgr --> updateDataCnt() : " + e.getMessage());
				}
			}
	   		//out.println("DB Connection Close");
		}
	}
	
	
	/**
	 * �˷������ ÷������ ����
	 * TABLE : sh_board_file3
	 *
	 * @param	sh_seq_no	��ȣ
	 *
	 * @return DataFileInfo[]
	 *
	 */
	public DataFileInfo[] getDataFileInfo ( String sh_seq_no ) throws Exception 
	{
		sh_seq_no	= Converter.filterSqlInjection(sh_seq_no);
		
		//DB���� OBJECT
		//DBConnectionPoolMgr dbMgr = null;
		DataSource ds = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			Statement stmt = null;
			ResultSet rs = null;
		String sql = null;
		Vector v = new Vector();
		
		try
		{
			//dbMgr = DBConnectionPoolMgr.getInstance();
			//con = dbMgr.getConnection("mydb");
			
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			con = ds.getConnection();
			//stmt = con.createStatement();
			////////////////////////////////////////////////////////////////////////
			//÷������ ���� ���ϱ�
			sql = "SELECT file_no, sh_no, file_name, file_size, file_count "
				+ " FROM sh_board_file3 "
				+ " WHERE sh_no = " + sh_seq_no
				+ " Order By file_no";
			//out.println("DataMgr --> SQL : " + sql );
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			    
			 while (rs.next()) {
	    		v.add(new DataFileInfo(
	       			rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), 
	       			rs.getString(5) ));
	  		}
	      
	    	return DataFileInfo.getArray(v);
		}
		catch( Exception e)
	    {
	        throw new SysException(e,"getDataFileInfo ����");
	    }
	    finally
	    {
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex1) {}
			if (rs != null) try { rs.close(); } catch(SQLException ex2) {}
			//if (con != null) dbMgr.returnConnection("mydb", con);
			if (con != null) con.close();
	    }
	}
	
	/**
	 * �˷������ ÷������ ���� ���� ���θ� �����ϴ� �޼ҵ�
	 * TABLE : sh_board_file3
	 *
	 * @param	file_no		���� ��ȣ
	 * @param	sh_seq_no		��ȣ
	 * @param	savePath	���� ���
	 *	
	 * @return boolean ���� �������� ǥ��
	 *
	 */
	public boolean DataFileDel( String file_no, String sh_seq_no, String savePath ) throws Exception
	{
		file_no		= Converter.filterSqlInjection(file_no);
		sh_seq_no		= Converter.filterSqlInjection(sh_seq_no);
		savePath	= Converter.filterSqlInjection(savePath);
		
		//DBConnectionPoolMgr dbMgr = null;
		DataSource ds = null;
		Connection con = null;
			PreparedStatement pstmt = null;
			Statement stmt = null;
			ResultSet rs = null;
		String sql = null;
	
		try
		{
			//dbMgr = DBConnectionPoolMgr.getInstance();
			//con = dbMgr.getConnection("mydb");
			
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
			con = ds.getConnection();
			//stmt = con.createStatement();
			
			con.setAutoCommit(false);
			/////////////////////////////////////////////////////////////////////////
			//÷������ ���� ���ϱ�
			String file_name = null;
			sql = "SELECT file_no, sh_no, file_name, file_size, file_count "
				+ " FROM sh_board_file3 "
				+ " WHERE file_no = " + file_no
				+ " and  sh_no = " + sh_seq_no;
			//out.println("DataMgr --> SQL : " + sql );
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			for ( ; rs.next() ; )
			{
				file_name = rs.getString(3);
			}
			/////////////////////////////////////////////////////////////////////////
			//����
			sql = "Delete From sh_board_file3 "
				+ " WHERE file_no = " + file_no
				+ " and  sh_no = " + sh_seq_no;
			//out.println("DataMgr --> SQL : " + sql );
			
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
			//file delete
			if(file_name.length() > 0) {
			   File file = new File(savePath + file_name);
			   if(file.exists()) {	
				   file.delete();
			   }
			}
			/////////////////////////////////////////////////////////////////////////
			con.commit();
			
			return true;
		}
		catch (Exception e)
		{
			//out.println("DataMgr --> DataFileDel() : " + e.getMessage());
			//out.println("DataMgr --> SQL : " + sql );
			con.rollback();
			
			return false;
		}
		finally
		{
			con.setAutoCommit(true);
			if(rs != null) {
	      		rs.close();
	   		}
	   		if(stmt != null) {
	      		stmt.close();
	   		}
	   		if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
					//out.println("DataMgr --> DataFileDel() : " + e.getMessage());
				}
				pstmt = null;
			}
	
			if (con != null) {
				try {
					//con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					//out.println("DataMgr --> DataFileDel() : " + e.getMessage());
				}
			}
	   		//out.println("DB Connection Close");
		}
	}
%>


