

function getUserUrls(uid, callbackFunction) {
	$.getJSON(
		"UrlsController",
		{ action: 'getAll', uid: uid },
	 	callbackFunction
	);
}

function getTopUrls(numberOfUrls, callbackFunction) {
	$.getJSON(
		"UrlsController",
		{ action: 'getTopUrls', numberOfUrls: numberOfUrls },
		callbackFunction
	);
}

function addUrl(url, callbackFunction) {
	$.get("UrlsController",
		{ action: "add",
			url: url,
		},
		callbackFunction
	);
}

function updateUrl(urlid, url, callbackFunction) {
    $.get("UrlsController",
		{ action: "update",
			urlid: urlid,
			newUrl: url,
		},
		callbackFunction
	);
}

function deleteUrl(urlid,callbackFunction) {
	console.log(callbackFunction)
	$.get("UrlsController",
		{ action: "delete",
			urlid: urlid,
		},
		callbackFunction
	);
}
