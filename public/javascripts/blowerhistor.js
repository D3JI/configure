function getCookieVal (offset) { 
	var cook = decodeURI(document.cookie);
	var endstr = cook.indexOf (";", offset); 
	if (endstr == -1) endstr = cook.length; 
	return unescape(cook.substring(offset, endstr)); 
}    
function getCookie (name) {
	 var arg = name + "="; 
	 var alen = arg.length; 
	 var cook = decodeURI(document.cookie);
	 var clen = cook.length; 
	 var i = 0; 
	 while (i < clen) { 
		 var j = i + alen; 
		 if (cook.substring(i, j) == arg) return getCookieVal (j); 
		 i = cook.indexOf(" ", i) + 1; 
		 if (i == 0) break; 
	 }
  return null; 
} 

function setCookie ( name, value) { 
	   value = encodeURI(value);
       var exp = new Date(); 
       exp.setTime (exp.getTime()+3600000000); 
	   var str_url = window.location.href; 
		var arr_param=new Array(); 
		arr_param=str_url.split("/"); 
		var url_string = arr_param[2];
	    document.cookie = name + "=" + value + "; expires=" + exp.toGMTString() + ";path=" + "/" + "; domain=" + url_string;
	   
}

function history_insert(linkname,address){
	address=address+"_sale_mimimama_";
	wlink=linkname+"+"+address; 
	old_info=getCookie("historyinfo");
	var insert_s=true; 
	////////////////////////
	if(old_info==null)          //判断cookie是否为空
	{
		insert=true;
	}else{ 
		var old_link=old_info.split("_sale_mimimama_");
		var len_old = old_link.length;
		for(var j=0;j<=12 && j<len_old ;j++)
		{
			if(old_link[j].indexOf(linkname)!=-1)	insert_s=false;
			if(old_link[j]=="null") 	break;
		}
	}
	/////////////////////////////
	if(insert_s)                //如果符合条件则重新写入数据
	{
		wlink+=getCookie("historyinfo");
		setCookie("historyinfo",wlink);
		//history_show().reload();
	}
	
}
//////////////////////////////////////////////////////////////////////////////// 
function history_show()
{   
var historyinfo=getCookie("historyinfo");
var content=""; 
if(historyinfo!=null)
{
history_arg=historyinfo.split("_sale_mimimama_");
var i;
var len = history_arg.length;
for(i=0;i<=12;i++)
{
	
   if( i < len && history_arg[i]!="null")
   {
    var wlink=history_arg[i].split("+");
    content+=("<li><a href='"+wlink[1]+"' target='_blank'>"+wlink[0]+"</a></li>");
    }
    document.getElementById("history").innerHTML=content;
    }
}
else
{document.getElementById("history").innerHTML="";}
}
