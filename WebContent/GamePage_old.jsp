<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.io.*,java.sql.*,servlet.*,game.main.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" /> 
<title>SMO网络</title>

<style>
body
{
margin:0px;
padding:0px;
font-size:36px;
}
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


#ctrller_box
{
	border-radius:20px;
	width:150px;
	height:150px;
	line-height:50px;
	position:fixed;
	bottom:100px;
	right:50px;
	background-color: #45818e;
}
.btns_dir
{
	border-radius:10px;
	width:50px;
	height:50px;
	text-align:center;
	user-select: none;
	background-color:lightblue;
}
.btns_dir:hover
{
	background-color: #cfe2f3;
}
.btns_dir:active
{
	background-color: #9fc5e8;
}
#btn_top
{
	position:absolute;
	left:50px;
	top:0px;
}
#btn_left
{
	position:absolute;
	left:0px;
	top:50px;
}
#btn_right
{
	position:absolute;
	left:100px;
	top:50px;
}
#btn_bottom
{
	position:absolute;
	left:50px;
	top:100px;
}
</style>

<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

<script type="text/javascript">
	console.clear();
	console.log("开始加载游戏");

	
	// 加载所有基础信息
	function check_data()
	{
	    if(hasgot_data_item && hasgot_data_monster)
	    {
	        // 获取完所有信息
	        console.log("基础信息加载完成");
	        // process_bar_status+=10;
		    // setProcessBarStatus("process_bar",process_bar_status);
	        
	        data_item=JSON.parse(str_item.responseText);
	        data_monster=JSON.parse(str_monster.responseText);
	        
	        // process_bar_status+=10;
		    // setProcessBarStatus("process_bar",process_bar_status);
	    }
	}
	// 用AJAX从服务器获取
	var data_item;var hasgot_data_item=false; // 所有的物品信息
	var data_monster;var hasgot_data_monster=false; // 所有的怪物信息
	
	var username="<%=Utils.get(session,"username")%>";
	console.log("玩家名为"+username);
	
	var str_item=$.get("Data_Item_Handler.jsp",function(){
	    hasgot_data_item=true;
	    // process_bar_status+=10;
	    // setProcessBarStatus("process_bar",process_bar_status);
	    check_data();
	});
	var str_monster=$.get("Data_Monster_Handler.jsp",function(){
	    hasgot_data_monster=true;
	    // process_bar_status+=10;
	    // setProcessBarStatus("process_bar",process_bar_status);
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
	    target.innerHTML+="生命上限"+jsonIn.result.hp_limit+"<br>";
	    target.innerHTML+="生命恢复"+jsonIn.result.hp_re+"<br>";
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
	}
	function modal_show_inv(jsonIn)
	{
	    let target=document.getElementById("modal_inv_body");
	    target.innerHTML="";
	    let step=0;
	    while(step<jsonIn.result.amounts)
	    {
	        target.innerHTML+=
	        	( (parseInt(jsonIn.result.slot[step]) >0) ? " <span style=\"color:green\">穿戴中</span> ":"")+
			getItemNameById(jsonIn.result.id_item[step])+" × "+
	        jsonIn.result.amount[step]+" | "+
	        (getItemUsableById(jsonIn.result.id_item[step])? UI_InvItemUse(jsonIn.result.id_item[step],jsonIn.result.order[step]) :"")+
	        (getItemDropableById(jsonIn.result.id_item[step])? UI_InvItemDrop(jsonIn.result.id_item[step],jsonIn.result.order[step]) :"")+
	        UI_InvItemCheck(jsonIn.result.id_item[step],jsonIn.result.order[step])+
	        "<br>";
	        step++;
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
			let str_get_can=$.get("AJAX_Handler.jsp?act=Qcancraft&id_crafting="+idIn,function(){
				console.log(str_get_can);
				str_get_can=str_get_can.result;
				console.log(str_get_can);
			});; // 获取原材料
			console.log("直接输出"+str_get_can);
			let str_get_raws=$.get("AJAX_Handler.jsp?act=Qcraftingraw&id_crafting="+idIn,function(){
				let json_get=JSON.parse(str_get_raws.responseText);
				let text="";
				
				alert(json_get);
			});; // 获取原材料
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
	

	
	
console.log("嘛 可能是加载完了 谁知道呢..");
console.log("反正加载不完跟我也没关系 嗯");
</script>
</head>

<body>  

<div class="progress">
    <div class="progress-bar progress-bar-striped progress-bar-animated" id="process_bar" style="width: 40%;"></div>
  </div>





<div style="width:100%;height:90%;border:5px solid red;">
<div id="container"></div> 
</div>

<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&ak=TTGBXxjhg74WayrWPgAk6pLmqzRHIrX9&services=&t=20171031174121"></script>
<script type="text/javascript"> 
var map= new BMap.Map("container");
// setTimeout(function(){map = new BMap.Map("container");},200);

// 创建地图实例  
console.log(map);

var loc_x=121.363847;
var loc_y=37.526844;
// 按钮 - 移动
function btn_click_move_up()
{
loc_y+=0.000020;
map_re_center();
}
function btn_click_move_left()
{
loc_x-=0.000020;
map_re_center();
}
function btn_click_move_right()
{
loc_x+=0.000020;
map_re_center();
}
function btn_click_move_down()
{
loc_y-=0.000020;
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
</div>

<!-- 头像 -->
<div id="pf-pic">头像</div>

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
        设置信息
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