<%

/*****************************************************************************

*Title			: zip_search.jsp

*@author		: K.H.S

*@date			: 2007-10

*@Description	: �����ȣ �˻�

*@Copyright		: 

******************************************************************************

*������		*������		*��������

******************************************************************************/

%>



<%@ page import="java.util.*, java.text.*, Bean.Front.Common.*"  contentType="text/html;charset=euc-kr"%>

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
		
		String sidoSelect = request.getParameter("sido");

	

	    if (SW == null || SW.length() == 0) SW = "";

	    if (SW != null && !SW.equals("")){

			SW = SW.replaceAll("'", "");

			SW = SW.replaceAll("&", "");

			SW = SW.replaceAll("\'", "");

			SW = SW.replaceAll("<", "");

			SW = SW.replaceAll(">", "");

			SW = SW.replaceAll("-", "");

			SW = SW.replaceAll("%", "");

			TableName       = " SH_ZIPCODE ";

			SelectCondition = " zipcode, sido, gugun, dong, bunji ";

			

		

			WhereCondition  = " Where sido = '" + FrontDbUtil.ConvertTo8859(sidoSelect) + "'";
			
			WhereCondition  += " and dong like '%" + FrontDbUtil.ConvertTo8859(SW) + "%'";
			

			OrderCondition  = " Order by seq Asc";

		}



		if (SW_all == null || SW_all.length() == 0) SW = "";

	    if (SW_all != null && !SW_all.equals("")){

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

			WhereCondition  += " and dong = '" + FrontDbUtil.ConvertTo8859(SW_all) + "' ";

			

			

			OrderCondition  = " Order by seq Asc";

		}

		//out.print("select " + SelectCondition + " from " + TableName + WhereCondition + OrderCondition + "<br/><br/>");

%>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>

<title>���� - �ٴٻ�� �����</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/member.css' />

<style>

		body {

			background:none;

		}

		#add_d {

			height:170px;

			overflow:auto;

		    scrollbar-face-color:#F8F8F8;

		    scrollbar-highlight-color:#D3D3D3;

		    scrollbar-shadow-color:#D3D3D3;

		    scrollbar-3dlight-color:#FFFFFF;

		    scrollbar-darkshadow-color:#FFFFFF;

		    scrollbar-arrow-color:#8b9ea6; 

		    scrollbar-track-color:#DDDDDD;

		}

		}

		#add_t {

			width:345px;

			margin-top:10px;

			background:url(/member/images/pt_bg_ad.gif) no-repeat 0 0;

		}

		#add_t caption {

			text-align:left;

			padding-bottom:3px;

		}

		#add_t thead th{

			padding-top:6px;

			height:25px;

			border-bottom:1px solid #EAEAEA;

		}

		#add_t tbody th, #add_t tbody td {

			height:25px;

			padding:0;

			border-bottom:1px solid #EAEAEA;

		}

		#add_t tbody th {

			width:70px;

		}

		.no_record {

			border:1px solid #EAEAEA;

			border-top:0;	

			height:170px;

		}

</style>



<script language="javascript">

<!--

	//�˻�

	function goSearch() {

		if(pbform.SW.value == ""){

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

		if(pbform.SW_all.value == ""){

			alert("�˻�� �Է��ϼ���!");

			pbform.SW_all.focus();

			return;

		}

		document.pbform.address_sel.value = "1";
		document.pbform.sido.value = document.getElementById("sidoSelect_all").value;
		pbform.submit();

	}

	

	//�����ȣ ����

	function send_code(zipcode, address) {

		var zip1 = zipcode.substr(0,3);

		var zip2 = zipcode.substr(4,3);

		//alert(address);

		opener.input_zipcode(zip1,zip2,address);

		window.close();

	}

//-->

</script>



</head>



<body id="popup" >

<form name="pbform" method="post" action="find_addr.jsp">

	<input type="hidden" name="MD" value="post">

	<input type="hidden" name="address_sel" value="0">
    
    <input type="hidden" name="sido">

<table cellspacing="0" align="center" id="cwt">

<tr>

	<td>

	<p class="title"><img src="images/address_title.gif" /></p>

	<p class="comment">ã���� �ϴ� �ּҸ� �Է��Ͻ� �� �˻���ư�� �����ּ���</p>

	<p class="input clear">

		<label for="sidoSelect_all">��.��.��.��</label>
        

		<select id="sidoSelect_all" style="width:80px;">
        		<option value="����">����</option>
                <option value="����Ư����">����Ư����</option>
                <option value="��õ">��õ</option>
                <option value="��õ������">��õ������</option>
                <option value="���">���</option>
                <option value="��⵵">��⵵</option>                
                <option value="����">����</option>
                <option value="����������">����������</option>
                <option value="�뱸">�뱸</option>
                <option value="�뱸������">�뱸������</option>
                <option value="�泲">�泲</option>
                <option value="��󳲵�">��󳲵�</option>
                <option value="���">���</option>
                <option value="���ϵ�">���ϵ�</option>
                <option value="����">����</option>
                <option value="������">������</option>
                <option value="����">����</option>
                <option value="���󳲵�">���󳲵�</option>
                <option value="����">����</option>
                <option value="����ϵ�">����ϵ�</option>
                <option value="�泲">�泲</option>
                <option value="��û����">��û����</option>
                <option value="���">���</option>
                <option value="��û�ϵ�">��û�ϵ�</option>
                <option value="����">����</option>
                <option value="���ֱ�����">���ֱ�����</option>
                <option value="���">���</option>
                <option value="��걤����">��걤����</option> 
                <option value="�λ�">�λ�</option>
                <option value="�λ걤����">�λ걤����</option>
                <option value="����Ư����ġ��">����Ư����ġ��</option>
                <option value="����">����</option>
                <option value="����Ư����ġ��">����Ư����ġ��</option>

        </select>
        <input type="text" class="typeText" style="width:100px;" name="SW_all"/>

		<a href="javascript:goSearch_all();"><img src="../images/btT01Search.gif" title="�˻�" alt="�˻�" style="margin-top:5px;" /></a>

	</p>

	<p class="input clear">

	&nbsp;&nbsp;&nbsp;&nbsp;�˻��� ����� ���� ��� �Ʒ� �˻��� �̿��� �ֽʽÿ�.	

	</p>

	<p class="input clear">

		<label for="sidoSelect">��.��.��.��</label>
		<select id="sidoSelect" style="width:80px;">
        		<option value="����">����</option>
                <option value="����Ư����">����Ư����</option>
                <option value="��õ">��õ</option>
                <option value="��õ������">��õ������</option>
                <option value="���">���</option>
                <option value="��⵵">��⵵</option>                
                <option value="����">����</option>
                <option value="����������">����������</option>
                <option value="�뱸">�뱸</option>
                <option value="�뱸������">�뱸������</option>
                <option value="�泲">�泲</option>
                <option value="��󳲵�">��󳲵�</option>
                <option value="���">���</option>
                <option value="���ϵ�">���ϵ�</option>
                <option value="����">����</option>
                <option value="������">������</option>
                <option value="����">����</option>
                <option value="���󳲵�">���󳲵�</option>
                <option value="����">����</option>
                <option value="����ϵ�">����ϵ�</option>
                <option value="�泲">�泲</option>
                <option value="��û����">��û����</option>
                <option value="���">���</option>
                <option value="��û�ϵ�">��û�ϵ�</option>
                <option value="����">����</option>
                <option value="���ֱ�����">���ֱ�����</option>
                <option value="���">���</option>
                <option value="��걤����">��걤����</option> 
                <option value="�λ�">�λ�</option>
                <option value="�λ걤����">�λ걤����</option>
                <option value="����Ư����ġ��">����Ư����ġ��</option>
                <option value="����">����</option>
                <option value="����Ư����ġ��">����Ư����ġ��</option>
        </select>
		<input type="text" class="typeText" style="width:100px;" name="SW"/>

		<a href="javascript:goSearch();"><img src="../images/btT01Search.gif" alt="�˻�" title="�˻�" style="margin-top:5px;" /></a>

	</p>



							<%

								ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 1);

								if( ResultVector.size() > 0){

							%>

								<div id="add_d">

									<table cellspacing="0" id="add_t">

									<caption>*�˻� ����� �ش� �ּҸ� Ŭ���Ͻø� �ڵ����� �Էµ˴ϴ�.</caption>

									<thead>

									<tr>

										<th>�����ȣ</th>

										<th>�ּ�</th>

									</tr>

									</thead>

									<tbody>

							<%		

									for (int i=0; i < ResultVector.size();i++){

										Hashtable h = (Hashtable)ResultVector.elementAt(i);

										sido = (String) h.get("SIDO");

										gugun = (String) h.get("GUGUN");

										dong = (String) h.get("DONG");

										bunji = (String) h.get("BUNJI");

										addr = sido + " " + gugun + " " + dong + " " + bunji;

										addr1 = 

sido + " " + gugun + " " + dong;

										zipcode = (String) h.get("ZIPCODE");

							%>

								<tr>

									<th><%=zipcode%></th>

									<td><a href='javascript:send_code("<%=zipcode%>","<%=addr1%>")'><%=addr%></a></td>

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

<!-- -->

	<p class="btn"><img src="../pub_img/btT01Confirm.gif"  title="Ȯ��"></p>

	</td>

</tr>

</table>

</form>

</body>

</html>



<% 

	} catch(Exception e) {

		out.println("zip_search.jsp : " + e.getMessage());

	} finally {



	}

%> 