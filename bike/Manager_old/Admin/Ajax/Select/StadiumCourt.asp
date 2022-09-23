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

Dim DEC_StadiumIDX

CMD = Request("CMD")
GameTitleIDX = Request("GameTitleIDX")
GameDay = Request("GameDay")
StadiumIDX = Request("StadiumIDX")

DEC_GameTitleIDX = fInject(crypt.DecryptStringENC(GameTitleIDX))
DEC_GameDay = fInject(GameDay)
DEC_StadiumIDX = fInject(crypt.DecryptStringENC(StadiumIDX))

Set oJSONoutput = jsArray()


LSQL = " SELECT StadiumNum"
LSQL = LSQL & " FROM "
LSQL = LSQL & " ("
LSQL = LSQL & " SELECT StadiumNum"
LSQL = LSQL & " FROM KoreaBadminton.dbo.tblTourney A"
LSQL = LSQL & " INNER JOIN KoreaBadminton.dbo.tblGameTitle B ON B.GameTitleIDX = A.GameTitleIDX "
LSQL = LSQL & " WHERE A.DelYN = 'N'"
LSQL = LSQL & " AND B.DelYN = 'N'"
LSQL = LSQL & " AND A.GameTitleIDX = '" & DEC_GameTitleIDX & "'"
LSQL = LSQL & " AND A.GameDay = '" & DEC_GameDay & "'"
LSQL = LSQL & " AND A.StadiumIDX = '" & DEC_StadiumIDX & "'"
LSQL = LSQL & " AND ISNULL(A.StadiumNum,'') <> ''"
LSQL = LSQL & " "
LSQL = LSQL & " UNION ALL"
LSQL = LSQL & " "
LSQL = LSQL & " SELECT StadiumNum"
LSQL = LSQL & " FROM KoreaBadminton.dbo.tblTourneyTeam A"
LSQL = LSQL & " INNER JOIN KoreaBadminton.dbo.tblGameTitle B ON B.GameTitleIDX = A.GameTitleIDX "
LSQL = LSQL & " WHERE A.DelYN = 'N'"
LSQL = LSQL & " AND B.DelYN = 'N'"
LSQL = LSQL & " AND A.GameTitleIDX = '" & DEC_GameTitleIDX & "'"
LSQL = LSQL & " AND A.GameDay = '" & DEC_GameDay & "'"
LSQL = LSQL & " AND A.StadiumIDX = '" & DEC_StadiumIDX & "'"
LSQL = LSQL & " AND ISNULL(A.StadiumNum,'') <> ''"
LSQL = LSQL & " "
LSQL = LSQL & " ) AS AA"
LSQL = LSQL & " GROUP BY AA.StadiumNum"
LSQL = LSQL & " ORDER BY AA.StadiumNum"

Set LRs = Dbcon.Execute(LSQL)

If Not (LRs.Eof Or LRs.Bof) Then

    Set oJSONoutput = jsArray()

	Do Until LRs.Eof

		Set oJSONoutput(NULL) = jsObject()

		oJSONoutput(Null)("StadiumNum") = LRs("StadiumNum")

	
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