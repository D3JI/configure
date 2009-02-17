var defaultMenuWidth="150"; //set default menu width.
var linkset;
if(typeof(mkfriends)=="undefined"){
	mkfriends=function (ID){
		var ID = ID;
		jx('/makefriends.php?uid='+ID,"","post",function(t) {var ir=t.responseText;if(ir=="-1"){loginDlg.show();return;}msgDlg.show(ir);return;});
	}
}
if(typeof(records)=="undefined"){
	records=function(uid,nk){
		var x=browser.getWindowCenter().x-115;
		var y=browser.getWindowCenter().y-240;
		var uid = uid;
		var nk=nk;
		jx('/record.php?id='+uid,"","post",function(t){
        	var ir=t.responseText;
			if(ir != '') {var msger=new Window('result',"查看 "+nk+" 的积分",ir,x,y,230,480);msger.show();} return;
    	});
	}
}
function geneinner(id,nickname,username,myid) {
	linkset = '';
	if ( myid && (id != myid)) {
		linkset+='<a href="#" onClick="mkfriends('+id+');return false">加<span style="color:darkblue">'+nickname+'</span></b>为好友</a>';
		linkset+='<a href="#" onclick="msgMgr.send('+id+',\''+nickname+'\');return false">给<span style="color:darkblue">'+nickname+'</span>写短消息</a>';
		linkset+='<a href="mail_new.php?mid='+id+'" target="_blank">给<span style="color:darkblue">'+nickname+'</span></b>发送信件</a>';
	}
	linkset+='<a href="http://www.mimimama.com/home.php?u='+username+'" target="_blank">看<span style="color:darkblue">'+nickname+'</span>的个人门户</a>';
	linkset+='<a href="/myclan.php?mid='+id+'" target="_blank">看<span style="color:darkblue">'+nickname+'</span>加入的圈子</a>';
	linkset+='<a href="/photos.php?mid='+id+'" target="_blank">看<span style="color:darkblue">'+nickname+'</span>的相册</a>';
	linkset+='<a href="/blogs.php?mid='+id+'" target="_blank">看<span style="color:darkblue">'+nickname+'</span>的文章</a>';
	linkset+='<a href="#" onclick="records('+id+',\''+nickname+'\');return false;" target="_blank">看<span style="color:darkblue">'+nickname+'</span>的积分</a>';
	return linkset;
}

var ie5=document.all && !window.opera;
var ns6=document.getElementById;

if (ie5||ns6){
	try{
		var o=document.createElement("div");
		body.appendChild(o);
		o.setAttribute("id","popitmenu");
		o.setAttribute("onMouseover","clearhidemenu();");
		o.setAttribute("onMouseout","dynamichide(event)");
		//document.write('<div id="popitmenu" onMouseover="clearhidemenu();" onMouseout="dynamichide(event)"></div>');
	}catch(ex){}
}
function changeinner(id,name) {
	document.getElementById('waitting').innerHTML='<a href="addlink.php?uid='+id+'">将'+name+'加为好友</a>';
}

function iecompattest(){
	return (document.compatMode && document.compatMode.indexOf("CSS")!=-1)? document.documentElement : document.body;
}

function showmenu(e,id,nickname,username,myid,optWidth){
	if (!document.all&&!document.getElementById) return;
	clearhidemenu();
	menuobj=ie5? document.all.popitmenu : document.getElementById("popitmenu");
	if(!menuobj){
		var o=document.createElement("div");
		document.body.appendChild(o);
		o.setAttribute("id","popitmenu");
		o.setAttribute("onMouseover","clearhidemenu();");
		o.setAttribute("onMouseout","dynamichide(event)");
		menuobj=ie5? document.all.popitmenu : document.getElementById("popitmenu");
	}
	menuobj.innerHTML=geneinner(id,nickname,username,myid);
	menuobj.style.width=(optWidth?optWidth:defaultMenuWidth)+"px";
	menuobj.contentwidth=menuobj.offsetWidth;
	menuobj.contentheight=menuobj.offsetHeight;
	eventX=ie5? event.clientX : e.clientX;
	eventY=ie5? event.clientY : e.clientY;
	var rightedge=ie5? iecompattest().clientWidth-eventX : window.innerWidth-eventX;
	var bottomedge=ie5? iecompattest().clientHeight-eventY : window.innerHeight-eventY;
	if (rightedge<menuobj.contentwidth) menuobj.style.left=ie5? iecompattest().scrollLeft+eventX-menuobj.contentwidth+"px" : 	window.pageXOffset+eventX-menuobj.contentwidth+"px";
	else menuobj.style.left=ie5? iecompattest().scrollLeft+eventX+"px" : window.pageXOffset+eventX+"px";
	if (bottomedge<menuobj.contentheight) menuobj.style.top=ie5? iecompattest().scrollTop+eventY-menuobj.contentheight+"px" : window.pageYOffset+eventY-menuobj.contentheight+"px";
	else menuobj.style.top=ie5? iecompattest().scrollTop+event.clientY+"px" : window.pageYOffset+eventY+"px";
	menuobj.style.visibility="visible";
	return false;
}

function contains_ns6(a, b) {
	//Determines if 1 element in contained in another- by Brainjar.com
	while (b.parentNode)
		if ((b = b.parentNode) == a)return true;
	return false;
}

function hidemenu(){
	if (window.menuobj)	menuobj.style.visibility="hidden";
}

function dynamichide(e){
	if (ie5&&!menuobj.contains(e.toElement))hidemenu();
	else if (ns6&&e.currentTarget!= e.relatedTarget&& !contains_ns6(e.currentTarget, e.relatedTarget))hidemenu();
}

function delayhidemenu(delay){
	var delay=delay?delay:10000;
	delayhide=setTimeout("hidemenu()",10000);
}

function clearhidemenu(){
	if (window.delayhide)clearTimeout(delayhide);
}

if (ie5||ns6)
document.onclick=hidemenu;