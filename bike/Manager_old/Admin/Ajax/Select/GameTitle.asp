<!-- #include file="../../dev/dist/config.asp"-->
<!-- #include file="../../classes/JSON_2.0.4.asp" -->
<!-- #include file="../../classes/JSON_UTIL_0.1.1.asp" -->
<!-- #include file="../../classes/json2.asp" -->
<%
'<!-- include file="../Library/json2.asp" -->
Dim LSQL
Dim LRs
Dim strjson
Dim strjson_sum

Dim oJSONoutput_SUM
Dim oJSONoutput

Dim CMD  
Dim GameTitleIDX 
Dim GameYear

Dim DEC_GameTitleIDX 
Dim DEC_GameYear

CMD = Request("CMD")
GameTitleIDX = Request("GameTitleIDX")
GameYear = Request("GameYear")

DEC_GameTitleIDX = fInject(crypt.DecryptStringENC(GameTitleIDX))

If GameYear <> "" Then
    DEC_GameYear = fInject(GameYear)
End If

Set oJSONoutput = jsArray()

'��ȸ��� ����
LSQL = " SELECT GameTitleIDX, GameTitleName"
LSQL = LSQL & " FROM tblGameTitle "
LSQL = LSQL & " WHERE DelYN = 'N'"

If DEC_GameYear <> "" Then
    LSQL = LSQL & " AND LEFT(GameS,4) = '" & DEC_GameYear & "'"    
End If

Set LRs = Dbcon.Execute(LSQL)

If Not (LRs.Eof Or LRs.Bof) Then

    Set oJSONoutput = jsArray()

	Do Until LRs.Eof

		Set oJSONoutput(NULL) = jsObject()

		oJSONoutput(Null)("GameTitleIDX") = crypt.EncryptStringENC(LRs("GameTitleIDX"))
        oJSONoutput(Null)("GameTitleName") = LRs("GameTitleName")
	

	  LRs.MoveNext
	Loop

	strjson =  toJSON(oJSONoutput)

Else

End If

Set oJSONoutput_SUM = jsArray()
Set oJSONoutput_SUM = jsObject()

oJSONoutput_SUM("CMD") = CMD
oJSONoutput_SUM("TYPE") = "JSON"
oJSONoutput_SUM("RESULT") = strjson

strjson_sum = toJSON(oJSONoutput_SUM)

Response.Write strjson_sum


LRs.Close
Set LRs = Nothing
DBClose()
  
%>