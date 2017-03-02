<%@page import="java.util.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.4/raphael-min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
 <div id="can"></div>
  <div id="canvas"></div>
 
<script type="text/javascript">
<%String n=(String)request.getAttribute("name");
String pas=(String)request.getAttribute("number");
String fin=(String)request.getAttribute("final");
String init=(String)request.getAttribute("init");
String eps=(String)request.getAttribute("eps");
String tr=(String)request.getAttribute("tableau de transitions");
String st=(String)request.getAttribute("tableau d'états");
System.out.println("-"+st+"-");
String q0=(String)request.getAttribute("l'état initial");
String f=(String)request.getAttribute("les états finaux");
System.out.println("-"+f+"-");
String nb_etat=(String)request.getAttribute("nombre d'états");
String nb_symb=(String)request.getAttribute("nombre de transitions");
%>
<%
int arr[];
int m =Integer.parseInt(n);
out.print(m);
int in=Integer.parseInt(init);
%>
var eps="<%out.print(eps);%>";
//if(name==null||)
	
var nb_etat=<%out.print(m);%>
var init=<%out.print(in);%>
console.log("init"+init);
var fin0=-1;
var fin=[];
fin="<%out.print(fin);%>";
var fin1=[];
fin1=fin.split(",");
console.log(fin1);
if(fin.length>1){
	//fin1=fin.split(",");
	for(i=0;i<fin1.length;i++){
		fin1[i]=parseInt(fin1[i]);
	}
	console.log('ho');
}
else{
	fin0=parseInt(fin);
	console.log("fin"+fin0);
	console.log('hoelse');
}
console.log("fin"+fin);
var down=false;
var pas_arr=[];
var from_arr=[];
var to_arr=[];
var valeur=0;
var valeur1=0;
var v=<%out.print(m);%>
var pas=[];
 pas="<%out.print(pas);%>";
 pas1=pas.split(",");
 console.log("epsilon"+eps);
 if(eps==="avec"){
	 pas1.push("*");	
	 console.log ('paaaas1'+pas1);
	}

console.log("pas"+pas);
var paper = Raphael(document.getElementById('can'));
var paper2=Raphael(document.getElementById("canvas"));
var ids=[];
var Xs=[];
var Ys=[];
var val=[];
var val1=[];
var it=0;
var link={from:"",to:"",pas:""};
var links=[];
var archtype = Raphael("canvas", 200, 100);
paper2.customAttributes.arc = function (xloc, yloc, value, total, R) {
    var alpha = 360 / total * value,
        a = (90 - alpha) * Math.PI / 180,
        x = xloc + R * Math.cos(a),
        y = yloc - R * Math.sin(a),
        path;
    if (total == value) {
        path = [
            ["M", xloc, yloc - R],
            ["A", R, R, 0, 1, 1, xloc - 0.01, yloc - R]
        ];
    } else {
        path = [
            ["M", xloc, yloc - R],
            ["A", R, R, 0, +(alpha > 180), 1, x, y]
        ];
    }
    return {
        path: path
    };
};
Array.prototype.assemble=function(obj){
	var length= this.length;
	for(i=0;i<length;i++){
		for(j=0;j<length;j++){
			if(obj[i]["from"]==obj[j]["from"]&&obj[i]["pas"]==obj[j]["pas"]){
				obj[i]["from"].concat(",",obj[j]["from"]);				
			}
		}
	}
	
}
Array.prototype.find=function(obj){
	var i=this.length;
	while (i--) {
        if (this[i] === obj) {
            return i;
        }
    }
    return false;	
}
Array.prototype.contains = function(obj){
    var i = this.length;
    while (i--) {
        if (this[i] === obj) {
            return true;
        }
    }
    return false;
}

Raphael.st.draggable = function() {
  var me = this,
  	  oldx = 0,
      lx = 0,
      ly = 0,
      ox = 0,
      oy = 0,       
      moveFnc = function(dx, dy) {
	 
	  	var test=ids.contains(this.data("id"));
	  	if(!test){
          lx = dx + ox;
          ly = dy + oy;
          me.transform('t' + lx + ',' + ly);       
	  	}else{
          this.mousedown(        		  
      			function(e) {  				
      			  x = e.offsetX;
      		      y = e.offsetY;    		       		 		
      			  line = Line(x, y, x, y, paper);
      			  $("#can").bind('mousemove', function(e) {
      			  x = e.offsetX;
      			  y = e.offsetY;
      			line.updateEnd(x, y);
   		  
   		   	console.log("oldx"+oldx);
   			console.log("oldxxxxxxx"+Math.abs(x-oldx));
   			
   		        if(Math.abs(x-oldx)<9){
   		        	console.log("hiiiiiiiii");
      			 ////line
      			  console.log("hhh")
   		        }
   		     		oldx = e.pageX;
      				 down=true;
      				index=ids.find(link["from"]);
     				console.log("index hhhhh"+index);
     				console.log(Xs[index]);
     				console.log("kk"+Xs[index]);
     				console.log(oldx-Xs[index]);
     				if(Math.abs(Xs[index]-oldx)>20){
     					console.log("xs index");
     				}
      				
      			      		});	
 				 link["from"]=this.data("id");
 				
       });
             }
      },
      startFnc = function() {},
      endFnc = function() {
    	  var test=ids.contains(this.data("id"));
          if(!test){
    		  Xs.push(this.attr('cx')+lx);
    		  Ys.push(this.attr('cy')+ly);
              ids.push(this.data("id"));
    	  }
          else{
        	  $("#can").bind("contextmenu", function(e) {
        		 console.log("pageX"+e.pageX);
        		 down=false;
  			   for(i=0;i<v;i++){					   					   
			   	  if(Math.abs(e.pageX-Xs[i])<=22&&Math.abs(e.pageY-Ys[i])<=22){	
			   		  console.log('ii'+i);
			   		paper.path([
			   			'M', e.pageX-10, e.pageY-10,
			   			'a', 25,25, 0, 1, 1, 0, -10
			   			]).attr({stroke:'black', 'stroke-width': 2, 'arrow-end':'open-wide-long'});
			   		console.log("valeur"+valeur1);
			   		console.log("vaaal"+val1);	
			   		console.log("teeeest"+val1.contains(valeur1));
			   		if(!val1.contains(valeur1)){
		        		  val1.push(valeur1);			        	  	
		        		    x_p=e.pageX-47;
					   		y_p=e.pageY-10;			   	
					   		link["to"]=ids[i];
					   		to_arr[it]=link['to'];
					   		link["from"]=ids[i];
					   		from_arr[it]=ids[i];
			        		  console.log('froom'+link["from"]);
			        		 console.log('toooo'+link["to"]);				        				        					        							        		 
			        		  var j=ids.find(link["from"]);
		        		 console.log("val1 "+val1.length);		        	  
		        		 console.log("length"+links.length);
		        		  $("#id"+valeur1).css({"position":"absolute","top":y_p+"px","left":x_p+"px","width":10+"px","display":"block"});
		        		  $("#id"+valeur1).keydown(function(e){
		        			  console.log(e.keyCode);
		        			  if(e.keyCode==13){
		        			 console.log("valeur change");
		        			 var p1=$(this).val()
		        			 if(pas1.contains(p1)){
		        				 pas_arr[it]=$(this).val();
		        				 link["pas"]=$(this).val();
			        			 //links.push(link);
			        			 console.log("lol");
			        			 console.log("val l"+val.length);		        	  
				        		 console.log("length"+links.length);
				        		 console.log("length pas_arr"+pas_arr.length);
								it++;
						        var id=$(this).attr("id");
						        //$(this).attr('disabled','disabled');
			        			$(this).css({"display":"none"});
			        			$(this).hide();
			        			 console.log("gggg"+$(this).val());
					        	$("#can1"+valeur1).html($(this).val()).css({"position":"absolute","top":y_p+"px","left":x_p+"px","width":20+"px"});
					        	valeur1++;
		        			 }
		        			 else{
		        				 alert("not valid ");
		        			 }
				        	}
		        		  });
		        		  $("#can1"+valeur).keyup(function(e){
		        			  console.log("up"+e.keyCode);
		        		  console.log("paa"+link["pas"]);
		        		  });
		        		  break;
		        	  }	//end if			        
			   	  }//end if 1
  			   }//end for
			  
  			    e.preventDefault();
  			});
        	 $("#can").bind("contextmenu");
    	  $("#can").mouseup(
				    function(e) {				    					  				    	 
					   for(i=0;i<v;i++){					   					   
						console.log('mouse');
						console.log(down);
				        	  if(Math.abs(e.offsetX-Xs[i])<=22&&Math.abs(e.offsetY-Ys[i])<=22){					        		  
				        		  $("#can").unbind('mousemove');
				        		  console.log('mouse');
				        		  console.log("contains"+val.contains(valeur));
				        	  if(!val.contains(valeur)){
				        		  
				        	  console.log("im here");				        		  	        	  
				        		 console.log("i  "+i);
				        		  //console.log("ids=="+ids);			       		  
				        		  link["to"]=ids[i];
				        		  
				        		  from_arr[it]=link['from'];
				        		  to_arr[it]=link["to"];
				        		  console.log('froom mouse'+link["from"]);
				        		 console.log('toooo mouse'+link["to"]);
				        		 //console.log('toooo_arr'+to_arr);				        		
				        		 if(down==true){	
				        			 val.push(valeur);			      
				        		 console.log("equals");
				        		 down=false;
				        		  var j=ids.find(from_arr[it]);        		  
				        		 var x_p=Math.abs((Xs[j]-Xs[i])/2-Xs[j]);
				        		 var y_p=Math.abs((Ys[j]-Ys[i])/2-Ys[j]);
				        		 console.log("xxxx[j]"+Xs[j]);
				        		 console.log("x[i]"+Xs[i]);
				        		 console.log("val l"+val.length);		        	  
				        		 console.log("length"+links.length);
				        		  $("#"+valeur).css({"position":"absolute","top":y_p+"px","left":x_p+"px","width":20+"px","display":"block"});
				        		  $("#"+valeur).keydown(function(e){
				        			  console.log(e.keyCode);
				        		if(e.keyCode==13){
				        			 console.log("valeur change");
				        				var val1=$(this).val();
				        				console.log("vaaal "+val1);
				        				console.log("valoooo"+val1.length);
				        			 if(val1.length>1){	
				        				var val1_sp=val1.split(",");
				        				console.log("vaaaleur"+val1_sp[0]);
				        				console.log("lenght"+val1_sp.length);
				        				 for(sp=0;sp<val1_sp.length;sp++){
				        					 
				        				 console.log("for");
				        					 if(pas1.contains(val1_sp[i])){
				        						 console.log("vaaaleur111"+val1_sp[i]);
						        				 link["pas"]=val1_sp[i];
						        				 pas_arr[it]=val1_sp[i];
						        				 from_arr[it]=link["from"];
						        				 to_arr[it]=link["to"];
							        			 //links.push(link);
							        			 it++;
							        			 console.log("iterator"+it)
							        			 console.log("val l"+val.length);		        	  
								        		 console.log("length pas arry mouse"+pas_arr.length);
										        var id=$(this).attr("id");
										        $(this).attr('disabled','disabled');
							        			$(this).css({"display":"none"});
							        			$(this).hide();
							        			 console.log("gggg"+$(this).val());
									        	$("#can"+valeur).html($(this).val()).css({"position":"absolute","top":y_p+"px","left":x_p+"px","width":20+"px"});
									        	valeur++;
						        			 }
						        			 else{
						        				 console.log("vaaal"+val1);				
						        				 alert("not valid: veuiller ");
						        				 break;	 
						        			 }
				        				 }
				        			 }
				        			 else{
				        				 if(pas1.contains($(this).val())){
					        				 link["pas"]=$(this).val();
					        				 pas_arr[it]=$(this).val();
						        			 //links.push(link);
						        			 it++;
						        			 console.log("iterator"+it)
						        			 console.log("val l"+val.length);		        	  
							        		 console.log("length pas arry mouse"+pas_arr.length);
									        var id=$(this).attr("id");
									        $(this).attr('disabled','disabled');
						        			$(this).css({"display":"none"});
						        			$(this).hide();
						        			 console.log("gggg"+$(this).val());
								        	$("#can"+valeur).html($(this).val()).css({"position":"absolute","top":y_p+"px","left":x_p+"px","width":20+"px"});
								        	valeur++;
					        			 }
					        			 else{
					        				 alert("not valid: veuiller ");
					        				 
					        				 
					        			 }
				        			 }
				        			/* if(pas1.contains($(this).val())){
				        				 link["pas"]=$(this).val();
				        				 pas_arr[it]=$(this).val();
					        			 //links.push(link);
					        			 it++;
					        			 console.log("iterator"+it)
					        			 console.log("val l"+val.length);		        	  
						        		 console.log("length pas arry mouse"+pas_arr.length);
								        var id=$(this).attr("id");
								        $(this).attr('disabled','disabled');
					        			$(this).css({"display":"none"});
					        			$(this).hide();
					        			 console.log("gggg"+$(this).val());
							        	$("#can"+valeur).html($(this).val()).css({"position":"absolute","top":y_p+"px","left":x_p+"px","width":20+"px"});
							        	valeur++;
				        			 }
				        			 else{
				        				 alert("not valid: veuiller ");
				        				 
				        				 
				        			 }*/
				        			 
						        	}
				        		  });
				        		  $("#"+valeur).keyup(function(e){
				        			  console.log("up"+e.keyCode);
				        		  console.log("paa"+link["pas"]);
				        		  });
				        		  break;
				        		 }
				        	  }	//end if			        
					   }//endfor
				     }
			        			 				   
					 }//end mouseup
				    );}
          ox = lx;
          oy = ly;  
          console.log("xs"+Xs);
          console.log("ys"+Ys);  
          
          $(".but").click(function(){
        	  var id=$(this).data("id");
        	  console.log("hii"+id);
          });
         
      }; 
    	 this.drag(moveFnc, startFnc, endFnc);
};
function Line(startX, startY, endX, endY, raphael) {
	    var start = {
	        x: startX,
	        y: startY
	    };
	    var end = {
	        x: endX,
	        y: endY
	    };
	    var getPath = function() {
	        return "M" + start.x + " " + start.y + " L" + end.x + " " + end.y;
	    };
	    var redraw = function() {
	        node.attr("path", getPath());
	    }

	    var node = raphael.path(getPath()).attr({stroke:'black', 'stroke-width': 2, 'arrow-end':
	    'open-wide-long'});
	    return {
	        updateStart: function(x, y) {
	            start.x = x;
	            start.y = y;
	            redraw();
	            return this;
	        },
	        updateEnd: function(x, y) {
	            end.x = x;
	            end.y = y;
	            redraw();
	            return this;
	        }
	    };
	};
	function Arc(startX, startY, endX, endY, raphael) {
	    var start = {
	        x: startX,
	        y: startY
	    };
	    var end = {
	        x: endX,
	        y: endY
	    };
	    var getPath = function() {
	    	var x_c=(start.x+end.x)/2;
	    	var y_c=(start.y+end.y)/8;
	        return "M" + start.x + " " + start.y + " Q" +x_c+ " " + y_c + " " + end.x + " " + end.y;
	    };
	    var redraw = function() {
	        node.attr("path", getPath());
	    }

	    var node = raphael.path(getPath()).attr({stroke:'black', 'stroke-width': 2,'arrow-end':
		    'open-wide-long'});
	    return {
	        updateStart: function(x, y) {
	            start.x = x;
	            start.y = y;
	            redraw();
	            return this;
	        },
	        updateEnd: function(x, y) {
	            end.x = x;
	            end.y = y;
	            redraw();
	            return this;
	        }
	    };
	};
	$(function() {
		var i=0;
		var j=1;
		  for(i;i<v;i++){
			  if(i==init){
				  if(fin1.contains(i)||i==fin0){
					  var mySet = paper.set();
					  var cp=paper.circle(30, 60*i+30, 30).attr("fill", "#ffc200");
					  var c1=paper.circle(30, 60*i+30, 25).attr({fill:'#ffc200',fillText:'hii'}).data({'id':i,'class':'cercle'});		  
					  var p=paper.path("M" + (10)+ " " +(60*i) + " L" + 15+ " " +(60*i+10)).attr({stroke:'black', 'stroke-width': 2, 'arrow-end':
					    'open-wide-long'});
					  var t1=paper.text(30,60*i+30,"q"+i).attr({"font-size":20});		 
					  mySet.push(c1,t1,p,cp);			  
					  mySet.draggable();
				  }
				  else{
				  var mySet = paper.set(); 
				  var c1=paper.circle(30, 60*i+30, 25).attr({fill:'#ffc200',fillText:'hii'}).data({'id':i,'class':'cercle'});		  
				  var p=paper.path("M" + (5)+ " " +(60*i-4) + " L" + 15+ " " +(60*i+5)).attr({stroke:'black', 'stroke-width': 2, 'arrow-end':
				    'open-wide-long'});
				  var t1=paper.text(30,60*i+30,"q"+i).attr({"font-size":20});		 
				  mySet.push(c1,t1,p);			  
				  mySet.draggable();
				  }
				  
			  }
			  else if(fin1.contains(i)||i==fin0){		 
				  var mySet = paper.set(); 
				  var cp=paper.circle(30, 60*i+30, 30).attr("fill", "#ffc200");
				  var c1=paper.circle(30, 60*i+30, 25).attr({fill:'#ffc200',fillText:'hii'}).data({'id':i,'class':'cercle'});		  
				  var t1=paper.text(30,60*i+30,"q"+i).attr({"font-size":20});		 
				  mySet.push(c1,t1,cp);			  
				  mySet.draggable();  
			  }
			  
			  else{
			  var mySet = paper.set(); 
			  var c1=paper.circle(30, 60*i+30, 25).attr({fill:'#ffc200',fillText:'hii'}).data({'id':i,'class':'cercle'});		  
			  var t1=paper.text(30,60*i+30,"q"+i).attr({"font-size":20});		 
			  mySet.push(c1,t1);			  
			  mySet.draggable();
			  if(i>=6){
				  var mySet = paper.set(); 
				  var c1=paper.circle(80, 20, 25).attr({fill:'#d8d8d8',fillText:'hii'}).data({'id':i,'class':'cercle'});		  
				  var t1=paper.text(80,20,"q"+i).attr({"font-size":20});		 
				  mySet.push(c1,t1);			  
				  mySet.draggable();
				  j++;
			  }	
			  }
		  }		  		 
		  $("#add").click(function(){
			  console.log("pas"+pas[0]);	
			  console.log("ii"+i);
			  var mySet = paper.set(); 
			  var c1=paper.circle(20, 60*i+20, 25).attr({fill:'#454545',fillText:'hii'}).data({'id':i,'class':'cercle'});		  
			  var t1=paper.text(20,60*i+20,"q"+i).attr({"font-size":20});		
			  console.log("val1"+$('#id1').attr("id"));
			  mySet.push(c1,t1);			  
			  mySet.draggable();	
			  i++;
			  console.log("jjj"+j);
			  if(i>=7){
				  var mySet = paper.set(); 
				  var c1=paper.circle(80, 60*(j-1)+20, 25).attr({fill:'#454545',fillText:'hii'}).data({'id':'c'+i,'class':'cercle'});		  
				  var t1=paper.text(80,60*(j-1)+20,"q"+(i-1)).attr({"font-size":20});		 
				  mySet.push(c1,t1);			  
				  mySet.draggable();
				  j++;
			  }
		  });
		  
		  $("#create").click(function(){
			  var json = JSON.stringify(from_arr);
			  var json1 = JSON.stringify(to_arr)
			   var json2 = JSON.stringify(pas_arr);
			  var json3=JSON.stringify(pas1);
			  var min=0;
			   $.get('servlet',{user:json,user1:json1,user2:json2,pas:json3,nb_etat:nb_etat,min:min,q0:init,qf:fin},function(responseText) { 
				                        //$('#output').html(responseText);  
				 $(location).attr('href','test.jsp')       
				                      });
			 // $(location).attr('href','test.jsp')
		  });
		  $("#create_min").click(function(){
			  var json = JSON.stringify(from_arr);
			  var json1 = JSON.stringify(to_arr)
			   var json2 = JSON.stringify(pas_arr);
			  var json3=JSON.stringify(pas1);
			  var min=1;
			   $.get('servlet',{user:json,user1:json1,user2:json2,pas:json3,nb_etat:nb_etat,min:min,q0:init,qf:fin},function(responseText) { 
				                        //$('#output').html(responseText);  
				 $(location).attr('href','test.jsp')       
				                      });
			 // $(location).attr('href','test.jsp')
		  });
});
</script>
<div id="a">
<%for(int i=0;i<m*m;i++){%>
<div id=<%out.print("can"+i);%>></div>
<input type='text'  'style='width:20px' id='<%=i%>' style="display:none"/>
<%} %>
<%for(int i=0;i<m*m;i++){%>
<div id=<%out.print("can1"+i);%>></div>
<input type='text' 'style='width:15px' id='<%out.print("id"+i);%>' style="display:none"/>
<%} %>
<div id="lol" style="color:green">
 <div id="can"></div>
 
  <div id="canvas"></div>
 <div id="cann"></div>
 <button id="add" class="but">add</button>
 <button id="create" class="but">determniser</button>
  <button id="create_min" class="but">minimiser</button>
<div id="output"></div>
</div>
</div>
</body>
</html>+