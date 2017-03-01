<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body >
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.4/raphael-min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<div id="titre">Déterminiation minimisation des automates</div>
<form method="post" action="servlet">
<p id="p1">nombre d'etat:</p>
<input type="number" max="7" min="0" name="name"  id="etat" class="inp"/>

<p id="p">les transitions:</p>
<p id='war'>les symboles separer par une virgule</p>
<input type="text" id="pas" name="number" class="inp" placeholder="donner les pas separer par une virgule "/>
<p id="p"> donner l'etat initial</p>
<p id='war'>donner le numero d'etat et commencez par 0</p>
<input type="number" max="7" min="0" name="init" id="init" class="inp" placeholder="donner le numero de votre etat initial"/>
<p id="p"> donner l'etat final</p>
<p id='war'>donner le numero d'etat et commencez par 0</p>
<input type="text" name="final" id="final"  class="inp" placeholder="donner le numero de votre etat(s) final separer par virgule"/>
<p id="p">avec ou sans epsilon</p>
<input type="radio" name="epsilon" value="avec"><p id="id1">avec epsilon</p> </br>
<input type="radio" name="epsilon" value="sans"><p id="id2">sans epsilon</p>
</br>
<input type="submit" id="sub"/>
</form>
<div id="canvas"></div>

</body>
</html>