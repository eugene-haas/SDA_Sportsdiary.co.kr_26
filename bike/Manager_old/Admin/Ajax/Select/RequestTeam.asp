<!-- #include file="../../dev/dist/config.asp"-->
<!-- #include file="../../classes/JSON_2.0.4.asp" -->
<!-- #include file="../../classes/JSON_UTIL_0.1.1.asp" -->
<!-- #include file="../../classes/json2.asp" -->
<script language="Javascript" runat="server">
function hasown(obj,  prop){
	if (obj.hasOwnProperty(prop) == true){
		return "ok";
	}
	else{
		return "notok";
	}
}

</script>
<%

Dim LSQL
Dim LRs
Dim strjson
Dim strjson_sum

Dim oJSONoutput_SUM
Dim oJSONoutput

Dim CMD  
Dim GameTitleIDX 

REQ = Request("Req")
'REQ = "{""CMD"":1,""GameTitleIDX"":""0B5EB9CEFAF1E107711072C78C2E36F8"",""GroupGameGb"":""F9A43D4DE4191C125B08095CC465CD4B"",""PlayType"":""9313C11726C4F47D4859E9CC91CA6DAA|A932F76713F8A9728D92A52C4795E4B7"",""TeamGb"":""2F9A5AB5A680D3EDDEE944350E247FCB"",""Level"":""13C75B262D4231E234F8EBBA4A58E54E|E957A65AA606B07B84BB4FB0AAD1EA4D|""}"
'REQ = "{""CMD"":2,""GameLevelDtlIDX"":""956""}"
Set oJSONoutput = JSON.Parse(REQ)

If hasown(oJSONoutput, "GameLevelDtlIDX") = "ok" then
    If ISNull(oJSONoutput.GameLevelDtlIDX) Or oJSONoutput.GameLevelDtlIDX = "" Then
      GameLevelDtlIDX = ""
      DEC_GameLevelDtlIDX = ""
    Else
      GameLevelDtlIDX = fInject(oJSONoutput.GameLevelDtlIDX)
      'DEC_GameLevelDtlIDX = fInject(crypt.DecryptStringENC(oJSONoutput.GameLevelDtlIDX))    
      DEC_GameLevelDtlIDX = fInject(oJSONoutput.GameLevelDtlIDX)    
    End If
  Else  
    GameTitleIDX = ""
    DEC_GameTitleIDX = ""
End if	

LSQL = "SELECT A.GameTitleIDX, A.TeamGb, A.Sex, B.Level, B.LevelDtlName, A.GroupGameGb,"
LSQL = LSQL & " B.TotRound, B.GameType,"
LSQL = LSQL & "  CASE WHEN TotRound = '512' THEN '9' "
LSQL = LSQL & "  WHEN TotRound = '256' THEN '8' "
LSQL = LSQL & "  WHEN TotRound = '128' THEN '7' "
LSQL = LSQL & "  WHEN TotRound = '64' THEN '6' "
LSQL = LSQL & "  WHEN TotRound = '32' THEN '5' "
LSQL = LSQL & "  WHEN TotRound = '16' THEN '4' "
LSQL = LSQL & "  WHEN TotRound = '8' THEN '3' "
LSQL = LSQL & "  WHEN TotRound = '4' THEN '2' "
LSQL = LSQL & "  WHEN TotRound = '2' THEN '1' "
LSQL = LSQL & "  Else '0' END AS GangCnt"
LSQL = LSQL & " FROM KoreaBadminton.dbo.tblGameLevel A"
LSQL = LSQL & " INNER JOIN KoreaBadminton.dbo.tblGameLevelDtl B ON A.GameLevelidx = B.GameLevelIDX"
LSQL = LSQL & " WHERE A.DelYN = 'N'"
LSQL = LSQL & " AND B.DelYN = 'N'"
LSQL = LSQL & " AND GameLevelDtlidx = '" & DEC_GameLevelDtlIDX & "'"

Set LRs = Dbcon.Execute(LSQL)

If Not (LRs.Eof Or LRs.Bof) Then
    GroupGameGb = LRs("GroupGameGb")
    TotRound = LRs("TotRound")
    GangCnt = LRs("GangCnt")
    GameType = LRs("GameType")
	
End If

LRs.Close


Call oJSONoutput.Set("TotRound", TotRound )
Call oJSONoutput.Set("GroupGameGb", GroupGameGb )
Call oJSONoutput.Set("GameType", GameType )

strjson = JSON.stringify(oJSONoutput)
Response.Write strjson
Response.write "`##`"


LSQL = " SELECT A.GameRequestTeamIDX, dbo.FN_NameSch(Team,'Team') AS TeamNM, Team, Teamdtl, CASE WHEN TeamDtl = '0' THEN '' ELSE TeamDtl END TeamDtlNM"
LSQL = LSQL & " FROM dbo.tblGameRequestTeam A"
LSQL = LSQL & " INNER JOIN dbo.tblGameRequestTouney B ON B.RequestIDX = A.GameRequestTeamIDX"
LSQL = LSQL & " WHERE A.DelYN = 'N'"
LSQL = LSQL & " AND B.DelYN = 'N'"
LSQL = LSQL & " AND B.GroupGameGb = 'B0030002'"
LSQL = LSQL & " AND B.GameLevelDtlIDX = '" & DEC_GameLevelDtlIDX & "'"

%>

<%
Set LRs = Dbcon.Execute(LSQL)

If Not (LRs.Eof Or LRs.Bof) Then

    strNum = 0

	Do Until LRs.Eof

    strNum = strNum + 1
%>

    <tr>
        <td><%=strNum%></td>
        <td>
        <%
            trim_TeamNM = REPLACE(LRs("TeamNM")," ","")
        %>
            [<%=LRs("GameRequestTeamIDX")%>]
            <a href='#' class='btn btn-player-sel' onclick=cli_Request("<%=trim_TeamNM%>","","<%=LRs("GameRequestTeamIDX")%>")>
            <%=LRs("TeamNM") & LRs("TeamDtlNM")%>
        
            </a>
        </td>
    </tr>
<%
	    LRs.MoveNext
	Loop

Else

End If
%>


<%
LRs.Close


Set LRs = Nothing
DBClose()
  
%>

<script>
	var $windowHeight = $(window).height(); /* ????????? ?????? */
	var $rightTable = $(".operate .tourney-container .scroll_box");
	var $Gameoperation =$(".Game_operation").outerHeight(true);
	var $tableHead = $(".content-wrap.operate .table-head").outerHeight(true);
	var $operateMatch = $(".operate .match_sel").outerHeight(true);
	$rightTable.css("height",$windowHeight - $Gameoperation - $tableHead - $operateMatch -30);

</script>

