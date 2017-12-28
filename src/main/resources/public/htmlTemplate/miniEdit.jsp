<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%response.setHeader("Pragma", "No-cache");response.setHeader("Cache-Control", "no-cache");response.setDateHeader("Expires", 0);%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>学生管理编辑</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="renderer" content="webkit" />
        <meta name="robots" content="noindex,nofollow" />
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="scripts/boot.js" type="text/javascript"></script>
        <link href="scripts/miniui/res/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .inputLable {
                width: 70px;
            }
        </style>
        <script src="scripts/gridFun.js" type="text/javascript"></script>
        <script type="text/javascript">
        	var gendarData=[{"id":"男","text":"男","nameSpell":"nan"},{"id":"女","text":"女","nameSpell":"nv"}];
        </script>
    </head>
    <body>

        <form id="form1" method="post" style="margin: 5px;">
            <div style="padding:10px;border:0px #ccc solid;">
                <table style="width:100%;">
                	<!--container_tag_start-->
                    <tr>
                    	<!--content_repeat:{"repeat":4,"columns":["column_comment","column_name","column_name","widgetType"]}-->
                    	<td class="inputLable">%s：</td><td><input name="%s：" id="%s：" class="%s： inputWidth" required="true"/></td>
                   </tr>
                   <!--container_tag_end-->
                    
                </table>
                <div style="text-align:center;padding:10px;">
                    <a class="mini-button" id="saveBtn" onclick="SaveData('form1');" style="width:60px;margin-right:20px;">保存</a>
                    <a class="mini-button" onclick="CloseWindow('cancel')" style="width:60px;">取消</a>
                </div>
            </div>
        </form>
        <script type="text/javascript">
            mini.parse();
            var flag = "";
            var form = new mini.Form("form1");
            
            function beforeTreeLoad(e) {
    	        var mytree = e.sender;    //树控件
    	        var node = e.node;      //当前节点
    	        var params = e.params;  //参数对象
    	        //可以传递自定义的属性
    	        params.pid = node.spid; //后台：request对象获取"myField"  
    	    }
            function beforeTreeLoadXzqh(e) {
    	        var mytree = e.sender;    //树控件
    	        var node = e.node;      //当前节点
    	        var params = e.params;  //参数对象
    	        //可以传递自定义的属性
    	        params.pid = node.codeid; //后台：request对象获取"myField"  
    	    }
            function beforenodeselect(e) {
            	 //禁止选中父节点
                if (e.isLeaf == false) e.cancel = true;
            }
            function zyxxValueFun(e){
            	mini.get("enrollspid").setValue(e.value.substring(0,6));
            }
            function sydValueFun(e){
            	mini.get("regionsourceid").setValue(e.value.substring(0,6));
            }
            
            function CloseWindow(action) {
                if (action == "close" && form.isChanged()) {
                    if (confirm("数据被修改了，是否先保存？")) {
                        return false;
                    }
                }
                if (window.CloseOwnerWindow)
                    return window.CloseOwnerWindow(action); 
                else
                    window.close();
            }
            
            function onIDCardsValidation(e) {
                if (e.isValid) {
                    var pattern = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
                    if (pattern.test(e.value) === false) {
                        e.errorText = "身份证输入不合法";
                        e.isValid = false;
                    }
                }
            }
            

            
        </script>
        <script type="text/javascript">
            $(function () {
                //权限验证        
                var r = "${STU_BASE_A}";
                var r2 = "${STU_BASE_E}";
                if (r=="false" && r=="false") {
                    mini.get("saveBtn").setEnabled(false);
                    mini.get("saveBtn").setTooltip("无权限STU_BASE_ADE");
                }
            });
        </script>
    </body>
</html>
