<%
/*****************************************************************************
*Title			: chungtak_find_addr.jsp
*@author		: S.H.M
*@date			: 2017.02.10
*@Description	: �����ȣ �˻�
*@Copyright		: 
******************************************************************************
*������		*������		*��������
******************************************************************************/
%>

<%@ page import="java.util.*, java.text.*, Bean.Front.Common.*" %>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil"/>



<%

	try {

		String TableName = null;
		String SelectCondition = null;
	    String WhereCondition = null;
	    String OrderCondition = null;
		String zipcode = null;
	    String sido = null;
	    String gugun = null;
	    String dong = null;
	    String bunji = null;
	    String addr =  null;
		String addr1= "";
	    int PAGE = 0;                                   // default page value of PAGE;
	
	    Vector  ResultVector;
	
	    String SW = request.getParameter("SW");
		String SW_all = request.getParameter("SW_all");
		String where_con = request.getParameter("address_sel");
		String jusogubun = request.getParameter("jusogubun"); //�ּұ��� 0:���θ��ּ� 1:�����ּ�
		String sidoSelect = request.getParameter("sido");
		String gugunSelect = request.getParameter("gugun");
		String sn = request.getParameter("sn");
		String gusn = request.getParameter("gusn");
		
		String titleName = request.getParameter("titleName");
		
		String zipType = request.getParameter("zipType");
		
		
// 		System.out.println("SW = " +      SW);
// 		System.out.println("SW_all = " +      SW_all);
// 		System.out.println("where_con = " +      where_con);
// 		System.out.println("jusogubun = " +      jusogubun);
// 		System.out.println("sidoSelect = " +      sidoSelect);
// 		System.out.println("gugunSelect = " +      gugunSelect);
// 		System.out.println("sn = " +      sn);
// 		System.out.println("gusn = " +      gusn);
// 		System.out.println("titleName = " +      titleName);
		
		
		if(titleName==null){
			titleName="���θ��ּ� ã�� ";
		}
		
		if(sidoSelect==null){
			sidoSelect="����Ư����";
		}

		if(gugunSelect==null){
			gugunSelect="";
		}

		if(sn==null){
			sn="0";
		}

		if(gusn==null){
			gusn="0";
		}

		if(jusogubun==null){
			jusogubun="0";
		}

		String 	sTableName = " SH_ZIPCODE ";
		String	sSelectCondition = " DISTINCT gugun ";
		String	sWhereCondition  = " Where sido = '" + FrontDbUtil.ConvertTo8859(sidoSelect) + "'";
		String	sOrderCondition = "";
		
// 		System.out.println(sTableName);
// 		System.out.println(sSelectCondition);
// 		System.out.println(sWhereCondition);
// 		System.out.println(sOrderCondition);
		
		int sPAGE = 0;

		if (SW_all == null || SW_all.length() == 0) SW = "";

		if (SW_all != null && !SW_all.equals("")) {

			SW_all = SW_all.replaceAll("'", "");
			SW_all = SW_all.replaceAll("&", "");
			SW_all = SW_all.replaceAll("\'", "");
			SW_all = SW_all.replaceAll("<", "");
			SW_all = SW_all.replaceAll(">", "");
			SW_all = SW_all.replaceAll("-", "");
			SW_all = SW_all.replaceAll("%", "");
	
			
			TableName       = " SH_ZIPCODE ";
	
			SelectCondition = " zipcode, sido, gugun, dong, bunji ";
			WhereCondition  = " Where sido = '" + FrontDbUtil.ConvertTo8859(sidoSelect) + "'";

			if(!gugunSelect.equals("")) {
				WhereCondition  += " and gugun = '" + FrontDbUtil.ConvertTo8859(gugunSelect) + "'";
			}

			WhereCondition  += " and dong like '%" + FrontDbUtil.ConvertTo8859(SW_all) + "%' ";

			OrderCondition  = " Order by seq Asc";
		}
		
		
		
		

		//out.print("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br/><br/>");
%>

<%@ page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title><%=titleName %> &gt; �����ȣ ã�� &gt; ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/js/public.js"></script>
<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript">
<!--
	//�˻�
	function goSearch() {

		if(pbform.SW.value == "") {
			alert("�˻�� �Է��ϼ���!");
			pbform.SW.focus();
			return;
		}

		document.pbform.address_sel.value = "0";
		document.pbform.sido.value = document.getElementById("sidoSelect").value;

		pbform.submit();
	}

	//�˻�
	function goSearch_all() {

		if(pbform.SW_all.value == "") {
			alert("�˻�� �Է��ϼ���!");
			pbform.SW_all.focus();
			return;
		}

		document.pbform.address_sel.value = "1";
		document.pbform.sido.value = document.getElementById("sidoSelect_all").value;
		document.pbform.sn.value = "<%=sn%>";
		document.pbform.jusogubun.value = "<%=jusogubun%>";
		document.pbform.gugun.value = document.getElementById("guSelect").value;
		
// 		alert(document.pbform.sido.value +" : "+ document.pbform.sn.value +" : "+ document.pbform.jusogubun.value +" : "+ document.pbform.gugun.value);

		pbform.submit();
	}

	//�����ȣ ����
	function send_code(zipcode, address, zipType) {
// 		alert(zipcode +"="+ address +"="+ zipType);

		var zip1 = zipcode.substr(0,3);
		var zip2 = zipcode.substr(4,3);
		//alert(address);
		opener.input_zipcode(zip1,zip2,address,zipType);
		window.close();
	}

	function find_addr_onLoad(){
		if("<%=sidoSelect%>" != null) {
			var sn = <%=sn%>;
			var gusn = <%=gusn%>;
			var zipType = <%=zipType%>;
			document.pbform.sidoSelect_all.options[sn].selected  = "true";
			document.pbform.guSelect.options[gusn].selected  = "true";
			document.pbform.sn.value = sn;
			document.pbform.gusn.value = gusn;
			document.pbform.zipType.value = zipType;
		}
	}

	function guSelectList(sido,sn){
		document.pbform.sido.value = document.getElementById("sidoSelect_all").value;
		document.pbform.gugun.value = document.getElementById("guSelect").value;
		document.pbform.jusogubun.value = <%=jusogubun%>;
		document.pbform.sn.value = sn;

		pbform.submit();
	}

	function fnGuListClick(sn){
		
		document.pbform.gusn.value = sn;
	}

	function jusoGubun(flg){
		var titleName = "";
		if(flg=='0'){ 
			titleName = "���θ��ּ� ã��";
		}else if(flg=='1'){
			titleName = "�����ּ� ã��";
		}
		document.pbform.titleName.value = titleName;
		document.pbform.sido.value = document.getElementById("sidoSelect_all").value;
		document.pbform.jusogubun.value = flg;

		document.pbform.submit();
	}

	function EnterDown(e){

		if(e.keyCode == 13){
			goSearch_all();
		}
	}

	function resizeWindowHeight(wValue, hValue) {
	    var popUpWinSize = document.getElementById("popUpWinHeight");
	    var windowHeight = popUpWinSize.offsetHeight + hValue;
		window.resizeTo(wValue, windowHeight);
	}
//-->
</script>
</head>

<body id="popup" onLoad="javascript:find_addr_onLoad();resizeWindowHeight(450,90);">
<form name="pbform" method="post" action="chungtak_find_addr.jsp">


<input type="hidden" name="MD" value="post" />
<input type="hidden" name="address_sel" value="0" />
<input type="hidden" name="jusogubun" value="0" />
<input type="hidden" name="sido" />
<input type="hidden" name="gugun" />
<input type="hidden" name="sn" />
<input type="hidden" name="gusn" />
<input type="hidden" name="titleName" />
<input type="hidden" name="zipType" />



	<!-- 400*500 -->
	<div id="popUpWinHeight" class="wrapPopup">
		<h1 class="dpNone">����</h1>
		<h2><span class="zipcode">�����ȣ ã��</span></h2>

		<!-- ���θ��ּ� ã�� -->
		<% if(jusogubun.equals("0")) { %>
			<div class="tabs_gray tab2 bdbNone">
				<ul>
				<li class="w50p"><a href="#" onClick="javascript:jusoGubun(0);">���θ��ּ� ã��</a></li>
				<li class="w50p current"><a href="#" onClick="javascript:jusoGubun(1);">�����ּ� ã��</a></li>
				</ul>
			</div>
			<div class="innerBox">
				<h3 class="dpNone">���θ��ּ� ã��</h3>
				<p class="mgb20 pdt5">
					ã���� �ϴ� �ּ��� ��, ���� ��,��,���� �����Ͻ� ��<br />
					���θ��� �Է��Ͻ� �� �˻���ư�� �����ּ���.
					<span class="displayB colorBlue mgt10">��) ����Ư���� ������ ���� �� ����� �Է�</span>
				</p>
				<table class="writeZipcode mgb20" summary="�ּ��� �� ��, �� �� ��, ���θ� ���� �����ȣ ã��">
					<caption>���θ��ּ� ã��</caption>
					<colgroup>
						<col style="width:70px;" />
						<col style="width:auto;" />
						<col style="width:70px;" />
						<col style="width:auto;" />
					</colgroup>
					<tr>
						<th scope="row">�� ��</th>
						<td>
							<select id="sidoSelect_all" title="��, ��">
								<option value="����Ư����" onClick='javascript:guSelectList(this.value,0);'>����Ư����</option>
								<option value="��õ������" onClick='javascript:guSelectList(this.value,1);'>��õ������</option>
								<option value="��⵵" onClick='javascript:guSelectList(this.value,2);'>��⵵</option>             
								<option value="����������" onClick='javascript:guSelectList(this.value,3);'>����������</option>
								<option value="�뱸������" onClick='javascript:guSelectList(this.value,4);'>�뱸������</option>
								<option value="��󳲵�" onClick='javascript:guSelectList(this.value,5);'>��󳲵�</option>
								<option value="���ϵ�" onClick='javascript:guSelectList(this.value,6);'>���ϵ�</option>
								<option value="������" onClick='javascript:guSelectList(this.value,7);'>������</option>
								<option value="���󳲵�" onClick='javascript:guSelectList(this.value,8);'>���󳲵�</option>
								<option value="����ϵ�" onClick='javascript:guSelectList(this.value,9);'>����ϵ�</option>
								<option value="��û����" onClick='javascript:guSelectList(this.value,10);'>��û����</option>
								<option value="��û�ϵ�" onClick='javascript:guSelectList(this.value,11);'>��û�ϵ�</option>
								<option value="���ֱ�����" onClick='javascript:guSelectList(this.value,12);'>���ֱ�����</option>
								<option value="��걤����" onClick='javascript:guSelectList(this.value,13);'>��걤����</option> 
								<option value="�λ걤����" onClick='javascript:guSelectList(this.value,14);'>�λ걤����</option>
								<option value="����Ư����ġ��" onClick='javascript:guSelectList(this.value,15);'>����Ư����ġ��</option>
								<option value="����Ư����ġ��" onClick='javascript:guSelectList(this.value,16);'>����Ư����ġ��</option>
							</select>
						</td>
						<th scope="row">�� �� ��</th>
						<td>
							<select id="guSelect" title="��, ��, ��">
			        		<%
			        			ResultVector = FrontBoard.list(sTableName, sSelectCondition, sWhereCondition, sOrderCondition, sPAGE, 1);
								
			        			if( ResultVector.size() > 0) {
									for (int i=0; i < ResultVector.size();i++){
										Hashtable h = (Hashtable)ResultVector.elementAt(i);
										gugun = (String) h.get("GUGUN");
							%>
								<option value='<%=gugun%>' onclick="javascript:fnGuListClick(<%=i%>);"><%=gugun%></option>
			                <%
			                		}
								}
							%>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">���θ�</th>
						<td colspan="3">
							<input type="text" class="text" style="width:168px;" title="���θ�" name="SW_all" onkeypress="javascript:if(event.keyCode==13){EnterDown(event)}" /><a href="javascript:goSearch_all();" class="btn_blue_s01 mgl10"><span>�˻�</span></a>
						</td>
					</tr>
				</table>

				<%
					ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 1);

					if( ResultVector.size() > 0) {
				%>
				<div class="boxScroll h140 pdt10">
					<p class="mgb15">* �˻� ����� �ش� �ּҸ� Ŭ���Ͻø� �ڵ����� �Էµ˴ϴ�.</p>
					<table class="listZipcode" summary="�����ȣ �˻� ����� �����ȣ, �ּ�">
						<caption>�����ȣ �˻� ���</caption>
						<colgroup>
							<col style="width:70px;" />
							<col style="width:auto;" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="textC"><strong>�����ȣ</strong></th>
								<th scope="col" class="pdl10">�ּ�</th>
							</tr>
						</thead>
						<tbody>
							<%		
									for (int i=0; i < ResultVector.size();i++) {
										Hashtable h = (Hashtable)ResultVector.elementAt(i);
										sido = (String) h.get("SIDO");
										gugun = (String) h.get("GUGUN");
										dong = (String) h.get("DONG");
										bunji = (String) h.get("BUNJI");
										addr = sido + " " + gugun + " " + dong + " " + bunji;
										addr1 = sido + " " + gugun + " " + dong + " " + bunji;;
										zipcode = (String) h.get("ZIPCODE");
							%>
							<tr>
								<td class="textC"><strong><%=zipcode%></strong></td>
								<td class="pdl10"><a href='javascript:send_code("<%=zipcode%>","<%=addr1%>","<%=zipType%>")'><%=addr%></a></td>
							</tr>
							<%
									}
							%>
						</tbody>
					</table>
				</div>
				<%
					}
				%>
				<% if( ResultVector.size() == 0){ %>
						<!-- �˻� ����� ���ٸ� �Ʒ��� div�� ����� �ּ���. -->
						<div class="no_record">
							�˻��� �ڷᰡ �����ϴ�.
						</div>
				<% } %>
			</div>
		<% } %>
		<!--// ���θ��ּ� ã�� -->

		<!-- �����ּ� ã�� -->
		<% if(jusogubun.equals("1")){ %>
			<div class="tabs_gray tab2 bdbNone">
				<ul>
				<li class="w50p current"><a href="#" onClick="javascript:jusoGubun(0);">���θ��ּ� ã��</a></li>
				<li class="w50p"><a href="#" onClick="javascript:jusoGubun(1);">�����ּ� ã��</a></li>
				</ul>
			</div>
			<div class="innerBox">
				<h3 class="dpNone">���θ��ּ� ã��</h3>
				<p class="mgb20 pdt5">
					ã���� �ϴ� �ּ��� ��, ���� ��,��,���� �����Ͻ� ��<br />
					��,��,��,���� �Է��Ͻ� �� �˻���ư�� �����ּ���.
					<span class="displayB colorBlue mgt10">��) ����Ư���� ������ ���� �� ���ﵿ �Է�</span>
				</p>
				<table class="writeZipcode mgb20" summary="�ּ��� �� ��, �� �� ��, ��,��,��,�� ���� �����ȣ ã��">
					<caption>���θ��ּ� ã��</caption>
					<colgroup>
						<col style="width:70px;" />
						<col style="width:auto;" />
						<col style="width:70px;" />
						<col style="width:auto;" />
					</colgroup>
					<tr>
						<th scope="row">�� ��</th>
						<td>
							<select id="sidoSelect_all" title="��, ��">
								<option value='����' onClick='javascript:guSelectList(this.value,0);'>����</option>
								<option value='��õ' onClick='javascript:guSelectList(this.value,1);'>��õ</option>
								<option value='���' onClick='javascript:guSelectList(this.value,2);'>���</option>
								<option value='����' onClick='javascript:guSelectList(this.value,3);'>����</option>
								<option value='�뱸' onClick='javascript:guSelectList(this.value,4);'>�뱸</option>
								<option value='�泲' onClick='javascript:guSelectList(this.value,5);'>�泲</option>
								<option value='���' onClick='javascript:guSelectList(this.value,6);'>���</option>
								<option value='����' onClick='javascript:guSelectList(this.value,7);'>����</option>
								<option value='����' onClick='javascript:guSelectList(this.value,8);'>����</option>
								<option value='����' onClick='javascript:guSelectList(this.value,9);'>����</option>
								<option value='�泲' onClick='javascript:guSelectList(this.value,10);'>�泲</option>
								<option value='���' onClick='javascript:guSelectList(this.value,11);'>���</option>
								<option value='����' onClick='javascript:guSelectList(this.value,12);'>����</option>
								<option value='���' onClick='javascript:guSelectList(this.value,13);'>���</option> 
								<option value='�λ�' onClick='javascript:guSelectList(this.value,14);'>�λ�</option>
								<option value='����' onClick='javascript:guSelectList(this.value,15);'>����</option>
							</select>
						</td>
						<th scope="row">�� �� ��</th>
						<td>
							<select id="guSelect" title="��, ��, ��">
			        		<%
			        			ResultVector = FrontBoard.list(sTableName, sSelectCondition, sWhereCondition, sOrderCondition, sPAGE, 1);
								
			        			if( ResultVector.size() > 0) {
									for (int i=0; i < ResultVector.size();i++){
										Hashtable h = (Hashtable)ResultVector.elementAt(i);
										gugun = (String) h.get("GUGUN");
							%>
								<option value='<%=gugun%>' onclick="javascript:fnGuListClick(<%=i%>);"><%=gugun%></option>
			                <%
			                		}
								}
							%>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">��,��,��,��</th>
						<td colspan="3">
							<input type="text" class="text" style="width:168px;" title="��,��,��,����" name="SW_all" onkeypress="javascript:if(event.keyCode==13){EnterDown(event)}" /><a href="javascript:goSearch_all();" class="btn_blue_s01 mgl10"><span>�˻�</span></a>
						</td>
					</tr>
				</table>

				<%
					ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 1);

					if( ResultVector.size() > 0) {
				%>
				<div class="boxScroll h140 pdt10">
					<p class="mgb15">* �˻� ����� �ش� �ּҸ� Ŭ���Ͻø� �ڵ����� �Էµ˴ϴ�.</p>
					<table class="listZipcode" summary="�����ȣ �˻� ����� �����ȣ, �ּ�">
						<caption>�����ȣ �˻� ���</caption>
						<colgroup>
							<col style="width:70px;" />
							<col style="width:auto;" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="textC"><strong>�����ȣ</strong></th>
								<th scope="col" class="pdl10">�ּ�</th>
							</tr>
						</thead>
						<tbody>
							<%		
							
							System.out.println(ResultVector.size());
							
									for (int i=0; i < ResultVector.size();i++) {
										Hashtable h = (Hashtable)ResultVector.elementAt(i);
										sido = (String) h.get("SIDO");
										gugun = (String) h.get("GUGUN");
										dong = (String) h.get("DONG");
										bunji = (String) h.get("BUNJI");
										addr = sido + " " + gugun + " " + dong + " " + bunji;
										addr1 = sido + " " + gugun + " " + dong + " " + bunji;;
										zipcode = (String) h.get("ZIPCODE");
							%>
							<tr>
								<td class="textC"><strong><%=zipcode%></strong></td>
								<td class="pdl10"><a href='javascript:send_code("<%=zipcode%>","<%=addr1%>",<%=zipType%>)'><%=addr%></a></td>
							</tr>
							<%
									}
							%>
						</tbody>
					</table>
				</div>
				<%
					}
				%>
				<% if( ResultVector.size() == 0){ %>
						<!-- �˻� ����� ���ٸ� �Ʒ��� div�� ����� �ּ���. -->
						<div class="no_record">
							�˻��� �ڷᰡ �����ϴ�.
						</div>
				<% } %>
			</div>
		<% } %>
		<!--// �����ּ� ã�� -->
		<div class="btnCenter">
			<a href="#" class="btn_blue_s01"><span>Ȯ��</span></a>
		</div>
	</div>
</form>
</body>
</html>
<% 
	} catch(Exception e) {
		out.println("chungtak_find_addr.jsp : " + e.getMessage());
	} finally {
		//
	}
%>