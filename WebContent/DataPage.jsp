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
body{height:100%;margin:0px;padding:0px;
font-family:merriweather,Georgia,Times New Roman,Microsoft Yahei;
text-align:center}
table{width:100%}
td{border:1px solid gray}

.bgc_gray{background-color:#EBEBEB}
.c_gray{color:gray}
.c_red{color:red}
.c_maroon{color:maroon}
.c_blue{color:blue}
.c_darkblue{color:darkblue}
.c_green{color:green}
.c_gold{color:gold}
.c_purple{color:purple}
.c_orange{color:orange}

.hovercolor-lightblue:hover
{
background-color:lightblue;
}
</style>

<script>
var data_item;var hasgot_data_item=false; // 所有的物品信息
var data_monster;var hasgot_data_monster=false; // 所有的怪物信息
var data_range;var hasgot_data_range=false; // 所有的range信息

function log_item(logIn)
{
    out_item.innerHTML+=logIn;
}
function log_monster(logIn)
{
    out_monster.innerHTML+=logIn;
}
function log_range(logIn)
{
    out_range.innerHTML+=logIn;
}

function load_all()
{
    var str_item=$.get("Data_Item_Handler.jsp",function(){
        hasgot_data_item=true;
        data_item=JSON.parse(str_item.responseText);
	    check_data();
	});
	var str_monster=$.get("Data_Monster_Handler.jsp",function(){
        hasgot_data_monster=true;
        data_monster=JSON.parse(str_monster.responseText);
        check_data();
        
	});
	var str_range=$.get("Data_Range_Handler.jsp",function(){
		hasgot_data_range=true;
        data_range=JSON.parse(str_range.responseText);
        check_data();
	});
}
$(document).ready(function(){
    const out_item=$("#out_item")[0];
    const out_range=$("#out_range")[0];
    const out_monster=$("#out_monster")[0];
    load_all();
});

function check_data()
{
    if(hasgot_data_item && hasgot_data_monster && hasgot_data_range)
    {
        // 获取完所有信息
        console.log("基础信息加载完成");
        
        
        

        let step;
        log_item("<tr><td>物品名称</td><td>物品id</td><td>描述</td><td>使用性</td><td>穿戴性</td><td>交易性</td><td>丢弃性</td><td>强化性</td><td>附魔性</td></tr>")
        for(step=0;step<data_item.amounts;step++)
        {
            log_item(
            "<tr class='hovercolor-lightblue "+(step%2==0?"bgc_gray":"")+"'><td style='color:"+getColorByRarity(data_item.rarity[step])+"'>"+data_item.name_item[step]+
            "</td><td>"+data_item.id_item[step]+
            "</td><td>"+data_item.des[step]+
            "</td><td class='"+(data_item.is_usable[step]?"c_blue":"c_gray")+"'>"+data_item.is_usable[step]+
            "</td><td class='"+(data_item.is_wearable[step]?"c_darkblue":"c_gray")+"'>"+data_item.is_wearable[step]+
            "</td><td class='"+(data_item.is_soldable[step]?"c_gold":"c_gray")+"'>"+data_item.is_soldable[step]+
            "</td><td class='"+(data_item.is_dropable[step]?"c_maroon":"c_gray")+"'>"+data_item.is_dropable[step]+
            "</td><td class='"+(data_item.is_strenthenable[step]?"c_green":"c_gray")+"'>"+data_item.is_strenthenable[step]+
            "</td><td class='"+(data_item.is_enchantable[step]?"c_purple":"c_gray")+"'>"+data_item.is_enchantable[step]+"</td></tr>"
            );
        }
        for(step=0;step<data_item.amounts;step++)
        {
            ;
        }
        for(step=0;step<data_monster.amounts;step++)
        {
            ;
        }
    }
}
	//根据rarity显示颜色
	function getColorByRarity(rarityIn)
	{
		switch(rarityIn)
		{
		case 0: // 普通
			return "black";
		case 1: // 稀有
			return "blue";
		case 2: // 罕见
			return "darkgreen";
		case 3: // 珍贵
			return "purple";
		case 4: // 传说
			return "darkred";
		case 5: // 史诗
			return "darkorange";
		case 10: // 唯一
			return "#DAA520";
		default:
			return "black";
		}
	}
</script>


<body>

<h1>物品数据</h1>
<table>
<tbody id="out_item"></tbody>
</table>

怪物数据<br>
<div id="out_monster">
</div>

范围数据<br>
<div id="out_range">
</div>


</body>
</html>