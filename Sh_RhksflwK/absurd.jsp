<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu05.jsp" %>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil"/>

<%
Vector ResultVector;

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
String startday=Converter.nullchk(request.getParameter("startday"));
String endday=Converter.nullchk(request.getParameter("endday"));
String status=Converter.nullchk(request.getParameter("status"));
String buse_name=Converter.nullchk(request.getParameter("buse_name"));
String result=Converter.nullchk(request.getParameter("result"));

int PAGE = 1;

///////////////////////////////////////////////////////////////////////////
String TableName = " sh_financetrouble ";
String SelectCondition = null;
String WhereCondition = null;
String OrderCondition = null;

if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){
PAGE = 1;
}else{
PAGE = Integer.parseInt(request.getParameter("PAGE"));
}

SelectCondition = " parcode,thid, name,title,publication,code,result,buseo,";
SelectCondition += "to_char(time1, 'YYYY-MM-DD') AS time1, to_char(time2, 'YYYY-MM-DD') AS time2, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date ";
OrderCondition  = " ORDER BY thid DESC";
WhereCondition=" where parcode=2 ";
if(!(finance_buseo.equals("�����") || finance_buseo.equals("�����")) &&  !finance_buseo.equals("�����Һ��ں�ȣ��") &&  !finance_buseo.equals("���հ����")){
WhereCondition+=" and buseo='" + finance_buseo + "' ";
}
if(finance_buseo.equals("�����Һ��ں�ȣ��")){
WhereCondition+=" and junbuseo='Y' ";
}

if(cmd.equals("search")){
if(!startday.equals("") && !endday.equals("")){
WhereCondition+=" and to_char(time1,'YYYY-MM-DD')>='" + startday + "' and to_char(time1, 'YYYY-MM-DD')<='" + endday + "'";
}
if(!status.equals("")){
WhereCondition+=" and code='" + status + "'";
}
if(!buse_name.equals("")){
WhereCondition+=" and buseo='" + buse_name + "'";
}
if(!result.equals("")){
WhereCondition+=" and result='" + result + "'";
}
if(!FIELD.equals("")){
WhereCondition+=" and " + FIELD + " like '%" + KEY + "%'";
}
else{
WhereCondition+=" and (title like '%" + KEY + "%' or name like '%" + KEY + "%' or text like '%" + KEY + "%')";
}
}

int StartRecord = 0;
int EndRecord   = 0;
int DefaultListRecord = 10;
int DefaultPageBlock = 10;

int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
//out.print("TotalRecordCount : " + TotalRecordCount + "<br><br>");
///////////////////////////////////////////////////////////////////////////
%>
<script language="javascript" src="js/common.js"></script>
<script language="javascript">
  <!--
  function GoReg(){
    if(!pbform.startday.value){
      if(pbform.endday.value){
        alert("�������� �־��ּ���");
        pbform.startday.focus();
        return;
      }
    }
    if(pbform.startday.value){
      if(!pbform.endday.value){
        alert("�������� �־��ּ���");
        pbform.endday.focus();
        return;
      }
    }

    if(!compareDt(pbform.startday.value, pbform.endday.value)){
      alert("�������� �������� ���� �� �����ϴ�.");
      return;
    }

    if(!pbform.startday.value && !pbform.buse_name.value && !pbform.status.value && !pbform.result.value ){
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

  function goView(thid,PAGE){
    pbform.thid.value=thid;
    pbform.PAGE.value=PAGE;
    pbform.action = "absurd_view.jsp";
    pbform.submit();
  }
  function goDetailView(thid,PAGE){
    pbform.thid.value=thid;
    pbform.PAGE.value=PAGE;
    pbform.action = "absurd_detail.jsp";
    pbform.submit();
  }

  //-->
</script>
<!-- ���������� ���� ���� -->
<form method=post name="pbform" action="" style="margin:0px;">
    <div class="noti-wrap">
        <p> �� �Ű��� ����� ��ǿ� ���� �����ͽŰ��� ��ȣ����, �����й������������� � ���� ���С����ͽŰ��� �ش��� ���, <em>�Ű������� ���硤ó�� �������� �Ű��� ��к�ȣ�� ������ ����</em>�Ͻñ� �ٶ��, ������ ����ħ������, ���������� �߰ߵǱ� ������ <em>�ǽŰ����� �������װ� �Ű����뵵 �����Ǿ�� �� �˴ϴ�.</em>
        </p>
        <ul>
            <li>�� �����ͽŰ��� ��ȣ���� ��2��(����), ��8��(���ͽŰ��� ���), ��10����5��(���ͽŰ��� ó��), ��12��(���ͽŰ��ڵ��� ��к��� �ǹ�) �� ��30��(��Ģ)</li>
            <li>�� �����й������������� ��64��(�Ű����� ��к���) �� ��88��(�������� ���� �� ���� ������ ��)</li>
        </ul>
    </div>
    <div class="list-header">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td rowspan="2" class="admin_subject">�����������Ű�</td>
                <td class="bluesky">��û��</td>
                <td>
                    <input type="text" class="input01" size="10" name="startday" value=""><a href="javascript:Calendar(pbform.startday);"><img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0"></a>
                    ~
                    <input type="text" class="input01" size="10" name="endday" value=""><a href="javascript:Calendar(pbform.endday);"><img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0"></a>
                </td>
                <td class="bluesky">ó������</td>
                <td>
                    <select name="status">
                        <option value="">����</option>
                        <option value="��û"
                        <%if(status.equals("��û")) { %>selected<% } %>>��û</option>
                        <option value="����"
                        <%if(status.equals("����")) { %>selected<% } %>>����</option>
                        <option value="��ø"
                        <%if(status.equals("��ø")) { %>selected<% } %>>��ø</option>
                        <option value="�ݼ�"
                        <%if(status.equals("�ݼ�")) { %>selected<% } %>>�ݼ�</option>
                        <option value="ó����"
                        <%if(status.equals("ó����")) { %>selected<% } %>>ó����</option>
                        <option value="�亯�Ϸ�"
                        <%if(status.equals("�亯�Ϸ�")) { %>selected<% } %>>�亯�Ϸ�</option>
                        <option value="�ο�öȸ"
                        <%if(status.equals("�ο�öȸ")) { %>selected<% } %>>�ο�öȸ</option>
                        <!-- -->
                    </select>
                </td>
                <td class="bluesky">ó�����</td>
                <td>
                    <select name="result">
                        <option value="">����</option>
                        <option value="��ġ/����"
                        <%if(result.equals("��ġ/����")) { %>selected<% } %>>��ġ/����</option>
                        <option value="�����ȳ�"
                        <%if(result.equals("�����ȳ�")) { %>selected<% } %>>�����ȳ�</option>
                        <option value="����/����"
                        <%if(result.equals("����/����")) { %>selected<% } %>>����/����</option>
                        <option value="��������"
                        <%if(result.equals("��������")) { %>selected<% } %>>��������</option>
                        <option value="����/������Ҵ�"
                        <%if(result.equals("����/������Ҵ�")) { %>selected<% } %>>����/������Ҵ�</option>
                        <option value="������ո�"
                        <%if(result.equals("������ո�")) { %>selected<% } %>>������ո�</option>
                        <option value="����"
                        <%if(result.equals("����")) { %>selected<% } %>>����</option>
                        <option value="��ǻ���"
                        <%if(result.equals("��ǻ���")) { %>selected<% } %>>��ǻ���</option>
                        <option value="��������"
                        <%if(result.equals("��������")) { %>selected<% } %>>��������</option>
                        <option value="�Ҽ�/����"
                        <%if(result.equals("�Ҽ�/����")) { %>selected<% } %>>�Ҽ�/����</option>
                        <option value="�ҹ�(�ο��ƴ�)"
                        <%if(result.equals("�ҹ�(�ο��ƴ�)")) { %>selected<% } %>>�ҹ�(�ο��ƴ�)</option>
                        <option value="����/����"
                        <%if(result.equals("����/����")) { %>selected<% } %>>����/����</option>
                        <!-- -->
                    </select>
                </td>
            </tr>
            <tr>
                <td class="bluesky">���μ�</td>
                <td>
                    <select name="buse_name">
                        <option value="">����</option>
                        <% //Vector ResultVector;
                        
                        String TableNameBuseo = " sh_buseo "; String SelectCondition1 = " BUSEO_CD, BUSEO_NM"; String WhereCondition1 = "where 1 = 1 ";
                        String OrderCondition1 = "";
                        
                        ResultVector = FrontBoard.list(TableNameBuseo, SelectCondition1, WhereCondition1, OrderCondition1, 1, 0, 100);
                        
                        String sh_buseo_cd = ""; String sh_buseo_nm = "";
                        
                        if( ResultVector.size() > 0){ for (int i=0; i < ResultVector.size();i++){
                        
                        Hashtable h = (Hashtable)ResultVector.elementAt(i);
                        
                        sh_buseo_cd = (String)h.get("BUSEO_CD"); sh_buseo_nm = (String)h.get("BUSEO_NM");
                        
                        %>
                        
                        <%if(buse_name.equals(sh_buseo_cd)){ %>
                        <option value="<%=sh_buseo_cd%>" selected id="selectBuseo">
                            <% } else { %>
                        <option value="<%=sh_buseo_cd%>" id="selectBuseo">
                            <% } %> <%=sh_buseo_nm%>
                        </option>
                        
                        <% } %> <% } %>
                        
                        <%--
                        <option value="�����"
                        <%if(buse_name.equals("�����")) { %>selected<% } %>>�����</option>
                        <option value="�����"
                        <%if(buse_name.equals("�����")) { %>selected<% } %>>�����</option>
                        <option value="IT������"
                        <%if(buse_name.equals("IT������")) { %>selected<% } %>>IT������</option>
                        <option value="�λ��ѹ���"
                        <%if(buse_name.equals("�λ��ѹ���")) { %>selected<% } %>>�λ��ѹ���</option>
                        <option value="���α�����"
                        <%if(buse_name.equals("���α�����")) { %>selected<% } %>>���α�����</option>
                        <option value="���������"
                        <%if(buse_name.equals("���������")) { %>selected<% } %>>���������</option>
                        <option value="������ȹ��"
                        <%if(buse_name.equals("������ȹ��")) { %>selected<% } %>>������ȹ��</option>
                        <option value="��ȹ��"
                        <%if(buse_name.equals("��ȹ��")) { %>selected<% } %>>��ȹ��</option>
                        <option value="�뷮������ ����ȭ�������"
                        <%if(buse_name.equals("�뷮������ ����ȭ�������")) { %>selected<% } %>>�뷮������ ����ȭ�������</option>
                        <option value="��ü�޽Ļ����"
                        <%if(buse_name.equals("��ü�޽Ļ����")) { %>selected<% } %>>��ü�޽Ļ����</option>
                        <option value="����ũ��������"
                        <%if(buse_name.equals("����ũ��������")) { %>selected<% } %>>����ũ��������</option>
                        <option value="�����ڻ������(�ݵ�)"
                        <%if(buse_name.equals("�����ڻ������(�ݵ�)")) { %>selected<% } %>>�����ڻ������(�ݵ�)</option>
                        <option value="��ȣ������"
                        <%if(buse_name.equals("��ȣ������")) { %>selected<% } %>>��ȣ������</option>
                        <option value="�������������"
                        <%if(buse_name.equals("�������������")) { %>selected<% } %>>�������������</option>
                        <option value="���������"
                        <%if(buse_name.equals("���������")) { %>selected<% } %>>���������</option>
                        <option value="����������"
                        <%if(buse_name.equals("����������")) { %>selected<% } %>>����������</option>
                        <option value="��Ź�������"
                        <%if(buse_name.equals("��Ź�������")) { %>selected<% } %>>��Ź�������</option>
                        <option value="�ɻ��"
                        <%if(buse_name.equals("�ɻ��")) { %>selected<% } %>>�ɻ��</option>
                        <!--                    <option value="����������" <%if(buse_name.equals("����������")) { %>selected<% } %>>����������</option>
                          -->
                        <option value="���������ź���"
                        <%if(buse_name.equals("���������ź���")) { %>selected<% } %>>���������ź���</option>
                        <option value="���Ű�����"
                        <%if(buse_name.equals("���Ű�����")) { %>selected<% } %>>���Ű�����</option>
                        <option value="������"
                        <%if(buse_name.equals("������")) { %>selected<% } %>>������</option>
                        <option value="�۷ι���ȯ�����"
                        <%if(buse_name.equals("�۷ι���ȯ�����")) { %>selected<% } %>>�۷ι���ȯ�����</option>
                        <option value="������ȹ��"
                        <%if(buse_name.equals("������ȹ��")) { %>selected<% } %>>������ȹ��</option>
                        <option value="�̻�ȸ�繫��"
                        <%if(buse_name.equals("�̻�ȸ�繫��")) { %>selected<% } %>>�̻�ȸ�繫��</option>
                        <option value="�ڱݺ�"
                        <%if(buse_name.equals("�ڱݺ�")) { %>selected<% } %>>�ڱݺ�</option>
                        <option value="��������"
                        <%if(buse_name.equals("��������")) { %>selected<% } %>>��������</option>
                        <option value="IT���ߺ�"
                        <%if(buse_name.equals("IT���ߺ�")) { %>selected<% } %>>IT���ߺ�</option>
                        <option value="������ȣ����"
                        <%if(buse_name.equals("������ȣ����")) { %>selected<% } %>>������ȣ����</option>
                        <option value="���հ����"
                        <%if(buse_name.equals("���հ����")) { %>selected<% } %>>���հ����</option>
                        <option value="����ũ������"
                        <%if(buse_name.equals("����ũ������")) { %>selected<% } %>>����ũ������</option>
                        <option value="�ڱݿ���"
                        <%if(buse_name.equals("�ڱݿ���")) { %>selected<% } %>>�ڱݿ���</option>
                        <option value="�ع�������"
                        <%if(buse_name.equals("�ع�������")) { %>selected<% } %>>�ع�������</option>
                        <option value="�ǸŻ����"
                        <%if(buse_name.equals("�ǸŻ����")) { %>selected<% } %>>�ǸŻ����</option>
                        <option value="�ѹ���"
                        <%if(buse_name.equals("�ѹ���")) { %>selected<% } %>>�ѹ���</option>
                        <option value="ī������"
                        <%if(buse_name.equals("ī������")) { %>selected<% } %>>ī������</option>
                        <option value="�ؾ����ڱ�������"
                        <%if(buse_name.equals("�ؾ����ڱ�������")) { %>selected<% } %>>�ؾ����ڱ�������</option>
                        <option value="ȫ����"
                        <%if(buse_name.equals("ȫ����")) { %>selected<% } %>>ȫ����</option>
                        <option value="ȸ��������"
                        <%if(buse_name.equals("ȸ��������")) { %>selected<% } %>>ȸ��������</option>
                        <option value="�������������"
                        <%if(buse_name.equals("�������������")) { %>selected<% } %>>�������������</option>
                        <option value="���������"
                        <%if(buse_name.equals("���������")) { %>selected<% } %>>���������</option>
                        <option value="������å��"
                        <%if(buse_name.equals("������å��")) { %>selected<% } %>>������å��</option>
                        <option value="��å�����"
                        <%if(buse_name.equals("��å�����")) { %>selected<% } %>>��å�����</option>
                        <option value="�����Һ��ں�ȣ��"
                        <%if(buse_name.equals("�����Һ��ں�ȣ��")) { %>selected<% } %>>�����Һ��ں�ȣ��</option>
                        <option value="�����б�����"
                        <%if(buse_name.equals("�����б�����")) { %>selected<% } %>>�����б�����</option>
                        <option value="����������"
                        <%if(buse_name.equals("����������")) { %>selected<% } %>>����������</option>
                        <option value="�ع����ý�(�߾�ȸ)"
                        <%if(buse_name.equals("�ع����ý�(�߾�ȸ)")) { %>selected<% } %>>�ع����ý�(�߾�ȸ)</option>
                        <option value="�ع����ý�(����)"
                        <%if(buse_name.equals("�ع����ý�(����)")) { %>selected<% } %>>�ع����ý�(����)</option> --%>
                    </select>
                </td>
                <td class="bluesky">��ȸ����</td>
                <td colspan="4">
                    <select name="FIELD">
                        <option value="">����</option>
                        <option value="title">����</option>
                        <option value="text">����</option>
                        <option value="name">�ο���</option>
                        <!-- -->
                    </select>
                    <input type="text" class="input01" size="48" style="width: 180px" name="KEY" value="<%=KEY%>">
                    <a href="javascript:GoReg();"><img src="img/btn_search.gif" width="38" height="17" border="0" alt="�˻�"></a>
                    <a href="javascript:pbform.reset();"><img src="img/btn_refresh.gif" width="48" height="17" border="0" alt="�ʱ�ȭ"></a>
                </td>
            </tr>
        </table>
    </div>
    <!-- // ���������� ���� ���� -->
    <br>
    <div class="tbl-wrap">
        <!-- �˻���� -->
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="30"><img src="img/result.gif" align="absmiddle"> �˻���� :
                    <span class="result_text">�� <%=TotalRecordCount %>��</span></td>
                <td height="30" align="right"><a href="excel/absurd_excel.jsp?cmd=<%=cmd%>&KEY=<%=KEY%>&FIELD=<%=FIELD%>&startday=<%=startday%>&endday=<%=endday%>&status=<%=status%>&buse_name=<%=buse_name%>&result=<%=result%>"><img src="img/btn_excel.gif" width="66" height="21" alt="����" border="0"></a></td>
            </tr>
        </table>
        <div class="subtit"><img src="img/arrow.gif" width="13" height="16" align="absmiddle">���������� �Ű�</div>
        <!-- // �˻���� -->

        <table border="0" cellspacing="0" cellpadding="0" class="tbl-list">
            <tr height="30" class="header">
                <td class="board_bg_title" align="center">��ȣ</td>
                <td class="board_bg_title" align="center">Ư���ڵ�</td>
                <td class="board_bg_title" align="center">����</td>
                <td class="board_bg_title" align="center">�ο���</td>
                <td class="board_bg_title" align="center">��û��</td>
                <td class="board_bg_title" align="center">ó������</td>
                <td class="board_bg_title" align="center">���μ�</td>
                <!--
                          <td class="board_bg_title" width="75" align="center">ó�����</td>
                -->
                <td class="board_bg_title" align="center">�亯��</td>
            </tr>
            <%
            ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);
            
            if( ResultVector.size() > 0){
            for (int i=0; i < ResultVector.size();i++){
            Hashtable h = (Hashtable)ResultVector.elementAt(i);
            
            String TITLE = (String)h.get("TITLE");	//����
            if (TITLE.length() > 31){
            TITLE = TITLE.substring(0,31);
            TITLE += "...";
            }
            //int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //�۹�ȣ ���
            int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//�۹�ȣ ���(����)
            String time2=(String)h.get("TIME2");
            String code=(String)h.get("CODE");
            %>
            <tr height="30">
                <td align="center"><%=listnum %></td>
                <td align="center"><%=(String)h.get("PUBLICATION") %></td>
                <td style="padding-left:10;">
                    <%if(time2==null || time2.equals("")){%>
                    <a href="javascript:goView('<%=(String)h.get("THID")%>',<%=PAGE %>);"><%=TITLE %></a>
                    <%}else{%>
                    <a href="javascript:goDetailView('<%=(String)h.get("THID")%>',<%=PAGE %>);"><%=TITLE %></a>
                    <%} %>
                </td>
                <td align="center"><%=(String)h.get("NAME") %></td>
                <td align="center"><%=(String)h.get("TIME1") %></td>
                <td align="center"><%=code %></td>
                <td align="center"><%=(String)h.get("BUSEO") %></td>
                <!--
                          <td align="center"><%=(String)h.get("RESULT") %></td>
                -->
                <%if("öȸ�Ϸ�".equals(code)){ %>
                <td align="center"><%=(String)h.get("ABANDON_DATE")%></td>
                <%}else{ %>
                <td align="center"><%=time2%></td>
                <%} %>
            </tr>
            <%
            }
            } else {
            %>
            <tr>
                <td class="no" align="center" colspan="9">��� �ڷᰡ �����ϴ�.</td>
            </tr>
            <%
            }
            %>
        </table>
        <br>
        <!-- // ����Ʈ -->
        <!-- ������ �ѹ��� -->
        <table width="945" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="center">
                    <% if(TotalRecordCount > 0) { %>
                    <%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock, "absurd.jsp?KEY="+KEY+"&cmd=" + cmd + "&FIELD=" + FIELD + "&startday=" + startday + "&endday=" + endday + "&status=" + status + "&buse_name=" + buse_name + "&PAGE=","<img src=img/board_prev.gif width=13 height=13 align=absmiddle border=0>","<img src=img/board_next.gif width=13 height=13 align=absmiddle border=0>")%>
                    <% } %>
                </td>
            </tr>
        </table>
                    <!-- ������ �ѹ��� -->
        <input type="hidden" name="cmd">
        <input type="hidden" name="thid">
        <input type="hidden" name="PAGE">
    </div>
</form>
<%@ include file="include/bottom.jsp" %>
<%
} catch(Exception e) {
out.println("absurd.jsp : " + e.getMessage());
} finally {

}
%>