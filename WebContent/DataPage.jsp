<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="game.main.*,servlet.*,java.sql.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据清单</title>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />

<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
</head>

<style>
body{height:100%;margin:0px;padding:0px;font-family:merriweather,Georgia,Times New Roman,Microsoft Yahei Light}
</style>

<script>

var data_item;var hasgot_data_item=false; // 所有的物品信息
var data_monster;var hasgot_data_monster=false; // 所有的怪物信息
var data_range;var hasgot_data_range=false; // 所有的range信息
$(document).ready(function(){
	const out=$("body")[0];
	function log(logIn)
	{
		let node=document.createElement("div");
		node.innerHTML=logIn+"<br>";
		out.appendChild(node);
	}
	
	var data_range_polygons; // 处理后的多边形s

	var str_item=$.get("Data_Item_Handler.jsp",function(){
	    hasgot_data_item=true;
	    check_data();
	});
	var str_monster=$.get("Data_Monster_Handler.jsp",function(){
	    hasgot_data_monster=true;
	    check_data();
	});
	var str_range=$.get("Data_Range_Handler.jsp",function(){
		hasgot_data_range=true;
	    check_data();
	});

	function check_data()
	{
	    if(hasgot_data_item && hasgot_data_monster && hasgot_data_range)
	    {
	        // 获取完所有信息
	        console.log("基础信息加载完成");
	        
	        data_item=JSON.parse(str_item.responseText);
	        data_monster=JSON.parse(str_monster.responseText);
	        data_range=JSON.parse(str_range.responseText);
	        
	        log("读取到"+data_item.amounts+"条物品数据,"+data_range.amounts+"条区域数据,"+data_monster.amounts+"条怪物数据");
	        
	        log("<br><br>物品表<br>");
	        log("物品名| 物品id | 描述 | 属性");
	        for(let step=0;step<data_item.amounts;step++)
	        {
	        	log("<span style='color:purple'>"+data_item.name_item[step]+"</span>"+"|"+data_item.id_item[step]+"|"+data_item.des[step]+
	        	(data_item.is_usable[step]?"|<span style='color:green'>可使用</span>"+(data_item.is_wearable[step]?"|<span style='color:blue'>可穿戴</span>":"|<span style='color:red'>不可穿戴</span>") :"|<span style='color:red'>不可使用</span>")+
	        	(data_item.is_soldable[step]?"|<span style='color:darkorange'>可交易</span>":"")+
	        	(data_item.is_dropable[step]?"|<span style='color:brown'>可丢弃</span>":"")
	        	);
	        }
	        for(let step=0;step<data_range.amounts;step++)
	        {
	        	;
	        }
	        for(let step=0;step<data_monster.amounts;step++)
	        {
	        	;
	        }
	    }
	}
});
</script>

<body>


</body>
</html>