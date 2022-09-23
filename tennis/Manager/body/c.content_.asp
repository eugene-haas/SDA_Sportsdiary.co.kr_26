<!-- #include virtual = "/pub/fn/fn_bbs_select.asp" -->
<!-- #include virtual = "/pub/fn/fn.paging.asp" -->

<%
 'Controller ################################################################################################

  'request ó��##############
  page = chkInt(chkReqMethod("page", "GET"), 1)
  search_word = chkLength(chkStrRpl(chkReqMethod("search_word", ""), ""), 10) 'chkStrReq ���� chkStrRpl replace
  search_first = chkInt(chkReqMethod("search_first", "POST"), 0)

  page = iif(search_first = "1", 1, page)
  'request ó��##############

  'ConStr = Replace(ConStr, "ITEMCENTER", "itemcenter_test")
  Set db = new clsDBHelper

	  intPageNum = page
	  intPageSize = 20
	  strTableName = " sd_TennisTitle "
	  'stateNo = ���ӻ��� 0ǥ����, 3 ��������ǥ���� , 4 ������������, 5 ��������ǥ���� , 6 ������������ , 7 �����ǥ����
	  strFieldName = " GameTitleIDX,gameTitleName,GameS,GameE,GameYear,cfg,GameRcvDateS,GameRcvDateE,ViewYN,MatchYN,viewState,stateNo,titlecode,titlegrade "

	  strSort = "  order by GameS desc"
	  strSortR = "  order by GameS"

	  'search
	  If chkBlank(search_word) Then
		strWhere = " DelYN = 'N' "
	  Else
		strWhere = " DelYN = 'N' and GameTitleIDX = " & tid
		page_params = "&search_word="&search_word
	  End if
  
  
  If CDbl(ADGRADE) > 500 then
	  Dim intTotalCnt, intTotalPage
	  Set rs = GetBBSSelectRS( ConStr, strTableName, strFieldName, strWhere, intPageSize, intPageNum, intTotalCnt, intTotalPage )

	  block_size = 10
	Else
	  SQL = "select " & strFieldName & " from " & strTableName & " where " & strWhere & " and GameE >= getdate() -30 " & strSort
	  Set rs = db.ExecSQLReturnRS(SQL , null, ConStr)
	End if

  '��ȸ����
  SQL = "Select hostname from tblGameHost where DelYN = 'N' "
  Set rst = db.ExecSQLReturnRS(SQL , null, ConStr)

  If Not rst.EOF Then 
    arrRS = rst.GetRows()
  End If
  

  '��ȸ�׷�/���
  SQL = "Select titleCode,titleGrade,hostTitle,idx from sd_TennisTitleCode where  DelYN = 'N' "
  Set rsg = db.ExecSQLReturnRS(SQL , null, ConStr)

  If Not rsg.EOF Then 
    arrRSG = rsg.GetRows()
  End if
%>
<%'View ####################################################################################################%>


		<!-- s: ������ ���� -->
		<div class="admin_content">
			<div class="page_title"><h1>��ȸ���� (sd_TenisTitle)</h1></div>

			<%If CDbl(ADGRADE) > 500 then%>
			<!-- s: ���� �˻� -->
				<div class="info_serch" id="gameinput_area">
				  <!-- #include virtual = "/pub/html/tennisAdmin/gameinfoform.asp" -->
				</div>
			<!-- e: ���� �˻� -->

			<!-- s: ����Ʈ ��ư -->
				<div class="list_btn">
					<a href="#" class="blue_btn" id="btnsave" onclick="mx.input_frm();" accesskey="i">���<span>(I)</span></a>
					<a href="#" class="blue_btn" id="btnupdate" onclick="mx.update_frm();" accesskey="e">����<span>(E)</span></a>
					<a href="#" class="pink_btn" id="btndel" onclick="mx.del_frm();" accesskey="r">����<span>(R)</span></a>
				</div>
			<!-- e: ����Ʈ ��ư -->
			<%End if%>


			<!-- s: ���̺� ����Ʈ -->
				<div class="table_list contest">
					<table cellspacing="0" cellpadding="0">
						<tr>
						<%If CDbl(ADGRADE) > 500 then%>
							<%If USER_IP = "118.33.86.240" then%>
							<th>��ȣ</th><th>��ȸ��</th><th>�Ⱓ</th><th>����</th><th>VACC</th><th>�䰭</th><th>��</th>
							<%else%>
							<th>��ȣ</th><th>��ȸ��</th><th>�Ⱓ</th><th>����</th><th>�䰭</th><th>��</th>
							<%End if%>
						<%Else%>
							<th>��ȣ</th><th>��ȸ��</th><th>�Ⱓ</th></thead>
						<%End if%>
						</tr>
						<tbody id="contest">
						<%
						Do Until rs.eof
							idx = rs("GameTitleIDX")
							title = rs("gameTitleName")
							sdate = rs("GameS")
							edate = rs("GameE")
							gamecfg = rs("cfg")
							rcvs = rs("GameRcvDateS")
							rcve = rs("GameRcvDateE")

							ViewYN = rs("ViewYN")
							MatchYN = rs("stateNo")
							viewState = rs("viewState")
							Select Case MatchYN '���ӻ��� 0ǥ����, 3 ��������ǥ���� , 4 ������������, 5 ��������ǥ���� , 6 ������������ , 7 �����ǥ����
							Case "0" : MatchYN = "<span class='blue_font'>�̳���</span>"
							Case "3" : MatchYN = "<span class='orange_font'>��������</span>"
							Case "4" : MatchYN = "��������"
							Case "5" : MatchYN = "��������"
							Case "6" : MatchYN = "��������"
							Case "7" : MatchYN = "�������"
							End Select


							titleCode = rs("titleCode")
							titleGrade = findGrade(rs("titleGrade"))
							%>
							  <!-- #include virtual = "/pub/html/tennisAdmin/gameinfolist.asp" -->
						  <%
						  rs.movenext
						  Loop
						  Set rs = Nothing
						%>
						</tbody>
					</table>
				</div>
			<!-- e: ���̺� ����Ʈ -->

			<%If CDbl(ADGRADE) > 500 then%>			
			<!-- s: ������ ��ư -->
			<%If nextrowidx <> "_end" then%>
			<div class="more_btn">
				<a href="javascript:mx.contestMore()">������</a>
			</div>
			<%End if%>
			<!-- e: ������ ��ư -->
			<%End if%>
		</div>
		<!-- s: ������ �� -->