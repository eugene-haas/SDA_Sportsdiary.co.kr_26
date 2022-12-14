	var appCache = window.applicationCache;
	
    window.addEventListener('load', function(e) {
		appCache.addEventListener('cached', handleCacheEvent, false);
		appCache.addEventListener('checking', handleCacheEvent, false);
		appCache.addEventListener('downloading', handleCacheEvent, false);
		appCache.addEventListener('progress', handleCacheEvent, false);
		appCache.addEventListener('noupdate', handleCacheEvent, false);
		appCache.addEventListener('obsolete', handleCacheEvent, false);
		appCache.addEventListener('updateready', handleCacheEvent, false);		
		appCache.addEventListener('error', handleCacheError, false);
	}, false);
	
	
	function handleCacheEvent(e){
		switch(e.type){
			case "cached": 	console.log("cached: 어플리케이션 캐시됨"); break;
			case "checking": console.log("checking: 업데이트 사항 체크"); break;		
			case "downloading": console.log("downloading: 다운로드 시작"); break;		
			case "progress": console.log("progress: 다운로드 진행"); break;		
			case "noupdate": console.log("noupdate: 업데이트 사항 없음"); break;		
			case "obsolete": console.log("obsolete: manifest 파일 찾을수 없음, 캐시삭제함"); break;		
			case "updateready": console.log("updateready: 업데이트 완료");
				if (appCache.status == appCache.UPDATEREADY) {
					appCache.swapCache();
					//alert("업데이트가 완료되었습니다. 새로고침하세요.")
					//if (confirm('업데이트 완료되었습니다. 재시작 합니다.')) {
						window.location.reload();
					//}
				}
				break;
		}
	}
	
	function handleCacheError(e){
		console.log("error: 업데이트 에러");
	}