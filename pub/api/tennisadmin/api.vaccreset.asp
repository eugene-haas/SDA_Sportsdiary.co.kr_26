<%
'#############################################
'���¹�ȯ
'#############################################

	Dim rpointChk, endYN, titleidx, returnCount
	
	If hasown(oJSONoutput, "IDX") = "ok" then
		titleidx = oJSONoutput.IDX
	End If

	result = 0	
	returnCount = 0

	If titleIDX <> "" then
		Set db = new clsDBHelper

		'ranking point ���� ���� Ȯ��
		strtable = " sd_TennisRPoint_log "
		strwhere = " where titleIDX = " & titleIDX 
		SQL1 = "select COUNT(*) from " & strtable & strwhere
		Set rs = db.ExecSQLReturnRS(SQL1 , null, ConStr)
		If CDbl(rs(0)) > 0 Then
			rpointChk = "Y"
		Else
			rpointChk = "N"
		End If

		'�����ڰ� ����� ���� �������� ���� ��¥�� ��, ���ؼ� ���ᳯ¥ ���ĸ� Y, �������̸� N
		strtable2 = " sd_TennisTitle "
		strfield = " GameE "
		strwhere = " where GameTitleIDX = " & titleIDX
		SQL2 = "select " & strfield & " from " & strtable2 & strwhere
		Set rs2 = db.ExecSQLReturnRS(SQL2 , null, ConStr)
		
		If rs2(0) < Date() Then
			endYN = "Y"
		Else 
			endYN = "N"
		End If
		
		'��ŷ����Ʈ �ݿ�����, ���������� �ΰ������� �����ϸ� ������Ʈ
		If endYN = "Y" AND rpointChk = "Y" Then

			strtable = "  dbo.TB_RVAS_MAST"
			strtablesub = " dbo.tblGameRequest "
			strwhere = " CUST_CD IN ( select requestIDX from " & strtablesub & " where GameTitleIDX= " & titleIDX & " ) "
			strfield = "  CUST_CD, CUST_NM,USER_NM, ENTRY_DATE, ENTRY_IDNO, SEND_TYPE "
			updatefield = " CUST_CD = NULL , CUST_NM = NULL,USER_NM= NULL, ENTRY_DATE = NULL, ENTRY_IDNO = NULL, SEND_TYPE = NULL "

			SQL3 = " select count(*) from  "  & strtable & " where " & strwhere
			Set rs3 = db.ExecSQLReturnRS(SQL3 , null, ConStr)
			returnCount = rs3(0)
			


			SQL4 = "update " & strtable & " set " & updatefield & " where " & strwhere			


'			Response.Write SQL4
'			Response.End

			Call db.ExecSQL(SQL4, null, ConStr)

			SQL5 = " update sd_TennisTitle set vacReturnYN = 'Y' where GameTitleIDX=" & titleIDX
			Call db.ExecSQL(SQL5, null, ConStr)

		End If

		db.dispose
		Set rs = nothing
		Set rs2 = nothing


	End If


	
	Call oJSONoutput.Set("result", result )
	Call oJSONoutput.Set("rpointChk", rpointChk )
	Call oJSONoutput.Set("endYN", endYN )
	Call oJSONoutput.Set("returnCount", returnCount )
	strjson = JSON.stringify(oJSONoutput)
	Response.Write strjson



%>