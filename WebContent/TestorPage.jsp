<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*,servlet.*,java.sql.*,game.main.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试者页面</title>
<style>
input
{
	width:600px;
}
</style>

<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

<script>
function send_ajax()
{
	$("#out_ajax").load(document.getElementById("in_ajax").value,document.getElementById("in_ajax_params").value,function(){;});
}
var thread_id_ping;
function start_send()
{
	thread_id_ping=setInterval("_ping()",5000);
	console.log("start - "+thread_id_ping);
}
function stop_send()
{
	clearInterval(thread_id_ping);
	console.log("stop - "+thread_id_ping);
}
function _ping()
{
	console.log("ping - "+new Date());
	$("#out_ping").load("AJAX_Handler.jsp","username=player3&act=Aping&loc_x=0&loc_y=0",function(){;});
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
function show_info()
{
	modal_show_info(JSON.parse($("#out_ajax")[0].innerText));
}
function modal_show_inv(jsonIn)
{
    let target=document.getElementById("modal_inv_body");
    target.innerHTML="";
    let step=0;
    while(step<jsonIn.result.amounts)
    {
        target.innerHTML+="id_item:"+jsonIn.result.id_item+" × ";
        target.innerHTML+=""+jsonIn.result.amount;
        target.innerHTML+=" | 使用 | 丢弃";
        target.innerHTML+="<br>";
        step++;
    }
}
function show_inv()
{
	modal_show_inv(JSON.parse($("#out_ajax")[0].innerText));
}


function check_data()
{
    if(hasgot_data_item && hasgot_data_monster)
    {
        // 获取完所有信息
        console.log("基础信息加载完成");
        data_item=JSON.parse(str_item.responseText);
        data_monster=JSON.parse(str_monster.responseText);
    }
}
// 基础信息 游戏一开始就用AJAX从服务器获取
var data_item;var hasgot_data_item=false; // 所有的物品信息
var data_monster;var hasgot_data_monster=false; // 所有的怪物信息

var str_item=$.get("Data_Item_Handler.jsp",function(){
    hasgot_data_item=true;
    check_data();
});
var str_monster=$.get("Data_Monster_Handler.jsp",function(){
    hasgot_data_monster=true;
    check_data();
});
</script>

</head>
<body>

<div id="id_out_status">当前状态:</div>

<table>
	<tr>
		<td>loc_x</td>
		<td><input type="number" id="in_loc_x" value="0"></td>
	</tr>
	<tr>
		<td>loc_y</td>
		<td><input type="number" id="in_loc_y" value="0"></td>
	</tr>
	<tr>
		<td>ajax目标地址</td>
		<td><input type="text" id="in_ajax" value="AJAX_Handler.jsp"></td>
	</tr>
	<tr>
		<td>ajax参数</td>
		<td><input type="text" id="in_ajax_params"></td>
	</tr>
	
</table>
<button onclick="start_send()">开始发送</button>
<button onclick="stop_send()">停止发送</button>
<button onclick="send_ajax()">发送ajax</button>
<br>

ping回传内容<br>
<div id="out_ping">
ping回传结果
</div>

ajax回传内容<br>
<div id="out_ajax">
ajax回传结果
</div>




<div id="bottom-box">
<!-- 信息行 -->
<div id="info-line">玩家信息</div>

<!-- 按钮行 -->
<div id="btn-line">
	<span  class="btns" data-toggle="modal" data-target="#modal_info">信息</span>
	<span class="btns" data-toggle="modal" data-target="#modal_inv">背包</span>
	<span class="btns">社交</span>
	<span class="btns">设置</span>
</div>

<!-- 头像 -->
<div id="pf-pic">头像</div>

</div>

<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal_info">
    打开模态框
  </button>

<!-- 模态框 玩家信息 -->
  <div class="modal fade" id="modal_info">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
   
        <!-- 模态框头部 -->
        <div class="modal-header">
          <h4 class="modal-title">玩家信息</h4><h5>玩家名</h5>
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
  
  进度条测试<br>
  <div class="progress">
    <div class="progress-bar progress-bar-striped progress-bar-animated" id="process_bar" style="width:40%"></div>
  </div>


<%=Utils.UI_InvBtnUse("1","-1")+Utils.UI_InvBtnDrop("1","-1")+Utils.UI_InvBtnCheck("1","-1") %>
</body>
</html>