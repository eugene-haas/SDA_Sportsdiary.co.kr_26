
const Person_GroupGameGB = "B0030001"
const Group_GroupGameGB = "B0030002"
const One_PlayType = "B0020001"
const Twin_PlayType = "B0020002"
const constMan = "Man"
const constWoman = "Woman"

var mx = {};
mx.empty = "empty";
mx.EnterType = "";
mx.GroupGameGb = mx.empty;
mx.GroupGameGbName = "";

mx.TeamGb = mx.empty;
mx.TeamGbName = "";

mx.Level = mx.empty;
mx.LevelName = "";

mx.LevelJoo = mx.empty;
mx.LevelJooName = "";

mx.LevelJooNum = mx.empty;

mx.Sex= mx.empty;
mx.SexName= "";

mx.PlayType= mx.empty;
mx.PlayTypeName= "";

CMD_GAMELEVELMENU = 1;
CMD_SEARCHPLAYER = 2;
CMD_SEARCHTEAM = 3;
CMD_PARTICIPATEENTRYLIST = 4;
CMD_SELECTENTRYINFO = 5;
CMD_SELECTENTRY= 6;
CMD_CONFIRMENTRYINFO = 7;


CMD_INSERTENTRYINFO = 11;
CMD_INSERTPLAYER = 12;

CMD_DELETEENTRY = 21;

CMD_UPDATEENTRY = 31;


function OnReceiveAjax(CMD, dataType, htmldata, jsondata) {
  
  switch(CMD) {
    case CMD_GAMELEVELMENU:
    {
      $('#divGameLevelMenu').html(htmldata); 

      if (mx.GroupGameGb !=  jsondata.GroupGameGb && mx.GroupGameGb != mx.empty ) {
        $("#tab_" +  jsondata.GroupGameGb).addClass("on");
        $("#tab_" + mx.GroupGameGb).removeClass("on");
        $("#GroupGameGB").val(jsondata.GroupGameGb)
      }
      initData();
    }
    break;
    case CMD_PARTICIPATEENTRYLIST : 
    {
      $('#GameEntryListCnt').val(jsondata.TotalNum); 
      $('#tbodyGameEntry').html(htmldata); 
    }break;
   
   
    case CMD_SELECTENTRY :
    { 

      if(jsondata.result == 0 )
      {
        $('#EntryIDX').val(jsondata.EntryIdx);
        $("#txtPlayerSearch_Player1").val(jsondata.Player_UserName);
        $("#txtPlayerIDX_Player1").val(jsondata.Player_MemberIDX);
        $("#txtPlayerName_Player1").val(jsondata.Player_UserName);
        $("#txtBirthDay_Player1").val(jsondata.Player_BirthDay);
        
        $("#Phone_Player1").val(jsondata.Player_Phone1);
        $("#txtPlayerPhone_Player1").val(jsondata.Player_Phone2);

        $("#txtClubSearch_Player1").val(jsondata.Player_TeamName);
        $("#txtClubCode_Player1").val(jsondata.Player_Team);
        $("#txtClubName_Player1").val(jsondata.Player_TeamName);
        $("#Sido_Player1").val(jsondata.Player_Sido);
        $("#SiGugun_Player1").val(jsondata.Player_SidoGugun);


        if(jsondata.GroupGameGb == Group_GroupGameGB){

          document.getElementById("LIPlayer1").style.display = 'block';
        }
        else{
          document.getElementById("LIPlayer1").style.display = 'none';
        }
        
        $("#TeamDtlName").val(jsondata.TeamDtl);

        if (null == jsondata.Player_Sex) {
          var sid = $("#man_Player1");
          sid.attr('checked','checked');
          $("#sex_Man_Player1").removeClass("on");
          $("#sex_Woman_Player1").removeClass("on");
          $("#sex_Man_Player1").addClass("on");
        }
        else {
          if(jsondata.Player_Sex.toLowerCase() == "woman") {
            var sid = $("#woman_Player1");
            sid.attr('checked','checked');
            $("#sex_Man_Player1").removeClass("on");
            $("#sex_Woman_Player1").removeClass("on");
            $("#sex_Woman_Player1").addClass("on");
          }
          else {
            var sid = $("#man_Player1");
            sid.attr('checked','checked');
            $("#sex_Man_Player1").removeClass("on");
            $("#sex_Woman_Player1").removeClass("on");
            $("#sex_Man_Player1").addClass("on");
          }
        }

        

        $("#txtPlayerIDX_Player2").val(jsondata.Partner_MemberIDX);
        $("#txtPlayerSearch_Player2").val(jsondata.Partner_UserName);
        $("#txtPlayerName_Player2").val(jsondata.Partner_UserName);
        $("#txtBirthDay_Player2").val(jsondata.Partner_BirthDay);
        $("#Phone_Player2").val(jsondata.Partner_Phone1);
        $("#txtPlayerPhone_Player2").val(jsondata.Partner_Phone2);
        $("#txtClubSearch_Player2").val(jsondata.Partner_TeamName);
        $("#txtClubCode_Player2").val(jsondata.Partner_Team);
        $("#txtClubName_Player2").val(jsondata.Partner_TeamName);
        $("#Sido_Player2").val(jsondata.Partner_Sido);
        $("#SiGugun_Player2").val(jsondata.Partner_SidoGugun);

        //alert(jsondata.GameLevelIDX);
        OnGameTitleMenuGameLevelChanged(jsondata.GameLevelIDX)

        visibleButtonChanged();

        if (null == jsondata.Partner_Sex) {
          var sid = $("#man_Player2");
          sid.attr('checked','checked');
          $("#sex_Man_Player2").removeClass("on");
          $("#sex_Woman_Player2").removeClass("on");
          $("#sex_Man_Player2").addClass("on");
        }
        else{
          if(jsondata.Partner_Sex.toLowerCase() == "woman") {
            var sid = $("#woman_Player2");
            sid.attr('checked','checked');
            $("#sex_Man_Player2").removeClass("on");
            $("#sex_Woman_Player2").removeClass("on");
            $("#sex_Woman_Player2").addClass("on");
          }
          else {
            var sid = $("#man_Player2");
            sid.attr('checked','checked');
            $("#sex_Man_Player2").removeClass("on");
            $("#sex_Woman_Player2").removeClass("on");
            $("#sex_Man_Player2").addClass("on");
          }
        }
      

      }
    }break;
    case CMD_DELETEENTRY : {
      if(jsondata.result == 0 )
      {
        alert("?????? ??????")
      }
      else{
        alert("?????? ?????????????????? ???????????? ????????????.");
      }
      invisibleButtonChanged();
      AllClearPlayer();
    } break;
    case CMD_UPDATEENTRY :
    {
      if(jsondata.result == 0 ) {
        alert("???????????? ??????")  

        $('form[name=s_frm]').attr('action','./request_receive_A.asp');
        $('form[name=s_frm]').submit(); 

      }
      else if(jsondata.result == 1){
        alert("?????? ????????? ?????? ???????????????.");
      }
      else if(jsondata.result == 2){
        alert("?????? ????????? ?????? ???????????????.");
      }
      else if(jsondata.result == 3){
        alert("????????? ????????? ?????? ???????????????.");
      }
      else if(jsondata.result == 4){
        alert("???????????? ???????????? ??????????????????.");
      }
      else if(jsondata.result == 5){
        alert("??? ?????? ????????? ???????????? ????????????.");
      }
      else if(jsondata.result == 6){
        alert("????????? ????????? ???????????? ????????????.");
      }
      else if(jsondata.result == 7){
        alert("?????? ?????? ??????????????? ???????????????. ?????? ??????????????????.");
      }
      else if(jsondata.result == 8){
        alert("????????? ???????????? ?????? ????????? ?????? ????????????.");
      }
      else if(jsondata.result == 9){
        alert("?????? ????????? ???????????? ????????????.");
      }
      else if(jsondata.result == 10){
        alert("????????? ???????????? ????????????.");
      }
      else if(jsondata.result == 11){
        alert("????????? ?????? ????????? ????????? ????????? ??? ????????????.");
      }
      else if(jsondata.result == 12){
        alert("?????? ?????? ????????? ???????????? ??????.");
      }
      else if(jsondata.result == 13){
        alert("????????? ????????? ????????? ?????? ??? ????????????.");
      }
      else if(jsondata.result == 14){
        alert("????????? ????????? ????????? ????????? ????????? ????????????.");
      }
      else if(jsondata.result == 15){
        alert("????????? ????????? ????????? ????????? ?????? ?????? ????????? ?????????.");
      }     
      else if(jsondata.result == 17){
        alert("????????? ??????????????? ????????? 14?????? ?????? ??? ????????????.");
      }
      
      else{
        alert("??????????????? ???????????? ?????? ????????? ??????????????????.");
        console.log("?????????:" + jsondata.result);
      }
      invisibleButtonChanged();
    } break;
    default:
      //$(location).attr('href', 'http://badmintonadmin.sportsdiary.co.kr/Main/GameTitleMenu/index.asp')
  }
};

function visibleButtonChanged()
{
  $("#btnDeleteEntry").css("display","inline-block");
  $("#btnUpdateEntry").css("display","inline-block");
};
function invisibleButtonChanged()
{
  $("#btnDeleteEntry").css("display","none");
  $("#btnUpdateEntry").css("display","none");
};


function PartnerAreaChanged()
{
  if(mx.PlayType != One_PlayType) {
    var con = document.getElementById("divPlayer2");

    if (mx.GroupGameGb == Person_GroupGameGB) {
      con.style.display = 'block';
    }
    else {
      con.style.display = 'none';
    }
  }
  else{
    var con = document.getElementById("divPlayer2");
    if (mx.GroupGameGb == Person_GroupGameGB) {
      con.style.display = 'none';
    }
    else {
      con.style.display = 'none';
    }
  }
};

function DeleteEntry()
{
  var GameTitleIDX = $('#GameTitleIDX').val();
  var EntryInfoIdx = $('#EntryInfoIDX').val();
  var EntryIdx = $('#EntryIDX').val();
  Url = "/Entry/ajax/Participate_DeleteEntry.asp"
  var packet = {};
  packet.CMD = CMD_DELETEENTRY;
  packet.GameTitleIDX = GameTitleIDX;
  packet.EntryInfoIDX = EntryInfoIdx;
  packet.EntryIDX = EntryIdx;
  SendPacket(Url, packet);
};

OnGroupGameGbChanged = function(value,name,isValue)
{
  if (isValue == 0) {
    alert("[" + name +"]"+" ??? ??????????????? ????????????");
    return;
  }
  if (value !=  mx.GroupGameGb ) {
    $("#tab_" + value).addClass("on");
    $("#tab_" + mx.GroupGameGb).removeClass("on");
  }
  mx.GroupGameGb = value;
  mx.GroupGameGbName = name;
  //console.log(" GroupGameGb : "+ mx.GroupGameGb);
  mx.ResetGroupGameChanged();
  OnGameTitleMenuChanged();
  
  $('#GroupGameGB').val(mx.GroupGameGb);
  var con = document.getElementById("divPlayer2");

  if (value == Person_GroupGameGB) {
    con.style.display = 'block';
  }
  else {
    con.style.display = 'none';
  }

  var con2 = document.getElementById("LIPlayer1");

  if (value == Person_GroupGameGB) {
    con2.style.display = 'none';
  }
  else {
    con2.style.display = 'block';
  }
  
  AllClearPlayer();
};

mx.ResetGroupGameChanged = function (){
  mx.TeamGb = mx.empty;
  mx.TeamGbName = "";
  
  mx.Level = mx.empty;
  mx.LevelName = "";
  
  mx.LevelJoo = mx.empty;
  mx.LevelJooName = "";
  
  mx.LevelJooNum = mx.empty;
  
  mx.Sex= mx.empty;
  mx.SexName= ""
  
  mx.PlayType= mx.empty;
  mx.PlayTypeName= ""
};

OnTeamChanged = function()
{ 
  var value = $('#TeamGb').val();
  var name = $('#TeamGb>option:selected').text();
  mx.TeamGb = value;
  mx.TeamGbName = name;
  //console.log(" TeamGB : "+ mx.TeamGb);
  //console.log(" TeamGbName : "+ mx.TeamGbName);
  mx.ResetTeamGbChanged();
  OnGameTitleMenuChanged();
};

mx.ResetTeamGbChanged = function (){
  mx.Level = mx.empty;
  mx.LevelName = "";
  
  mx.LevelJoo = mx.empty;
  mx.LevelJooName = "";
  
  mx.LevelJooNum = mx.empty;
  
  mx.Sex= mx.empty;
  mx.SexName= ""
  
  mx.PlayType= mx.empty;
  mx.PlayTypeName= ""
};

OnSexPlayTypeChanged = function()
{
  var value = $('#SexPlayType').val();
  var name = $('#SexPlayType>option:selected').text();
  var SexPlayType = value.split("|");
  mx.Sex = SexPlayType[0];
  mx.PlayType = SexPlayType[1];
  mx.SexPlayTypeNM = name;
  //console.log(" Sex : "+ mx.Sex + " " + " PlayType : "+ mx.PlayType);
  mx.ResetSexPlayTypeChanged();
  OnGameTitleMenuChanged();
};

mx.ResetSexPlayTypeChanged = function (){
  mx.Level = mx.empty;
  mx.LevelName = "";
  mx.LevelJoo = mx.empty;
  mx.LevelJooName = "";
  mx.LevelJooNum = mx.empty;
};

OnLevelChanged = function()
{  
  var value = $('#Level').val();
  var name = $('#Level>option:selected').text();
  mx.Level = value;
  mx.LevelName = name;
  //console.log(" Level : "+ mx.Level);
  mx.ResetLevelChanged();
  OnGameTitleMenuChanged();
};

mx.ResetLevelChanged = function (){
  mx.LevelJoo = mx.empty;
  mx.LevelJooName = "";
  mx.LevelJooNum = mx.empty;
};

function OnLevelJooNameChanged()
{ 
  var value = $('#LevelJooName').val();
  var name = $('#LevelJooName>option:selected').text();
  mx.LevelJoo = value;
  mx.LevelJooName = name;
  //console.log(" LevelJoo : "+ mx.LevelJoo);
  OnGameTitleMenuChanged();
};

function confirmGameEnterInfo()
{
  var UserName = $('#EnterInfoUserName').val();
  var PhoneNumber1 = $('#EnterInfoPhoneNumber1').val();
  var PhoneNumber2 = $('#EnterInfoPhoneNumber2').val();
  var Password= $('#EnterInfoPassword').val();
  var GameTitleIDX = $('#GameTitleIDX').val();

  if (UserName.length < 2) {
    alert("????????? ????????? ????????? ??????????????????.")
    return;
  }
  if (PhoneNumber2.length != 7 && PhoneNumber2.length != 8 ){
    alert("?????????????????? ????????? ??????????????????.")
    return;
  }

  if (Password.length < 4){
    alert("??????????????? 4?????? ????????? ??????????????????.")
    return;
  }


  Url = "/Entry/ajax/Particiapte_CheckEntryInfo.asp"
  var packet = {};
  packet.CMD = CMD_CONFIRMENTRYINFO;
  packet.GameTitleIDX = GameTitleIDX;
  packet.UserName = UserName;
  packet.PhoneNumber = PhoneNumber1 + PhoneNumber2;
  packet.Password = Password;
  SendPacket(Url, packet);

};

function OnGameTitleMenuGameLevelChanged(GameLevelIDX)
{
  
  var EnterType = $("#EnterType").val();
  Url = "/ajax/GameTitleMenu/Participate_GameLevelMenu.asp"
  var GameTitleIDX = $('#GameTitleIDX').val();
  $('#GameLevelIDX').val(GameLevelIDX);
  var packet = {};
  packet.CMD = CMD_GAMELEVELMENU
  packet.GameTitleIDX = GameTitleIDX;
  packet.GameLevelIDX = GameLevelIDX;
  packet.EnterType = EnterType;
  packet.GroupGameGb = mx.GroupGameGb;
  packet.TeamGb = mx.TeamGb;
  packet.PlayType = mx.PlayType;
  packet.Sex = mx.Sex;
  packet.Level = mx.Level;
  packet.LevelJoo = mx.LevelJoo;
  console.log(packet);
  SendPacket(Url, packet);
};


function OnGameTitleMenuChanged()
{
  var EnterType = $("#EnterType").val();
  Url = "/ajax/GameTitleMenu/Participate_GameLevelMenu.asp"
  var GameTitleIDX = $('#GameTitleIDX').val();
  var packet = {};
  packet.CMD = CMD_GAMELEVELMENU
  packet.GameTitleIDX = GameTitleIDX;
  packet.GameLevelIDX = "";
  packet.EnterType = EnterType;
  packet.GroupGameGb = mx.GroupGameGb;
  packet.TeamGb = mx.TeamGb;
  packet.PlayType = mx.PlayType;
  packet.Sex = mx.Sex;
  packet.Level = mx.Level;
  packet.LevelJoo = mx.LevelJoo;
  SendPacket(Url, packet);
};


$(document).ready(function() {
  invisibleButtonChanged();
  initData();
  initPlayerAutoCompleted();
  initTeamAutoCompleted();
  radio_btn();
  radio_btn1();
  var GameTitleIDX = $('#GameTitleIDX').val();
  var EntryIdx = $('#EntryIDX').val();
  if(EntryIdx.length != 0 && GameTitleIDX.length != 0) {
    modifyParticipate(EntryIdx)
  }
}); 

function initData()
{
  var EnterType = $('#EnterType').val();

  var GroupGameGBValue = $('#GroupGameGB').val();
  var teamGbValue = $('#TeamGb').val();
  var teamGbName = $('#TeamGb>option:selected').text();
  if($('#SexPlayType').val() != "")
  {
    console.log($('#SexPlayType').val())
    var SexPlayType = $('#SexPlayType').val().split("|");
    var sexPlayTypeName = $('#SexPlayType>option:selected').text();
  }

  var levelValue = $('#Level').val();
  var levelName = $('#Level>option:selected').text();
  var levelJooNameValue = $('#LevelJooName').val();
  var levelJooNameName = $('#LevelJooName>option:selected').text();

  mx.EnterType = EnterType;
  mx.GroupGameGb = GroupGameGBValue;
  mx.TeamGb = teamGbValue;
  mx.TeamGbName = teamGbName;
  mx.Sex = SexPlayType[0];
  mx.PlayType = SexPlayType[1];
  mx.SexPlayTypeNM = sexPlayTypeName;
  mx.Level =levelValue;
  mx.LevelName =levelName;
  mx.LevelJoo =levelJooNameValue;
  mx.LevelJooName =levelJooNameName;
  
  ViewData();
  PartnerAreaChanged();
};

function ViewData(){
  console.log(" GroupGameGb : "+ mx.GroupGameGb);
  console.log(" GroupGameGbName : "+ mx.GroupGameGbName);
  console.log(" TeamGB : "+ mx.TeamGb);
  console.log(" TeamGbName : "+ mx.TeamGbName);
  console.log(" Sex : "+ mx.Sex + " " + " PlayType : "+ mx.PlayType);
  console.log(" SexPlayTypeNM : "+ mx.SexPlayTypeNM);
  console.log(" Level : "+ mx.Level);
  console.log(" LevelName : "+ mx.LevelName);
  console.log(" LevelJoo : "+ mx.LevelJoo);
  console.log(" LevelJooName : "+ mx.LevelJooName);
  console.log(" EnterType : "+ mx.EnterType);
  console.log(" ------------------  ");
};



function AllClearPlayer()
{
  $('#Sido_Player1').val("");
  $('#SiGugun_Player1').val("");
  $('#txtPlayerSearch_Player1').val("");
  $('#txtPlayerIDX_Player1').val("");
  $('#txtClubCode_Player1').val("");
  $('#txtClubName_Player1').val("");
  $('#txtBirthDay_Player1').val("");
  $('#Phone_Player1').val("010");
  $('#txtPlayerPhone_Player1').val("");
  $('#txtClubSearch_Player1').val("");

  var sid_Player1_Man = $("#man_Player1");
  sid_Player1_Man.attr('checked',true);
  var sid_Player1_Woman = $("#woman_Player1");
  sid_Player1_Woman.attr('checked',false);
  $("#sex_Man_Player1").removeClass("on");
  $("#sex_Woman_Player1").removeClass("on");
  $("#sex_Man_Player1").addClass("on");




  $('#Sido_Player2').val("");
  $('#SiGugun_Player2').val("");
  $('#txtPlayerSearch_Player2').val("");
  $('#txtPlayerIDX_Player2').val("");
  $('#txtClubCode_Player2').val("");
  $('#txtClubName_Player2').val("");
  $('#txtBirthDay_Player2').val("");
  $('#Phone_Player2').val("010");
  $('#txtPlayerPhone_Player2').val("");
  $('#txtClubSearch_Player2').val("");
  
  var sid_Player2_Man = $("#man_Player2");
  sid_Player2_Man.attr('checked',true);
  var sid_Player2_Woman = $("#woman_Player2");
  sid_Player2_Woman.attr('checked',false);
  $("#sex_Man_Player2").removeClass("on");
  $("#sex_Woman_Player2").removeClass("on");
  $("#sex_Man_Player2").addClass("on");
}

function ClearPlayer1(){
  $('#Sido_Player1').val("");
  $('#SiGugun_Player1').val("");
  $('#txtPlayerSearch_Player1').val("");
  $('#txtPlayerIDX_Player1').val("");
  $('#txtClubCode_Player1').val("");
  $('#txtClubName_Player1').val("");
  $('#txtBirthDay_Player1').val("");
  $('#Phone_Player1').val("010");
  $('#txtPlayerPhone_Player1').val("");
  $('#txtClubSearch_Player1').val("");
  
  var sid_Player1_Man = $("#man_Player1");
  sid_Player1_Man.attr('checked',true);
  var sid_Player1_Woman = $("#woman_Player1");
  sid_Player1_Woman.attr('checked',false);
  $("#sex_Man_Player1").removeClass("on");
  $("#sex_Woman_Player1").removeClass("on");
  $("#sex_Man_Player1").addClass("on");
}

function ClearPlayer2(){
  $('#Sido_Player2').val("");
  $('#SiGugun_Player2').val("");
  $('#txtPlayerSearch_Player2').val("");
  $('#txtPlayerIDX_Player2').val("");
  $('#txtClubCode_Player2').val("");
  $('#txtClubName_Player2').val("");
  $('#txtBirthDay_Player2').val("");
  $('#Phone_Player2').val("010");
  $('#txtPlayerPhone_Player2').val("");
  $('#txtClubSearch_Player2').val("");

  var sid_Player2_Man = $("#man_Player2");
  sid_Player2_Man.attr('checked',true);
  var sid_Player2_Woman = $("#woman_Player2");
  sid_Player2_Woman.attr('checked',false);
  $("#sex_Man_Player2").removeClass("on");
  $("#sex_Woman_Player2").removeClass("on");
  $("#sex_Man_Player2").addClass("on");
}


function modifyParticipate(EntryIdx){
  Url = "/ajax/GameTitleMenu/Participate_SelectEntry.asp"
  var GameTitleIDX = $('#GameTitleIDX').val();
  var EntryInfoIdx = $('#EntryInfoIDX').val();
  var packet = {};
  packet.CMD = CMD_SELECTENTRY;
  packet.GameTitleIDX = GameTitleIDX;
  packet.EntryInfoIdx = EntryInfoIdx;
  packet.EntryIdx = EntryIdx;
  SendPacket(Url, packet);
};



//??????????????? ???????????? ????????????
function PlayerSearchOnChanged(PlayerType)
{
  if (PlayerType =="Player1")
  {
    var txtPlayerSearch_Player1_Text = $("#txtPlayerSearch_Player1").val();
    
    if (txtPlayerSearch_Player1_Text.length == 0)
    {
      ClearPlayer1();
    }
  }

  if (PlayerType =="Player2")
  {
    var txtPlayerSearch_Player2_Text = $("#txtPlayerSearch_Player2").val();
    
    if (txtPlayerSearch_Player2_Text.length == 0)
    {
      ClearPlayer2();
    }
  }
};

function initPlayerAutoCompleted()
{
  $( "#txtPlayerSearch_Player1" ).autocomplete({
		source : function( request, response ) {
      var packet=  {}
      packet.CMD = CMD_SEARCHPLAYER;
      packet.SVAL = request.term;
      packet.EnterType = mx.EnterType;

			$.ajax(
				{
						type: 'post',
						url: "/Ajax/GameTitleMenu/Participate_SearchPlayer.asp",
						dataType: "json",
						data: { "REQ" : JSON.stringify(packet) },
						success: function(data) {
								//???????????? json ????????? response ??? ????????? ???????????? ??????
								response(
										$.map(data, function(item) {
												return {
														label: item.UserLabel,
														value: item.data,
                            uidx:item.uidx,
                            team : item.team,
                            teamNm : item.teamNm,
                            sex : item.sex,
                            birthDay : item.birthDay,
                            phone1 : item.phone1,
                            phone2 : item.phone2,
                            sido : item.sido,
                            sidoNm : item.sidoNm,
                            sigungu : item.sigungu,
                            sigunguNm : item.sigunguNm
												}
										})
								);
            }
        }
			);
		},

        //????????? ?????? ???????????????
        minLength: 1,
        select: function( event, ui ) {
          var obj = {};
          obj.CMD = CMD_SEARCHPLAYER;
          $("#txtClubCode_Player1").val(ui.item.team);
          $("#txtClubName_Player1").val(ui.item.teamNm);
          $("#txtClubSearch_Player1").val(ui.item.teamNm);
          $("#txtPlayerIDX_Player1").val(ui.item.uidx);
          $("#txtPlayerName_Player1").val(ui.item.value);
          $("#txtPlayerSearch_Player1").val(ui.item.label);
          $("#txtBirthDay_Player1").val(ui.item.birthDay);
          $("#Phone_Player1").val(ui.item.phone1);
          $("#txtPlayerPhone_Player1").val(ui.item.phone2);
          $("#Sido_Player1").val(ui.item.sido);
          $("#SiGugun_Player1").val(ui.item.sigungu);
          if (ui.item.phone2.length >= 7) {
            $("#Phone_Player1").val(ui.item.phone1);
            $("#txtPlayerPhone_Player1").val(ui.item.phone2);
          }
          console.log("ui.item.sex" + ui.item.sex + "<br/>")
          if (null == ui.item.sex) {
            var sid = $("#man_Player1");
            sid.attr('checked','checked');
            $("#sex_Man_Player1").removeClass("on");
            $("#sex_Woman_Player1").removeClass("on");
            $("#sex_Man_Player1").addClass("on");
          }
          else {
            if(ui.item.sex.toLowerCase() == "woman") {
              var sid = $("#woman_Player1");
              sid.attr('checked','checked');
              $("#sex_Man_Player1").removeClass("on");
              $("#sex_Woman_Player1").removeClass("on");
              $("#sex_Woman_Player1").addClass("on");
            }
            else {
              var sid = $("#man_Player1");
              sid.attr('checked','checked');
              $("#sex_Man_Player1").removeClass("on");
              $("#sex_Woman_Player1").removeClass("on");
              $("#sex_Man_Player1").addClass("on");
            }
          }
        }
    });

    $( "#txtPlayerSearch_Player2" ).autocomplete({
      source : function( request, response ) {
        var packet=  {}
        packet.CMD = CMD_SEARCHPLAYER;
        packet.SVAL = request.term;
        packet.EnterType = mx.EnterType;
        $.ajax(
          {
              type: 'post',
              url: "/Ajax/GameTitleMenu/Participate_SearchPlayer.asp",
              dataType: "json",
              data: { "REQ" : JSON.stringify(packet) },
              success: function(data) {
                  //???????????? json ????????? response ??? ????????? ???????????? ??????
                  response(
                      $.map(data, function(item) {
                          return {
                              label: item.UserLabel,
                              value: item.data,
                              uidx:item.uidx,
                              team : item.team,
                              teamNm : item.teamNm,
                              sex : item.sex,
                              birthDay : item.birthDay,
                              phone1 : item.phone1,
                              phone2 : item.phone2,
                              sido : item.sido,
                              sidoNm : item.sidoNm,
                              sigungu : item.sigungu,
                              sigunguNm : item.sigunguNm

                          }
                      })
                  );
              }
          }
        );
      },
  
          //????????? ?????? ???????????????
          minLength: 1,
          select: function( event, ui ) {
            var obj = {};
            obj.CMD = CMD_SEARCHPLAYER;
            $("#txtClubCode_Player2").val(ui.item.team);
            $("#txtClubName_Player2").val(ui.item.teamNm);
            $("#txtClubSearch_Player2").val(ui.item.teamNm);
            $("#txtPlayerIDX_Player2").val(ui.item.uidx);
            $("#txtPlayerName_Player2").val(ui.item.value);
            $("#txtPlayerSearch_Player2").val(ui.item.label);
            $("#txtBirthDay_Player2").val(ui.item.birthDay);
            $("#Sido_Player2").val(ui.item.sido);
            $("#SiGugun_Player2").val(ui.item.sigungu);
            if (ui.item.phone2.length >= 7) {
              $("#Phone_Player2").val(ui.item.phone1);
              $("#txtPlayerPhone_Player2").val(ui.item.phone2);
            }
            
            if (null == ui.item.sex) {
              var sid = $("#man_Player2");
              sid.attr('checked','checked');
              $("#sex_Man_Player2").removeClass("on");
              $("#sex_Woman_Player2").removeClass("on");
              $("#sex_Man_Player2").addClass("on");
            }
            else{
              if(ui.item.sex.toLowerCase() == "woman") {
                var sid = $("#woman_Player2");
                sid.attr('checked','checked');
                $("#sex_Man_Player2").removeClass("on");
                $("#sex_Woman_Player2").removeClass("on");
                $("#sex_Woman_Player2").addClass("on");
              }
              else {
                var sid = $("#man_Player2");
                sid.attr('checked','checked');
                $("#sex_Man_Player2").removeClass("on");
                $("#sex_Woman_Player2").removeClass("on");
                $("#sex_Man_Player2").addClass("on");
              }
            }
          }
      });
};

function initTeamAutoCompleted()
{
  $( "#txtClubSearch_Player1" ).autocomplete({
    source : function( request, response ) {
      var packet=  {}
      packet.CMD = CMD_SEARCHTEAM;
      packet.SVAL = request.term;
      packet.EnterType = mx.EnterType;
      packet.UserID = $('#Admin_UserID').val();
      packet.Authority = $('#Admin_Authority').val();
      $.ajax(
        {
            type: 'post',
            url: "/Ajax/GameTitleMenu/Participate_SearchTeam.asp",
            dataType: "json",
            data: { "REQ" : JSON.stringify(packet) },
            success: function(data) {
                //???????????? json ????????? response ??? ????????? ???????????? ??????
                response(
                    $.map(data, function(item) {
                        return {
                            label: item.teamLabel,
                            value: item.teamNm,
                            teamidx:item.teamidx,
                            team : item.team,
                            teamNm : item.teamNm,
                            sido : item.sido,
                            sidoNm : item.sidoNm,
                            sigungu : item.sigungu,
                            sigunguNm : item.sigunguNm
                        }
                    })
                );
            }
        }
      );
    },

        //????????? ?????? ???????????????
        minLength: 1,
        select: function( event, ui ) {
          var obj = {}
          obj.CMD = CMD_SEARCHTEAM
          $("#txtClubCode_Player1").val(ui.item.team)
          $("#txtClubName_Player1").val(ui.item.teamNm)
          $("#txtClubSearch_Player1").val(ui.item.teamNm)
          $("#Sido_Player1").val(ui.item.sido);
          $("#SiGugun_Player1").val(ui.item.sigungu);
          
        }
    });
    
   
    $( "#txtClubSearch_Player2" ).autocomplete({
      source : function( request, response ) {
        var packet=  {}
        packet.CMD = CMD_SEARCHTEAM;
        packet.SVAL = request.term;
        packet.EnterType = mx.EnterType;
        packet.UserID = $('#Admin_UserID').val();
        packet.Authority = $('#Admin_Authority').val();
  
        $.ajax(
          {
              type: 'post',
              url: "/Ajax/GameTitleMenu/Participate_SearchTeam.asp",
              dataType: "json",
              data: { "REQ" : JSON.stringify(packet) },
              success: function(data) {
                  //???????????? json ????????? response ??? ????????? ???????????? ??????
                  response(
                      $.map(data, function(item) {
                          return {
                            label: item.teamLabel,
                            value: item.teamNm,
                            teamidx:item.teamidx,
                            team : item.team,
                            teamNm : item.teamNm,
                            sido : item.sido,
                            sidoNm : item.sidoNm,
                            sigungu : item.sigungu,
                            sigunguNm : item.sigunguNm
                          }
                      })
                  );
              }
          }
        );
      },
  
          //????????? ?????? ???????????????
          minLength: 1,
          select: function( event, ui ) {
            var obj = {}
            obj.CMD = CMD_SEARCHTEAM
            $("#txtClubCode_Player2").val(ui.item.team)
            $("#txtClubName_Player2").val(ui.item.teamNm)
            $("#txtClubSearch_Player2").val(ui.item.teamNm)
            $("#Sido_Player2").val(ui.item.sido);
            $("#SiGugun_Player2").val(ui.item.sigungu);
          }
      });
};


function radio_btn()
{
  $("#spanSexPlayer1 label").eq(0).addClass("on");
  $('#spanSexPlayer1 label').on('click',function()
  {
    $("#spanSexPlayer1 label").removeClass("on");
    $(this).addClass("on");
    if ($(this).attr("for") =="man_Player1") 
    {
      var sid = $("#man_Player1");
      sid.attr('checked',true);
      var sid2 = $("#woman_Player1");
      sid2.attr('checked',false);

    }
    else if ($(this).attr("for") =="woman_Player1") 
    {
      var sid = $("#man_Player1");
      sid.attr('checked',false);
      var sid2 = $("#woman_Player1");
      sid2.attr('checked',true);
    }
  });
};


function radio_btn1()
{
  $("#spanSexPlayer2 label").eq(0).addClass("on");
  $('#spanSexPlayer2 label').on('click',function()
  {
    $("#spanSexPlayer2 label").removeClass("on");
    $(this).addClass("on");

    if ($(this).attr("for") =="man_Player2") 
    {
      var sid = $("#man_Player2");
      sid.attr('checked',true);
      var sid2 = $("#woman_Player2");
      sid2.attr('checked',false);
      
    }
    else if ($(this).attr("for") =="woman_Player2") 
    {
      var sid = $("#man_Player2");
      sid.attr('checked',false);
      var sid2 = $("#woman_Player2");
      sid2.attr('checked',true);
      
    }
  });
};