package dbprojectfinal;



import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.TextArea;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class jdbcexam{
	public static Connection con;
	public static ResultSet rs;
	public static java.sql.Statement st;
	//1515009 김다영
	class MenuFrame extends JFrame implements ActionListener{
		JButton i,d,a;
		MenuFrame(){
			setTitle("team15_title_GUI");
			setSize(500,300);
			setDefaultCloseOperation(EXIT_ON_CLOSE);
			
			setLayout(new BorderLayout());
			JPanel p2 = new JPanel(new FlowLayout());
			JLabel l = new JLabel("Who are You?");
			p2.add(l);
			add(p2,"North");
			JPanel p = new JPanel(new FlowLayout());
			
			d = new JButton("Director");
			d.addActionListener(this);
			p.add(d);
			a = new JButton("Actor");
			a.addActionListener(this);
			p.add(a);
			i = new JButton("Investor");
			i.addActionListener(this);
			p.add(i);
			
			add(p,"Center");
			setVisible(true);
		
		}
		public void actionPerformed(ActionEvent e){
			if(e.getSource()==i){
				
				setVisible(false);
				new InvestorFrame();
				
			}
			else if(e.getSource()==d){
				setVisible(false);
				new DirectorFrame();
			}
				
			else if(e.getSource()==a)
			{
				setVisible(false);
				new ActorFrame();
			}
				}
		}

	
	//1515009 김다영
		class DirectorFrame extends JFrame{//director 전용 frame
			
			public int title_id;
			
			JButton insertMov;
			JButton delete;
			JButton insertAud;
			JButton insertFes;
			JButton checkInv;
			JButton pickAct;
			JButton showAct;
			JButton showAFilm;
			
			JTextField directorName1,directorName2;
			JTextField Title1,Title2,Title3,Title4,Title6;
			JTextField genre;
			JTextField festivName;
			JTextField budget;
			JTextField audDate;
			JTextField annDate;
			JTextField actorRole;
			JTextField actorName,actorName2;
			
			TextArea result = new TextArea();
			TextArea result2 = new TextArea();
			//frame 에 적용될 것들
			
			public DirectorFrame(){//디렉터프레임 생성자
				
				Toolkit tk = getToolkit();
				Dimension d = tk.getScreenSize();
				setTitle("Director");
				setSize(d.width,d.height);
				setDefaultCloseOperation(EXIT_ON_CLOSE);
				
		        JPanel p = new JPanel();
		        
		        JPanel iml = new JPanel();
		        JPanel imt = new JPanel(new FlowLayout());
		        JPanel imb = new JPanel(new FlowLayout());
				
		        JPanel p1 = new JPanel(new GridLayout(3,1));
				JLabel inml= new JLabel("<Input movie title, director name, budget, genre and press 'insert' or 'done'.>");
				iml.add(inml);
				p1.add(iml);
				//영화를 등록하기 위해 감독 유저가 해야할 것들 설명
				Title1= new JTextField(20);
				Title1.setText("title");
				imt.add(Title1);
				directorName1 = new JTextField(20);
				directorName1.setText("director name");
				imt.add(directorName1);
				budget = new JTextField(20);
				budget.setText("budget");
				imt.add(budget);
				genre = new JTextField("genre",20);
				imt.add(genre);
				p1.add(imt);
				//가제, 감독 이름, 예산을 입력받는다.
				
				insertMov = new JButton("insert");
				insertMov.addActionListener(new DActionListener());
				imb.add(insertMov);
				delete = new JButton("done");
				delete.addActionListener(new DActionListener());
				imb.add(delete);
				p1.add(imb);
				p.add(p1);
				//insert 와 done 버튼제공
				JPanel ina = new JPanel();
				JPanel inat = new JPanel(new FlowLayout());
				JPanel inab = new JPanel(new FlowLayout());
				JLabel audl = new JLabel();
				
				JPanel p2 = new JPanel(new GridLayout(3,1));
				audl.setText("<Input title, audtion date, annouce date and press 'insert'.>");
				ina.add(audl);
				p2.add(ina);
				//오디션을 등록하기 위해 감독 유저가 해야할 것을 알려준다.
				Title2 = new JTextField(20);
				Title2.setText("title");
				inat.add(Title2);
				audDate = new JTextField("audtion date",20);
				inat.add(audDate);
				annDate = new JTextField("announce date",20);
				inat.add(annDate);
				p2.add(inat);
				//가제, 오디션 날짜, 발표 날짜를 입력받는다.
				insertAud = new JButton("insert");
				insertAud.addActionListener(new DActionListener());
				inab.add(insertAud);
				p2.add(inab);
				p.add(p2);
				//오디션을 등록할 수 있는 버튼 제공
				
				JPanel p3 = new JPanel(new GridLayout(3,1));
				JPanel inf = new JPanel();
				JPanel inft = new JPanel(new FlowLayout());
				JPanel infb = new JPanel(new FlowLayout());
				JLabel f = new JLabel("<Insert movie title, director name, festival name and press 'insert'.>");
				//감독이 자신의 수상이력을 등록할 수 있도록 한다.
				inf.add(f);
				p3.add(inf);
				
				Title3 = new JTextField(20);
				Title3.setText("title");
				inft.add(Title3);
				directorName2 = new JTextField(20);
				directorName2.setText("director name");
				inft.add(directorName2);
				festivName = new JTextField(20);
				festivName.setText("festival name");
				inft.add(festivName);
				p3.add(inft);
				//영화 제목, 감독 이름, 영화제 이름을 입력받는다.
				insertFes = new JButton("insert");
				insertFes.addActionListener(new DActionListener());
				infb.add(insertFes);
				p3.add(infb);
				p.add(p3);
				//insert 버튼 제공
				
				JPanel p7 = new JPanel(new GridLayout(3,1));
				JPanel pac = new JPanel();
				JPanel pact = new JPanel(new FlowLayout());
				JPanel pacb = new JPanel(new FlowLayout());
				JLabel pic = new JLabel("<Insert movie title, actor name, actor role and press 'pick'.>");
				//배우를 뽑을 수 있다.
				pac.add(pic);
				p7.add(pac);
				
				Title6 = new JTextField("title",20);
				pact.add(Title6);
				actorName = new JTextField("actor name", 20);
				pact.add(actorName);
				actorRole = new JTextField("actor role",20);
				pact.add(actorRole);
				p7.add(pact);
				//가제, 배우 이름, 지정할 역할을 입력받는다.
				pickAct = new JButton("pick");
				pickAct.addActionListener(new DActionListener());
				pacb.add(pickAct);
				p7.add(pacb);
				//pick 버튼 제공
				p.add(p7);
				add(p);
				
				JPanel p4 = new JPanel(new GridLayout(4,1));
				JPanel cl = new JPanel();
				JPanel cf = new JPanel(new FlowLayout());
				JPanel cb = new JPanel(new FlowLayout());
				JLabel cla = new JLabel("<Insert movie title and press 'check' to check current investment.>"
				+" or <Insert movie title and press 'show' to check current applied actors.>");
				cl.add(cla);
				p4.add(cl);
				//현재 투자상황을 알 수 있도록 해준다.
				Title4 = new JTextField("title",20);
				cf.add(Title4);
				p4.add(cf);
				//가제를 입력받는다.
				checkInv = new JButton("check");
				checkInv.addActionListener(new DActionListener());
				cb.add(checkInv);
				showAct = new JButton("show");
				showAct.addActionListener(new DActionListener());
				cb.add(showAct);
				p4.add(cb);
				JPanel abc = new JPanel();
				abc.add(result);
				p4.add(abc);
				p.add(p4);
				//check버튼 제공
				
				
				
				JPanel p6 = new JPanel(new GridLayout(4,1));
				JPanel cal = new JPanel();
				JLabel l5 = new JLabel("<Input actor name and press 'show' to see actor's filmography.>");
				cal.add(l5);
				p6.add(cal);
				//감독은 배우의 필모그래피 확인이 가능하다.
				JPanel cat = new JPanel(new FlowLayout());
				JPanel cab = new JPanel(new FlowLayout());
				JPanel car = new JPanel();
				result2.setText("=============================================================================================="
						+ "==================================================================================="+"\n"
			               +"\tmovie "+"\t||\t"+"year"+"\t||\t"+"role"+"\t||\t"+"actor_name"+"\n"
			               +"================================================================================================="
			               + "================================================================================"+"\n");
				actorName2 = new JTextField("actor name",20);
				cat.add(actorName2);
				p6.add(cat);
				//배우 이름을 입력받는다.
				showAFilm =  new JButton("show");
				showAFilm.addActionListener(new DActionListener());;
				cab.add(showAFilm);
				p6.add(cab);
				car.add(result2);
				p6.add(car);
				p.add(p6);
				//버튼 제공
				
				

				setVisible(true);			

			}
			class DActionListener implements ActionListener{
				public void actionPerformed(ActionEvent e){
					
					try{
						
						con = DriverManager.getConnection("jdbc:mysql://localhost:3306/team15", "team15", "team15");
						st = con.createStatement(); 	
					
					PreparedStatement ps;
					
					if(e.getSource()==insertMov){//영화 삽입
						try{ 
							int [] ti = new int[100];//아이디 배열
							rs = st.executeQuery("select working_title_id from DBCOURSE_TITLE_ID;");
							while(rs.next()){
								for(int i=0;i<ti.length;i++)
									ti[i]=rs.getInt(1);
							}//아이디를 다받아서 배열에 저장
							title_id = (int)(Math.random()*10000+1);//랜덤 아이디
							 while(true){
								 int j;
								 for(j=0;j<ti.length;j++){
									 if(ti[j]==title_id){
										 title_id = (int)(Math.random()*10000+1);
										 j=-1;
										 break;
									 }
								 }//duplicate 확인
								 if(j!=-1)
									 break;//unique한 아이디이면 ok
							 }
						
							rs = st.executeQuery("select name from DBCOURSE_DIRECTOR where name=\""+directorName1.getText()+"\";");
							//감독 이름이 이미 존재하는지 확인
							if(rs.wasNull()){
								ps = con.prepareStatement("insert into DBCOURSE_DIRECTOR values(?,?)");
								ps.setString(1, directorName1.getText());
								ps.setString(2,"No Movie");
								ps.executeUpdate();
							}//감독 체크하고 없으면 감독테이블에 삽입
							
						ps = con.prepareStatement("INSERT INTO DBCOURSE_TITLE_ID "
								+ "VALUES(?,?,?)");
						ps.setInt(1, title_id);
						ps.setString(2, Title1.getText());
						ps.setString(3, null);
						ps.executeUpdate();//새로운 영화에 타이틀 아이디 주기
						
						
						ps = con.prepareStatement("INSERT INTO DBCOURSE_MOVIE VALUES(?,?,?)");
						ps.setInt(1, title_id);
						ps.setString(2, directorName1.getText());
						ps.setString(3, genre.getText());
						ps.executeUpdate();//무비 테이블에 영화 삽입
						
						ps = con.prepareStatement("INSERT INTO DBCOURSE_MOVIE_ASSET VALUES(?,?,?)");
						ps.setInt(1, title_id);
						ps.setString(2,null);
						ps.setString(3, budget.getText());
						ps.executeUpdate();//무비 에셋 테이블에 추가
						
						result.setText("Movie Inserted");
						
						
					
						}
						catch(SQLException e1){
							System.out.println("insert movie error");
							e1.printStackTrace();
							
						}
					}
					else if(e.getSource() == delete){//영화 종료
						try{
							
							
							st.executeUpdate("UPDATE DBCOURSE_TITLE_ID SET DONE=\"done\";");//완료함을 저장
							result.setText("Audition Finished");
							
						}
						catch(SQLException e1){
							System.out.println("done movie error");
							e1.printStackTrace();
						
						}
						
					}
					else if(e.getSource()==insertAud){//오디션 삽입
						try{
							int tempId=-1;
							ps = con.prepareStatement("INSERT INTO DBCOURSE_AUDITION VALUES(?,?,?)");
							rs = st.executeQuery("SELECT WORKING_TITLE_ID FROM DBCOURSE_TITLE_ID WHERE WORKING_TITLE =\""+Title2.getText()+"\";");
							//영화 아이디 가져오기
							if(rs.next()){
								tempId = rs.getInt(1);
							ps.setInt(1,tempId);
							String d1 = audDate.getText();
							String d2 = annDate.getText();
							ps.setString(2,d1);
							ps.setString(3, d2);
							ps.executeUpdate();
							}//오디션 삽입
							else{
								result.setText("check your input");
							}
							
							result.setText("Audition Inserted");
							
						}
						catch(SQLException e1){
							System.out.println("insert audition error");
							e1.printStackTrace();
						}
					}
					else if(e.getSource()==insertFes){//수상작
						try{
							
							ps= con.prepareStatement("INSERT INTO DBCOURSE_FILM_FESTIVAL VALUES(?,?,?)");
							ps.setString(1, Title3.getText());
							ps.setString(2, directorName2.getText());
							ps.setString(3, festivName.getText());
							ps.executeUpdate();
							result.setText("Prize Inserted");
						//수상 이력 삽입
						}
						catch(SQLException e1){
							System.out.println("insert festival error");
							e1.printStackTrace();
						}
					}
					else if(e.getSource()== checkInv){//투자금 확인
						try{
							
							result.setText("========================================================================"+"\n"
						               +"\tcurrent Investment\t\n"
						               +"============================================================================"+"\n");
							rs = st.executeQuery("SELECT CURRENT_INVESTMENT FROM DBCOURSE_MOVIE_ASSET natural join DBCOURSE_TITLE_ID WHERE WORKING_TITLE = \""+Title4.getText()+"\";");
							if(rs.next())
								result.append(rs.getString(1));//디렉터 유저에게 투자금 알려줌
							else
								result.append("No Investment Yet");
							
							
						}
						catch(SQLException e1){
							System.out.println("check investiment error");
							e1.printStackTrace();
							
						}
						
					}
					else if(e.getSource()==showAct){//배우 확인
						try{
							int tempId=0;
							result.setText("=============================================================================================="
									+ "==================================================================================="+"\n"
						               +"\tactor name "+"\t||\t"+"gender"+"\t||\t"+"debut year"+"\t||\t"+"career"+"\n"
						               +"================================================================================================="
						               + "================================================================================"+"\n");
							
							rs = st.executeQuery("SELECT WORKING_TITLE_ID FROM DBCOURSE_TITLE_ID WHERE WORKING_TITLE =\""+Title4.getText()+"\";");
							//영화 아이디 가져오기
							if(rs.next()) {
								tempId = rs.getInt(1);
								rs = st.executeQuery("SELECT a.name,a.gender,a.debut_year,a.career FROM DBCOURSE_ACTOR as a,DBCOURSE_RECRUIT as r where a.name = r.applied_actor and r.working_title_id = "+tempId+";");
							//관련 배우 테이블 불러오기
							   while (rs.next()) {
							       String an = rs.getString(1);
							       String ag = rs.getString(2);
							       String dy= rs.getString(3);
							       int cy = rs.getInt(4);
							       result.append(an+"   ||   "+ag+"   ||   "+dy+"   ||   "+cy+"\n");
							   }
							   
							}
							
							
							  
						
							
						}

						catch(SQLException e1){
							System.out.println("show actor error");
							e1.printStackTrace();
							
						}
					}
					else if(e.getSource()==showAFilm){//필모그래피
						try{
							
							
							
								
							rs = st.executeQuery("SELECT movie, year,role,actor_name FROM DBCOURSE_FILMOGRAPHY where actor_name =\""+actorName2.getText()+"\";");
							
							   while (rs.next()) {
							       String mn = rs.getString(1);
							       String y = rs.getString(2);
							       String r= rs.getString(3);
							       String an = rs.getString(4);
							       result2.append(mn+"   ||   "+y+"   ||   "+r+"   ||   "+an+"\n");

							   }
							   
							
							
							   
							  
						
							
						}

						catch(SQLException e1){
							System.out.println("show actor filmography error");
							e1.printStackTrace();
							
						}
					}
					else if(e.getSource()==pickAct){//배우 뽑기
						try{
							int tempId = 0;
							rs = st.executeQuery("SELECT WORKING_TITLE_ID FROM DBCOURSE_TITLE_ID WHERE WORKING_TITLE =\""+Title6.getText()+"\";");
							//영화 아이디 가져오기
							if(rs.next()){
							tempId = rs.getInt(1);}
							st.executeUpdate("UPDATE DBCOURSE_RECRUIT SET CASTING_ROLE=\""+actorRole.getText()+"\" WHERE WORKING_TITLE_ID = "+ tempId+" and applied_actor = \""+actorName.getText()+"\";");
							result.setText("Actor Picked");
							
						}

						catch(SQLException e1){
							System.out.println("pick actor error");
							e1.printStackTrace();
						}
						
					} 
					
					else{
						
					}}
					catch(SQLException e3){
						System.out.println("connection in event handling error");
					}
				}
						}

	}
		//1515004 권나현
class ActorFrame extends JFrame{
	
	public String name1,gender,debut_year;
	public String name2,movie1,role;
	public String name3;
	int movie2;
	
	public int career,year;
	//사용자 입력을 받아 저장할 변수 선언
	   
	public JButton b1,b2,b3,b4,b5,b6;

	public JTextField t1,t2,t3,t4,t5,t6,t7,t8,t9;
	   
	public TextArea result;
	//public JScrollPane scrollPane;
	//gui component 선언
	
	public ActorFrame(){
	      
	      
	      setSize(1000,800);
	      setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	      setTitle("Actor");
	      
	      JPanel panel = new JPanel();
	      //최종 panel
	      
	      //panel.setLayout(new GridLayout(11,1));
	      
	      JPanel topic1 = new JPanel();
	      JPanel topic2 = new JPanel();
	      JPanel topic3 = new JPanel();
	      JPanel topic4 = new JPanel();
	      
	      
	      JPanel panel1 = new JPanel();
	      JPanel panel2 = new JPanel();
	      JPanel panel3 = new JPanel();
	      JPanel panel4 = new JPanel();
	      JPanel panel5 = new JPanel();
	      JPanel panel6 = new JPanel();
	      JPanel panel7 = new JPanel();
	      JPanel panel8 = new JPanel();
	      JPanel panel9 = new JPanel();
	      JPanel panel10 = new JPanel();
	      JPanel panel11 = new JPanel();
	      
	      
	      JLabel l1 = new JLabel("<Input data of actor, and press 'insert' or 'delete' button.>");
	      JLabel l2 = new JLabel("<Input data of actor's filmography, and press 'insert' of 'delete' button.>");
	      JLabel l3 = new JLabel("<Input data of movie code that you want to apply, your name and press 'apply' button.> ");
	      JLabel l4 = new JLabel("<If you want to know what movies are accepting application, press 'search' button.>");
	      
	      t1 = new JTextField("name",20);
	      t2 = new JTextField("gender(f/m)",20);
	      t3 = new JTextField("debut year",20);
	      
	      t4 = new JTextField("actor name",20);
	      t5 = new JTextField("movie",20);
	      t6 = new JTextField("launched year",20);
	      t7 = new JTextField("role",20);
	      
	      t8 = new JTextField("movie code",20);
	      t9 = new JTextField("name",20);
	      //사용자의 입력을 받기 위한 텍스트필드 생성
	      
	      b1 = new JButton("insert");
	      b2 = new JButton("delete");
	      b3 = new JButton("insert");
	      b4 = new JButton("delete");
	      b5 = new JButton("apply");
	      b6 = new JButton("search");
	      //버튼 생성
	      
	      b1.addActionListener(new ActActionListener());
	      b2.addActionListener(new ActActionListener());
	      b3.addActionListener(new ActActionListener());
	      b4.addActionListener(new ActActionListener());
	      b5.addActionListener(new ActActionListener());
	      b6.addActionListener(new ActActionListener());
	      //button에 action 추가
	      
	      
	      result = new TextArea();
	      result.setSize(100,20);
	     // scrollPane = new JScrollPane(result);
	     // scrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
	      //필요한 테이블 정보를 받아 올 text area
	      
	  
	      


      
	      panel1.add(t1);
	      panel1.add(t2);
	      panel1.add(t3);

	      
	      panel2.add(b1);
	      panel2.add(b2);
  
	      panel3.add(result);

     
	      panel4.add(t4);
	      panel4.add(t5);
	      panel4.add(t6);
	      panel4.add(t7);
 
	      panel6.add(b3);
	      panel6.add(b4);
     
	      panel5.add(t8);
	      panel5.add(t9);
	      panel5.add(b5);
	      
	      panel7.add(b6);
	      
	      panel8.add(l4);
	      panel9.add(l1);
	      panel10.add(l2);
	      panel11.add(l3);
	      
	      
	      topic1.setLayout(new GridLayout(3,1));
	      topic1.add(panel9);//l1    
	      topic1.add(panel1);
	      topic1.add(panel2);
	      
	      topic2.setLayout(new GridLayout(3,1));
	      topic2.add(panel10);//l2
	      topic2.add(panel4);
	      topic2.add(panel6);
	      
	      topic3.setLayout(new GridLayout(2,1));
	      topic3.add(panel11);//l3
	      topic3.add(panel5);
	      
	      topic4.setLayout(new GridLayout(3,1));
	      topic4.add(panel8);//l4
	      topic4.add(panel3);  
	      topic4.add(panel7);
	      
	      
	      
	      panel.add(topic1);
	      panel.add(topic2);
	      panel.add(topic3);
	      panel.add(topic4);
	      
	      add(panel);
	      setVisible(true);
	      
	      

	   }
		   
		   
		   
		   
		   

		  
		   
		   
		   class ActActionListener implements ActionListener{
		   
		   public void actionPerformed(ActionEvent e){
		      try {

		         
		         if(e.getSource() == b1){
		         //배우 정보 insert
		            name1 = t1.getText();
		            gender = t2.getText();
		            debut_year = t3.getText();
		            career = 2017-(Integer.parseInt(debut_year));
		            //텍스트필드에서 입력값을 받아 로컬 변수에 저장
		            
		            PreparedStatement pStmt = con.prepareStatement("insert into dbcourse_actor "
		            + "values (?,?,?,?)");
		            
		            pStmt.setString(1, name1);
		            pStmt.setString(2, gender);
		            pStmt.setString(3, debut_year);
		            pStmt.setInt(4, career);
		            //입력값을 이용해 dbcourse_actor 테이블에 배우 정보 insert
		            
		            pStmt.executeUpdate();
		            //prepared statement 실행
		            
		            result.setText(name1+ " 's actor information was successfully inserted.");
		         }
		         
		         if(e.getSource() == b2){
		         //배우 정보 delete
		            name1 = t1.getText();
		            //배우의 정보 삭제는 이름만 입력해도 가능한 것으로 설정
		            
		            PreparedStatement pStmt = con.prepareStatement("delete from dbcourse_actor "
		                  + "where name = ?");
		            pStmt.setString(1,name1);
		            //텍스트필드에서 받아온 입력값을 사용해 dbcourse_actor 테이블에서 배우 정보 delete
		            
		            pStmt.executeUpdate();
		            //prepared statement 실행
		            
		            result.setText(name1+ " 's actor information was successfully deleted.");
		            
		         }
		         
		         if(e.getSource() == b3){
		         //배우 필모그래피 insert
		        	 
		            name2 = t4.getText();
		            movie1 = t5.getText();
		            year = Integer.parseInt(t6.getText());
		            role = t7.getText();
		            //배우 경력에 관한 정보를 텍스트필드에서 받아옴
		            
		            PreparedStatement pStmt = con.prepareStatement("insert into dbcourse_filmography "
		                  + "values (?,?,?,?)");
		            pStmt.setString(1,name2);
		            pStmt.setString(2,movie1);
		            pStmt.setInt(3,year);
		            pStmt.setString(4,role);
		            //받아온 레코드를 dbcourse_filmography 테이블에 insert 
		            
		            pStmt.executeUpdate();
		            
		            result.setText(name2+ " 's filmography was successfully inserted.");
		         }
		         
		         if(e.getSource() == b4){
		         //배우 필모그래피 삭제
		            name2 = t4.getText();
		            movie1 = t5.getText();
		            year = Integer.parseInt(t6.getText());
		            role = t7.getText();
		            //필모그래피의 정보는 테이블의 모든 정보를 모두 입력해야 delete 가능
		            
		            PreparedStatement pStmt = con.prepareStatement("delete from dbcourse_filmography "
		                  + "where actor_name = ? and movie =? and year = ? and role = ?");
		            
		            pStmt.setString(1,name2);
		            pStmt.setString(2,movie1);
		            pStmt.setInt(3,year);
		            pStmt.setString(4,role);
		            
		            pStmt.executeUpdate();
		            //입력값을 사용해 dbcourse_filmography 테이블에서 배우 경력 정보 delete
		            
		            result.setText(name2+" 's filmography was successfully deleted.");
		         }
		         
		         if(e.getSource() == b5){
		         //조회 화면에 띄워진 정보를 보고 영화 지원
		            
		         /*배우가 영화에 지원
		         	movie와 title_id를 working_title_id로 조인하여 
		         	조회 화면에서 movie의 모든 정보를 제공한다(가제 포함)
		         	배우는 조회 화면에서 지원할 영화를 골라
		         	이름과 지원영화를 쓰고 지원 버튼을 누른다
		         
		         	지원영화를 보고 title_id 테이블을 이용해 영화의 아이디를 알아낸다
		         	아이디를 이용해 recruit 테이블에 영화의 아이디, 배우 이름을 인서트 하고
		         	audition 테이블의 모든 정보를 조회 화면에 띄워준다
		         */
		         
		            movie2 = Integer.parseInt(t8.getText());
		            name3 = t9.getText();
		            
		            
		            PreparedStatement pStmt = con.prepareStatement("insert into dbcourse_recruit "
		                  + "values (?,?,null)");
		            
		            pStmt.setInt(1, movie2);
		            pStmt.setString(2, name3);
		            
		            pStmt.executeUpdate();
		            
		            result.setText("<Audition information of the movie that you applied>"+"\n"+"working title|movie code|audition date|announcement date"+"\n");
		            ResultSet rset = st.executeQuery("select distinct t.working_title,t.working_title_id,a.aud_date,a.announce_date "
		                  + "from dbcourse_recruit as r, dbcourse_audition as a, dbcourse_title_id as t "
		                  + "where r.working_title_id = a.working_title_id "
		                  + "and a.working_title_id = t.working_title_id "
		                  + "and t.working_title_id = "+movie2);
		            // JOIN을 이용하여 사용자가 지원한 영화의 오디션 정보를 받아온다
		            while(rset.next()){
		               result.append(rset.getString("t.working_title")+" | "
		            		   +rset.getString("t.working_title_id")+" | "
		                     +rset.getString("a.aud_date")+" | "
		                     +rset.getString("a.announce_date")+"\n");
		            }
		            //받아온 정보를 TextArea result에 출력한다
		         }
		         
		         if(e.getSource() == b6){
		         //지원할 수 있는 영화 정보 조회
		        	 
		            ResultSet rset = st.executeQuery("select t.working_title,m.working_title_id,m.director,m.genre "
		                  + "from dbcourse_title_id as t,dbcourse_movie as m "
		                  + "where t.working_title_id = m.working_title_id");
		            	//JOIN을 이용하여 영화 정보를 가져온다. movie 테이블에는 영화 제목이 아닌
		            	//영화 코드가 저장되어 있으므로 movie 테이블과 title_id 테이블을 조인하여 영화 제목을 추가하여 출력해 준다.
		            	//
		            result.setText("<Movie information>"+"\n"+"working title|movie code|director|genre"+"\n");
		            
		            while(rset.next()){
		               
		               result.append(rset.getString("t.working_title")+" | "
		                     +rset.getString("m.working_title_id")+" | "
		                     +rset.getString("m.director")+" | "
		                     +rset.getString("m.genre")+"\n");
		               
		               }
		          
		            //TextArea에 지원 가능한 영화 정보 출력
		         }
		         
		      

		      
		         
		         

		         
		         
		         
		         

		      } catch (SQLException sqex) {

		         System.out.println("SQLException: " + sqex.getMessage());

		         System.out.println("SQLState: " + sqex.getSQLState());

		      }
		   }
		   }}
//1515005 권성경
		   class InvestorFrame extends JFrame{

			  
			   
			 
			   
			   
			   
			  
			   
			   JTextField invst_name;
			   JTextField worktitle;
			   JTextField investment;
			   
			   JButton insert;
			   JButton delete;
			   
			   JLabel expl;
                           JPanel dinfopanel;
	
	                   TextArea direc;
			   
			   //============생성자===============
			   public InvestorFrame(){		setSize(1000,820);
		setTitle("Investor");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setVisible(true);
		
		JPanel txtpanel = new JPanel();
		txtpanel.setLayout(new GridLayout(3,1));
		
		
		//=======insert,delete investor field=============
		//======explain textfield======
		JPanel texplainpanel = new JPanel();

		expl = new JLabel("Input information of investment and press 'input' or 'delete'.");
		expl.setFont(new Font("b",Font.PLAIN,20));
		texplainpanel.add(expl);
		
		txtpanel.add(texplainpanel);
		
		
		//======textfield==========
		JPanel tfieldpanel = new JPanel();
		invst_name = new JTextField("name",20);
		worktitle = new JTextField("title",20);
		investment = new JTextField("amount to invest",20);
		
		tfieldpanel.add(invst_name);
		tfieldpanel.add(worktitle);
		tfieldpanel.add(investment);
		
		txtpanel.add(tfieldpanel);
		
		//=====insert, delete button========
		JPanel tbuttonpanel = new JPanel();
		
		insert = new JButton("insert");
		delete = new JButton("delete");
		
		insert.addActionListener(new IActionListener());
		delete.addActionListener(new IActionListener());
		
		tbuttonpanel.add(insert);
		tbuttonpanel.add(delete);
		
		txtpanel.add(tbuttonpanel);
		
		add(txtpanel,BorderLayout.PAGE_START);
		
		//===end of insert,delete investor field========
		//======show movie info=============
		
		
		JPanel minfopanel = new JPanel();
		
		TextArea movi = new TextArea();
		
		minfopanel.add(movi);
		
		
		add(minfopanel,BorderLayout.CENTER);
		movi.setFont(new Font("myfont",Font.PLAIN,20));
		movi.setText("====================================================================="+"\n"
					+"가제 "+"\t||\t"+"감독"+"\t||\t"+"장르"+"\n"
					+"====================================================================="+"\n");
		
		try{
			//영화의 정보를 rs에 받아서 보여줌
			st= con.createStatement();
			st.executeQuery("select working_title, director, genre "
					+ "from dbcourse_movie, dbcourse_title_id "
					+ "where dbcourse_movie.working_title_id=dbcourse_title_id.working_title_id;");
			
			rs=st.getResultSet();
			
			while(rs.next()){
				String wt = rs.getString("working_title");
				String dr = rs.getString("director");
				String gn = rs.getString("genre");
				movi.append(wt+"   ||   "+dr+"   ||   "+gn+"\n");
			}
		}
		catch (SQLException sqex) {

			System.out.println("SQLException: " + sqex.getMessage());

			System.out.println("SQLState: " + sqex.getSQLState());

		}
		//=======end of show movie===============
		//=========show dir info===============
		
        dinfopanel = new JPanel();
		
		direc = new TextArea(3,0);
		
		dinfopanel.add(direc);
		dinfopanel.setSize(900, 300);
		direc.setSize(900, 300);
		
		add(dinfopanel,BorderLayout.PAGE_END);
		direc.setFont(new Font("myfont",Font.PLAIN,20));
		direc.setText("====================================================================="+"\n"
					+"감독 "+"\t"+"||"+"\t"+"영화"+"\t"+"||"+"\t"+"영화제"+"\t"+"\n"
					+"====================================================================="+"\n");
		try{
			//감독의 정보를 받아서 보여줌
			st= con.createStatement();
			st.executeQuery("select name, movie, festiv_name "
					+ "from (select name, dbcourse_director.movie, festiv_name "
					+ "from dbcourse_director, dbcourse_film_festival "
					+ "where dbcourse_director.name = dbcourse_film_festival.director) as T;");
			
			rs=st.getResultSet();
			
			while(rs.next()){
				String nm = rs.getString("name");
				String mv = rs.getString("movie");
				String fn = rs.getString("festiv_name");
				direc.append(nm+"\t||\t"+mv+"\t||\t"+fn+"\n");
			}
			
		}
		catch (SQLException sqex) {

			System.out.println("SQLException: " + sqex.getMessage());

			System.out.println("SQLState: " + sqex.getSQLState());

		}
			      //==========================================
			   }
			      class IActionListener implements ActionListener{
			   public void actionPerformed(ActionEvent e){
			      
		//투자자 삽입
		if(e.getSource()==insert){
			try{
				
				st= con.createStatement();
				//현재 투자금과 예산을 가져옴
				st.executeQuery("select current_investment, budget "
						+ "from dbcourse_movie_asset "
						+ "where working_title_id = (select working_title_id "
													+ "from dbcourse_title_id "
													+ "where working_title = \""+worktitle.getText()+"\");");
				rs=st.getResultSet();
				rs.next();
				String s1=rs.getString("current_investment");
				String s2 = rs.getString("budget");
				int cur = Integer.parseInt(s1);
				int bud = Integer.parseInt(s2);
				

				//만약 투자하고자 하는 금액을 추가하였을 때 예산을 넘는다면 insert하지 않음
				if(bud<(cur+(Integer.parseInt(investment.getText())))){
					expl.setText("Your investment is over budget!");
				}
				//그렇지 않으면 insert
				else{
					st= con.createStatement();
					
					//id를 먼저 가져옴
					st.executeQuery("select working_title_id "
							+ "from dbcourse_title_id "
							+ "where working_title = \""+worktitle.getText()+"\";");
					rs=st.getResultSet();
					rs.next();
					int id = rs.getInt(1);
					
					//transation을 위한 boolean값
					boolean insertsuccess=false;
					try{
						//transation
						con.setAutoCommit(false);
						PreparedStatement pStmt = con.prepareStatement("insert into dbcourse_investor "
								+ "values (?,?,?)");
						pStmt.setString(1,invst_name.getText() );
					
						pStmt.setInt(2,id);
					
						pStmt.setInt(3,(Integer.parseInt(investment.getText())) );
					
						pStmt.executeUpdate();		
					
						st.executeUpdate("update dbcourse_movie_asset "
								+ "set current_investment = current_investment+"
								+investment.getText()+" where working_title_id = "+id+";");
						
						//성공하면 true
						insertsuccess=true;
					
					}
					catch(SQLException sqle){
						System.out.println(sqle.getMessage());
					}
					finally{
						if(insertsuccess){
							con.commit();
							expl.setText("Invested successfully!");
							direc.setText("====================================================================="+"\n"
									+"감독"+"\t"+"||"+"\t"+"영화"+"\t"+"||"+"\t"+"투자금"+"\t"+"\n"
									+"====================================================================="+"\n");
						try{
							//투자 정보를 받아서 보여줌
							st= con.createStatement();
							st.executeQuery("select inv_name, working_title, investment "
									+ "from dbcourse_investor, dbcourse_title_id "
									+ "where dbcourse_investor.working_title_id = dbcourse_title_id.working_title_id; ");
				
							rs=st.getResultSet();
							
							while(rs.next()){
								String nm = rs.getString("inv_name");
								String mv = rs.getString("working_title");
								String in = rs.getString("investment");
								direc.append(nm+"\t||\t"+mv+"\t||\t"+in+"\n");
							}
							//4초 간 보여줌
							try {
							      Thread.sleep(4 * 1000);
							    } catch (InterruptedException ee) { }
							
							//4초 후 다시 감독 정보 보여줌
							direc.setText("");
							direc.setText("====================================================================="+"\n"
									+"감독 "+"\t"+"||"+"\t"+"영화"+"\t"+"||"+"\t"+"영화제"+"\t"+"\n"
									+"====================================================================="+"\n");

							st.executeQuery("select name, movie, festiv_name "
									+ "from (select name, dbcourse_director.movie, festiv_name "
									+ "from dbcourse_director, dbcourse_film_festival "
									+ "where dbcourse_director.name = dbcourse_film_festival.director) as T;");
							
							rs=st.getResultSet();
							
							while(rs.next()){
								String nm = rs.getString("name");
								String mv = rs.getString("movie");
								String fn = rs.getString("festiv_name");
								direc.append(nm+"\t||\t"+mv+"\t||\t"+fn+"\n");
							}
					
							


							
						}
						catch (SQLException sqex) {

							System.out.println("SQLException: " + sqex.getMessage());

							System.out.println("SQLState: " + sqex.getSQLState());

						}
						}
						else{
							//transaction 실패한 경우
							con.rollback();
						}
					}
				}
				
			}
			catch (SQLException sqex) {
				sqex.printStackTrace();

				System.out.println("SQLException: " + sqex.getMessage());

				System.out.println("SQLState: " + sqex.getSQLState());

			}
		}
		//투자 취소
		else if(e.getSource()==delete){
			
			try{
				st= con.createStatement();
				
				//id먼저 가져옴
				st.executeQuery("select working_title_id "
						+ "from dbcourse_title_id "
						+ "where working_title = \""+worktitle.getText()+"\";");
				rs=st.getResultSet();
				rs.next();
				int id = rs.getInt(1);
				
				//투자자가 투자한 금액 가져옴
				st.executeQuery("select investment "
						+ "from dbcourse_investor "
						+ "where working_title_id = "+id+" and inv_name='"+invst_name.getText()+"';");
				rs=st.getResultSet();
				rs.next();
				int invmn = rs.getInt(1);
				
				boolean deletesuccess=false;
				//투자금보다 많은 금액은 취소할 수 없음
				if(invmn<Integer.parseInt(investment.getText())){
					expl.setText("You can not cancel more than the investment amount.");
				}
				//투자금==취소하고자 하는 금액일 경우 movie_asset 뿐 아니라 investor table에서도 제거함
				else if(invmn==Integer.parseInt(investment.getText())){
	
				
				try{
					//transaction
				con.setAutoCommit(false);
				//movie_asset테이블에서 삭제
				st.executeUpdate("update dbcourse_movie_asset "
						+ "set current_investment = current_investment-"
						+investment.getText()+" where working_title_id = "+id+";");

				//investor테이블에서 삭제
				st.executeUpdate("delete from dbcourse_investor "
						+ "where working_title_id = "+id+" and inv_name = \""+invst_name.getText()+"\";");
				
				deletesuccess=true;
				}
				catch(SQLException sqle){
					System.out.println(sqle.getMessage());
				}
				finally{
					if(deletesuccess){
						con.commit();
						expl.setText("Investment canceled.");
					}
					else{
						con.rollback();
					}
				}
				
				}
				//투자금> 취소하고자 하는 금액 일 경우 delete하지 않고 투자 금액만 감소 시킴
				else{
					try{
						//transaction
						con.setAutoCommit(false);
				//movie_asset테이블에서 투자금 감소시킴
				st.executeUpdate("update dbcourse_movie_asset "
						+ "set current_investment = current_investment-"
						+investment.getText()+" where working_title_id = "+id+";");
				//investor테이블에서 투자금 감소시킴 
				st.executeUpdate("update dbcourse_investor "
						+ "set investment = investment-"
						+investment.getText()+" where working_title_id = "+id+";");
				
				deletesuccess=true;
					}
					catch(SQLException sqle){
						System.out.println(sqle.getMessage());
					}
					finally{
						if(deletesuccess){
							con.commit();
							expl.setText("amount of Investment is decreased.");
						}
						else{
							con.rollback();
						}
					}

				
				}
				
				
	
				
			

			}
			catch (SQLException sqex) {

				System.out.println("SQLException: " + sqex.getMessage());

				System.out.println("SQLState: " + sqex.getSQLState());

			}
			
		}
			   }//ActionPerformed 끝
		   }
		   }
	
//공통 main method
   public static void main(String[] args) {

      try {

         con = null;
         st = null;

         rs = null;

         con = DriverManager.getConnection("jdbc:mysql://localhost:3306/team15?autoReconnect=true&useSSL=false",
        		 "team15", "team15");
        
         st = con.createStatement();
         
         
     	
			
			//1515009 김다영
			st.executeUpdate("CREATE TABLE DBCOURSE_DIRECTOR("
					+ "NAME VARCHAR(30) PRIMARY KEY,"
					+ "MOVIE VARCHAR(30));");

					st.executeUpdate("CREATE TABLE DBCOURSE_TITLE_ID("
					+ "WORKING_TITLE_ID INT PRIMARY KEY,"
					+ "WORKING_TITLE VARCHAR(30) NOT NULL,"
					+ "DONE VARCHAR(30));");
			
			//1515005 권성경
			st.executeUpdate("create table DBCOURSE_MOVIE("
					+ "working_title_id int not null,"
					+ "director varchar(30) not null,"
					+ "genre varchar(30),"
					+ "primary key (working_title_id),"
					+ "foreign key (working_title_id) references dbcourse_title_id(working_title_id));");
					
			//1515009 김다영		
			st.executeUpdate("CREATE TABLE DBCOURSE_FILM_FESTIVAL("
					+ "MOVIE VARCHAR(30) NOT NULL,"
					+ "DIRECTOR VARCHAR(30) NOT NULL,"
					+ "FESTIV_NAME VARCHAR(30) PRIMARY KEY,"
					+ "FOREIGN KEY(DIRECTOR) REFERENCES dbcourse_DIRECTOR(NAME));");

			
			
			//1515005 권성경
			st.executeUpdate("create table DBCOURSE_INVESTOR("
					+ "inv_name varchar(30) not null,"
					+ "working_title_id int not null,"
					+ "investment int,"
					+ "primary key (inv_name, working_title_id));");
			st.executeUpdate("create table DBCOURSE_movie_asset("
					+ "working_title_id int not null,"
					+ "current_investment int,"
					+ "budget int,"
					+ "primary key(working_title_id),"
					+ "foreign key(working_title_id) references dbcourse_movie(working_title_id));");
			
				
			//1515004 권나현		
			st.executeUpdate("create table DBCOURSE_ACTOR("
					+ "name varchar(30) not null,"
					+ "gender char(1),"
					+ "debut_year varchar(30),"
					+ "career int,"
					+ "primary key(name));");


			st.executeUpdate("create table DBCOURSE_FILMOGRAPHY("
					+ "actor_name varchar(30) not null,"
					+ "movie varchar(30) not null,"					
					+ "year int,"
					+ "role varchar(30),"
					+ "primary key(actor_name),"
					+ "foreign key(actor_name) references DBCOURSE_ACTOR(name));");


			   st.executeUpdate("create table DBCOURSE_RECRUIT("
		               + "working_title_id int(5) not null,"
		               + "applied_actor varchar(30) not null,"
		               + "casting_role varchar(30),"
		               + "primary key(working_title_id,applied_actor),"
		               + "foreign key(applied_actor) references DBCOURSE_ACTOR(name));");
		         
		         st.executeUpdate("create table DBCOURSE_AUDITION("
		               + "working_title_id int(5) not null,"
		               + "aud_date date,"
		               + "announce_date date,"
		               + "primary key(working_title_id));");
			
		
			
			st.executeUpdate("create view invest as "
					+ "select * "
					+ "from DBCOURSE_MOVIE, DBCOURSE_INVESTOR "
					+ "where dbcourse_movie.working_title_id = dbcourse_investor.working_title_id;");
			st.executeUpdate("create view asset as "
					+ "select * "
					+ "from DBCOURSE_MOVIE, DBCOURSE_movie_asset, DBCOURSE_investor "
					+ "where dbcourse_movie.working_title_id = dbcourse_investor.working_title_id;");
			

								//1515005 권성경
								st.executeUpdate("insert into dbcourse_director "
										+ "values(\"Junho Bong\",\"The Host\");");
								st.executeUpdate("insert into dbcourse_director "
										+ "values(\"Steven Spielberg\",\"Saving Private\");");
								//1515009 김다영
							    st.executeUpdate("insert into DBCOURSE_DIRECTOR "
					          			+ "values(\"Christopher Nolan\",\"Interstella\");");

							    //1515005 권성경
								st.executeUpdate("insert into dbcourse_title_id "
										+ "values(10000,\"Parasite\",null);");
								st.executeUpdate("insert into dbcourse_title_id "
										+ "values(20000,\"Ready Play One\",null);");
								st.executeUpdate("insert into dbcourse_movie "
										+ "values(10000,\"Junho Bong\",\"Action\");");
								st.executeUpdate("insert into dbcourse_movie "
										+ "values(20000,\"Steven Spielberg\",\"SF\");");


							//1515005 김다영
							st.executeUpdate("insert into DBCOURSE_TITLE_ID "
					         + "values(20001,\"The Post\",NULL);");
					         st.executeUpdate("insert into DBCOURSE_TITLE_ID "
					          + "values(30000,\"Dunkirk\",NULL);");

					         
					         
					         st.executeUpdate("insert into DBCOURSE_MOVIE "
					          + "values(20001,\"Steven Spielberg\",\"drama\");");
					         st.executeUpdate("insert into DBCOURSE_MOVIE "
					          + "values(30000,\"Christopher Nolan\",\"action\");");

					         
					         //1515005 권성경
								st.executeUpdate("insert into dbcourse_investor "
										+ "values(\"CJ\",10000,10000);");
								st.executeUpdate("insert into dbcourse_investor "
										+ "values(\"new\",20000,1000000);");
								st.executeUpdate("insert into dbcourse_investor "
										+ "values(\"new\",20001,1500000);");
								st.executeUpdate("insert into dbcourse_investor "
										+ "values(\"new\",30000,3000000);");
								
								
								st.executeUpdate("insert into dbcourse_movie_asset "
										+ "values(10000,10000,1000000);");
								st.executeUpdate("insert into dbcourse_movie_asset "
										+ "values(20000,1000000,3000000);");
								st.executeUpdate("insert into dbcourse_movie_asset "
										+ "values(20001,1500000,2000000);");
								st.executeUpdate("insert into dbcourse_movie_asset "
										+ "values(30000,3000000,3000000);");
								
								
					//1515004 권나현
					st.executeUpdate("insert into dbcourse_actor "
					               + "values('Kangho Song','m',1996,21),"
					               + "('Simon Pegg','m',1999,18),"
					               + "('Olivia Cooke','f',2012,5),"
					               + "('Meryl Streep','f',1977,40),"
					               + "('Mark Rylance','m',1985,32),"
					               + "('Tom Hardy','m',2001,16),"
					               + "('Tom Hanks','m',1980,37),"
					               + "('T.J.Miller','m',2007,10),"
					               + "('Julie Nickson','f',1980,37),"
					               + "('Aneurin Barnard','m',2011,6);");
					
			
				//1515005 권성경
					st.executeUpdate("insert into dbcourse_recruit "
					               + "values(10000,	\"Kangho Song\",\"Main\"),"
					               + "(20000,\"Simon Pegg\",\"Sub\"),"
					               + "(20000,\"Olivia Cooke\",null),"
					               + "(20000,\"Meryl Streep\", \"Main\"),"
					               + "(20000,\"Mark Rylance\",null),"
					               + "(30000,\"Mark Rylance\",null),"
					               + "(30000,\"Tom Hardy\",null),"
					               + "(20001,\"Tom Hanks\",null),"
					               + "(20000,\"T.J. Miller\",null),"
					               + "(20001,\"Julie Nickson\",null),"
					               + "(30000,\"Aneurin Barnard\",null);");

					         
					         //1515009 김다영
					         st.executeUpdate("insert into DBCOURSE_FILM_FESTIVAL "

					          + "values(\"Saving Private\",\"Steven Spielberg\",\"Academy\");");

					         st.executeUpdate("insert into DBCOURSE_FILM_FESTIVAL "

					          + "values(\"Interstella\",\"Christopher Nolan\",\"Max Movie\");");

					        
					//1515004 권나현
					         st.executeUpdate("insert into dbcourse_filmography "
					               + "values('Kangho Song','The Host',2006,'main'),"
					               + "('Simon Pegg','Star Wars',2015,'main'),"
					               + "('Olivia Cooke','The Signal',2014,'main'),"
					               + "('Meryl Streep','The Devil wears Prada',2006,'main'),"
					               + "('Mark Rylance','Bridge of Spies',2015,'main'),"
					               + "('Tom Hardy','Mad Max',2015,'main'),"
					               + "('Tom Hanks','Bridge of Spies',2015,'main'),"
					               + "('T.J.Miller','Deadpool',2016,'sub'),"
					               + "('Julie Nickson','Rambo2',1985,'sub'),"
					               + "('Aneurin Barnard','Legend',2015,'sub');");
					         
					         
					         st.executeUpdate("insert into dbcourse_audition "
					               + "values(10000,'2017-07-25','2017-08-31'),"
					               + "(20000,'2017-06-21','2017-07-01'),"
					               + "(20001,'2017-05-27','2017-06-03'),"
					               + "(30000,'2017-05-27','2017-06-05');");
					         
					      

								
								
								
			
			
			st.executeUpdate("alter table DBCOURSE_recruit add index(applied_actor(3))");
			st.executeUpdate("alter table DBCOURSE_investor add index(inv_name(2))");
			st.executeUpdate("alter table DBCOURSE_actor add index(name(5))");
			st.executeUpdate("alter table DBCOURSE_title_id add index(working_title(5))");
			st.executeUpdate("alter table DBCOURSE_filmography add index(actor_name(3))");


         
         
         
         rs = st.executeQuery("show databases;");

         

         if (st.execute("show databases;")) {

            rs = st.getResultSet();

         }

         new jdbcexam().new MenuFrame();

         while (rs.next()) {

            String str = rs.getNString(1);

            System.out.println(str);

         }

         
      } catch (SQLException sqex) {

         System.out.println("SQLException: " + sqex.getMessage());

         System.out.println("SQLState: " + sqex.getSQLState());

      }



   }

}
