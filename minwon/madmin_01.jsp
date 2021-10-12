<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil"/>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu0201.jsp" %>

<%
	String ListPage = Converter.nullchk(request.getParameter("ListPage"));
	//String pageNum = request.getParameter("pageNum");
	String myPage = request.getRequestURI();
	String finance_buseo=Converter.nullchk((String)session.getAttribute("buseo"));

	try
	{
		String cmd = Converter.nullchk(request.getParameter("cmd"));	//�˻���
	    String KEY = Converter.nullchk(request.getParameter("KEY"));	//�˻���
	    if(KEY != null && !KEY.equals("")) {
	    	KEY = StringReplace.sqlFilter(KEY);		//������ ���͸�
	    }
	    //out.println("KEY : " + KEY + "<br>");
	    String FIELD = Converter.nullchk(request.getParameter("FIELD"));	//�˻�����
		String category = Converter.nullchk(request.getParameter("category"));
		String minwon_gubun = Converter.nullchk(request.getParameter("minwon_gubun"));
		String status  = Converter.nullchk(request.getParameter("status"));
		String buse_name  = Converter.nullchk(request.getParameter("buse_name"));
		String start  = Converter.nullchk(request.getParameter("start"));
		String end  = Converter.nullchk(request.getParameter("end"));
		String result  = Converter.nullchk(request.getParameter("result"));

		int PAGE = 1;

		///////////////////////////////////////////////////////////////////////////
		String TableName = " sh_minwon ";
		String SelectCondition = null;
		String WhereCondition = null;
		String OrderCondition = null;

		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){
			PAGE = 1;
	    }else{
			PAGE = Integer.parseInt(request.getParameter("PAGE"));
	    }

	    SelectCondition = " mid, category, minwon_gubun, subject, name, status,";
		SelectCondition += "to_char(creation_date, 'YYYYMMDD') AS creation_date, buse_name, result,";
		SelectCondition += "to_char(answer_date, 'YYYY-MM-DD') AS answer_date, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date, answer,fname";
	    OrderCondition  = " ORDER BY mid DESC ";
		WhereCondition = "where 1 = 1 ";

		//����
	    if(!(finance_buseo.equals("�����") || finance_buseo.equals("�����")) &&  !finance_buseo.equals("�����Һ��ں�ȣ��")){
	    	WhereCondition+=" and buse_name='" + finance_buseo + "' ";
	    }
	    if(finance_buseo.equals("�����Һ��ں�ȣ��")){
	    	WhereCondition+=" and junbuseo='Y' ";
	    }

        if(cmd.equals("search")){
			if(!start.equals("") && !end.equals("")){
				WhereCondition += " and to_char(creation_date, 'yyyymmdd') >= '"+start+"' and to_char(creation_date, 'yyyymmdd') <= '"+end+"'";
			}
			if (!category.equals("")) {
				WhereCondition += " and category = '"+category+"'";
			}
			if (!minwon_gubun.equals("")) {
				WhereCondition += " and minwon_gubun = '"+minwon_gubun+"'";
			}
			if (!status.equals("")) {
				WhereCondition += " and status = '"+status+"'";
			}
			if (!buse_name.equals("")) {
				WhereCondition += " and buse_name = '"+buse_name+"'";
			}
			if (!result.equals("")) {
				WhereCondition += " and result = '"+result+"'";
			}
			if(!FIELD.equals("")){
	    		WhereCondition+=" and " + FIELD + " like '%" + KEY + "%'";
	    	}
			else{
	    		WhereCondition+=" and (subject like '%" + KEY + "%' or name like '%" + KEY + "%' or content like '%" + KEY + "%')";
	    	}
		}

		int StartRecord = 0;
		int EndRecord   = 0;
		int DefaultListRecord = 10;
		int DefaultPageBlock = 10;

		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);



%>
<script language="javascript" src="js/common.js"></script>
<script language="javascript">
<!--

	function GoReg(){

		if(!compareDt(pbform.start.value, pbform.end.value)){
          alert("�������� �������� ���� �� �����ϴ�.");
		  return;
		}

		if(!pbform.start.value && !pbform.category.value && !pbform.minwon_gubun.value && !pbform.status.value && !pbform.buse_name.value && !pbform.result.value ){
			/*
			if(!pbform.FIELD.value){
				alert("��ȸ������ ���ּ���");
				pbform.FIELD.focus();
				return;
			}
			*/
			if(!pbform.KEY.value){
				alert("�˻�� �����ּ���");
				pbform.KEY.focus();
				return;
			}
		}

		pbform.cmd.value = "search";
	    pbform.submit();

	}

	function goView(mid,PAGE){
		pbform.mid.value=mid;
		pbform.PAGE.value=PAGE;
		pbform.action = "madmin_01_view.jsp";
		pbform.submit();
	}

	function goDetailView(mid,PAGE){
		pbform.mid.value=mid;
		pbform.PAGE.value=PAGE;
		pbform.action = "madmin_01_detail.jsp";
		pbform.submit();
	}

	function DownloadPopup(mid){
		pbform.mid.value=mid;
		var wint = (screen.height - 245) / 2;
		var winl = (screen.width - 300) / 2;
		winprops = 'height=245,width=300,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'
		winurl = 'include/file_popup1.jsp?mid='+mid;
		win = window.open(winurl, "file_popup1", winprops)
	}


//-->
</script>
<!-- �ο�������Ȳ �˻� �� -->
<form method=post name="pbform" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="95" bgcolor="f4f4f4"  style="padding-left:25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0" background="img/title_bg.gif">
        <tr>
          <td width="135">
            <table width="135" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="70" align="center" class="admin_subject">�ο�������Ȳ</td>
              </tr>
            </table>
          </td>
          <td width="5"></td>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30" class="adminsub_subject" style="padding-left:5;">
                  <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                      <td width="60" class="bluesky">��û��</td>
                      <td width="100">
                        <input type="text" class="input01" size="10" name="start" value="<%=start%>" readonly>
                        <a href="javascript:Calendar(pbform.start);"><img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0"></a>
                      </td>
                      <td width="20" align="center">~</td>
                      <td width="100">
                        <input type="text" class="input01" size="10" name="end" value="<%=end%>" readonly>
                        <a href="javascript:Calendar(pbform.end);"><img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0"></a>
                      </td>
                      <td width="15">&nbsp;</td>
                      <td width="40" class="bluesky">�о�</td>
                      <td>
                        <select name="category">
						  <option value="">��ü</option>
                          <option value="��������"<%if(category.equals("��������")) { %>selected<% } %>>��������</option>
						  <option value="�ݵ��ǸŰ���"<%if(category.equals("�ݵ��ǸŰ���")) { %>selected<% } %>>�ݵ��ǸŰ���</option>
						  <option value="��������"<%if(category.equals("��������")) { %>selected<% } %>>��������</option>
						  <option value="�ٴٸ�Ʈ"<%if(category.equals("�ٴٸ�Ʈ")) { %>selected<% } %>>�ٴٸ�Ʈ</option>
						  <option value="������(���)"<%if(category.equals("������(���)")) { %>selected<% } %>>������(���)</option>
						  <option value="�鼼����"<%if(category.equals("�鼼����")) { %>selected<% } %>>�鼼����</option>
						  <option value="ȸ������/���̰�"<%if(category.equals("ȸ������/���̰�")) { %>selected<% } %>>ȸ������/���̰�</option>
						  <option value="��������ģ��"<%if(category.equals("��������ģ��")) { %>selected<% } %>>��������ģ��</option>
						  <option value="��Ÿ����"<%if(category.equals("��Ÿ����")) { %>selected<% } %>>��Ÿ����</option>
                        </select>
                      </td>
                      <td width="15">&nbsp;</td>
                      <td width="60" class="bluesky">�ο��з�</td>
                      <td>
                        <select name="minwon_gubun">
                          <option value="">��ü</option>
						  <option value="�Ϲݹο�"<%if(minwon_gubun.equals("�Ϲݹο�")) { %>selected<% } %>>�Ϲݹο�</option>
						  <option value="�ܼ�����"<%if(minwon_gubun.equals("�ܼ�����")) { %>selected<% } %>>�ܼ�����</option>
                        </select>
                      </td>
                      <td width="15">&nbsp;</td>
                      <td width="60" class="bluesky">ó������</td>
                      <td>
                         <select name="status">
                          <option value="">����</option>
						  <option value="��û"<%if(status.equals("��û")) { %>selected<% } %>>��û</option>
						  <option value="����"<%if(status.equals("����")) { %>selected<% } %>>����</option>
  						  <option value="��ø"<%if(status.equals("��ø")) { %>selected<% } %>>��ø</option>
  						  <option value="�ݼ�"<%if(status.equals("�ݼ�")) { %>selected<% } %>>�ݼ�</option>
  						  <option value="ó����"<%if(status.equals("ó����")) { %>selected<% } %>>ó����</option>
  						  <option value="�亯�Ϸ�"<%if(status.equals("�亯�Ϸ�")) { %>selected<% } %>>�亯�Ϸ�</option>
  						  <option value="�ο�öȸ"<%if(status.equals("�ο�öȸ")) { %>selected<% } %>>�ο�öȸ</option>
                        </select>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td height="30" class="adminsub_subject" style="padding-left:5;">
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="60" class="bluesky">���μ�</td>
                      <td width="100">
                        <select name="buse_name">
                          <option value="">����</option>
                    <option value="�����" <%if(buse_name.equals("�����")) { %>selected<% } %>>�����</option>
                    <option value="�����" <%if(buse_name.equals("�����")) { %>selected<% } %>>�����</option>
                    <option value="ICT������" <%if(buse_name.equals("ICT������")) { %>selected<% } %>>ICT������</option>
                    <option value="�λ��ѹ���" <%if(buse_name.equals("�λ��ѹ���")) { %>selected<% } %>>�λ��ѹ���</option>
                    <option value="���α�����" <%if(buse_name.equals("���α�����")) { %>selected<% } %>>���α�����</option>
                    <option value="���������" <%if(buse_name.equals("���������")) { %>selected<% } %>>���������</option>
                    <option value="������ȹ��" <%if(buse_name.equals("������ȹ��")) { %>selected<% } %>>������ȹ��</option>
                    <option value="��ȹ��" <%if(buse_name.equals("��ȹ��")) { %>selected<% } %>>��ȹ��</option>
                    <option value="�뷮������ ����ȭ�������" <%if(buse_name.equals("�뷮������ ����ȭ�������")) { %>selected<% } %>>�뷮������ ����ȭ�������</option>
                    <option value="��ü�޽Ļ����" <%if(buse_name.equals("��ü�޽Ļ����")) { %>selected<% } %>>��ü�޽Ļ����</option>
                    <option value="����ũ��������" <%if(buse_name.equals("����ũ��������")) { %>selected<% } %>>����ũ��������</option>
                    <option value="��ī�ݵ�����(�ݵ�)" <%if(buse_name.equals("��ī�ݵ�����(�ݵ�)")) { %>selected<% } %>>��ī�ݵ�����(�ݵ�)</option>
                    <option value="��ȣ������" <%if(buse_name.equals("��ȣ������")) { %>selected<% } %>>��ȣ������</option>
                    <option value="�������������" <%if(buse_name.equals("�������������")) { %>selected<% } %>>�������������</option>
                    <option value="���������" <%if(buse_name.equals("���������")) { %>selected<% } %>>���������</option>
                   <%--  <option value="����������" <%if(buse_name.equals("����������")) { %>selected<% } %>>����������</option> --%>
                    <option value="��Ź�������" <%if(buse_name.equals("��Ź�������")) { %>selected<% } %>>��Ź�������</option>
                    <option value="�ɻ��" <%if(buse_name.equals("�ɻ��")) { %>selected<% } %>>�ɻ��</option>
<!--                    <option value="����������" <%if(buse_name.equals("����������")) { %>selected<% } %>>����������</option>  -->
                    <option value="���������ź���" <%if(buse_name.equals("���������ź���")) { %>selected<% } %>>���������ź���</option>
                    <option value="���Ű�����" <%if(buse_name.equals("���Ű�����")) { %>selected<% } %>>���Ű�����</option>
                    <option value="������" <%if(buse_name.equals("������")) { %>selected<% } %>>������</option>
                    <option value="�۷ι���ȯ�����" <%if(buse_name.equals("�۷ι���ȯ�����")) { %>selected<% } %>>�۷ι���ȯ�����</option>
                    <option value="������ȹ��" <%if(buse_name.equals("������ȹ��")) { %>selected<% } %>>������ȹ��</option>
                    <option value="�̻�ȸ�繫��" <%if(buse_name.equals("�̻�ȸ�繫��")) { %>selected<% } %>>�̻�ȸ�繫��</option>
                    <option value="�ڱݺ�" <%if(buse_name.equals("�ڱݺ�")) { %>selected<% } %>>�ڱݺ�</option>
                    <option value="��������" <%if(buse_name.equals("��������")) { %>selected<% } %>>��������</option>
                    <option value="IT���ߺ�" <%if(buse_name.equals("IT���ߺ�")) { %>selected<% } %>>IT���ߺ�</option>
                    <option value="������ȣ����" <%if(buse_name.equals("������ȣ����")) { %>selected<% } %>>������ȣ����</option>
                    <option value="���հ����" <%if(buse_name.equals("���հ����")) { %>selected<% } %>>���հ����</option>
                    <option value="����ũ������" <%if(buse_name.equals("����ũ������")) { %>selected<% } %>>����ũ������</option>
                    <option value="�ڱݿ���" <%if(buse_name.equals("�ڱݿ���")) { %>selected<% } %>>�ڱݿ���</option>
                    <%-- <option value="�ع�������" <%if(buse_name.equals("�ع�������")) { %>selected<% } %>>�ع�������</option> --%>
                    <option value="�ǸŻ����" <%if(buse_name.equals("�ǸŻ����")) { %>selected<% } %>>�ǸŻ����</option>
                    <option value="�ѹ���" <%if(buse_name.equals("�ѹ���")) { %>selected<% } %>>�ѹ���</option>
                    <option value="ī������" <%if(buse_name.equals("ī������")) { %>selected<% } %>>ī������</option>
                   <%--  <option value="�ؾ����ڱ�������" <%if(buse_name.equals("�ؾ����ڱ�������")) { %>selected<% } %>>�ؾ����ڱ�������</option> --%>
                    <option value="ȫ����" <%if(buse_name.equals("ȫ����")) { %>selected<% } %>>ȫ����</option>
                    <option value="ȸ��������" <%if(buse_name.equals("ȸ��������")) { %>selected<% } %>>ȸ��������</option>
                  <%--   <option value="������������" <%if(buse_name.equals("������������")) { %>selected<% } %>>������������</option> --%>
					<option value="���������" <%if(buse_name.equals("���������")) { %>selected<% } %>>���������</option>
				    <option value="������å��" <%if(buse_name.equals("������å��")) { %>selected<% } %>>������å��</option>
					<option value="��å�����" <%if(buse_name.equals("��å�����")) { %>selected<% } %>>��å�����</option>
		            <option value="�����Һ��ں�ȣ��" <%if(buse_name.equals("�����Һ��ں�ȣ��")) { %>selected<% } %>>�����Һ��ں�ȣ��</option>
					<option value="�����а��ߺ�" <%if(buse_name.equals("�����а��ߺ�")) { %>selected<% } %>>�����а��ߺ�</option>
					<%-- <option value="����������" <%if(buse_name.equals("����������")) { %>selected<% } %>>����������</option> --%>
					<option value="�ع����ý�(�߾�ȸ)" <%if(buse_name.equals("�ع����ý�(�߾�ȸ)")) { %>selected<% } %>>�ع����ý�(�߾�ȸ)</option>
					<option value="�ع����ý�(����)" <%if(buse_name.equals("�ع����ý�(����)")) { %>selected<% } %>>�ع����ý�(����)</option>
					
					<option value="IB�������" <%if(buse_name.equals("IB�������")) { %>selected<% } %>>IB�������</option>
					<option value="IT������" <%if(buse_name.equals("IT������")) { %>selected<% } %>>IT������</option>
					<option value="�泲��������" <%if(buse_name.equals("�泲��������")) { %>selected<% } %>>�泲��������</option>
					<option value="�濵������" <%if(buse_name.equals("�濵������")) { %>selected<% } %>>�濵������</option>
					<option value="�����и����ú�" <%if(buse_name.equals("�����и����ú�")) { %>selected<% } %>>�����и����ú�</option>
					<option value="������������" <%if(buse_name.equals("������������")) { %>selected<% } %>>������������</option>
					<option value="���������" <%if(buse_name.equals("���������")) { %>selected<% } %>>���������</option>
					<option value="����������" <%if(buse_name.equals("����������")) { %>selected<% } %>>����������</option>
					<option value="��������" <%if(buse_name.equals("��������")) { %>selected<% } %>>��������</option>
					<option value="������������" <%if(buse_name.equals("������������")) { %>selected<% } %>>������������</option>
					<option value="�ع����ý�" <%if(buse_name.equals("�ع����ý�")) { %>selected<% } %>>�ع����ý�</option>
					<option value="���Ӱ濵������" <%if(buse_name.equals("���Ӱ濵������")) { %>selected<% } %>>���Ӱ濵������</option>
										
					</select>
                      </td>
                      <td width="7"></td>

                      <td width="55" class="bluesky">ó�����</td>
                      <td width="100">
                        <select name="result">
                        <option value="">����</option>
						  <option value="��ġ/����"<%if(result.equals("��ġ/����")) { %>selected<% } %>>��ġ/����</option>
						  <option value="�����ȳ�"<%if(result.equals("�����ȳ�")) { %>selected<% } %>>�����ȳ�</option>
						  <option value="����/����"<%if(result.equals("����/����")) { %>selected<% } %>>����/����</option>
						  <option value="��������"<%if(result.equals("��������")) { %>selected<% } %>>��������</option>
						  <option value="����/������Ҵ�"<%if(result.equals("����/������Ҵ�")) { %>selected<% } %>>����/������Ҵ�</option>
						  <option value="������ո�"<%if(result.equals("������ո�")) { %>selected<% } %>>������ո�</option>
						  <option value="����"<%if(result.equals("����")) { %>selected<% } %>>����</option>
						  <option value="��ǻ���"<%if(result.equals("��ǻ���")) { %>selected<% } %>>��ǻ���</option>
						  <option value="��������"<%if(result.equals("��������")) { %>selected<% } %>>��������</option>
						  <option value="�Ҽ�/����"<%if(result.equals("�Ҽ�/����")) { %>selected<% } %>>�Ҽ�/����</option>
						  <option value="�ҹ�(�ο��ƴ�)"<%if(result.equals("�ҹ�(�ο��ƴ�)")) { %>selected<% } %>>�ҹ�(�ο��ƴ�)</option>
						  <option value="����/����"<%if(result.equals("����/����")) { %>selected<% } %>>����/����</option>
						 <!-- -->
                        </select>
                      </td>
                      <td width="7"></td>
                      <td width="50" class="bluesky">��ȸ����</td>
                      <td>
                        <select name="FIELD">
                          <option value="">����</option>
						  <option value="subject">����</option>
						  <option value="content">����</option>
  						  <option value="name">�ο���</option>
                          <!-- -->
                        </select>
                      </td>
					  <td width="4"></td>
                      <td>
                        <input type="text" class="input01" size="24" name="KEY" value="<%=KEY%>">
                      </td>
                     <td width="4"></td>
                      <td width="40"><a href="javascript:GoReg();"><img src="img/btn_search.gif" width="38" height="17" border="0" alt="�˻�"></a></td>
                      <td width="40"><a href="javascript:pbform.reset();"><img src="img/btn_refresh.gif" width="48" height="17" border="0" alt="�ʱ�ȭ"></a></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<!-- // �ο�������Ȳ �˻� �� -->
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td style="padding:0 0 10 10 ;">
      <!-- �˻���� -->
      <table width="960" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30"><img src="img/result.gif" align="absmiddle"> �˻���� :
            <span class="result_text">��<%=TotalRecordCount%>��</span></td>
          <td height="30" align="right"><a href="excel/madmin_excel.jsp?cmd=<%=cmd%>&KEY=<%=KEY%>&FIELD=<%=FIELD%>&start=<%=start%>&end=<%=end%>&status=<%=status%>&buse_name=<%=buse_name%>&category=<%=category%>&result=<%=result%>&minwon_gubun=<%=minwon_gubun%>"><img src="img/btn_excel.gif" width="66" height="21" alt="����" border="0"></a></td>
        </tr>
        <tr>
          <td height="2" class="result_line" colspan="2"></td>
        </tr>
      </table>
      <!-- // �˻���� -->
    </td>
  </tr>
  <!-- �ο�������Ȳ ����Ʈ -->
  <tr>
    <td style="padding-left:25;"><img src="img/arrow.gif" width="13" height="16" align="absmiddle">
      <span class="txt_title">�ο�������Ȳ</span></td>
  </tr>
  <tr>
    <td style="padding:10 0 0 25;">
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td colspan="11" height="2" class="board_topline"></td>
        </tr>
        <tr height="30">
          <td class="board_bg_title" width="50" align="center">��ȣ</td>
          <td class="board_bg_title" width="120" align="center">�о�</td>
          <td class="board_bg_title" width="80" align="center">�ο��з�</td>
          <td class="board_bg_title" width="220" align="center">����</td>
          <td class="board_bg_title" width="80" align="center">�ο���</td>
          <td class="board_bg_title" width="70" align="center">��û��</td>
          <td class="board_bg_title" width="70" align="center">ó������</td>
          <td class="board_bg_title" width="90" align="center">���μ�</td>
          <td class="board_bg_title" width="75" align="center">ó�����</td>

<td class="board_bg_title" width="40" align="center">����</td>
          <td class="board_bg_title" width="70" align="center">�亯��</td>
        </tr>
        <tr>
          <td colspan="11" height="1" class="board_line"></td>
        </tr>
		<!-- loop start -->
        <%
			Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);

		    if( ResultVector.size() > 0){
				for (int i=0; i < ResultVector.size();i++){
					Hashtable h = (Hashtable)ResultVector.elementAt(i);

					String SUBJECT = (String)h.get("SUBJECT");	//����
					if (SUBJECT.length() > 31){
						SUBJECT = SUBJECT.substring(0,31);
						SUBJECT += "...";
					}
					//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //�۹�ȣ ���
					int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//�۹�ȣ ���(����)
					String answer_date =(String)h.get("ANSWER_DATE");
					String abandon_date =(String)h.get("ABANDON_DATE");
					String fname =(String)h.get("FNAME");
					String mid =(String)h.get("MID");
		%>

       <tr height="30"  onMouseOver=this.style.backgroundColor='F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'>

	      <td align="center"><%=listnum%></td>
		  <td align="center"><%=(String)h.get("CATEGORY") %></td>
          <td align="center"><%=(String)h.get("MINWON_GUBUN") %></td>
          <td style="padding-left:10;">
			<%if(answer_date==null || answer_date.equals("")){%>
       			<a href="javascript:goView('<%=mid%>',<%=PAGE %>);"><%=SUBJECT %></a>
			<%}else{%>
          		<a href="javascript:goDetailView('<%=mid%>',<%=PAGE %>);"><%=SUBJECT %></a>
			<%} %>
		  </td>
          <td align="center"><%=(String)h.get("NAME") %></td>
          <td align="center"><%=(String)h.get("CREATION_DATE") %></td>
          <td align="center"><%=(String)h.get("STATUS") %></td>
          <td align="center"><%=(String)h.get("BUSE_NAME") %></td>
          <td align="center"><%=(String)h.get("RESULT") %></td>
		  <%if(fname==null || fname.equals("")){%>
		  <td align="center"></td>
		  <%}else{%>
		  <td align="center"><a href="javascript:DownloadPopup('<%=mid%>');"><img src="img/file_icon.gif" border="0" align="absmiddle"></a></td>
		  <%} %>
		  <%if("öȸ�Ϸ�".equals((String)h.get("STATUS"))){ %>
          <td align="center"><%=abandon_date%></td>
          <%}else{ %>
          <td align="center"><%=answer_date%></td>
          <%} %>
        </tr>
        <tr>
          <td colspan="11" class="board_line2" height="1"></td>
        </tr>
        <%
			        }
				} else {
			%>
					<tr>
						<td class="no" align="center" colspan="11">��� �ڷᰡ �����ϴ�.</td>
					</tr>
			<%
				}
			%>
      </table>
      <br>
      <!-- // �ο�������Ȳ ����Ʈ -->
      <!-- ������ �ѹ��� -->
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
		<% if(TotalRecordCount > 0) { %>
			<%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock, "madmin_01.jsp?KEY="+KEY+"&cmd=" + cmd + "&FIELD=" + FIELD + "&start=" + start + "&end=" + end + "&category=" + category + "&minwon_gubun=" + minwon_gubun + "&status=" + status + "&buse_name=" + buse_name + "&PAGE=","<img src=img/board_prev.gif width=13 height=13 align=absmiddle border=0>","<img src=img/board_next.gif width=13 height=13 align=absmiddle border=0>")%>
			<% } %>
          </td>
         </tr>
      </table>
      <!-- ������ �ѹ��� -->
    </td>
  </tr>
</table>
<input type="hidden" name="cmd">
<input type="hidden" name="mid">
<input type="hidden" name="PAGE">
</form>
<%@ include file="include/bottom.jsp" %>
<%
	} catch(Exception e) {
		out.println("madmin_01.jsp : " + e.getMessage());
	} finally {

	}
%>