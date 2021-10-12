<%
/*****************************************************************************
*Title			: login_proc.jsp
*@author		: K.H.S
*@date			: 2007-10
*@Description	: 로그인 처리
*@Copyright		: 
******************************************************************************
*수정일		*수정자		*수정사유
******************************************************************************/
%>
<%@ page import="java.util.*,java.text.*,Bean.Front.Common.*, util.*" contentType="text/html;charset=euc-kr" pageEncoding="euc-kr" %>
<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/><jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />	<% request.setCharacterEncoding("euc-kr"); %>
<%
	try {
	    String sh_id = Converter.nullchk(request.getParameter("sh_id"));
		//out.println("sh_id : " + sh_id + "<br>");
		String sh_pwd = Converter.nullchk(request.getParameter("sh_pwd"));		sh_pwd = aes.aesEncode(sh_pwd);
	    ///////////////////////////////////////////////////
	    String TableName = " sh_minwon_admin ";
	    String SelectCondition = null;
	    String WhereCondition = null;
	    String OrderCondition = null;
		int TotalRecordCount = 0;

		//아이디 검색
		WhereCondition = " where sh_id = '" + sh_id + "'";
		TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
		if(TotalRecordCount == 0){
%>
			<script language='javascript'>
				alert('존재하지 않는 아이디 입니다. \n\n 확인 후 다시 작업하시기 바랍니다.');				location.href="index.jsp";				
				//history.go(-1);
				//self.location = "logout.jsp";
	        </script>
<%		}						//로그인횟수 체크 20170801 추가 		WhereCondition = " where sh_id = '" + sh_id + "' and sh_login_fail_cnt < 3";		TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);		if(TotalRecordCount == 0){%>			<script language='javascript'>				alert('비밀번호 3회 실패 . \n\n 관리자에게 문의 바랍니다.');								location.href="index.jsp";								//history.go(-1);				//self.location = "logout.jsp";	        </script><%		}
		///////////////////////////////////////////////////
		//아이디,비밀번호 검색
		WhereCondition = " where sh_id = '" + sh_id + "' and sh_pwd='" + sh_pwd + "'";
		TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);		if(TotalRecordCount == 0){			Vector vtsheet   = new Vector();			vtsheet.addElement("update sh_minwon_admin set sh_login_fail_cnt = sh_login_fail_cnt + 1 where sh_id =? ");	        vtsheet.addElement("String");	        vtsheet.addElement(sh_id);			String Result = FrontBoard.DataProcess(vtsheet);			
%>
			<script language='javascript'>
				alert('아이디에 비밀번호가 일치하지 않습니다. \n\n 확인 후 다시 작업하시기 바랍니다.');				//history.go(-1);
				location.href="index.jsp";
				//self.location = "logout.jsp";
	        
			</script>
<%		        
        }else{        	Vector vtsheet   = new Vector();			vtsheet.addElement("update sh_minwon_admin set SH_LOGIN_FAIL_CNT = 0 where sh_id =? ");	        vtsheet.addElement("String");	        vtsheet.addElement(sh_id);			String Result = FrontBoard.DataProcess(vtsheet);             }
		///////////////////////////////////////////////////
		String sh_name = "";
		String sh_buseo = "";
		String sh_mobile = "";
		String sh_gicwe = "";
		String sh_admin_manager = "";
		String sh_admin_faq = "";
		String sh_admin_minwonall = "";
		String sh_admin_buseo = "";
		String sh_admin_result = "";
		String sh_admin_jebo = "";
		String sh_admin_bujori = "";
		String sh_admin_myunsei = "";
		String sh_admin_corruption = "";				String sh_admin_favors = "";				String sh_admin_upright = "";				String sh_admin_sms = "";
				
		SelectCondition = " sh_id, sh_name, sh_pwd, sh_buseo,sh_mobile, sh_gicwe,	sh_gicgub, sh_admin_manager, sh_admin_faq, ";
		SelectCondition += " sh_admin_minwonall, sh_admin_buseo, sh_admin_result, sh_admin_jebo, sh_admin_bujori, ";
		SelectCondition += " sh_admin_myunsei, sh_admin_corruption, sh_admin_favors, sh_admin_upright, sh_inuser , sh_admin_sms";
		//WhereCondition  = " where sh_id = '" + sh_id + "'";
		WhereCondition = " where sh_id = '" + sh_id + "' and sh_pwd='" + sh_pwd + "'";
    	OrderCondition  = " ORDER BY sh_id ";
    	//out.print("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br><br>");
    	
		Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 1, 1);
    	
    	if( ResultVector.size() > 0){
			for (int i=0; i < ResultVector.size();i++){
				Hashtable h = (Hashtable)ResultVector.elementAt(i);				
				sh_name = (String)h.get("SH_NAME");
				//out.println("sh_name : " + sh_name + "<br>");
				sh_buseo = (String)h.get("SH_BUSEO");
				sh_mobile = (String)h.get("SH_MOBILE"); 
				sh_gicwe = (String)h.get("SH_GICWE");
				sh_admin_manager = (String)h.get("SH_ADMIN_MANAGER");
				sh_admin_faq = (String)h.get("SH_ADMIN_FAQ");
				sh_admin_minwonall = (String)h.get("SH_ADMIN_MINWONALL");
				sh_admin_buseo = (String)h.get("SH_ADMIN_BUSEO");
				sh_admin_result = (String)h.get("SH_ADMIN_RESULT");
				sh_admin_jebo = (String)h.get("SH_ADMIN_JEBO");
				sh_admin_bujori = (String)h.get("SH_ADMIN_BUJORI");
				sh_admin_myunsei = (String)h.get("SH_ADMIN_MYUNSEI");
				sh_admin_corruption = (String)h.get("SH_ADMIN_CORRUPTION");								sh_admin_favors = (String)h.get("SH_ADMIN_FAVORS");								sh_admin_upright = (String)h.get("SH_ADMIN_UPRIGHT");								sh_admin_sms = (String)h.get("SH_ADMIN_SMS");			}
		}
		session.setAttribute("id", sh_id);		session.setAttribute("name", sh_name);		session.setAttribute("buseo", sh_buseo);		session.setAttribute("sh_mobile", sh_mobile);		session.setAttribute("sh_gicwe", sh_gicwe);		session.setAttribute("sh_admin_manager", sh_admin_manager);		session.setAttribute("sh_admin_faq", sh_admin_faq);		session.setAttribute("sh_admin_minwonall", sh_admin_minwonall);		session.setAttribute("sh_admin_buseo", sh_admin_buseo);		session.setAttribute("sh_admin_result", sh_admin_result);		session.setAttribute("sh_admin_jebo", sh_admin_jebo);		session.setAttribute("sh_admin_bujori", sh_admin_bujori);		session.setAttribute("sh_admin_myunsei", sh_admin_myunsei);		session.setAttribute("sh_admin_corruption", sh_admin_corruption);		session.setAttribute("sh_admin_favors", sh_admin_favors);		session.setAttribute("sh_admin_upright", sh_admin_upright);		session.setAttribute("sh_admin_sms", sh_admin_sms);				String location = "main.jsp";
		if(sh_admin_corruption.equals("Y")){			location = "corruption.jsp";		}				if(sh_admin_myunsei.equals("Y")){			location = "oil.jsp";		}				if(sh_admin_bujori.equals("Y")){			location = "absurd.jsp";		}				if(sh_admin_jebo.equals("Y")){			location = "finance.jsp";		}				if(sh_admin_result.equals("Y")){			location = "result.jsp";		}				if(sh_admin_buseo.equals("Y")){			location = "madmin_02.jsp";		}				if(sh_admin_minwonall.equals("Y")){			location = "madmin_01.jsp";		}				if(sh_admin_sms.equals("Y")){			location = "center_minwon_admin_list.jsp";		}				if(sh_admin_favors.equals("Y")){			location = "favors.jsp";		}						
%>
		<script language="javascript">
        	alert("로그인 되었습니다.");
       		//self.location = "../body.html";
       		//top.document.location.href = "../index.html";
       		//top.document.location.href = "http://www.suhyup.co.kr/djemals/index.html";
       		top.self.location = "<%=location%>";
       		//top.self.location = "http://localhost:8000/djemals/index.html";
        </script>
<%	} catch(Exception e) {		out.println("login_proc.jsp : " + e.getMessage());	} finally {	}%>
