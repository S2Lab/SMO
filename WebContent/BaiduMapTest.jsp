<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>  
<html>
<head>  
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<title>Hello, World</title>  
<style type="text/css">  
html{height:100%}  
body{height:100%;margin:0px;padding:0px}  
#container{height:100%}  



#ctrller_box{border-radius:20px;width:150px;
	height:150px;line-height:50px;position:fixed;
	bottom:100px;right:50px;background-color: #45818e;
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

</style>  
<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&ak=TTGBXxjhg74WayrWPgAk6pLmqzRHIrX9&services=&t=20171031174121"></script>
</head>
 
<body>  
<div id="map_main">地图</div> 
<script type="text/javascript">
//当前位置信息
// 暂时直接定位到鲁东大学北23宿舍楼的位置
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


var map = new BMap.Map("map_main");
// 创建地图实例  
var point = new BMap.Point(loc_x, loc_y);
// 创建点坐标  
map.centerAndZoom(point, 19);
map.enableScrollWheelZoom(false);
map.setMapStyle({style:'midnight'});
// 初始化地图，设置中心点坐标和地图级别  
</script>  

  <!-- 位置控制按钮 -->
	<div id="ctrller_box">
		<div id="btn_top" class="btns_dir" onclick="btn_click_move_up()">↑</div>
		<div id="btn_left" class="btns_dir" onclick="btn_click_move_left()">←</div>
		<div id="btn_right" class="btns_dir" onclick="btn_click_move_right()">→</div>
		<div id="btn_bottom" class="btns_dir" onclick="btn_click_move_down()">↓</div>
	</div>

</body>  
</html>