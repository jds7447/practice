package version_09_20220205;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Toolkit;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.imageio.ImageIO;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

//메인 클래스
public class GalagonGame extends JPanel implements KeyListener, Runnable {
	//게임 실행중 여부 플래그
	private boolean running = true;
	
	//es.02.02 불린형 객체 endgamemg 추가 기본 형태는 false
	private boolean endgamemg;
	private boolean winmg;
	
	//각 유닛 객체들 저장소
	private ArrayList sprites = new ArrayList();
	private Common starship;
	private BufferedImage alienImage;
	private BufferedImage shotImage;
	private BufferedImage shipImage;
	private BufferedImage alienShotImage;
	
	//탄환으로 적 맞췄을 때 폭발 이미지
	private BufferedImage boomImage;
	
	//점수 표기용
	private JLabel score1;
	private int score2;
	
	//초기 화면용 라벨
	private JLabel start1;
	private JLabel start2;
	
	//게임 설명용 라벨
	private JLabel guide1;
	private JLabel guide2;
	
	//별 객체 변수
	private Background background;
	
	//게임 승리 라벨
	private JLabel win;
	private JLabel finalScore;
	
	//es.02.02 게임 패배 라벨
	private JLabel Lose;
	private JLabel end;
	
	// 스테이지 표시
	private JLabel finishStage;
	
	protected int stage = 0;
	
	//생성자 : 프레임 셋팅 및 각 유닛 이미지 생성
	public GalagonGame() {
		JFrame frame = new JFrame("Galaga Game");
		frame.setSize(800, 900);
		frame.add(this, BorderLayout.CENTER);
		frame.setResizable(false);
		frame.setVisible(true);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		// 현재 시스템 디스플레이의 창 사이즈를 가져온다
		Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
		// 생성되는 프레임 창의 위치를 (현재디스플레이의가로/2 - 프레임창가로/2, 현재디스플레이의세로/2 - 프레임창세로/2) 로 설정
		// 즉, 화면 정 중앙에 맞춘다
		frame.setLocation((int)((screenSize.getWidth() / 2) - (frame.getWidth()/2)), (int)((screenSize.getHeight() / 2) - (frame.getHeight()/2)));
		
		//별 객체 생성 및 별 좌표 생성
		background = new Background(this);
		background.addStar();
		
		//배경으로 패널 배경색 검은색으로 설정
		setBackground(Color.BLACK);
		
		setLayout(null);
		
		Font font1 = new Font("Gothic", Font.BOLD, 40);
		Font font2 = new Font("Arial", Font.PLAIN, 20);
		
		score1 = new JLabel("Score : " + score2);
		score1.setForeground(Color.YELLOW);
		score1.setFont(font1);
		score1.setSize(280, 45);
		score1.setLocation(10, 10);
		add(score1);

		start1 = new JLabel("GALAGON GAME");
		start1.setForeground(Color.RED);
		start1.setFont(new Font("Dialog", Font.ITALIC, 70));
		start1.setSize(570, 75);
		start1.setLocation((getWidth()/2) - (start1.getWidth()/2), (getHeight()/2) - start1.getHeight() - 50);
		add(start1);

		start2 = new JLabel("Please press the space bar");
		start2.setForeground(Color.WHITE);
		start2.setFont(new Font("Arial", Font.PLAIN, 30));
		start2.setSize(360, 35);
		start2.setLocation((getWidth()/2) - (start2.getWidth()/2), (getHeight()/2) + 50);
		add(start2);

		guide1 = new JLabel("Move : left(←) & right(→)");
		guide1.setForeground(Color.WHITE);
		guide1.setFont(font2);
		guide1.setSize(230, 25);
		guide1.setLocation((getWidth()/2) - (guide1.getWidth()/2), getHeight() - guide1.getHeight() - 40);
		add(guide1);
		
		guide2 = new JLabel("Attack : space bar");
		guide2.setForeground(Color.WHITE);
		guide2.setFont(font2);
		guide2.setSize(170, 25);
		guide2.setLocation((getWidth()/2) - (guide2.getWidth()/2), getHeight() - guide2.getHeight() - 10);
		add(guide2);
		
		// 게임 승리 시 승리 구문 라벨
		win = new JLabel("");
		win.setForeground(Color.RED);
		win.setFont(new Font("Dialog", Font.ITALIC, 90));
		win.setSize(470, 95);
		win.setLocation((getWidth()/2) - (win.getWidth()/2), (getHeight()/2) - win.getHeight() - 200);
		add(win);
		
		//es.02.02 패배 라벨 추가
		Lose = new JLabel("");
		Lose.setForeground(Color.BLUE);
		Lose.setFont(new Font("Dialog", Font.ITALIC, 90));
		Lose.setSize(470, 95);
		Lose.setLocation((getWidth()/2) - (Lose.getWidth()/2), (getHeight()/2) - Lose.getHeight() - 200);
		add(Lose);
		//es.02.02 종료 라벨 추가
		end = new JLabel("");
		end.setForeground(Color.WHITE);
		end.setFont(new Font("Dialog", Font.ITALIC, 30));
		end.setSize(480, 35);
		end.setLocation((getWidth()/2) - (end.getWidth()/2), getHeight() - end.getHeight() - 70);
		add(end);
		
		//최종 점수 라벨
		finalScore = new JLabel("");
		finalScore.setForeground(Color.YELLOW);
		finalScore.setFont(new Font("Arial", Font.PLAIN, 50));
		finalScore.setSize(330, 55);
		finalScore.setLocation((getWidth()/2) - (finalScore.getWidth()/2), (getHeight()/2) + 150);
		add(finalScore);
		
		//최종 스테이지 라벨
		finishStage = new JLabel("");
		finishStage.setForeground(Color.GREEN);
		finishStage.setFont(new Font("Arial", Font.PLAIN, 50));
		finishStage.setSize(300, 55);
		finishStage.setLocation((getWidth()/2) - (finishStage.getWidth()/2), (getHeight()/2) - (finishStage.getHeight()/2));
		add(finishStage);
		
		//각 유닛들 이미지 불러오기
		try {
			shotImage = ImageIO.read(new File("fireball.gif"));
			shipImage = ImageIO.read(new File("ship2.png"));
			alienImage = ImageIO.read(new File("sprite_rotmg_enemy0.png"));
			alienShotImage = ImageIO.read(new File("Attack.png"));
			boomImage = ImageIO.read(new File("boom.png"));
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		//포커스 지정(프레임)
		this.requestFocus();
		//내 유닛과 적 유닛 생성하여 저장소에 저장
//		this.initSprites();
		//키 이벤트 지정(프레임)
		addKeyListener(this);
		
		//배경음
		Sound bs = new Sound("wind.wav", true, 0);
//		bs.start();
	}
	//내 유닛과 적 유닛 저장 메소드
	private void initSprites() {
		//내 유닛 생성하여
		starship = new StarShip(this, shipImage, (getWidth()/2) - (shipImage.getWidth()/2), getHeight() - shipImage.getHeight());
		//저장소에 저장
		sprites.add(starship);		
		//적 유닛 객체를 5행 12열로 60마리 생성하여
		for(int y = 0; y < 5; y++) {
			for(int x = 0; x < 12; x++) {
				Common alien = new Alien(this, alienImage, 50 + (x * 50), 50 + (y * 30));
				//순서대로 저장소에 저장
				sprites.add(alien);
			}
		}
//		for(int y = 0; y < 4; y++) {
//			for(int x = 0; x < 6; x++) {
//				Common alien = new Alien(this, alienImage, getWidth() + 300 + (x * 50), 200 + (y * 30));
//				//순서대로 저장소에 저장
//				sprites.add(alien);
//			}
//		}
//		for(int y = 0; y < 4; y++) {
//			for(int x = 0; x < 6; x++) {
//				Common alien = new Alien(this, alienImage, -300 + (x * 50), 200 + (y * 30));
//				//순서대로 저장소에 저장
//				sprites.add(alien);
//			}
//		}
	}
	//게임 시작 : 저장소를 비우고 다시 채움
	private void startGame() {
		
		win.setText("");
		end.setText("");
		finalScore.setText("");
		finishStage.setText("");
		
		sprites.clear();
		initSprites();
		Thread start = new Thread(this);
		start.start();
	}
	//게임 패배 : 프로그램 종료
	public void endGame() {
		System.out.println("endGame");
		System.exit(0);
	}
	
	//es.02.02 게임 패배시 점수와 패배문구가 나오게 하는 메소드
	public void endGamemg() {
		endgamemg = true;
		Lose.setText("Game Lose");
		
		sprites.clear();
		
		finishStage.setText("Stage : " + stage);
		
		finalScore.setText("Score : " + score2);
		score1.setText("");
		end.setText("ENTER 키를 누르면 종료됩니다. ");
	}
	//es.02.04 게임 승리시 점수와 승리문구가 나오게 하는 메소드
	public void Winner() {
		winmg = true;
		win.setText("Game Win");
		
		finishStage.setText("Stage : " + stage);
		
		finalScore.setText("Score : " + score2);
		score1.setText("");
		
		end.setText("ENTER 키를 누르면 다음 스테이지");
	}
	
	//유닛 삭제 : 전달 받은 유닛을 저장소에서 삭제
	public void removeSprite(Common sprite) {
		if(sprite instanceof Alien) {
			score2 += 50;
			
			//폭발 이미지 객체 생성 및 리스트에 넣기
			Common boom = new Boom(this, boomImage, sprite.getX(), sprite.getY());
			sprites.add(boom);
		}
		sprites.remove(sprite);
	}
	//탄환 생성 : 탄환 생성 후 저장소에 저장
	public void fire() {
//		try {
//			Thread.sleep(30);
//		} catch(Exception e) {}
		Common shot = new Shot(this, shotImage, starship.getX() + (shipImage.getWidth()/2) - (shotImage.getWidth()/2), starship.getY() - 30);
		sprites.add(shot);
		
		//탄환 발사음
		Sound ss = new Sound("Laser_Shot.wav", true, 1);
		ss.start();
		
	}

	//적 탄환 생성 : 적의 탄환 생성 후 저장소에 저장
	public void Attack() {
		int dx = 0;
		int get = (int) (Math.random() * sprites.size());
		if(sprites.get(get) instanceof Alien) {
			Common enemy = (Common)sprites.get(get);
			if(starship.x > enemy.x)
				dx = (int) (starship.x / enemy.x);
			else if(starship.x < enemy.x)
				dx = (int) -(enemy.x / starship.x);
			if(dx > 3)
				dx = 3;
			Common Attack = new AlienShot(this, alienShotImage, enemy.getX() + (alienImage.getWidth()/2) - (alienShotImage.getWidth()/2), enemy.getY() + alienImage.getHeight(), dx);
			sprites.add(Attack);
		}
	}
	//그리기 오버라이딩
	@Override
	public void paint(Graphics g) {
		//부모 컨테이너(프레임) 그리고
		super.paint(g);
				
		//검은색 사각형 생성 (배경)
//		g.setColor(Color.black);
//		g.fillRect(0, 0, getWidth(), getHeight());
		
		//별 그리기
		background.draw(g);
		
		//저장소에 저장한 객체들을 모두 그리기 (제네릭 쓰면 형변환 안해도 됨)
		for(int i = 0; i < sprites.size(); i++) {
			Common sprite = (Common) sprites.get(i);
			sprite.draw(g);
		}
	}
	//게임 진행
	public void run() {
		
		stage++;
		
		//게임 실행중 여부 플래그에 따라 반복 진행/정지
		while(running) {
			
			int alienCount = 0;
			
			//배경 움직임
			background.move();
			
			//저장소에 저장한 객체 모두 움직임
			for(int i = 0; i < sprites.size(); i++) {
				Common sprite = (Common) sprites.get(i);
				sprite.move();
			}
			//저장소의 모든 객체가 부딪혓는지 비교
			//예) 0번과 그 이후 나머지 비교, 1번과 그 이후 나머지 비교, .... 
			for(int p = 0; p < sprites.size(); p++) {
				for(int s = p+1; s < sprites.size(); s++) {
					Common me = (Common) sprites.get(p);
					Common other = (Common) sprites.get(s);
					//두 객체가 부딪혔으면
					if(me.checkCollision(other)) {
						//각 객체에 정의된 handleCollision 메소드로
						//적과 부딪혔는지 확인하여 그에 맞는 동작을 실행
						me.handleCollision(other);
						other.handleCollision(me);
					}
				}
			}
			score1.setText("Score : " + score2);
			//변경된 정보로 다시 그림
			repaint();
			
			//게임 승리 검사
			for(int i = 0; i < sprites.size(); i++) {
				Common sprite = (Common) sprites.get(i);
				if(sprite instanceof Alien)
					alienCount++;
			}
			
			//es.02.04 게임 승리시 스레드 실행 중지 및 승리 문구 출력 
			if(alienCount == 0 && !endgamemg) {
				Winner();
				break;
			}
				//other 객체가(부딪힌 객체가) AlienSprite(적)이면
				//if(other instanceof StarShip)
			
			//게임 승리 시 동작
//			if(alienCount == 0) {
//				win.setText("Game Win");
//				finalScore.setText("Score : " + score2);
//				score1.setText("");
//			}
			
			// 0.01초 쉼
			try {Thread.sleep(10);} catch(Exception e) {}
			
			//es.02.02 게임 패배시 스레드 실행 중지(멈추기)
			if(endgamemg) {
				break;
			}
		}
	}
	//키 누름 이벤트
	@Override
	public void keyPressed(KeyEvent e) {
		//누른 키가 좌, 우 방향키이면 내 유닛 움직임
		if(e.getKeyCode() == KeyEvent.VK_LEFT && (stage != 0))
			starship.setDx(-3);
		if(e.getKeyCode() == KeyEvent.VK_RIGHT && (stage != 0))
			starship.setDx(3);
		//누른 키가 스페이스바이면 탄환 생성하여 발사
		if((e.getKeyCode() == KeyEvent.VK_SPACE) && (stage != 0))
			fire();
		
		if((e.getKeyCode() == KeyEvent.VK_SPACE) && (stage == 0)) {
			remove(start1);
			remove(start2);
			remove(guide1);
			remove(guide2);
			startGame();
		}
		
		//es.02.02 게임 패배시 엔터키를 누르면 종료
		if(e.getKeyCode() == KeyEvent.VK_ENTER && endgamemg) {
			endGame();
			}
		//es.02.04 게임 승리시 엔터키를 누르면 종료
		if(e.getKeyCode() == KeyEvent.VK_ENTER && winmg) {
//			endGame();

			startGame();
		}
//		if(e.getKeyCode() == KeyEvent.VK_ENTER && ) {
//			endGame();
//		}
		
	}
	//키 뗌 이벤트
	@Override
	public void keyReleased(KeyEvent e) {
		//좌우 방향키를 뗏으면 내 유닛 멈춤
		if(e.getKeyCode() == KeyEvent.VK_LEFT  && (stage != 0))
			starship.setDx(0);
		if(e.getKeyCode() == KeyEvent.VK_RIGHT  && (stage != 0))
			starship.setDx(0);
	}
	@Override
	public void keyTyped(KeyEvent arg0) {}
	
	//프로그램 실행
	public static void main(String[] args) {
		//이벤트 분배 스레드로 GUI와 각 객체 셋팅하고
		GalagonGame g = new GalagonGame();
		//메인 스레드로 게임 진행
//		g.gameLoop();
	}
}
