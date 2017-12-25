//gird添加记录
function addFun(url, title, width, height, gridId,saveUrl,idsEnabled,idsEnabledValue) {
	mini.open({
		url : url,
		title : title,
		width : width,
		height : height,
		showMaxButton:true,
		
		onload : function() {
			var iframe = this.getIFrameEl();
			var data = {
				action : "add",
				saveUrl:saveUrl,
				idsEnabled:idsEnabled,
				idsEnabledValue:idsEnabledValue
			};
			iframe.contentWindow.SetData(data);
		},
		ondestroy : function(action) {
			mini.get(gridId).reload();
		}
	});
}

//gird编辑记录
function editFun(baseData) {
	var gridObject=mini.get(baseData.gridId);
	var row = gridObject.getSelecteds();
	if (row.length < 1) {
		mini.alert("请选中一条记录");
		return;
	}
	if (row.length != 1) {
		mini.alert("只能选中一条记录");
		return;
	}
	var id = eval("row[0]." + baseData.dataid);
	baseData.id=id;
	baseData.action="edit";
	mini.open({
		url : baseData.url,
		title : baseData.title,
		width : baseData.width,
		height : baseData.height,
		onload : function() {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.SetData(baseData);
			//SetData(baseData);
		},
		ondestroy : function(action) {
			gridObject.reload();
		}
	});
}

//gird删除记录
function removeFun(url, gridId, dataid) {
	var gridObject=mini.get(gridId);
	var rows = gridObject.getSelecteds();
	if (rows.length < 1) {
		mini.alert("请选中一条记录");
		return;
	}
	if (confirm("确定删除选中记录？")) {
		var ids = [];
		for (var i = 0, l = rows.length; i < l; i++) {
			var r = rows[i];
			ids.push(eval("r." + dataid));
		}
		var id = ids.join(',');
		$.ajax({
			url : url,
			type : "post",
			data : {
				ids : id
			},
			cache : false,
			dataType : "json",
			success : function(json) {
				var messageid = mini.showMessageBox({
					title : "操作提示",
					iconCls : "mini-messagebox-question",
					buttons : [ "ok" ],
					message : json.msg,
					iconCls : "mini-messagebox-info",
					callback : function(action) {
						if (json.success) {
							gridObject.reload();
						}
					}
				});
			},
			error : function(jqXHR, textStatus, errorThrown) {
				mini.alert(jqXHR.responseText);
			}
		});
	}
}

//grid快速搜索
function gridSearchFun(gridId,keyid) {
	var gridObject=mini.get(gridId);
	gridObject.load({key:mini.get(keyid).getValue().replace(/(^\s*)|(\s*$)/g,"")});
}
//grid快速搜索_取消
function gridSearchCloseFun(gridId,keyid) {
	mini.get(keyid).setValue("");
	mini.get(keyid).setText("");
	mini.get(gridId).load();
}

//打开窗口
function miniOpenFun(url, title, width, height){
	mini.open({
		url : url,
		title : title,
		width : width,
		height : height,
		onload : function(){
		},
		ondestroy : function(action){
		}
	});
}

function setEnabledFun(idsEnabled,enable){
	var idArray=idsEnabled.split(",");
	for(var i=0;i<idArray.length;i++){
		mini.get(idArray[i]).setEnabled(mini.decode(enable));
	}
};

function SetData(data) {
	//跨页面传递的数据对象，克隆后才可以安全使用
	data = mini.clone(data);
	flag=data.saveUrl;
    if (data.action == "edit"){
    	var form = new mini.Form(data.formid);
        $.ajax({
        	type:"POST",
            url: data.setDataUrl,
            data:{id:data.id},
            cache: false,
            success: function (text) {
                var o = mini.decode(text);
                form.setData(o);
                form.setChanged(false);
                for(var i=0;i<data.parObj.length;i++){
                	var parResIdStr=data.parObj[i].parResId;
                	var parResTextStr=data.parObj[i].parResText;
                	$.ajax({
               			type:"POST",
                        url: data.parObj[i].parUrl,
                        data:{id:eval("o."+data.parObj[i].parid)},
                        cache: false,
                        success: function (json) {
                            var obj = mini.decode(json);
                            mini.get(parResIdStr);
                			mini.get(parResIdStr).setValue(eval("obj."+parResIdStr));
                			mini.get(parResIdStr).setText(eval("obj."+parResTextStr));
                        }
                    });
                }
            }
        });
    }else if(data.action == "add"){
    	
    }
    setEnabledFun(data.idsEnabled,data.idsEnabledValue);
}

function SaveData(formid) {
	var form = new mini.Form(formid);
    var o = form.getData(true); 
    form.validate();
    if (form.isValid() == false) return;
    mini.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    $.ajax({
        url:flag,
		type: "POST",
        data: o,
        cache: false,
        dataType:"json",
        success: function(json) {
        	var messageid = mini.showMessageBox({
                title: "操作提示",
                iconCls: "mini-messagebox-question",
                buttons: ["ok"],
                message: json.msg,
                iconCls:"mini-messagebox-info",
                callback: function (action) {
                	if(json.success){
                    	CloseWin("save");
                	}
                }
            });
        },
        error: function (jqXHR, textStatus, errorThrown) {
            mini.alert(jqXHR.responseText);
        },
        complete:function(jqXHR, textStatus, errorThrown){
        	mini.unmask(document.body);
        }
    });
}


function closeclick(e){
	var obj = e.sender;
	obj.setValue("");
	obj.setText("");
}

function CloseWin(e){
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(e);
    else window.close();            
}
