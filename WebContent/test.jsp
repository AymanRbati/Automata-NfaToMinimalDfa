<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.4/raphael-min.js"></script>

</head>
<body>
 <div id="can" style="height: 800px;" ></div>
<script>
<%String init=(String)request.getAttribute("init");%>
<%
String tr=(String)request.getAttribute("tableau de transitions");
String st=(String)request.getAttribute("tableau d'états");
System.out.println("-"+st+"-");
String q0=(String)request.getAttribute("l'état initial");
String f=(String)request.getAttribute("les états finaux");
System.out.println("-"+f+"-");
String nb_etat=(String)request.getAttribute("nombre d'états");
String nb_symb=(String)request.getAttribute("nombre de transitions");
%>

var init=<%out.print(q0);%>
var q0=<%out.print(q0);%>
var tr=<%out.print(tr);%>
var st=<%out.print(st);%>
var nb_etat=<%out.print(nb_etat);%>
var nb_symb=<%out.print(nb_symb);%>
var etats=<%out.print(st);%>;
if(etats==null||tr==null||st==null){
	alert("deja");
}
else{
var st=etats.split(", ");
var st=etats.split(", ");
console.log(a);
var f=<%out.print(f);%>;
var qf=f.split(", ");

qf=qf.replace("[","");
qf=qf.replace("]","");

qf=qf.split(',');
console.log('qffff'+(qf[1]));
for(i=0;i<qf.length;i++){
	qf[i]=parseInt(qf[i]);
}
console.log("plus"+(qf[0]+qf[1]));
drawn=[];
pos_x=[];
pos_y=[];
x_p=50;
y_p=50;
cpls=[];
var pos1;
var pos2;
var paper =Raphael(document.getElementById("can"));
var z=["0 200","200 0","200 200"];
var x=[0,200];
var y=[0,200,-100];
var ch_x=[];
var ch_y=[];
var ch_f=[];
var code=97;
var d=0;
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
function calcule(){
	return Math.floor(Math.random()*2);
		}
		function exist(){
			pos1=calcule();
			pos2=calcule();
			while(pos1==0&&pos2==0){
				 pos1=calcule();
				pos2=calcule();
			}
			if(ch_x.length!=5){
			/*console.log("pos1"+pos1);
			console.log("pos2"+pos2);*/
			
			for(k=0,s=0;k<ch_f.length;k++){
				ch=""+x[pos1]+" "+y[pos2];
				/*console.log("found cy 1  " +k+"  "+ch_y[k]);
				console.log("found cx 1  "+k+"  "+ch_x[k]);
				console.log("found y 1  "+k+"  "+y[k]);
				console.log("found x 1  "+k+"  "+x[k]); */
				if(ch_f[k]===ch){
					console.log("found y "+y[pos2]);
					console.log("found x "+x[pos1]);
					console.log("found cy 2  "+ch_f);
					//console.log("found cx 2  "+k);
					console.log("found y 2 "+ch);
					console.log("found x 2 "+k);
					 s++;
					 exist();
				}
			}
			
			}
			
			return s;
		}

$(document).ready(function(){
	console.log("hhhhh"+tr[0].length);
	  var c1=paper.circle(70, 70, 20).attr({fill:'#a5a5a5',fillText:'hii'}).data({'id':'c0','class':'cercle'});		  
	  var t1=paper.text(70, 70,"{"+state[0]+"}").attr({"font-size":20});	
	  drawn.push(0);
	  pos_x.push(50);
	  pos_y.push(50);

for(i=0;i<arr.length;i++){
	for(j=0;j<arr[i].length;j++){
		if(!drawn.contains(i)){
			for(l=0;l<state.length;l++){
					if(drawn.contains(arr[i][l])){
						it=drawn.find(arr[i][l]);
						console.log("it"+it);
						break;					
					}//end if
			}//end for 
				p_x=pos_x[it];
				p_y=pos_y[it];
				console.log("p_x"+p_x);
				f=exist();
				if(f==0){
					console.log("statttae");
						if(qf.contains(i)){
							var cp=paper.circle((x[pos1]+p_x), (y[pos2]+p_y), 25).attr("fill", "#ffc200");
							var c1=paper.circle((x[pos1]+p_x), (y[pos2]+p_y), 20).attr({fill:'#a5a5a5',fillText:'hii'}).data({'id':'c','class':'cercle'});	
				paper.path("M" +(x[pos1]+p_x) + " " +(y[pos2]+p_y) + " L" + p_x+ " " +p_y).attr({stroke:'yellow', 'stroke-width': 2, 'arrow-end':
				    'open-wide-long'});
				var t1=paper.text((x[pos1]+p_x),(y[pos2]+p_y) ,state[arr[i][l]]).attr({"font-size":20});
				var mySet = paper.set();
				mySet.push(c1,t1,cp);
							}//fi if contains i 
							else if(state[i]==qi){
								var c1=paper.circle((x[pos1]+p_x), (y[pos2]+p_y), 20).attr({fill:'#a5a5a5',fillText:'hii'}).data({'id':'c','class':'cercle'});	
				paper.path("M" +(x[pos1]+p_x) + " " +(y[pos2]+p_y) + " L" + p_x+ " " +p_y).attr({stroke:'yellow', 'stroke-width': 2, 'arrow-end':
				    'open-wide-long'});
				 var p=paper.path("M" + (x[pos1]+p_x)+ " " +(y[pos2]+p_y-30) + " L" + (x[pos1]+p_x+5)+ " " +(y[pos2]+p_y-20)).attr({stroke:'black', 'stroke-width': 2, 'arrow-end':'open-wide-long'});
							}
				else{
				var c1=paper.circle((x[pos1]+p_x), (y[pos2]+p_y), 20).attr({fill:'#a5a5a5',fillText:'hii'}).data({'id':'c','class':'cercle'});	
				paper.path("M" +(x[pos1]+p_x) + " " +(y[pos2]+p_y) + " L" + p_x+ " " +p_y).attr({stroke:'yellow', 'stroke-width': 2, 'arrow-end':
				    'open-wide-long'});
				var t1=paper.text((x[pos1]+p_x),(y[pos2]+p_y),state[arr[i][l]]).attr({"font-size":20});
				var mySet = paper.set();
				mySet.push(c1,t1);
				}// fin else contains

				/*var c1=paper.circle((x[pos1]+p_x), (y[pos2]+p_y), 20).attr({fill:'#a5a5a5',fillText:'hii'}).data({'id':'c','class':'cercle'});	
				paper.path("M" +(x[pos1]+p_x) + " " +(y[pos2]+p_y) + " L" + p_x+ " " +p_y).attr({stroke:'yellow', 'stroke-width': 2, 'arrow-end':
				    'open-wide-long'});
				var t1=paper.text((x[pos1]+p_x),(y[pos2]+p_y) ,state[arr[i][l]]).attr({"font-size":20});
				var mySet = paper.set();
				mySet.push(c1,t1);*/
				drawn.push(i);
				console.log(drawn);
				pos_x.push(x[pos1]+p_x);
				pos_y.push(y[pos2]+p_y);
				y_p=(p_y+y[pos2])/2+10;
				x_p=(p_x+px[pos1])/2+30;
				$("#can").append("<p id=\"id" +d+"\">"+String.fromCharCode(code+j)+"</p>");
				  $("#id"+d).css({"color":"green","position":"absolute","top":y_p+"px","left":x_p+"px","width":10+"px"});
				  d++;
				  ch_f.push(""+x[pos1]+" "+y[pos2]);
				  cpls.push(""+i+" "+arr[i][l]);
				  cpls.push(""+arr[i][l]+" "+i);


				}//ens if f==0			

		}// end if state
		else{
			if(arr[i][j]!=-1){
			if(!drawn.contains(arr[i][j])){
			console.log("find"+arr[i][j]);
			drawn.push(arr[i][j]);
			f=exist();
					if(f==0){
						it=drawn.find(i);
						p_x=pos_x[it];
						p_y=pos_y[it];
						console.log("p_x"+p_x);
						var c1=paper.circle((p_x+x[pos1]), (p_y+y[pos2]), 20).attr({fill:'#a5a5a5',fillText:'hii'}).data({'id':'c','class':'cercle'});	
				paper.path("M" +(p_x) + " " +(p_y) + " L" + (p_x+x[pos1])+ " " +(p_y+y[pos2])).attr({stroke:'yellow', 'stroke-width': 2, 'arrow-end':
				    'open-wide-long'});
				var t1=paper.text((x[pos1]+p_x),(y[pos2]+p_y) ,state[arr[i][j]]).attr({"font-size":20});
				var mySet = paper.set();
				mySet.push(c1,t1);
				 y_p=(2*p_y+y[pos2])/2+10;
					  x_p=(2*p_x+x[pos2])/2+30;
					 // console.log("couple")
					  
					 // <div class=\"fieldwrapper\" id=\"field" + intId + "\"/>"
					  //$(document).append("<p id='id'"+j+"_"+i+">"+String.fromCharCode(code+j)+"</p>");
					  //$("#can").append("<p style='position:absolute,'top':"+400+"'px','left':"+x_p+"'px'>"+String.fromCharCode(code+j)+"</p>");
					  $("#can").append("<p id=\"id" +d+"\">"+String.fromCharCode(code+j)+"</p>");
					  $("#id"+d).css({"position":"absolute","top":y_p+"px","left":x_p+"px","width":10+"px"});
					  d++;
					pos_x.push(p_x+x[pos1]);
					pos_y.push(p_y+y[pos2]);
				  ch_f.push(""+x[pos1]+" "+y[pos2]);
				  cpls.push(""+i+" "+arr[i][j]);
				  cpls.push(""+arr[i][j]+" "+i);

					}// end if f==0

				}// end contais arr if  
				else {
					it=drawn.find(i);
						p_x=pos_x[it];
						p_y=pos_y[it];
						i_s=drawn.find(arr[i][j]);
						a_x=pos_x[i_s];
						a_y=pos_y[i_s];
						console.log("pp"+pos_x);
						console.log(p_x);
						console.log(it);
						if(cpls.contains(""+i+" "+arr[i][j])||cpls.contains(""+arr[i][j]+" "+i)){
							console.log("contains"+"  "+i+" "+arr[i][j])
					  paper.path("M" + p_x + " " + p_y + " Q" +150+ " " + 100 + " " + a_x + " " + a_y).attr({stroke:'black', 'stroke-width': 2, 'arrow-end':
					    'open-wide-long'});
					  y_p=(p_y+a_y-50)/2;
					  x_p=(p_x+a_x)/2+20;
					 // console.log("couple")
					  
					 // <div class=\"fieldwrapper\" id=\"field" + intId + "\"/>"
					  //$(document).append("<p id='id'"+j+"_"+i+">"+String.fromCharCode(code+j)+"</p>");
					  //$("#can").append("<p style='position:absolute,'top':"+400+"'px','left':"+x_p+"'px'>"+String.fromCharCode(code+j)+"</p>");
					  $("#can").append("<p id=\"id" +d+"\">"+String.fromCharCode(code+j)+"</p>");
					  $("#id"+d).css({"position":"absolute","top":y_p+"px","left":x_p+"px","width":10+"px","color":"green"});
					  d++;
						}//if cpls contains
						else{
							it=drawn.find(i);
						p_x=pos_x[it];
						p_y=pos_y[it];
						i_s=drawn.find(arr[i][j]);
						a_x=pos_x[i_s];
						a_y=pos_y[i_s];

						console.log("isss"+i_s);
						console.log("isssposnnd"+pos_x[i_s]);
						console.log("pos_x"+pos_x[it]);
						console.log("pos_y"+pos_y[it]);
						console.log("a_x"+a_x);
						console.log("a_y"+a_y);
							console.log("d"+d);
							paper.path("M" +(p_x) + " " +(p_y) + " L" + a_x+ " " +a_y).attr({stroke:'yellow', 'stroke-width': 2, 'arrow-end':
				    'open-wide-long'});
							y_p=(p_y+a_y)/2-20;
					  x_p=(p_x+a_x)/2-20;
					  console.log("not")
					  console.log("x_p"+x_p);
					  console.log("y_p"+y_p);
					  $("#can").append("<p id=\"id" +d+"\">"+String.fromCharCode(code+j)+"</p>");
					  $("#id"+d).css({"position":"absolute","top":y_p+"px","left":x_p+"px","width":10+"px","color":"red"});
					  d++;
					  console.log("d"+d);
						}//else cpls
				
				


				}// end else contains

			}//end if ""
			if(i==arr[i][j]){
			if(drawn.contains(i)){
				it=drawn.find(i);
				p_x=pos_x[it];
				p_y=pos_y[it];
						paper.path([
			   			'M', p_x-10,p_y-10,
			   			'a', 25,25, 0, 1, 1, 0, -10
			   			]).attr({stroke:'black', 'stroke-width': 2, 'arrow-end':'open-wide-long'});
			}//if drawn
			

		}//end if arr==state

		}//end else state
		/*if(i==arr[i][j]){
			if(drawn.contains(state[i])){
				it=drawn.find(state[i]);
				p_x=pos_x[it];
				p_y=pos_y[it];
						paper.path([
			   			'M', p_x-10,p_y-10,
			   			'a', 25,25, 0, 1, 1, 0, -10
			   			]).attr({stroke:'black', 'stroke-width': 2, 'arrow-end':'open-wide-long'});
			}//if drawn*/


		

	}//end for j
	ch_f=[];
}// end for i

		
	});
	
}
</script>

 

<div id="output">
</div>

</body>
</html>