<!--#include file="../dev/dist/config.asp"-->
<!--#include file="head.asp"-->

<%
  
  Dim iTotalCount, iTotalPage, LCnt0 '����¡
  LCnt0 = 0

  Dim LCnt, NowPage, PagePerData '����Ʈ
  LCnt = 0

  iDivision = "1"                   ' T:����, 1:���䰶����, 2:�����󰶷���, 3:�������亯, 4:�����Խ���, 5:����Դ�ȭ��
  iLoginID = "junida" 

  NowPage = fInject(Request("i2"))  ' ����������
  PagePerData = global_PagePerData  ' ��ȭ�鿡 ����� ����
  BlockPage = global_BlockPage      ' ����¡��, 5�� 1,2,3,4,5 ���� ������ ���������� ����

  'Request Data
	iSearchText = fInject(Request("iSearchText"))
	iSearchCol = fInject(Request("iSearchCol"))

  If Len(NowPage) = 0 Then
		NowPage = 1
	End If

	if(Len(iSearchCol) = 0) Then iSearchCol = "S" ' T:����, S:����, C:����, U:�ۼ���
	if(Len(iSearchText) = 0) Then iSearchText = "" ' �˻���

  iType = "2"                      ' 1:��ȸ, 2:�Ѱ���

  LSQL = "EXEC Community_Board_Search_STR '" & NowPage & "','" & PagePerData & "','" & BlockPage & "','" & iType & "','" & iDivision & "','" & iSearchCol & "','" & iSearchText & "','" & iSubType & "','" & iTemp & "','" & iLoginID & "'"
	'response.Write "LSQL="&LSQL&"<br>"
  'response.End
  
  Set LRs = DBCon4.Execute(LSQL)
  If Not (LRs.Eof Or LRs.Bof) Then
		Do Until LRs.Eof
        iTotalCount = LRs("TOTALCNT")
        iTotalPage = LRs("TOTALPAGE")
      LRs.MoveNext
		Loop
	End If
  LRs.close
%>

  <script type="text/javascript">

    var selSearchValue = "<%=iSearchCol%>";
    var txtSearchValue = "<%=iSearchText%>";

    function WriteLink(i2) {

      post_to_url('./Community_Photo_Write.asp', { 'i2': i2, 'iType': '1' });

    }

    function ReadLink(i1, i2) {
      //location.href = 'cmRead.asp?i1=' + i1 + '&i2=' + i2;
      //post_to_url('./cmRead.asp', { 'i1': i1, 'i2': i2 });

      //./Community_Motion_Read.asp

      //alert(i1 + " , " + i2);
      post_to_url('./Community_Photo_Write.asp', { 'i1': i1, 'i2': i2, 'iType': '2' });
    }

    function PagingLink(i2) {

      //location.href = 'cmList.asp?i2=' + i2;
      post_to_url('./Community_Photo_List.asp', { 'i2': i2, 'iSearchCol': selSearchValue, 'iSearchText': txtSearchValue });
    }

    function fn_selSearch() {

      selSearchValue = document.getElementById('selSearch').value;
      txtSearchValue = document.getElementById('txtSearch').value;

      post_to_url('./Community_Photo_List.asp', { 'i2': 1, 'iSearchCol': selSearchValue, 'iSearchText': txtSearchValue });
    }

  </script>


   <section>
    <div id="content">

		<!-- S: �׺���̼� -->
		<div	class="navigation_box">
			Ŀ�´�Ƽ > ������ > ���䰶����
		</div>
		<!-- E: �׺���̼� -->
    <div class="search_top community">
			<div class="search_box">
				<select id="selSearch" name="selSearch" class="title_select">
					<option value="S">����</option>
					<option value="U">�ۼ���</option>
				</select>
				<input type="text" id="txtSearch" name="txtSearch" class="title_input in_2"/>
			 <a href="javascript:;" id="btnselSearch" name="btnselSearch" onclick="javascript:fn_selSearch();" class="btn_skyblue">�˻�</a>
			</div>
      <div class="btn_list right">
        <!--<input type="button" id="btnselSearch" name="btnselSearch" value="�˻�" onclick="javascript:fn_selSearch();" />-->
		  </div>
      <br />
     <!-- 
        S : ���� ����
     -->
    <table class="table-list">
      <caption>��ȸ ����Ʈ</caption>
      <colgroup>
        <col width="*" />
        <col width="*" />
        <col width="*" />
        <col width="*" />
        <col width="*" />
        <col width="*" />
      </colgroup>
      <thead>
        <tr>
          <th scope="col">����</th>         
          <th scope="col">�ۼ���</th>
          <th scope="col">����</th>
          <th scope="col">�ۼ���</th>
        </tr>
      </thead>
      <tbody id="gametitlelist">
          <%
            ' ����Ʈ ��ȸ
            iType = "1"

            LSQL = "EXEC Community_Board_Search_STR '" & NowPage & "','" & PagePerData & "','" & BlockPage & "','" & iType & "','" & iDivision & "','" & iSearchCol & "','" & iSearchText & "','" & iSubType & "','" & iTemp & "','" & iLoginID & "'"
	          'response.Write "LSQL="&LSQL&"<br>"
            'response.End
  
            Set LRs = DBCon4.Execute(LSQL)
										
            If Not (LRs.Eof Or LRs.Bof) Then
		          Do Until LRs.Eof
                  LCnt = LCnt + 1
        %>
        <tr style="cursor:pointer" onclick="javascript:ReadLink('<%=encode(LRs("MSeq"),0) %>','<%=NowPage %>');">
          <td><%=LRs("Num") %></td>
          <td><%=LRs("Name") %></td>
          <td class="name"><%=LRs("Subject") %></td>
          <td><%=LRs("InsDateCv") %></td>
        </tr>
        <%
			        LRs.MoveNext
		        Loop
        %>

        <%
						Else
				%>
					<!--�Խ��ǿ� �����Ͱ� ���� ���-->
				<tr>
					<td colspan="4">
							<div>��ϵ� �Խù��� �����ϴ�.</div>
						</td>
				</tr>
        <%
          End If
  
          LRs.close
  
          JudoKorea_DBClose()
        %>

      </tbody>
    </table>

    <%
			if LCnt > 0 then
		%>
      <!--#include file="../dev/dist/judoPaging_Admin.asp"-->
		<%
			End If
		%>

    <!-- E : ���� ���� -->
    <div class="btn_list right">
			<a href="javascript:;" onclick="javascript:WriteLink('<%=NowPage %>');" class="btn_skyblue"><span class="icon_pen">�۾���</span></a>
		</div>


    </div>
  <section>

    <script type="text/javascript">

      $("#txtSearch").val(txtSearchValue);
      $("#selSearch").val(selSearchValue);

    </script>
<!--#include file="footer.asp"-->
