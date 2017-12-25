var key = "databaseInfo";

function storeDBInfo(data){
	var dataJson = mini.encode(data);
	window.localStorage.setItem(key,dataJson);
}

function getDBInfo(){
	var dataJson =  window.localStorage.getItem(key);
	return mini.decode(dataJson);
}

function remove(){
	window.localStorage.removeItem(key);
}