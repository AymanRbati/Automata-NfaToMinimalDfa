# Automata-NfaToMinimalDfa
****************************************************************************************************************************
*******************Determinisation et minimisation d'un AFN en utilisant JAVA-JSP-RAPHAEL framework*************************
****************************************************************************************************************************
Dans la premier page,l'utilisateur entre les informations du graphe: nombre d'états,nombre de symboles,les symoboles désirés,etat initial,etat final
le nombre de symboles sans epsilons
S'il ya epsilone il faule l'écrire dans les symboles "epsilone"
Dans la deusieme page , l'utilisateur dessine le graphe et choisit de le déterminer ou le minimiser
Et le graphe résultat va etre dessiné 

la servlette contient le controlleur en java qui contient l'algorithme 

Parfois ca marche pas (due aux problemes à la liasin entre le controlleur et Js),
Mais ca marche toujours dans le classe test.java (run as java application)

********************************remarque sur la saisie des donnees********************

pour l'interface c'est un drag and drop:
il faut clicker sur le cercle et puis le drager
le drag se fait qu'une seule fois (si vous deplacer un cercle danss un endroi vous ne pouvez le changer)
puis le deuxieme cercle 
puis vous clicker  sur le cercle et vous tirez vers l'autre pour que le ligne  se dessine (si la ligne n'est pa dessiné des le 1er tire commencez)
puis une case d'inout texte s'affiche vous faites entrer votre pas(symbole) //
cas de plsr symbole il faut les separer par un virgule
si un etat part vers lui meme il faut faire un click droit sur le cercle
si vous dessiner un graphe avec epsilon il faut ecrire un etoit '*'
si une erreur d'envoi de donnee est produite sur la servlet et le resultat n'est pa afficher vous pouvez lancer la page auto_dessin qui dessine un graphe en se basant sur une tabelau donnee
![cap1](https://cloud.githubusercontent.com/assets/21956791/23459755/7e53ab84-fe8a-11e6-985e-2ed31aa66894.PNG)
![image](https://cloud.githubusercontent.com/assets/21956791/23459832/ce971cac-fe8a-11e6-8864-1ea315af67a6.png)
![17093912_10211183470409821_779878180_n](https://cloud.githubusercontent.com/assets/21956791/23459910/1a70e7f2-fe8b-11e6-9702-3e919e1d60b8.png)
***********************************************************************************************************************
*******************Réalise par   :  Ayman RBATI,Oumayma KHAYE *********************************************************
*******************Encadré par   :  Youssef BADDI             ******************************************************************************
*******************Filière       :  Génie informatique        **************************************************************************************
*******************Etablissement :  ENSAk                     *********************************************************
************************************************************************************************************************************
