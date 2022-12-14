function decodeUTF8(str){return decodeURIComponent(str);}
function encodeUTF8(str){return encodeURIComponent(str);}	

var mx =  mx || {};
mx.CMD_TABLECMT	 =	1; //코멘트 인서트, 업데이트
mx.CMD_COLUMNCMT	 =	2; //코멘트 인서트, 업데이트
mx.CMD_LOGIN = 3; //로그인

mx.CMD_BOARDWRITEOK = 500;



mx.CMD_DATAGUBUN = 10000;
mx.CMD_TABLECLUMN = 10002;
mx.CMD_TABLELIST = 10004;

mx.CMD_A6 = 6; //테이블 복사






////////////////////////////////////////
mx.IsHttpSuccess = function( r ){
	try{
		return ( !r.status && location.protocol == "file:" || (r.status >= 200 && r.status < 300) || r.status == 304 || navigator.userAgent.indexOf("Safari") >= 0 && typeof r.status == "undefined" );
	}
	catch(e){}
	return false;
};

mx.HttpData = function( r, type ){
	var ct = r.getResponseHeader( "Content-Type" );
	var data = !type && ct && ct.indexOf( "xml" ) >=0;
	data = type == "xml" || data ? r.responseXML : r.responseText;
	if( type == "script" ){
		eval.call( "window", data );
	}
	else if( type == "mix" ){
		if ( data.indexOf("$$$$") !== -1 ){
			var mixdata = data.split( "$$$$" );
			( function () { eval.call("window", mixdata[0]); } () );
			data = mixdata[1];
		}
	}
	return data;
};

mx.SendPacket = function( sender, packet){

	var datatype = "mix";
	var timeout = 5000;
	var reqcmd = packet.CMD;
	var reqdone = false;//Closure
	var url = "/pub/ajax/bike/reqdbcomment.asp";
	var strdata = "REQ=" + encodeURIComponent( JSON.stringify( packet  ) );
	var xhr = new XMLHttpRequest();
	xhr.open( "POST", url );
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	setTimeout( function(){ reqdone = true; }, timeout );

	xhr.onreadystatechange = function(){
		if( xhr.readyState == 4 && !reqdone ){
			if( mx.IsHttpSuccess( xhr ) ){
				mx.ReceivePacket( reqcmd, mx.HttpData( xhr, datatype ), sender );
				return true;
			}
			xhr = null;
		}
	};
    console.log(JSON.stringify( packet  ) );	
	xhr.send( strdata );
};

mx.ReceivePacket = function( reqcmd, data, sender ){// data는 response string
	var rsp = null;
	var callback = null;
	var jsondata = null;
	var htmldata = null;
	var resdata = null;

	
	if ( Number(reqcmd) > mx.CMD_DATAGUBUN  ){
		htmldata = data;
	}
	else{
		if(typeof data == 'string'){jsondata = JSON.parse(data);}
		else{jsondata = data;}
	}

	if( jsondata !='' && jsondata != null){
		switch (Number(jsondata.result))	{
		case 0:	break;
		case 1:	alert('데이터가 존재하지 않습니다.');return; 	break;
		case 100:	return; 	break; //메시지 없슴
		case 1212: location.href="tablehelp.asp"; return; break;
		}
	}

	switch (Number(reqcmd))	{
	case mx.CMD_TABLECLUMN:	this.OnClumn( reqcmd, jsondata, htmldata, sender );		break;
	case mx.CMD_TABLECMT:	this.OnComment( reqcmd, jsondata, htmldata, sender );		break;
	case mx.CMD_COLUMNCMT:	this.OnComment( reqcmd, jsondata, htmldata, sender );		break;

	case mx.CMD_TABLELIST :	this.OnList( reqcmd, jsondata, htmldata, sender );		break;
	}
};


mx.OnList =  function(cmd, packet, html, sender){
	document.getElementById("dbhelp_modal").innerHTML = html;

	if( $("#dbhelp_modal").css("display") == "none" ) {
		$('#dbhelp_modal').modal('show');
	}
	//$("#dbhelp_modal").is($("#dbhelp_modal").show()) {
	//}
};



mx.OnIIS =  function(cmd, packet, html, sender){
	document.getElementById("dbselect").style.display = "none";
	document.getElementById("axcontents").innerHTML = html;
};



mx.OnClumn =  function(cmd, packet, html, sender){
	document.getElementById("dbhelp_modal").innerHTML = html;
	$('#dbhelp_modal').modal('show');
};


mx.OnComment =  function(cmd, packet, html, sender){
	sender.style.borderColor  = 'red';
};


mx.goPage = function(packet, pageno){
	packet.PN = pageno;
	mx.SendPacket( null, packet);
};

mx.copyTable =function(tableName){
	var packet = {};
	packet.CMD = mx.CMD_A6;
	var control = document.getElementById(tableName).value;
	if(confirm ("["+ control + "]" +" 테이블을 복사하시겠습니까?")){
		packet.TABLENAME = control;
    mx.SendPacket(null, packet)
  }
};