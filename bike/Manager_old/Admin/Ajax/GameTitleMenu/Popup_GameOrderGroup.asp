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
  'REQ = "{""CMD"":5,""tGameLevelDtlIDX"":""D699A4D046D9389A5B28ACBEC4075BBD"",""tTeamGameNum"":""1"",""tGameNum"":""0""}"
  Set oJSONoutput = JSON.Parse(REQ)

  If hasown(oJSONoutput, "tGameLevelDtlIDX") = "ok" then
    GameLevelDtlIDX = fInject(oJSONoutput.tGameLevelDtlIDX)
    DEC_GameLevelDtlIDX = fInject(crypt.DecryptStringENC(oJSONoutput.tGameLevelDtlIDX))
  Else  
    GameLevelDtlIDX = ""
    DEC_GameLevelDtlIDX = ""
  End if	

	If hasown(oJSONoutput, "tTeamGameNum") = "ok" then
    If ISNull(oJSONoutput.tTeamGameNum) Or oJSONoutput.tTeamGameNum = "" Then
      TeamGameNum = ""
      DEC_TeamGameNum = ""
    Else
      TeamGameNum = fInject(oJSONoutput.tTeamGameNum)
      DEC_TeamGameNum = fInject(crypt.DecryptStringENC(oJSONoutput.tTeamGameNum))    
    End If
  Else  
    TeamGameNum = ""
    DEC_TeamGameNum = ""
	End if	

	If hasown(oJSONoutput, "tGameNum") = "ok" then
    If ISNull(oJSONoutput.tGameNum) Or oJSONoutput.tGameNum = "" Then
      tGameNum = ""
      DEC_tGameNum = ""
    Else
      tGameNum = fInject(oJSONoutput.tGameNum)
      DEC_tGameNum = fInject(crypt.DecryptStringENC(oJSONoutput.tGameNum))    
    End If
  Else  
    tGameNum = ""
    DEC_tGameNum = ""
	End if	


  LSQL = " SELECT A.Team AS LTeam, A.TeamDtl AS LTeamDtl, B.Team AS RTeam, B.TeamDtl AS RTeamDtl,"
  LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(A.Team,'Team') AS LTeamNM, "
  LSQL = LSQL & " KoreaBadminton.dbo.FN_NameSch(B.Team,'Team') AS RTeamNM,"
  LSQL = LSQL & " D.GameLevelIDX"
  
  LSQL = LSQL & " FROM tblTourneyTeam A"
  LSQL = LSQL & " INNER JOIN tblTourneyTeam B ON B.GameLevelDtlidx = A.GameLevelDtlidx AND B.TeamGameNum = A.TeamGameNum"
  LSQL = LSQL & " INNER JOIN tblGameLevelDtl C ON C.GameLevelDtlidx = A.GameLevelDtlidx"
  LSQL = LSQL & " INNER JOIN tblGameLevel D ON D.GameLevelidx = C.GameLevelidx"
  LSQL = LSQL & " LEFT JOIN ("
  LSQL = LSQL & "   SELECT GameLevelDtlidx, TeamGameNum, GameNum, Team, TeamDtl, Result, Jumsu"
  LSQL = LSQL & "   FROM KoreaBadminton.dbo.tblGroupGameResult"
  LSQL = LSQL & "   WHERE DelYN = 'N'"
  LSQL = LSQL & "   ) AS E ON E.GameLevelDtlidx = A.GameLevelDtlidx AND E.TeamGameNum = A.TeamGameNum AND E.Team + E.TeamDtl = A.Team + A.TeamDtl"
  LSQL = LSQL & " WHERE A.DelYN = 'N'"
  LSQL = LSQL & " AND B.DelYN = 'N'"
  LSQL = LSQL & " AND C.DelYN = 'N'"
  LSQL = LSQL & " AND D.DelYN = 'N'"
  LSQL = LSQL & " AND A.ORDERBY < B.ORDERBY"
  LSQL = LSQL & " AND A.GameLevelDtlIDX  = '" & DEC_GameLevelDtlIDX & "'"
  LSQL = LSQL & " AND A.TeamGameNum = '" & TeamGameNum & "'"


  Set LRs = Dbcon.Execute(LSQL)

  If Not (LRs.Eof Or LRs.Bof) Then
    LTeam = LRs("LTeam")
    LTeamDtl = LRs("LTeamDtl")
    LTeamNM = LRs("LTeamNM")
    RTeam = LRs("RTeam")
    RTeamDtl = LRs("RTeamDtl")
    RTeamNM = LRs("RTeamNM")
    GameLevelIDX = LRs("GameLevelIDX")
  End If

  LRs.Close

  strjson = JSON.stringify(oJSONoutput)
  Response.Write strjson
  Response.write "`##`"
  'Response.Write "<BR/>LSQL : " & LSQL & "<BR/>"
%>
  <!-- S: modal-body -->
  <div class="modal-body">
    <!-- S: order-header -->
    <div class="order-header clearfix">
      <!-- S: team team-a -->
      <div class="team team-a">
        <!-- S: table -->
        <table class="table">
          <thead>
            <tr>
              <th class="belong">??????</th>
              <!--<th>??????</th>-->
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>
                <span><%=LTeamNM%>
                <%
                  If LTeamDtl <> "0" Then
                    Response.Write LTeamDtl
                  End If
                %>
                </span>
                <!--
                /
                <span>??????</span>
                -->
              </td>
              <!--<td>
                
                <span>?????????</span> /
                <span>?????????</span>
                
              </td>
              -->
            </tr>
          </tbody>
        </table>
        <!-- E: table -->
      </div>
      <!-- E: team team-a --> 
      <!-- S: vs -->
      <div class="vs">
        <img src="../../images/modal/vs_img.png" alt="vs">
      </div>
      <!-- E: vs -->  
      <!-- S: team team-b -->
      <div class="team team-b">
        <!-- S: table -->
        <table class="table">
          <thead>
            <tr>
              <!--<th>??????</th>-->
              <th class="belong">??????</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <!--<td>
                
                <span>?????????</span> /
                <span>?????????</span>
                
              </td>
              -->
              <td>
                <span>
                <%=RTeamNM%>
                <%
                  If RTeamDtl <> "0" Then
                    Response.Write RTeamDtl
                  End If
                %>                
                </span>
                <!--
                /
                <span>??????</span>
                -->
              </td>
            </tr>
          </tbody>
        </table>
        <!-- E: table -->
      </div>
      <!-- E: team team-b -->
    </div>
    <!-- E: order-header -->  
    <!-- S: order-body -->
    <div class="order-body clearfix">
      <!-- S: group group-a -->
      <div class="group group-a">
        <!-- S: table table-fix-header -->
        <table class="table table-fix-header">
          <tbody>
            <tr>
              <th>?????????</th>
              <th class="sel">??????</th>
            </tr>
          </tbody>
        </table>
        <!-- E: table table-fix-header -->  
        <!-- S: scroll-box -->
        <div class="scroll-box">
          <!-- S: table table-body -->
          <table class="table table-body">
            <tbody>
          
              <%
       
                '?????? ????????? ?????? SELECT
                'LSQL = " SELECT C.GameRequestPlayerIDX ,C.MemberName, C.MemberIDX, B.GameLevelDtlIDX, C.Team , C.TEamdtl, D.TorneyTeamTempIDX"
                'LSQL = LSQL & " FROM tblGameRequestTeam A"
                'LSQL = LSQL & " INNER JOIN tblGameRequestTouney B ON B.RequestIDX = A.GameRequestTeamIDX "
                'LSQL = LSQL & " INNER JOIN tblGameRequestPlayer C ON C.GameRequestTeamIDX = A.GameRequestTeamIDX"
                'LSQL = LSQL & " INNER JOIN tblGameLevelDtl E ON E.GameLevelDtlIDX = B.GameLevelDtlIDX"
                'LSQL = LSQL & " LEFT JOIN "
                'LSQL = LSQL & "   ("
                'LSQL = LSQL & "   SELECT GameRequestPlayerIDX, GameLevelDtlidx, TorneyTeamTempIDX "
                'LSQL = LSQL & "   FROM tblTorneyTeamTemp"
                'LSQL = LSQL & "   WHERE DelYN = 'N'"
                'LSQL = LSQL & "   AND TeamGameNum = '" & TeamGameNum & "'"
                'LSQL = LSQL & "   AND GameLevelDtlIDX = '" & DEC_GameLevelDtlIDX & "'"
                'LSQL = LSQL & "   ) AS D ON D.GameLevelDtlidx = B.GameLevelDtlIDX AND D.GameRequestPlayerIDX = C.GameRequestPlayerIDX"
                'LSQL = LSQL & " WHERE A.DelYN = 'N'"
                'LSQL = LSQL & " AND B.DelYN = 'N'"
                'LSQL = LSQL & " AND C.DelYN = 'N'"
                'LSQL = LSQL & " AND E.DelYN = 'N'"
                ''LSQL = LSQL & " AND B.GameLevelDtlIDX = '" & DEC_GameLevelDtlIDX & "'"
                'LSQL = LSQL & " AND E.GameLevelIDX = '" & GameLevelIDX & "'"
                'LSQL = LSQL & " AND A.Team + A.TeamDtl = '" & LTeam & LTeamDtl & "'"
                'LSQL = LSQL & " AND B.GroupGameGb = 'B0030002'"     

                LSQL = " SELECT Distinct C.GameRequestPlayerIDX ,C.MemberName, C.MemberIDX, B.GameLevelDtlIDX, C.Team , C.TEamdtl, "
                LSQL = LSQL & " '' as TorneyTeamTempIDX "
                LSQL = LSQL & " FROM tblGameRequestTeam A "
                LSQL = LSQL & " INNER JOIN tblGameRequestTouney B ON B.RequestIDX = A.GameRequestTeamIDX "
                LSQL = LSQL & " INNER JOIN tblGameRequestPlayer C ON C.GameRequestTeamIDX = A.GameRequestTeamIDX "
                LSQL = LSQL & " INNER JOIN tblGameLevelDtl E ON E.GameLevelDtlIDX = B.GameLevelDtlIDX "
                LSQL = LSQL & " LEFT JOIN ( "
                LSQL = LSQL & " 	SELECT A.GameRequestPlayerIDX, A.GameLevelDtlidx, A.TorneyTeamTempIDX, B.GameLevelidx"
                LSQL = LSQL & " 	FROM tblTorneyTeamTemp A"
                LSQL = LSQL & " 	INNER JOIN tblGameLevelDtl B ON B.GameLevelDtlidx = A.GameLevelDtlidx "
                LSQL = LSQL & " 	WHERE A.DelYN = 'N' "
                LSQL = LSQL & " 	AND B.DelYN = 'N' "
                LSQL = LSQL & " 	AND A.TeamGameNum = '" & TeamGameNum & "' AND A.GameLevelDtlIDX = '" & DEC_GameLevelDtlIDX & "' 	"
                LSQL = LSQL & " 	) AS D ON D.GameLevelidx = E.GameLevelIDX AND D.GameRequestPlayerIDX = C.GameRequestPlayerIDX "
                LSQL = LSQL & " WHERE A.DelYN = 'N' AND B.DelYN = 'N' AND C.DelYN = 'N' AND E.DelYN = 'N' "
                LSQL = LSQL & " AND E.GameLevelIDX = '" & GameLevelIDX & "' AND A.Team + A.TeamDtl = '" & LTeam & LTeamDtl & "' AND B.GroupGameGb = 'B0030002'"                                          
                'Response.Write "<BR/>LSQL : " & LSQL & "<BR/>"

                Set LRs = Dbcon.Execute(LSQL)

                If Not (LRs.Eof Or LRs.Bof) Then

                  i = 0

                  Do Until LRs.Eof                   
              %>
                <tr>
                  <td><%=LRs("MemberName")%></td>
                  <td>
                    <!--btn btn-red-->
                    <!--btn btn-gray-->
                    <a href="#" class="btn btn-red" id="Btn_Player<%=i%>" onclick="OnWaitPlayerClick('<%=crypt.EncryptStringENC(LRs("GameRequestPlayerIDX"))%>');">??????</a>
                    <!--
                    <%If LRs("TorneyTeamTempIDX") = "" OR ISNULL(LRs("TorneyTeamTempIDX")) Then %>
                    <a href="#" class="btn btn-red" id="Btn_Player<%=i%>" onclick="OnWaitPlayerClick('<%=crypt.EncryptStringENC(LRs("GameRequestPlayerIDX"))%>');">??????</a>
                    <%Else%>
                    <a href="#" class="btn btn-red-empty" id="Btn_Player<%=i%>" onclick="OnWaitDeleteClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>','<%=crypt.EncryptStringENC(LRs("GameRequestPlayerIDX"))%>');">??????</a>
                    <%End If%>
                    -->
                  </td>
                </tr>                
              <%
                        i = i + 1
                        LRs.MoveNext            
                    Loop
                End If

                LRs.Close
              %>
            </tbody>
          </table>
          <!-- E: table table-body -->
        </div>
        <!-- E: scroll-box -->
      </div>
      <!-- E: group group-a --> 
      <!-- S: order-paper -->
      <div class="order-paper">
        <input type="hidden" id="SelectReqPlayerIDX" value="">
        <!-- S: arr-table -->
        <div class="arr-table">
          <!-- S: table-fix-header -->
          <table class="table-fix-header">
            <tbody>
              <tr>
                <th>No</th>
                <th colspan="2">?????????</th>
                <th colspan="2">??????</th>
                <th class="game-event">??????</th>
                <th colspan="2">??????</th>
                <th colspan="2">?????????</th>
              </tr>
            </tbody>
          </table>
          <!-- E: table-fix-header -->
        </div>
        <!-- E: arr-table --> 
        <!-- S: scroll-box -->
        <div class="scroll-box" id="DP_GroupPlayerList">
          <!-- S: table -->
          <table class="table">
            <tbody>
              <%
                '????????? ????????? ?????? ?????? ??????
                For i = 1 To 5 
              %>
              <tr>
                <td>
                <%=i+1%>
                </td>
                <td onclick="OnEmptyAreaClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>',<%=i%>,'1')" id="DP_LPlayerA_<%=i%>">
                </td>
                <td onclick="OnEmptyAreaClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>',<%=i%>,'2')" id="DP_LPlayerB_<%=i%>">
                
                </td>
                <td>-</td>
                <td>-</td>
                <td class="game-event">????????????</td>
                <td>-</td>
                <td>-</td>
                <td onclick="OnEmptyAreaClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>',<%=i%>,'1')" id="DP_RPlayerA_<%=i%>">
                
                </td>
                <td onclick="OnEmptyAreaClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>',<%=i%>,'2')" id="DP_RPlayerB_<%=i%>">
                
                </td>
              </tr>
              <%
                Next
              %>
              
              <!--
              <tr>
                <td>4</td>
                <td>
                  <img src="../../images/modal/ic_check.png" alt>
                </td>
                <td>
                  <img src="../../images/modal/ic_check.png" alt>
                </td>
                <td>-</td>
                <td>-</td>
                <td class="game-event">????????????</td>
                <td>-</td>
                <td>-</td>
                <td>?????????</td>
                <td>?????????</td>
              </tr>
              -->

            </tbody>
          </table>
          <!-- E: table -->
        </div>
        <!-- E: scroll-box -->  
        <!-- S: arr-table -->
        <div class="arr-table arr-footer">
          <!-- S: table-fix-footer -->
          <table class="table-fix-footer">
            <tbody>
              <tr class="total">
                <td>
                  <span class="ic-deco">
                    <i class="fas fa-angle-double-right"></i>
                  </span>
                </td>
                <td colspan="3">-</td>
                <td>-</td>
                <td class="text-bold">??????</td>
                <td>-</td>
                <td colspan="3">-</td>
              </tr>
            </tbody>
          </table>
          <!-- E: table-fix-footer -->
        </div>
        <!-- E: arr-table -->
      </div>
      <!-- E: order-paper --> 
      <!-- S: group group-b -->
      <div class="group group-b">
        <!-- S: table table-fix-header -->
        <table class="table table-fix-header">
          <tbody>
            <tr>
              <th>?????????</th>
              <th class="sel">??????</th>
            </tr>
          </tbody>
        </table>
        <!-- E: table table-fix-header -->  
        <!-- S: scroll-box -->
        <div class="scroll-box">
          <!-- S: table table-body -->
          <table class="table table-body">
            <tbody>
              <%
                '?????? ????????? ?????? SELECT
                LSQL = " SELECT Distinct C.GameRequestPlayerIDX ,C.MemberName, C.MemberIDX, B.GameLevelDtlIDX, C.Team , C.TEamdtl, "
                LSQL = LSQL & " '' as TorneyTeamTempIDX  "
                LSQL = LSQL & " FROM tblGameRequestTeam A "
                LSQL = LSQL & " INNER JOIN tblGameRequestTouney B ON B.RequestIDX = A.GameRequestTeamIDX "
                LSQL = LSQL & " INNER JOIN tblGameRequestPlayer C ON C.GameRequestTeamIDX = A.GameRequestTeamIDX "
                LSQL = LSQL & " INNER JOIN tblGameLevelDtl E ON E.GameLevelDtlIDX = B.GameLevelDtlIDX "
                LSQL = LSQL & " LEFT JOIN ( "
                LSQL = LSQL & " 	SELECT A.GameRequestPlayerIDX, A.GameLevelDtlidx, A.TorneyTeamTempIDX, B.GameLevelidx"
                LSQL = LSQL & " 	FROM tblTorneyTeamTemp A"
                LSQL = LSQL & " 	INNER JOIN tblGameLevelDtl B ON B.GameLevelDtlidx = A.GameLevelDtlidx "
                LSQL = LSQL & " 	WHERE A.DelYN = 'N' "
                LSQL = LSQL & " 	AND B.DelYN = 'N' "
                LSQL = LSQL & " 	AND A.TeamGameNum = '" & TeamGameNum & "' AND A.GameLevelDtlIDX = '" & DEC_GameLevelDtlIDX & "' 	"
                LSQL = LSQL & " 	) AS D ON D.GameLevelidx = E.GameLevelIDX AND D.GameRequestPlayerIDX = C.GameRequestPlayerIDX "
                LSQL = LSQL & " WHERE A.DelYN = 'N' AND B.DelYN = 'N' AND C.DelYN = 'N' AND E.DelYN = 'N' "
                LSQL = LSQL & " AND E.GameLevelIDX = '" & GameLevelIDX & "' AND A.Team + A.TeamDtl = '" & RTeam & RTeamDtl & "' AND B.GroupGameGb = 'B0030002'"                                          
                'Response.Write "<BR/>LSQL : " & LSQL & "<BR/>"
                Set LRs = Dbcon.Execute(LSQL)

                If Not (LRs.Eof Or LRs.Bof) Then
                  Do Until LRs.Eof                   
              %>
                <tr>
                  <td><%=LRs("MemberName")%></td>
                  <td>
                  <a href="#" class="btn btn-red" id="Btn_Player<%=i%>" onclick="OnWaitPlayerClick('<%=crypt.EncryptStringENC(LRs("GameRequestPlayerIDX"))%>');">??????</a>
                  <!--
                    <%If LRs("TorneyTeamTempIDX") = "" OR ISNULL(LRs("TorneyTeamTempIDX")) Then %>
                    <a href="#" class="btn btn-red" id="Btn_Player<%=i%>" onclick="OnWaitPlayerClick('<%=crypt.EncryptStringENC(LRs("GameRequestPlayerIDX"))%>');">??????</a>
                    <%Else%>
                    <a href="#" class="btn btn-red-empty" id="Btn_Player<%=i%>" onclick="OnWaitDeleteClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>','<%=crypt.EncryptStringENC(LRs("GameRequestPlayerIDX"))%>');">??????</a>
                    <%End If%> 
                    -->               
                  </td>
                </tr>                
              <%
                        LRs.MoveNext            
                    Loop
                End If
                LRs.Close
              %>            
            </tbody>
          </table>
          <!-- E: table table-body -->
        </div>
        <!-- E: scroll-box -->
      </div>
      <!-- E: group group-b -->
    </div>
    <!-- E: order-body -->  
    <!-- S: order-footer -->
    <div class="order-footer">
      <ul class="btn-list clearfix">
        <li><a href="#" class="btn btn-default" data-dismiss="modal">??????</a></li>
        <li><a href="#" class="btn btn-red" onclick="OnTeamTempCompleteClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>');">????????? ?????? ????????????</a></li>
        <!--<li><a href="#" class="btn btn-blue" onclick="OnGameOrderPaperClick('<%=GameLevelDtlIDX%>','<%=TeamGameNum%>');">??????</a></li>-->
       
      </ul>
    </div>
    <!-- E: order-footer -->
  </div>
  <!-- E: modal-body -->
<%

Set LRs = Nothing
DBClose()
  
%>