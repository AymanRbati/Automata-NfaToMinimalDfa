package fin;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;

/**
 * Servlet implementation class servlet
 */
@WebServlet("/servlet")		
public class servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 
    /**
     * Default constructor. 
     */
	private static int nb_symb =2;
	private static int nb_etat=4;
	private static String[][] tab;
	private static ArrayList<ArrayList<String>> D = new ArrayList<ArrayList<String>>();
	private static ArrayList<String> E = new ArrayList<String>();
	private static String tab1[]={"0","0","0","1","1","2","2","2"};//FROM
	private static String tab2[]={"a","a","b","a","b","a","a","b"};//Symb
	private static String tab3[]={"1","2","2","2","3","1","2","3"};//TO
	private static  ArrayList<ArrayList<Integer>> M2 = new ArrayList<ArrayList<Integer>>();
	private static ArrayList<Integer> f=new ArrayList<Integer>();
	private static int finaltab[][];
	private static String q0="0";
	private static String qf="3";
	static boolean M=true;
	public  String name_1;
	public  String[] n;
	public String name_2;
	public String name_3;
	public String name;
	//public String[] tab;
    public servlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected String[] parse(String t){
		 t=t.replace("]","");
		t= t.replace("[","");
		String[] res=t.split(",");
		 return res;
	 }
    protected String parse1(String t){
		 t=t.replace("]","");
		t= t.replace("[","");
		 return t;
	 }
 // check if the automata is nfa or dfa
 	public static void validate2(String tab[][]) {

 		if (isNFA(tab)) {
 			System.out.println("This is an NFA !");
 			validate3NFA();
 		} else {
 			System.out.println("This is a DFA  !");
 			int T[][] = convertoint(tab, nb_etat, nb_symb);
 			validate3DFA(T);
 		}
 	}

 	public static void validate3NFA() {
 		System.out.println("Determinisation is done");
 		E.add("1");
 		int current = 0;
 		while (current < E.size()) {
 			traitement(E.get(current));
 			current++;
 		}

 		// conversion en tableau statique
 		int T[][] = new int[D.size()][nb_symb];
 		for (int i = 0; i < D.size(); i++) {
 			for (int j = 0; j < nb_symb; j++) {
 				int s;
 				if (M) {
 					s = E.indexOf(D.get(i).get(j)) + 1;
 					if (s == 0) {
 						T[i][j] = 0;
 					} else {
 						T[i][j] = s;
 					}
 				} else {
 					s = E.indexOf(D.get(i).get(j));
 					if (s == -1) {
 						T[i][j] = -1;
 					} else {
 						T[i][j] = s;
 					}
 				}
 			}
 		}
 		if (!M) {
 			for (int i = 0; i < E.size(); i++)
 				E.set(i, delone2(E.get(i)));
 		}
 		// on determine les etats finaux et nonfinaux
 		ArrayList<Integer> fStates = new ArrayList<Integer>();
 		ArrayList<Integer> nonfStates = new ArrayList<Integer>();
 		String array[] = qf.split(",");
 		for (int i = 1; i <= E.size(); i++) {
 			for (String a : array) {
 				if (!M) {
 					if (E.get(i - 1).contains(a)) {
 						if (!fStates.contains(i - 1))
 							fStates.add(i - 1);
 					}
 				} else {
 					if (E.get(i - 1).contains(a)) {
 						if (!fStates.contains(i))
 							fStates.add(i);
 					}
 				}
 			}

 			if (!fStates.contains(i))
 				nonfStates.add(i);
 		}
 		// updating the first state
 		for (int i = 0; i < E.size(); i++) {
 			if (E.get(i).contains(q0))
 				q0 = E.get(i);
 		}

 		if (M)
 			validate4(fStates, nonfStates, T);
 		else {
 			ArrayList<String> s=new ArrayList<String>();
 			s=convert(fStates);
 			qf =Arrays.toString(s.toArray());
 			finaltab = T;
 		}
 		
 		System.out.println("rrrrr");

 		System.out.println("rrrrr");

 	}

 	public static void validate3DFA(int T[][]) {
 		ArrayList<Integer> fStates = new ArrayList<Integer>();
 		ArrayList<Integer> nonfStates = new ArrayList<Integer>();
 		String array[] = qf.split(",");
 		for (int i = 1; i <= nb_etat; i++) {
 			boolean b = false;
 			for (String a : array) {
 				if (Integer.parseInt(a) == i) {
 					fStates.add(i);
 					b = true;
 				}
 			}
 			if (!b)
 				nonfStates.add(i);
 		}
 		if (M)
 			validate4(fStates, nonfStates, T);
 		else {
 			ArrayList<String> s=new ArrayList<String>();
 			s=convert(fStates);
 			qf =Arrays.toString(s.toArray());
 			System.out.println("jjjjjj"+qf);
 			finaltab = T;
 			for (int i = 0; i < nb_etat; i++) {
 				E.add(Integer.toString(i));
 			}
 		}

 	}

 	public static void validate4(ArrayList<Integer> fStates, ArrayList<Integer> nonfStates, int T[][]) {
 		System.out.println("DFA Minimization is done");
 		// The DFA minimization
 		ArrayList<ArrayList<Integer>> M1;
 		ArrayList<ArrayList<Integer>> M3;
 		int T2[][] = new int[T.length][nb_symb];
 		ArrayList<Integer> l = rmUnreacheableStates(q0, T, T2, nb_symb);
 		update(l, fStates);
 		update(l, nonfStates);
 		ArrayList<Integer> I = fStates;
 		M2.add(I);
 		ArrayList<Integer> I2 = nonfStates;
 		M2.add(I2);

 		do {
 			M1 = M2;
 			M2 = new ArrayList<ArrayList<Integer>>();
 			for (int i = 0; i < M1.size(); i++) {
 				I = new ArrayList<Integer>();
 				I = M1.get(i);
 				if (I.size() == 1)
 					M2.add(I);
 				else {
 					I2 = new ArrayList<Integer>();
 					I2.add(I.get(0));
 					M3 = new ArrayList<ArrayList<Integer>>();
 					M3.add(I2);
 					M2.add(I2);
 					for (int j = 1; j < I.size(); j++) {
 						int n = M3.size();
 						boolean equiv = false;
 						for (int k = 0; k < n; k++) {
 							if (isEquiv(M3.get(k).get(0), I.get(j), T2, nb_symb, M1)) {
 								M3.get(k).add(I.get(j));
 								equiv = true;
 							}
 						}
 						if (!equiv) {
 							I2 = new ArrayList<Integer>();
 							I2.add(I.get(j));
 							if (!belong(I2, M3)) {
 								M3.add(I2);
 								M2.add(I2);
 							}

 						}
 					}
 				}
 			}

 		} while (!M2.equals(M1));
 		int m = M2.size();
 		int T3[][] = new int[m][nb_symb];
 		for (int i = 0; i < m; i++) {
 			for (int j = 0; j < nb_symb; j++) {
 				boolean b = false;
 				int n = 0;
 				for (int k = 0; k < M2.get(i).size(); k++) {
 					n = M2.get(i).get(k);
 					if(n==0)n=1;
 					if (T2[n - 1][j] != 0) {// iiiii
 						b = true;
 						k = M2.get(i).size();
 					}
 				}
 				if (b) {
 					n--;// car letat n correspend a n-1 dans T2
 					T3[i][j] = findM(T2[n][j], M2);
 				} else {
 					T3[i][j] = -1;
 				}
 			}
 		}
 		int q = findM(Integer.parseInt(q0), M2);// on cherche l'indice de l'etat
 												// initial dans M2
 		for (int i = 0; i < fStates.size(); i++) {
 			if (!f.contains(findM(fStates.get(i), M2)))
 				f.add(findM(fStates.get(i), M2));
 		}
 		q0 = Arrays.toString(M2.get(q).toArray());
 		q0 = q0.replace("[", "").replace("]", "").replace(" ", "");
 		q0 = delone2(q0);
 		E=convert(f);
 		qf = Arrays.toString(E.toArray());
 		//System.out.println(Arrays.deepToString(M2.toArray()));

 		deloneM2(M2);
 		finaltab = T3;
 	}
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		
 		

 		
 	//converting M2 TO String
 	public static ArrayList<ArrayList<String>> convertoM2(ArrayList<ArrayList<Integer>> M){
 		E=new ArrayList<String>();
 		ArrayList<ArrayList<String>> S= new ArrayList<ArrayList<String>>();
 		for(int i=0;i<M.size();i++){
 			ArrayList<String> s=new ArrayList<String>();
 			S.add(s);
 			for(int j=0;j<M.get(i).size();j++){
 				s.add(Integer.toString(M.get(i).get(j)));
 			}
 		}
 		return S;
 	}

 	//arrlist of int to arr of string
 	public static ArrayList<String> convert(ArrayList<Integer> f){
 		ArrayList<String> s= new ArrayList<String>();
 		for(int i=0;i<f.size();i++){
 			s.add(Integer.toString(f.get(i)));
 		}
 		return s;
 	}
 	
 	
 		public static void traitement(String str) {
 			ArrayList<String> T = new ArrayList<String>();
 			D.add(T);
 			// T contient les valeurs pour l'etat str
 			String array1[] = str.split(","); // divise l'état en entiers
 			for (int j = 0; j < nb_symb; j++) {
 				String s = ""; // le string qui va etre stocké pour cet état et pour ce symbole
 				for (String x1 : array1) { // pour chaque entier de l'état
 					s = check(x1, j, tab, s);
 				}
 				
 				T.add(s);
 				if (!E.contains(s) && !"".equals(s))
 					E.add(s);

 			}
 		}
 		//detetcts the symbols used and make them in an arrayList
 		static ArrayList<String> ArrayOfSymb(String tab2[],int nb_symb){
 			int n=tab2.length;
 			ArrayList<String> list = new ArrayList<String>();
 			boolean b=false;
 			for(int i=0;i<n;i++){
 			if(tab2[i]=="*")
 				b=true;
 			else{
 			if(!list.contains(tab2[i]))
 				list.add(tab2[i]);
 			if(list.size()==nb_symb)
 				i=n;
 			}}
 			if(b)
 				list.add("*");
 			return list;
 		}
 		//creates a 2 dimensionnal array representing the automata
 		static String[][] Remplir(String tab1[],ArrayList<String> symboles,String tab2[],String tab3[]){
			System.out.println("caclculllllllllllll 1");
 			int e=tab1.length;
 			int n=0;
 			String[][] tab=new String [nb_etat][nb_symb+1];
 			tab = new String[nb_etat][nb_symb + 1];
 			for (int i = 0; i < nb_etat; i++) {
 				for (int j = 0; j <= nb_symb ; j++) {
 					tab[i][j] = "";
 					System.out.println("caclculllllllllllll  "+i);
 				}
 			}
 			for(int i=0;i<e;i++){
 			n=Integer.parseInt(tab1[i]);
 			if(tab2[i]!="*"){ //check if character is not epsilone
 				if(tab[n][symboles.indexOf(tab2[i])].length()==0)
 				tab[n][symboles.indexOf(tab2[i])]=addone2(tab3[i]);
 				else{
 					tab[n][symboles.indexOf(tab2[i])]=tab[n][symboles.indexOf(tab2[i])]+","+addone2(tab3[i]);	
 				}
 				
 			}
 			else{
 				if(tab[n][nb_symb].length()==0)
 				tab[n][nb_symb]=addone2(tab3[i]);
 				else{
 				tab[n][nb_symb]=tab[n][nb_symb]+","+addone2(tab3[i]);	
 				}
 				System.out.println("caclculllllllllllll else");
 				
 			}
 			}
 			System.out.println("jjjjj");
 			return tab;
 		}
 		// add one to string number
 		static String addone(String s){
 			int n=Integer.parseInt(s)+1;
 			return Integer.toString(n);
 		}
 		
 		
 	   
 		public static String check(String x1, int j, String[][] tab, String s) {
 			int x = Integer.parseInt(x1);
 			x++;
 			if(x==0){
 				x++;
 			}
 			if (!"".equals(tab[x - 1][j])) {
 				String array2[] = tab[x - 1][j].split(",");
 				for (String y : array2) {
 					if (!s.contains(y)) {
 						if (s == "") {
 							s = s.concat(y);
 						} else {
 							s = s.concat(',' + y);
 						}
 						s = check(y, nb_symb, tab, s);
 					}
 				}
 			}
 			if(s.length()>1 && s.length()!=0)
 			s=sort(s);
 			return s;
 		}
 	    //checking if the automata is an NFA 
 		public static boolean isNFA(String[][] tab) {
 			boolean b = false;
 			for (int i = 0; i < nb_etat; i++) {
 				if (!"".equals(tab[i][nb_symb]))
 					b = true;
 			}
 			if (!b) {
 				for (int i = 0; i < nb_etat; i++) {
 					for (int j = 0; j < nb_symb; j++) {
 						if (tab[i][j].length() > 1) {
 							b = true;
 							i = nb_etat - 1;
 							j = nb_symb - 1;
 						}
 					}
 				}
 			}
 			return b;
 		}
 	     // on determine si deux états sont équivalents par rapport à M1
 		static boolean isEquiv(int a, int b, int T[][], int nb, ArrayList<ArrayList<Integer>> M1) {
 			boolean bo = true;
 			a--;
 			b--;
 			for (int i = 0; i < nb; i++) {
 				if (T[a][i] != T[b][i]) {
 					if(T[a][i]==0 || T[b][i]==0){
 						bo=false;
 					}
 					else if (findM(T[a][i], M1) != findM(T[b][i], M1))
 						bo = false;
 				}
 			}
 			return bo;
 		}

 		// on cherche l'indice d'un état dans M1
 		static int findM(int a, ArrayList<ArrayList<Integer>> M1) {
 			for (int i = 0; i < M1.size(); i++) {
 				if (M1.get(i).contains(a))
 					return i;
 			}
 			return -1;
 		}

 		// removing unreachable states (états inaccessibles)
 		static ArrayList<Integer> rmUnreacheableStates(String q0, int[][] T, int[][] T2, int nb_symb) {
 			HashMap<Integer, Boolean> hm = new HashMap<Integer, Boolean>();
 			hm.put(1, false);
 			while (hm.containsValue(false)) {
 				int q = Fkey(hm);
 				hm.put(q, true);
 				q--;
 				for (int a = 0; a < nb_symb; a++) {
 					if (!hm.containsKey(T[q][a]) && T[q][a]!=0) 
 						hm.put(T[q][a], false);
 						T2[q][a] = T[q][a];
 				}
 			}
 			ArrayList<Integer> l = new ArrayList<Integer>();
 			l.addAll(hm.keySet());
 			return l;
 		}

 		// finding a key in the HashMap with a value of false 
 		static int Fkey(HashMap<Integer, Boolean> hm) {
 			Iterator<Integer> it = hm.keySet().iterator();
 			boolean b = false;
 			int i = 0;
 			while (!b) {
 				i = it.next();
 				if (!hm.get(i))
 					b = true;
 			}
 			return i;
 		}
 		//updates a group of states by removing the unreachable states
 		static void update(ArrayList<Integer> l,ArrayList<Integer> t){
 			int s=t.size();
 			for(int i=0;i<s;i++){
 				if(!l.contains(t.get(i))){
 					t.remove(i);
 				}	
 			}
 		}
 		//adding one to a string of numbers
 			static String addone2(String qf){
 					String[] ary = qf.split(",");
 					for(int i=0;i<ary.length;i++)
 						ary[i]=addone(ary[i]);
 					qf=Arrays.toString(ary);
 				    StringBuilder sb = new StringBuilder(qf);
 					sb.deleteCharAt(qf.length()-1).deleteCharAt(0);
 					qf=sb.toString().replaceAll(" ", "");
 				return qf;
 			}
 			//add one from states on M2
 		static void addoneM2(ArrayList<ArrayList<Integer>> M2) {
 			for (int i = 0; i < M2.size(); i++) {
 				for (int j = 0; j < M2.get(i).size(); j++) {
 					int n = M2.get(i).get(j);
 					M2.get(i).set(j, n + 1);
 				}
 			}
 		}
 		//delete one from states on M2
 		static void deloneM2(ArrayList<ArrayList<Integer>> M2) {
 			for (int i = 0; i < M2.size(); i++) {
 				for (int j = 0; j < M2.get(i).size(); j++) {
 					int n = M2.get(i).get(j);
 					M2.get(i).set(j, n - 1);
 				}
 			}
 		}
 		//converting an array of strings to an array of int

 			 static int[][] convertoint(String tab[][],int m,int n){
 				int[][] T=new int[m][n];
 				for(int i=0;i<m;i++){
 					for(int j=0;j<n;j++){
 						if(M){
 							if(tab[i][j]=="")
 								T[i][j]=0;
 							else T[i][j]=Integer.parseInt(tab[i][j]);
 						}

 						else{
 								if(tab[i][j]=="")
 	 								T[i][j]=-1;
 	 							else T[i][j]=Integer.parseInt(tab[i][j])-1;
 						}
 					}

 				}		return T;
 			}
 			 //deleting one from a string of numbers
 				static String delone2(String qf){
 					String[] ary = qf.split(",");
 					for(int i=0;i<ary.length;i++)
 						ary[i]=delone(ary[i]);
 					qf=Arrays.toString(ary);
 				    StringBuilder sb = new StringBuilder(qf);
 					sb.deleteCharAt(qf.length()-1).deleteCharAt(0);
 					qf=sb.toString().replaceAll(" ", "");
 		
 				return qf;
 			}
 				// delete one to string number
 			static String delone(String s){
 				int n=Integer.parseInt(s)-1;
 				return Integer.toString(n);
 			}
 			//sort a string of numbers
 			public static String sort(String s){
 				String[] ary = s.split(",");
 				ArrayList<Integer> a=new ArrayList<Integer>();
 				for(int i=0;i<ary.length;i++){
 					if(!ary[i].equals(","))
 						a.add(Integer.parseInt(ary[i]));}
 					//ary=(String[])a.toArray();
 					//Arrays.sort(ary);
 					Collections.sort(a);
 					s="";
 					for(int i=0;i<a.size()-1;i++){
 						s=s+a.get(i).toString()+",";
 					}
 					s=s+a.get(a.size()-1);
 					return s;

 			}
 			//check if any state of M3 is contained in M2
 			public static boolean belong(ArrayList<Integer> M2,ArrayList<ArrayList<Integer>> M3){
 				boolean b=false;
 				for(int i=0;i<M2.size();i++){
 					for(int j=0;j<M3.size();j++){
 					if(M3.get(j).contains(M2.get(i))){
 						b=true;
 					}
 				}}
 				return b;
 			}
//enlever les crochets 
	public String[] rep_c(String[] tab){
		for(int i=0;i<tab.length;i++){
			tab[i]=tab[i].replace("\"", "");
		}
		return tab;
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 		 
			response.setContentType("text/plain");
			PrintWriter out=response.getWriter();	
			name_1=request.getParameter("user");
			if(name_1.length()>1){
				tab1=parse(name_1);
			}
			else{
				tab1[0]=parse1(name_1);
			}
			//tab1=parse(name_1);//from
			out.println("tab1"+tab1[0]);
			name_2=request.getParameter("user1");
			if(name_2.length()>1){
				tab3=parse(name_2);
			}
			else{
				tab3[0]=parse1(name_2);
			}
			name_3=request.getParameter("user2");
			if(name_3.length()>1){
				tab2=parse(name_3);
			}
			else{
				tab2[0]=parse1(name_3);
			}
			String pas=request.getParameter("pas");
			String nb=request.getParameter("nb_etat");
			String m=request.getParameter("min");
			
			q0=request.getParameter("q0");
			System.out.println("q0 r"+q0);
			qf=request.getParameter("qf");
			System.out.println("qf r"+qf);
			String [] sym=parse(pas);
			nb_etat=Integer.parseInt(nb);
			System.out.println("nb etat r"+nb_etat);
			int min=Integer.parseInt(m);
			nb_symb=sym.length;
			System.out.println("nb symb r"+nb_symb);
			out.println("hh"+sym[0]);
			request.setAttribute("init","22");			
			tab1=rep_c(tab1);
			tab2=rep_c(tab2);
			tab3=rep_c(tab3);
					
			//calcul			
			if(min==1){
				M=true;
			}
			else{
				M=false;
			}
			String s;
			ArrayList<String> symboles=ArrayOfSymb(tab2,nb_symb);
			 tab=Remplir(tab1, symboles, tab2, tab3);
			 System.out.println("-1 :"+Arrays.toString(tab1)+"-");
			 System.out.println("-2 :"+Arrays.toString(tab2)+"-");
			 System.out.println("-3 :"+Arrays.toString(tab3)+"-");
			 System.out.println("tab is :");
			 for(int i=0;i<tab.length;i++){
				 for(int j=0;j<tab[i].length;j++){
					 System.out.println("tab["+i+"]["+j+"]"+tab[i][j]);
				 }
			 }
			 
			 System.out.println();
			 if(M){
					q0=addone(q0);
					qf=addone2(qf);
				}
			 validate2(tab); 
			if (M) {
				s=Arrays.deepToString(convertoM2(M2).toArray());
			} else{
				s=Arrays.toString(E.toArray());
			}
			
			
			request.setAttribute("tableau d'états","\""+s+"\"");
			System.out.println("states :"+s);
			request.setAttribute("les états finaux","\""+qf+"\"");
			System.out.println("qf"+qf);
			request.setAttribute("l'état initial","\""+q0+ "\"");
			request.setAttribute("tableau de transitions", Arrays.deepToString(finaltab));
			System.out.println("tr"+Arrays.deepToString(finaltab));
			request.setAttribute("nombre d'états","\""+nb_etat+ "\"");
			request.setAttribute("nombre de transitions","\""+nb_symb+ "\"");
		out.println("name2"+name_2);
		out.println("nb eate"+nb_etat);
		out.println("nb sym"+nb_symb);
		out.println("tablll"+tab3[0]);
		out.println("tab2"+tab1[0]);
		out.println("qf"+qf);
		out.println("STATE"+s);
		request.getRequestDispatcher("test.jsp").forward(request, response);

	}
	

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//String[] ne=parse(n);
		String name=request.getParameter("name").toString();
		String pas=request.getParameter("number").toString();
		String init=request.getParameter("init").toString();
		String fin=request.getParameter("final").toString();
		String eps=request.getParameter("epsilon").toString();
		PrintWriter out=response.getWriter();
		out.println(name);
		out.println(pas);
		//n="o";
		//out.println("hh"+ne);
		request.setAttribute("name2", name);
		request.setAttribute("name", name);
		request.setAttribute("number",pas);
		request.setAttribute("final", fin);
		request.setAttribute("init",init);
		request.setAttribute("eps",eps);
		request.getRequestDispatcher("page.jsp").forward(request, response);
	}
	

}
