<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu0202.jsp" %>
<%
	String ListPage = Converter.nullchk(request.getParameter("ListPage"));
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
		String start  = Converter.nullchk(request.getParameter("start"));
		String end  = Converter.nullchk(request.getParameter("end"));
		String result  = Converter.nullchk(request.getParameter("result"));

		int PAGE = 1;
		int StartRecord = 0;
		int EndRecord   = 0;
		int DefaultListRecord = 10;
		int DefaultPageBlock = 10;

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
		
	    SelectCondition = " mid, category, minwon_gubun, subject, name, status, bupin, ";
		SelectCondition += "to_char(creation_date, 'YYYY-MM-DD  AM HH24:MI:SS') AS creation_date, buse_name, result,";
		SelectCondition += "to_char(answer_date, 'YYYY-MM-DD  AM HH24:MI:SS') AS answer_date, to_char(abandon_date, 'YYYY-MM-DD  AM HH24:MI:SS') AS abandon_date, answer,fname";
	    OrderCondition  = " ORDER BY mid DESC ";
	    
	    
// 	    session.setAttribute("buseName", (String) h.get("BUSE_NAME"));
// 		System.out.println("buseName1 : " + session.getAttribute("buseName"));
// 		System.out.println("buseName2 : " + finance_buseo);
	    
	    
	    String where_buseo = "";
		/* if("�����".equals(finance_buseo)){
			where_buseo = "where bupin = '1'";
		}else if("�����".equals(finance_buseo)){
			where_buseo = "where bupin = '2'";
		}else{
			where_buseo = "where 1 = 1";
		}
		
		WhereCondition = where_buseo;

		//����
	    if(!finance_buseo.equals("")){
	    	WhereCondition+=" and buse_name='" + finance_buseo + "' ";
	    } */
		/*
	    if(finance_buseo.equals("�ع�������")){
	    	WhereCondition+=" and junbuseo='Y' ";
	    }

		*/
		//if("�����".equals(finance_buseo) || "�����".equals(finance_buseo)){
		
		/* WhereCondition = "where mid in ( "
				   + "select SH_MINWON_NO "
				   + "from sh_minwon_history "
				   + "where SH_BUSEO_From = '"+finance_buseo+"' "
				   + "and sh_no in (select min(sh_no) from sh_minwon_history where SH_BUSEO_From = '"+finance_buseo+"' and sh_minwon_no = '"++"' group by SH_MINWON_NO) "
				   + ") \n";
		
		Vector ResultVector2 = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);
		
		System.out.println("!!!!!!!!!!!!!!!!!");
		System.out.println("@@@@@ResultVector2.size()-->" + ResultVector2.size());
		 */
		
		if("�����".equals(finance_buseo) ||
			"�����".equals(finance_buseo) ||
			"�ع����ý�(����)".equals(finance_buseo) ||
			"�ع����ý�(�߾�ȸ)".equals(finance_buseo) ||
			"�����Һ��ں�ȣ��".equals(finance_buseo)){
			WhereCondition = "where (buse_name='" + finance_buseo + "' or mid in ( "
			   + "select SH_MINWON_NO "
			   + "from sh_minwon_history "
			   //+ "where SH_BUSEO_FROM = '"+finance_buseo+"' "
			   //+ "and sh_no in (select min(sh_no) from sh_minwon_history where (SH_BUSEO_FROM = '"+finance_buseo+"' or SH_BUSEO_TO = '"+finance_buseo+"') group by SH_MINWON_NO) "
			   + "where sh_no in (select min(sh_no) from sh_minwon_history where (SH_BUSEO_FROM = '"+finance_buseo+"' or SH_BUSEO_TO = '"+finance_buseo+"') group by SH_MINWON_NO) "
			   + ")) \n";
		} else {
			WhereCondition =" where buse_name='" + finance_buseo + "' \n";
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
		
		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
		
// 		System.out.println(SelectCondition);
// 		    System.out.println(OrderCondition);

%>

<script language="javascript" src="js/common.js"></script>
<script language="javascript">

	function GoReg(){

		if(!compareDt(pbform.start.value, pbform.end.value)){
          alert("�������� �������� ���� �� �����ϴ�.");
		  return;
		}

		if(!pbform.start.value && !pbform.category.value && !pbform.minwon_gubun.value && !pbform.status.value && !pbform.result.value){
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
		pbform.action = "madmin_02_view.jsp";
		pbform.submit();
	}
	function goDetailView(mid,PAGE){
		pbform.mid.value=mid;
		pbform.PAGE.value=PAGE;
		pbform.action = "madmin_02_detail.jsp";
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

</script>
<!-- �ο�������Ȳ �˻� �� -->
<form method=post name="pbform" action="">
	<div class="list-header">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td rowspan="2" class="admin_subject">�μ���<br>�ο�������Ȳ</td>
				<td class="bluesky">��û��</td>
				<td>
					<input type="text" class="input01" size="10" name="start" value="" readonly><a href="javascript:Calendar(pbform.start);"><img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0"></a>
					~
					<input type="text" class="input01" size="10" name="end" value="" readonly><a href="javascript:Calendar(pbform.end);"><img src="img/btn_calender.gif" width="23" height="18" align="absmiddle" border="0"></a>
				</td>
				<td class="bluesky">�о�</td>
				<td>
					<select name="category" width="130">
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
						<!-- -->
					</select>
				</td>
				<td class="bluesky">�ο��з�</td>
				<td>
					<select name="minwon_gubun">
						<option value="">��ü</option>
						<option value="�Ϲݹο�"<%if(minwon_gubun.equals("�Ϲݹο�")) { %>selected<% } %>>�Ϲݹο�</option>
						<option value="�ܼ�����"<%if(minwon_gubun.equals("�ܼ�����")) { %>selected<% } %>>�ܼ�����</option>
						<!-- -->
					</select>
				</td>
				<td class="bluesky">ó������</td>
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
			<tr>
				<td class="bluesky">ó�����</td>
				<td>
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
				<td class="bluesky">��ȸ����</td>
				<td colspan="3">
					<select name="FIELD">
						<option value="">�����ϼ���</option>
						<option value="subject">����</option>
						<option value="content">����</option>
						<option value="name">�ο���</option>
					</select>
					<input type="text" class="input01" style="width: 180px" size="48" name="KEY" value="<%=KEY%>" />
					<a href="javascript:GoReg();"><img src="img/btn_search.gif" width="38" height="17" border="0" alt="�˻�"></a>
					<a href="javascript:pbform.reset();"><img src="img/btn_refresh.gif" width="48" height="17" border="0" alt="�ʱ�ȭ"></a>
				</td>
			</tr>
		</table>
	</div>

<!-- // �ο�������Ȳ �˻� �� -->
<br>
	<div class="tbl-wrap">
      <!-- �˻���� -->
      <table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30"><img src="img/result.gif" align="absmiddle"> �˻���� :
              <span class="result_text">��<%=TotalRecordCount%>��</span>
          </td>
          <td height="30" align="right">
          	  <a href="excel/madmin_excel.jsp?cmd=<%=cmd%>&KEY=<%=KEY%>&FIELD=<%=FIELD%>&start=<%=start%>&end=<%=end%>&status=<%=status%>&category=<%=category%>&result=<%=result%>&minwon_gubun=<%=minwon_gubun%>"><img src="img/btn_excel.gif" width="66" height="21" alt="����" border="0"></a>
          </td>
        </tr>
      </table>
      <!-- // �˻���� -->
  <!-- �ο�������Ȳ ����Ʈ -->
    <div class="subtit"><img src="img/arrow.gif" width="13" height="16" align="absmiddle">
      <span class="txt_title">�μ��� �ο�������Ȳ</span></div>
      <table border="0" cellspacing="0" cellpadding="0" class="tbl-list">
        <tr>
          <td class="board_bg_title" align="center">��ȣ</td>
          <td class="board_bg_title" align="center">�о�</td>
          <td class="board_bg_title" align="center">�ο��з�</td>
          <td class="board_bg_title"  align="center">����</td>
          <td class="board_bg_title" align="center">�ο���</td>
          <td class="board_bg_title" align="center">��û��</td>
          <td class="board_bg_title" align="center">ó������</td>
          <td class="board_bg_title" align="center">���μ�</td>
          <td class="board_bg_title" align="center">ó�����</td>
		      <td class="board_bg_title" align="center">����</td>
          <td class="board_bg_title" align="center">�亯��</td>
        </tr>
			<!-- loop start -->
        <%
        	System.out.println("########### ����Ʈ");
	        System.out.println("TableName----------" +TableName);
	        System.out.println("SelectCondition----" +SelectCondition);
	        System.out.println("WhereCondition-----" +WhereCondition);
	        System.out.println("OrderCondition-----" +OrderCondition);
	        System.out.println("DefaultListRecord--" +DefaultListRecord);
        
        
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
// 					System.out.println((String)h.get("BUSE_NAME"));
		

		%>

       <tr>

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
			<%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock, "madmin_02.jsp?KEY="+KEY+"&cmd=" + cmd + "&FIELD=" + FIELD + "&start=" + start + "&end=" + end + "&category=" + category + "&minwon_gubun=" + minwon_gubun + "&status=" + status +  "&PAGE=","<img src=img/board_prev.gif width=13 height=13 align=absmiddle border=0>","<img src=img/board_next.gif width=13 height=13 align=absmiddle border=0>")%>
			<% } %>
          </td>
         </tr>
      </table>
      <!-- ������ �ѹ��� -->
	</div>
<input type="hidden" name="cmd">
<input type="hidden" name="mid">
<input type="hidden" name="PAGE">
</form>
<%@ include file="include/bottom.jsp" %>
<%
	} catch(Exception e) {
		out.println("madmin_02.jsp : " + e.getMessage());
	} finally {

	}
%>