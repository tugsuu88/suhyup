<%
/*****************************************************************************
*Title			: login_proc.jsp
*@author		: K.H.S
*@date			: 2007-10
*@Description	: �α��� ó��
*@Copyright		: 
******************************************************************************
*������		*������		*��������
******************************************************************************/
%>
<%@ page import="java.util.*,java.text.*,Bean.Front.Common.*, util.*" contentType="text/html;charset=euc-kr" pageEncoding="euc-kr" %>
<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<%
	try {
	    String sh_id = Converter.nullchk(request.getParameter("sh_id"));
		//out.println("sh_id : " + sh_id + "<br>");
		String sh_pwd = Converter.nullchk(request.getParameter("sh_pwd"));

	    String TableName = " sh_minwon_admin ";
	    String SelectCondition = null;
	    String WhereCondition = null;
	    String OrderCondition = null;
		int TotalRecordCount = 0;

		//���̵� �˻�
		WhereCondition = " where sh_id = '" + sh_id + "'";
		TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
		if(TotalRecordCount == 0){
%>
			<script language='javascript'>
				alert('�������� �ʴ� ���̵� �Դϴ�. \n\n Ȯ�� �� �ٽ� �۾��Ͻñ� �ٶ��ϴ�.');
				//history.go(-1);
				//self.location = "logout.jsp";
	        </script>
<%		}
		///////////////////////////////////////////////////
		//���̵�,��й�ȣ �˻�
		WhereCondition = " where sh_id = '" + sh_id + "' and sh_pwd='" + sh_pwd + "'";
		TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
%>
			<script language='javascript'>
				alert('���̵� ��й�ȣ�� ��ġ���� �ʽ��ϴ�. \n\n Ȯ�� �� �ٽ� �۾��Ͻñ� �ٶ��ϴ�.');
				location.href="index.jsp";
				//self.location = "logout.jsp";
	        
			</script>
<%		        
        }else{
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
		String sh_admin_corruption = "";
				
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
				sh_admin_corruption = (String)h.get("SH_ADMIN_CORRUPTION");
		}
		session.setAttribute("id", sh_id);

%>
		<script language="javascript">
        	alert("�α��� �Ǿ����ϴ�.");
       		//self.location = "../body.html";
       		//top.document.location.href = "../index.html";
       		//top.document.location.href = "http://www.suhyup.co.kr/djemals/index.html";
       		top.self.location = "<%=location%>";
       		//top.self.location = "http://localhost:8000/djemals/index.html";
        </script>
<%