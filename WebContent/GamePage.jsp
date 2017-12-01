<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="game.main.*,servlet.*" %>

<%if(Utils.get(session,"username").equals("")) response.sendRedirect("Login.jsp");%>

 <html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />

<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

<style type="text/css">  
html{height:100%}  
body{height:100%;margin:0px;padding:0px}  
#container{height:100%}  



#bottom-box
{
position:fixed;
bottom:0px;
width:100%;
border-top-left-radius:10px;
border-top-right-radius:10px;
background-color:#eac78d;
}
#btn-line
{
float:left;
}
#pf-pic
{
width:32px;
height:32px;
float:right;
border:1px solid black;
}

.btns
{
height:60px;
width:32px;
border-radius:5px;
font-size:24px;
margin-left:6px;
margin-right:6px;
background-color:#b0843a;
}



#ctrller_box{border-radius:60px;width:150px;
	height:150px;line-height:50px;position:fixed;
	bottom:60px;right:20px;background-color: #45818e;
}
.btns_dir{
	border-radius:10px;
	width:50px;
	height:50px;
	text-align:center;
	user-select: none;
	background-color:lightblue;}
.btns_dir:hover{background-color: #cfe2f3;}
.btns_dir:active{background-color: #9fc5e8;}
#btn_top{position:absolute;left:50px;top:0px;}
#btn_left{position:absolute;left:0px;top:50px;}
#btn_right{	position:absolute;left:100px;top:50px;}
#btn_bottom
{
	position:absolute;
	left:50px;
	top:100px;
}

a{text-decoration:none}
a:hover{text-decoration:none}
a:visited{text-decoration:none}

span:hover{background-color:lightgreen}

</style> 
</head>


<body>

<script>console.log("Sword Magic Online v 0.5.2 by S2Lab.Firok");</script>
<div id="container"></div> 
<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&ak=TTGBXxjhg74WayrWPgAk6pLmqzRHIrX9&services=&t=20171031174121"></script>
<script> /**
 * @fileoverview 百度地图API事件包装器
 * 此代码可使用closure compiler的advanced模式进行压缩
 * @author Baidu Map Api Group 
 * @version 1.2
 */
/** 
 * @namespace BMap的所有library类均放在BMapLib命名空间下
 */
var BMapLib = window.BMapLib || {};
/**
 * 事件封装器的静态类，不可实例化
 * @class EventWrapper
 */
BMapLib.EventWrapper = window.BMapLib.EventWrapper || {};
(function(){

//var EventWrapper = window.BMapLib.EventWrapper;
/**
 * 添加DOM事件监听函数
 * @param {HTMLElement} element DOM元素
 * @param {String} event 事件名称
 * @param {Function} handler 事件处理函数
 * @returns {MapsEventListener} 事件监听对象
 */
BMapLib.EventWrapper.addDomListener = function(instance, eventName, handler) {
    if (instance.addEventListener) {
        instance.addEventListener(eventName, handler, false);
    }
    else if (instance.attachEvent) {
        instance.attachEvent('on' + eventName, handler);
    }
    else {
        instance['on' + eventName] = handler;
    }
    return new MapsEventListener(instance, eventName, handler, MapsEventListener.DOM_EVENT);
};
/**
 * 添加DOM事件监听函数，函数仅执行一次
 * @param {HTMLElement} element DOM元素
 * @param {String} event 事件名称
 * @param {Function} handler 事件处理函数
 * @returns {MapsEventListener} 事件监听对象
 */
BMapLib.EventWrapper.addDomListenerOnce = function(instance, eventName, handler) {
    var eventListener = EventWrapper['addDomListener'](instance, eventName, function(){
        // 移除
        EventWrapper['removeListener'](eventListener);
        return handler.apply(this, arguments);
    });
    return eventListener;
};
/**
 * 添加地图事件监听函数
 * @param {Object} instance 实例
 * @param {String} event 事件名称
 * @param {Function} handler 事件处理函数
 * @returns {MapsEventListener} 事件监听对象
 */
BMapLib.EventWrapper.addListener = function(instance, eventName, handler) {
    instance.addEventListener(eventName, handler);
    return new MapsEventListener(instance, eventName, handler, MapsEventListener.MAP_EVENT);
};
/**
 * 添加地图事件监听函数，函数仅执行一次
 * @param {Object} instance 需要监听的实例
 * @param {String} event 事件名称
 * @param {Function} handler 事件处理函数
 * @returns {MapsEventListener} 事件监听对象
 */
BMapLib.EventWrapper.addListenerOnce = function(instance, eventName, handler){
    var eventListener = EventWrapper['addListener'](instance, eventName, function(){
        // 移除
        EventWrapper['removeListener'](eventListener);
        return handler.apply(this, arguments);
    });
    return eventListener;
};
/**
 * 移除特定实例的所有事件的所有监听函数
 * @param {Object} instance 需要移除所有事件监听的实例
 * @returns {None}
 */
BMapLib.EventWrapper.clearInstanceListeners = function(instance) {
    var listeners = instance._e_ || {};
    for (var i in listeners) {
        EventWrapper['removeListener'](listeners[i]);
    }
    instance._e_ = {};
};
/**
 * 移除特定实例特定事件的所有监听函数
 * @param {Object} instance 需要移除特定事件监听的实例
 * @param {String} event 需要移除的事件名
 * @returns {None}
 */
BMapLib.EventWrapper.clearListeners = function(instance, eventName) {
    var listeners = instance._e_ || {};
    for (var i in listeners) {
        if (listeners[i]._eventName == eventName) {
            EventWrapper['removeListener'](listeners[i]);
        }
    }
};
/**
 * 移除特定的事件监听函数
 * @param {MapsEventListener} listener 需要移除的事件监听对象
 * @returns {None}
 */
BMapLib.EventWrapper.removeListener = function(listener) {
    var instance = listener._instance;
    var eventName = listener._eventName;
    var handler = listener._handler;
    var listeners = instance._e_ || {};
    for (var i in listeners) {
        if (listeners[i]._guid == listener._guid) {
            if (listener._eventType == MapsEventListener.DOM_EVENT) {
                // DOM事件
                if (instance.removeEventListener) {
                    instance.removeEventListener(eventName, handler, false);
                }
                else if (instance.detachEvent) {
                    instance.detachEvent('on' + eventName, handler);
                }
                else {
                    instance['on' + eventName] = null;
                }
            }
            else if (listener._eventType == MapsEventListener.MAP_EVENT) {
                // 地图事件
                instance.removeEventListener(eventName, handler);
            }
            delete listeners[i];
        }
    }
};
/**
 * 触发特定事件
 * @param {Object} instance 触发事件的实例对象
 * @param {String} event 触发事件的名称
 * @param {Object} args 自定义事件参数，可选
 * @returns {None}
 */
BMapLib.EventWrapper.trigger = function(instance, eventName) {
    var listeners = instance._e_ || {};
    for (var i in listeners) {
        if (listeners[i]._eventName == eventName) {
            var args = Array.prototype.slice.call(arguments, 2);
            listeners[i]._handler.apply(instance, args);
        }
    }
};

/**
 * 事件监听类
 * @constructor
 * @ignore
 * @private
 * @param {Object} 对象实例
 * @param {string} 事件名称
 * @param {Function} 事件监听函数
 * @param {EventTypes} 事件类型
 */
function MapsEventListener(instance, eventName, handler, eventType){
    this._instance = instance;
    this._eventName = eventName;
    this._handler = handler;
    this._eventType = eventType;
    this._guid = MapsEventListener._guid ++;
    this._instance._e_ = this._instance._e_ || {};
    this._instance._e_[this._guid] = this;
}
MapsEventListener._guid = 1;

MapsEventListener.DOM_EVENT = 1;
MapsEventListener.MAP_EVENT = 2;

})();
</script>
<script type="text/javascript"> 
var map = new BMap.Map("container");
// 创建地图实例  
map.setMapStyle({style:'midnight'});
// map.disableDragging(true);
map.disableContinuousZoom(true);
map.disableDoubleClickZoom(true);
map.disablePinchToZoom(true);
map.disableScrollWheelZoom(true);

var loc_x=121.363847;
var loc_y=37.526844;

// 按钮 - 移动
function btn_click_move_up()
{
loc_y+=0.000060;
map_re_center();
}
function btn_click_move_left()
{
loc_x-=0.000060;
map_re_center();
}
function btn_click_move_right()
{
loc_x+=0.000060;
map_re_center();
}
function btn_click_move_down()
{
loc_y-=0.000060;
map_re_center();
}
// 重新定位地图
function map_center_at(loc_xIn,loc_yIn)
{
loc_x=loc_xIn;
loc_y=loc_yIn;
map_re_center();
}
function map_re_center()
{
	// 创建点坐标  
	map.centerAndZoom(new BMap.Point(loc_x,loc_y), 19);
}
map_re_center();
</script>  
<script>
//加载所有基础信息
function check_data()
{
    if(hasgot_data_item && hasgot_data_monster && hasgot_data_range)
    {
        // 获取完所有信息
        console.log("基础信息加载完成");
        
        data_item=JSON.parse(str_item.responseText);
        data_monster=JSON.parse(str_monster.responseText);
        data_range=JSON.parse(str_range.responseText);
        
        // 处理多边形信息
        data_range_polygons=[];
        let step=0;
        // console.log("amounts=="+data_range.amounts); 
        
        while(step<data_range.amounts)
        {
        	// console.log("第"+step+"次处理");
        	let points=[];
        	let str_pos_array=data_range.pos[step].split(';'); // 拿到这一次的点集合
        	let step2=0;
        	let pos_line="";
        	while(step2<str_pos_array.length)
        	{
        		pos_line=str_pos_array[step2].split(',');
        		let point_to_add=new BMap.Point(parseFloat(pos_line[0]),parseFloat(pos_line[1]));
        		points.push(point_to_add);
        		
            	
        		step2++;
        	}
        	let Pnew = new BMap.Polygon(points, {} );
        	
        	let id_range=data_range.id_range[step];

			
        	Pnew.addEventListener("click", function(){
        		// alert("something");
        		
        	    let str_get=$.get("AJAX_Handler.jsp?act=Qrangefunclist&id_range="+id_range,function(){
        			let json_get=JSON.parse(str_get.responseText);
        			$("#btn_modal_func").click();
        			modal_show_func(json_get,id_range);
        		});
        	});  

        	data_range_polygons.push(Pnew);
        	
        	step++;
        }
        
        _refreshSurrs();
        
        
        console.log("读取到"+data_item.amounts+"条物品数据,"+data_range.amounts+"条区域数据,"+data_monster.amounts+"条怪物数据");

    }

}
// 用AJAX从服务器获取
var data_item;var hasgot_data_item=false; // 所有的物品信息
var data_monster;var hasgot_data_monster=false; // 所有的怪物信息
var data_range;var hasgot_data_range=false; // 所有的range信息

var data_range_polygons; // 处理后的多边形s

var username="<%=Utils.get(session,"username")%>";
console.log("玩家名为"+username);

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

// 按钮 - 个人信息
function btn_click_info()
{
    let str_get=$.get("AJAX_Handler.jsp?act=Qinfo",function(){
		let json_get=JSON.parse(str_get.responseText);
		modal_show_info(json_get);
	});
    
}
function modal_show_info(jsonIn)
{
    let target=document.getElementById("modal_info_body");
    target.innerHTML="";
    target.innerHTML+="物攻"+jsonIn.result.atk_p+"<br>";
    target.innerHTML+="物防"+jsonIn.result.def_p+"<br>";
    target.innerHTML+="魔攻"+jsonIn.result.atk_m+"<br>";
    target.innerHTML+="魔防"+jsonIn.result.def_m+"<br>";
    target.innerHTML+="速度"+jsonIn.result.speed+"<br>";
    target.innerHTML+="命中"+jsonIn.result.acc+"<br>";
    target.innerHTML+="生命"+jsonIn.result.hp+"<br>";
    target.innerHTML+="生命上限"+jsonIn.result.hp_limit+"<br>";
    target.innerHTML+="生命恢复"+jsonIn.result.hp_re+"<br>";
    target.innerHTML+="魔法"+jsonIn.result.mp+"<br>";
    target.innerHTML+="魔法上限"+jsonIn.result.mp_limit+"<br>";
    target.innerHTML+="魔法恢复"+jsonIn.result.mp_re+"<br>";
    target.innerHTML+="主职业"+jsonIn.result.class+"<br>";
    target.innerHTML+="主职业等级"+jsonIn.result.lv+"<br>";
    target.innerHTML+="副职业"+jsonIn.result.class_sub+"<br>";
    target.innerHTML+="副职业等级"+jsonIn.result.lv_sub+"<br>";
    
    target.innerHTML+="<br>";
}
// 按钮 - 背包栏
function btn_click_inv()
{
	let str_get=$.get("AJAX_Handler.jsp?act=SQinv",function(){
		let json_get=JSON.parse(str_get.responseText);
		modal_show_inv(json_get);
	});
	let str_get_coin=$.get("AJAX_Handler.jsp?act=SQcoin",function(){
		let json_get=JSON.parse(str_get_coin.responseText);
		modal_show_gold(json_get);
	});
}
function modal_show_gold(jsonIn)
{
	out_coin_gold=document.getElementById("out_coin_gold");
	out_coin_silver=document.getElementById("out_coin_silver");
	out_coin_copper=document.getElementById("out_coin_copper");
	out_coin_irisia=document.getElementById("out_coin_irisia");
	
	out_coin_gold.innerText="金币:"+jsonIn.result.gold;
	out_coin_silver.innerText="银币:"+jsonIn.result.silver;
	out_coin_copper.innerText="铜币:"+jsonIn.result.copper;
	out_coin_irisia.innerText="艾瑞希亚币:"+jsonIn.result.irisia;
	
}
function modal_show_inv(jsonIn)
{
    let target=document.getElementById("modal_inv_body");
    target.innerHTML="";
    // console.log(jsonIn);
    if(jsonIn.result.amounts==1)
   	{
    	target.innerHTML+=
        	( (parseInt(jsonIn.result.slot) >0) ? " <span style=\"color:green\">穿戴中</span> ":"")+
		"<span style=\"color:"+getColorByRarity(getItemRarityById(jsonIn.result.id_item))+"\">"+getItemNameById(jsonIn.result.id_item)+"</span> × "+
        jsonIn.result.amount+" | "+
        (getItemUsableById(jsonIn.result.id_item)? UI_InvItemUse(jsonIn.result.id_item,jsonIn.result.order) :"")+
        (getItemDropableById(jsonIn.result.id_item)? UI_InvItemDrop(jsonIn.result.id_item,jsonIn.result.order) :"")+
        UI_InvItemCheck(jsonIn.result.id_item,jsonIn.result.order)+
        "<br>";
   	}
    else
    {
	    let step=0;
	    while(step<jsonIn.result.amounts)
	    {
	        target.innerHTML+=
	        	( (parseInt(jsonIn.result.slot[step]) >0) ? " <span style=\"color:green\">穿戴中</span> ":"")+
	        	"<span style=\"color:"+getColorByRarity(getItemRarityById(jsonIn.result.id_item[step]))+"\">"+getItemNameById(jsonIn.result.id_item[step])+"</span> × "+
	        jsonIn.result.amount[step]+" | "+
	        (getItemUsableById(jsonIn.result.id_item[step])? UI_InvItemUse(jsonIn.result.id_item[step],jsonIn.result.order[step]) :"")+
	        (getItemDropableById(jsonIn.result.id_item[step])? UI_InvItemDrop(jsonIn.result.id_item[step],jsonIn.result.order[step]) :"")+
	        UI_InvItemCheck(jsonIn.result.id_item[step],jsonIn.result.order[step])+
	        "<br>";
	        step++;
	    }
    }
}
	// 根据id获取这个item在数据序列中的位置
	function getItemLocById(idIn)
	{
		let step=0;
		while(step<data_item.amounts)
		{
			if(data_item.id_item[step]==idIn)
	        {
	            return step;
	        }
			step++;
		}
		return -1;
	}
	// 获取item名称
	function getItemNameById(idIn)
	{
		return data_item.name_item[getItemLocById(idIn)];
	}
	// 获取item的具体属性
	function getItemUsableById(idIn)
	{
		return data_item.is_usable[getItemLocById(idIn)];
	}
	function getItemDropableById(idIn)
	{
		return data_item.is_dropable[getItemLocById(idIn)];
	}
	function getItemRarityById(idIn)
	{
		return data_item.rarity[getItemLocById(idIn)];
	}
		// 根据rarity显示颜色
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
		// 物品项目 按钮的相关函数
		function UI_InvItemUse(idIn,orderIn)
		{
		    return "<span style=\"border:1px solid gray\" onclick=\"UI_click_item_use("+idIn+","+orderIn+")\">使用</span>";
		}
		function UI_InvItemDrop(idIn,orderIn)
		{
		    return "<span style=\"border:1px solid gray\" ondblclick=\"UI_click_item_drop("+idIn+","+orderIn+")\">丢弃</span>";
		}
		function UI_InvItemCheck(idIn,orderIn)
		{
		    return "<span style=\"border:1px solid gray\" onclick=\"UI_click_item_check("+idIn+","+orderIn+")\">检查</span>";
		}
		function UI_click_item_use(idIn,orderIn)
		{
		    let str_get=$.get("AJAX_Handler.jsp?act=SAuseitem&id_item="+idIn+"&order="+orderIn+"&amount=1",function(){
				let json_get=JSON.parse(str_get.responseText);
				modal_show_inv(json_get);
			});
		    let str_get_coin=$.get("AJAX_Handler.jsp?act=SQcoin",function(){
				let json_get=JSON.parse(str_get_coin.responseText);
				modal_show_gold(json_get);
			});
		}
		function UI_click_item_drop(idIn,orderIn)
		{
		    let str_get=$.get("AJAX_Handler.jsp?act=SAdropitem&id_item="+idIn+"&order="+orderIn+"&amount=1",function(){
				let json_get=JSON.parse(str_get.responseText);
				modal_show_inv(json_get);
			});
		}
		function UI_click_item_check(idIn,orderIn)
		{
		    alert(data_item.des[getItemLocById(idIn)]);
		}
// 按钮 - 社交栏
function btn_click_soc()
{
    ;
}
// 按钮 - 合成栏
function btn_click_make()
{
	let str_get=$.get("AJAX_Handler.jsp?act=Qcraftinglist",function(){
		let json_get=JSON.parse(str_get.responseText);
		modal_show_make(json_get);
	});
}
function modal_show_make(jsonIn)
{
	// console.log(jsonIn);
    let target=document.getElementById("modal_make_body");
    target.innerHTML="";
    let step=0;
    while(step<jsonIn.result.amounts)
    {
        target.innerHTML+=
        	"<span style=\"font-size:75%;color:blue \">Lv."+jsonIn.result.lv_need[step]+"</span>"+
		getItemNameById(jsonIn.result.product_id_item[step])+" × "+
        jsonIn.result.product_amount[step]+" | "+
        "<span style=\"border:1px solid gray\" onclick=\"btn_click_make_detail("+jsonIn.result.id_crafting[step]+")\" id=\"make_detail_"+step+"\">详细</span>"+
        "<span style=\"border:1px solid gray\" onclick=\"btn_click_make_do("+jsonIn.result.id_crafting[step]+")\" id=\"make_make_"+step+"\">合成</span>"+
        // onclick=btn_click_make_detail(step)
        // id == make_detail_0
        
        "<br>";
        $("#make_detail_"+step).popover();
        step++;
    }
}
	// 查看详细
	function btn_click_make_detail(idIn)
	{
		let if_ok_can=false;
		let if_ok_raw=false;
		let str_can="";
		let str_raw="";
		let str_get_can=$.get("AJAX_Handler.jsp?act=Qcancraft&id_crafting="+idIn,function(){
			let json_get=JSON.parse(str_get_can.responseText);
			str_get_can=json_get.result;
			
			str_can+=(str_get_can?"能合成":"不能合成");
			if_ok_can=true;
			_show_make_detail(if_ok_can,if_ok_raw,str_can,str_raw);
		});; // 获取能否合成
		let str_get_raws=$.get("AJAX_Handler.jsp?act=Qcraftingraw&id_crafting="+idIn,function(){
			let json_get=JSON.parse(str_get_raws.responseText);
			
			str_raw+=
				"主职业需求: "+json_get.result.class_need+"\n"+
				"主职业等级需求: "+json_get.result.lv_need+"\n"+
				"副职业需求: "+json_get.result.class_sub_need+"\n"+
				"副职业等级需求: "+json_get.result.lv_sub_need+"\n"+
				"消耗经验: "+json_get.result.gold_need+"\n\n"+
				"需要材料: ";
			if(json_get.result.amounts==1)
			{
				str_raw+=getItemNameById( json_get.result.raw_id_item ) + " × "+
				json_get.result.raw_amount;
			}
			else
			{
				let step=0;
				for(step=0;step<json_get.result.amounts;step++)
				{
					str_raw+=getItemNameById( json_get.result.raw_id_item[step] ) + " × "+
					json_get.result.raw_amount[step];
				}
			}
			
			if_ok_raw=true;
			_show_make_detail(if_ok_can,if_ok_raw,str_can,str_raw);
		});; // 获取原材料
	}
		// 显示详细
		function _show_make_detail(if_ok_can,if_ok_raw,str_can,str_raw)
		{
			if(if_ok_can && if_ok_raw)
			{
				alert(str_raw+"\n\n\n"+str_can);
			}
			else
				return;
		}
	// 合成
	function btn_click_make_do(idIn)
	{
		let str_get_can=$.get("AJAX_Handler.jsp?act=Acraft&id_crafting="+idIn,function(){
			;
		});; // 获取原材料
	}
// 按钮 - 设置
function btn_click_setting()
{
	;
}
// 按钮 - 功能列表
function modal_show_func(jsonIn,id_rangeIn)
{
	let target=document.getElementById("modal_func_body");
	
	target.innerHTML="";
	
	document.getElementById("modal_func_head").innerText=data_range.name_range[getLocFromRangeId(id_rangeIn)];
	
	
	if(jsonIn.result.amounts==1)
	{
		target.innerHTML+="<span onclick=\"postExecuteFunc("+id_rangeIn+",'"+jsonIn.result.func_type+"',"+jsonIn.result.id_target+")\">"+getFuncType(jsonIn.result.func_type)+"</span>"
		+"<br>";
	}
	else
	{
		let step=0;
		while(step<jsonIn.result.amounts)
		{
			target.innerHTML+="<span onclick=\"postExecuteFunc("+id_rangeIn+",\""+jsonIn.result.func_type[step]+"\","+jsonIn.result.id_target[step]+")\">"
			+"<br>";
		}
	}
	
	target.innerHTML+="<span onclick=\"alert(data_range.des["+getLocFromRangeId(id_rangeIn)+"])\">查看详细</span>";
}
	// 获取功能对应的类型
	function getFuncType(funcIn)
	{
		switch(funcIn)
		{
		case "resource":
			return "采集资源";
		case "shop":
			return "查看商店";
		default:
			return "未定义";
		}
	}
	// 根据id_range获取range位置
	function getLocFromRangeId(idIn)
	{
		for(let step=0;step<data_range.amounts;step++)
		{
			if(data_range.id_range[step]==idIn)
				return step;
		}
	}
	// 执行功能
	function postExecuteFunc(id_rangeIn,funcTypeIn,id_targetIn)
	{
		// $("#btn_modal_func").click();
		
		
		document.getElementById("modal_func_body").innerText="";
		let str_get;
		
		switch(funcTypeIn)
		{
		case "resource":
			$("#btn_modal_func").click(); // 隐藏模态框
			str_get=$.get("AJAX_Handler.jsp?act=Arangefunc&id_range="+id_rangeIn+"&func="+funcTypeIn+"&id_target="+id_targetIn,function(){
				let json_get=JSON.parse(str_get.responseText);
			});
			break;
		
		case "shop":
			str_get=$.get("AJAX_Handler.jsp?act=Qshoplist&id_range="+id_rangeIn+"&func="+funcTypeIn+"&id_shop="+id_targetIn,function(){
				let json_get=JSON.parse(str_get.responseText);
				
				let target=document.getElementById("modal_func_body");
				document.getElementById("modal_func_head").innerText="商店列表";
				
				
				if(json_get.result.amounts==1)
				{
					_show_item_sold(target,
							json_get.result.id_shop,
							json_get.result.id_trade,
							json_get.result.name,
							json_get.result.id_item,
							json_get.result.amount_sold,
							
							json_get.result.gold_need,
							json_get.result.silver_need,
							json_get.result.copper_need,
							json_get.result.irisia_need,
							
							
							json_get.result.des
							);
				}
				else
				{
					for(let step=0;step<json_get.result.amounts;step++)
					{
						_show_item_sold(target,
								json_get.result.id_shop,
								json_get.result.id_trade[step],
								json_get.result.name[step],
								json_get.result.id_item_sold[step],
								json_get.result.amount_sold[step],
								
								json_get.result.gold_need[step],
								json_get.result.silver_need[step],
								json_get.result.copper_need[step],
								json_get.result.irisia_need[step],
								
								
								json_get.result.des[step]
								);
					}
				}
				
			});
			break;
			
		default:
			console.log("WRONG FUNC TYPE");
		}
	}
		// 显示一个销售条目
		function _show_item_sold(targetIn,id_shopIn,id_tradeIn,nameIn,id_item_soldIn,amount_soldIn,gold_needIn,silver_needIn,copper_needIn,irisia_needIn,desIn)
		{
			targetIn.innerHTML+=
			""+nameIn+" | "+getItemNameById(id_item_soldIn)+" × "+amount_soldIn+" | "
			+"<span style=\"color:gold\">"+gold_needIn
			+"</span>,<span style=\"color:silver\">"
			+silver_needIn+"</span>,<span style=\"color:#b45836\">"
			+copper_needIn+"</span>,<span style=\"color:blue\">"
			+irisia_needIn+"</span>"
			+"<span style=\"border:1px solid gray;\" onclick=\"sendTrade("+id_shopIn+","+id_tradeIn+")\">购买</span>"
			+"<br>";
		}
			// 发送交易请求
			function sendTrade(id_shopIn,id_tradeIn)
			{
				$.get("AJAX_Handler.jsp?act=Ashopbuy&id_shop="+id_shopIn+"&id_trade="+id_tradeIn,function(){
					;
				});
			}


console.log("嘛 可能是加载完了 谁知道呢..");
console.log("反正加载不完跟我也没关系 嗯");

console.log("开始给服务器发消息刷新自己位置");
function _toPing()
{
	$.post("AJAX_Handler.jsp?act=Aping&loc_x="+loc_x+"&loc_y="+loc_y,function(){
		;
	});
}
setInterval("_toPing()",5000);

console.log("开始从服务器获取周围的东西");
function _refreshSurrs() // 清空所有标记 显示新的标记
{
	map.clearOverlays(); // 移除原来的
	
	// 获取新的
	let str_get_surrs_players=$.get("AJAX_Handler.jsp?act=SQsurrsPlayer",function(){
		let json_get=JSON.parse(str_get_surrs_players.responseText);
		let step=0;
		while(step<json_get.result.amount)
		{
			_addSurrsPlayer( new BMap.Point(json_get.result.loc_x[step],json_get.result.loc_y[step]) ,step, json_get.result.username[step]+"");
			step++;
		}
	});
	
	// 添加range
	let step=0;
	while(step<data_range_polygons.length)
	{
		map.addOverlay(data_range_polygons[step++]);
	}

}
function _addSurrsPlayer(pointIn,indexIn,usernameIn)
{
	 var myIcon = new BMap.Icon("imgs/icon_player.png", new BMap.Size(32, 32), {    
	        // 指定定位位置。   
	        // 当标注显示在地图上时，其所指向的地理位置距离图标左上    
	        // 角各偏移10像素和25像素。您可以看到在本例中该位置即是   
	        // 图标中央下端的尖角位置。    
	        anchor: new BMap.Size(16, 16),    
	        // 设置图片偏移。   
	        // 当您需要从一幅较大的图片中截取某部分作为标注图标时，您   
	        // 需要指定大图的偏移位置，此做法与css sprites技术类似。    
	        imageOffset: new BMap.Size(0, 0)   // 设置图片偏移    
	    });      
	    // 创建标注对象并添加到地图   
	    var marker = new BMap.Marker(pointIn, {icon: myIcon});
	    marker.addEventListener("click",function(){
	    	// 在这里添加点击后的事件
	    	$("#btn_modal_func").click();
	    	
	        func_modal_show_player(usernameIn);
	        
	    });
	    map.addOverlay(marker);
}
function _addSurrRanges(idIn,nameIn,posIn,styleIn)
{

	let step=0;
	while(step<pos.length)
	{
		// map.addOverlay(data_range_polygons[step]);
		step++;
	}
	
	
	 
    // 创建标注对象并添加到地图   
    // var marker = new BMap.Marker(point, {icon: myIcon});     
}
function _addSurrsNPC(pointIn,indexIn)
{
	var myIcon = new BMap.Icon("imgs/icon_npc.png", new BMap.Size(32, 32), {    
        // 指定定位位置。   
        // 当标注显示在地图上时，其所指向的地理位置距离图标左上    
        // 角各偏移10像素和25像素。您可以看到在本例中该位置即是   
        // 图标中央下端的尖角位置。    
        anchor: new BMap.Size(16, 16),    
        // 设置图片偏移。   
        // 当您需要从一幅较大的图片中截取某部分作为标注图标时，您   
        // 需要指定大图的偏移位置，此做法与css sprites技术类似。    
        imageOffset: new BMap.Size(0, 0)   // 设置图片偏移    
    });      
    // 创建标注对象并添加到地图   
    var marker = new BMap.Marker(pointIn, {icon: myIcon});
    marker.addEventListener("click",function(){
    	// 在这里添加点击后的事件
    	alert("npc clicked "+indexIn);
    });
    map.addOverlay(marker);
}

setInterval("_refreshSurrs()",100000);

function func_modal_show_player(usernameIn)
{
	let target=document.getElementById("modal_func_body");
	
	let str_get=$.get("AJAX_Handler.jsp?act=OQinfo&username="+usernameIn,function(){

		let json_get=JSON.parse(str_get.responseText);

		
		let target=document.getElementById("modal_func_body");
		document.getElementById("modal_func_head").innerText=usernameIn;
		
	    target.innerHTML="";
	    target.innerHTML+="物攻"+json_get.result.atk_p+"<br>";
	    target.innerHTML+="物防"+json_get.result.def_p+"<br>";
	    target.innerHTML+="魔攻"+json_get.result.atk_m+"<br>";
	    target.innerHTML+="魔防"+json_get.result.def_m+"<br>";
	    target.innerHTML+="速度"+json_get.result.speed+"<br>";
	    target.innerHTML+="命中"+json_get.result.acc+"<br>";
	    target.innerHTML+="生命上限"+json_get.result.hp_limit+"<br>";
	    target.innerHTML+="生命恢复"+json_get.result.hp_re+"<br>";
	    target.innerHTML+="魔法上限"+json_get.result.mp_limit+"<br>";
	    target.innerHTML+="魔法恢复"+json_get.result.mp_re+"<br>";
	    target.innerHTML+="主职业"+json_get.result.class+"<br>";
	    target.innerHTML+="主职业等级"+json_get.result.lv+"<br>";
	    target.innerHTML+="副职业"+json_get.result.class_sub+"<br>";
	    target.innerHTML+="副职业等级"+json_get.result.lv_sub+"<br>";
	    
	    target.innerHTML+="<br>";
	});
    
}
function func_modal_show_npc(idRangeIn)
{
	let target=document.getElementById("modal_func_body");
    // target.innerHTML="player"+indexIn+"modal";
}
function func_modal_show_shop(idRangeIn)
{
	let target=document.getElementById("modal_func_body");
    // target.innerHTML="player"+indexIn+"modal";
}

</script>


<!-- 位置控制按钮 -->
	<div id="ctrller_box">
		<div id="btn_top" class="btns_dir" onclick="btn_click_move_up()">↑</div>
		<div id="btn_left" class="btns_dir" onclick="btn_click_move_left()">←</div>
		<div id="btn_right" class="btns_dir" onclick="btn_click_move_right()">→</div>
		<div id="btn_bottom" class="btns_dir" onclick="btn_click_move_down()">↓</div>
	</div>


<div id="bottom-box">

<!-- 按钮行 -->
<div id="btn-line">
	<span class="btns" data-toggle="modal" data-target="#modal_info" onclick="btn_click_info()">信息</span>
	<span class="btns" data-toggle="modal" data-target="#modal_inv" onclick="btn_click_inv()">背包</span>
	<span class="btns" data-toggle="modal" data-target="#modal_soc" onclick="btn_click_soc()">社交</span>
	<span class="btns" data-toggle="modal" data-target="#modal_make" onclick="btn_click_make()">合成</span>
	<span class="btns" data-toggle="modal" data-target="#modal_setting" onclick="btn_click_setting()">设置</span>
	<span class="btns" data-toggle="modal" data-target="#modal_func" onclick="" id="btn_modal_func" style="display:none">动作</span>
</div>

<!-- 头像 -->
<div id="pf-pic"><img src="imgs/icon_player.png"></div>

</div>




<div class="container">
<!-- 模态框 玩家信息 -->
  <div class="modal fade" id="modal_info">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
   
        <!-- 模态框头部 -->
        <div class="modal-header">
          <h4 class="modal-title">玩家信息</h4><h5><%=Utils.get(session,"username") %></h5>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
   
        <!-- 模态框主体 -->
        <div class="modal-body" id="modal_info_body">
          玩家信息
        </div>
   
        <!-- 模态框底部 -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
        </div>
   
      </div>
    </div>
  </div>
  
<!-- 模态框 背包栏 -->
  <div class="modal fade" id="modal_inv">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
   
        <!-- 模态框头部 -->
        <div class="modal-header">
          <h4 class="modal-title">背包</h4>
          <span style="color:gold" id="out_coin_gold">金币:100</span>|
          <span style="color:silver" id="out_coin_silver">银币:100</span>|
          <span style="color:#b45836" id="out_coin_copper">铜币:100</span>|
          <span style="color:#336699" id="out_coin_irisia">艾瑞希亚币:100</span>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
   
        <!-- 模态框主体 -->
        <div class="modal-body" id="modal_inv_body">
          背包信息
        </div>
   
        <!-- 模态框底部 -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
        </div>
   
      </div>
    </div>
  </div>
  
<!-- 模态框 社交栏 -->
  <div class="modal fade" id="modal_soc">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
   
        <!-- 模态框头部 -->
        <div class="modal-header">
          <h4 class="modal-title">社交</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
   
        <!-- 模态框主体 -->
        <div class="modal-body" id="modal_soc_body">
         社交信息
        </div>
   
        <!-- 模态框底部 -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
        </div>
   
      </div>
    </div>
  </div>
  
  <!-- 模态框 社交栏 -->
  <div class="modal fade" id="modal_make">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
   
        <!-- 模态框头部 -->
        <div class="modal-header">
          <h4 class="modal-title">合成</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
   
        <!-- 模态框主体 -->
        <div class="modal-body" id="modal_make_body">
         合成栏
        </div>
   
        <!-- 模态框底部 -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
        </div>
   
      </div>
    </div>
  </div>
  
  <!-- 模态框 设置栏 -->
  <div class="modal fade" id="modal_setting">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
   
        <!-- 模态框头部 -->
        <div class="modal-header">
          <h4 class="modal-title">设置</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
   
        <!-- 模态框主体 -->
        <div class="modal-body" id="modal_setting_body">
        
        <div><a href="ShopPage.jsp">商店</a></div>
        
        </div>
   
        <!-- 模态框底部 -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
        </div>
   
      </div>
    </div>
  </div>
   
  <!-- 模态框 动作栏 -->
  <div class="modal fade" id="modal_func">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
   
        <!-- 模态框头部 -->
        <div class="modal-header">
          <h4 class="modal-title" id="modal_func_head">动作</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
   
        <!-- 模态框主体 -->
        <div class="modal-body" id="modal_func_body">
        动作信息
        </div>
   
        <!-- 模态框底部 -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
        </div>
   
      </div>
    </div>
  </div>
  
  
</div>


</body>  
</html>