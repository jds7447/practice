package version_08_20220128;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Point;
import java.util.Vector;

//배경 별 클래스
public class Background {
	final int STAR_SIZE = 4;
	final int STAR = 80;
	GalagonGame game;
	Vector<Point> starVector = new Vector<Point>();
	Vector<Point> starVector2 = new Vector<Point>();
//	ArrayList<Color> colors = new ArrayList<Color>();
	
	public Background(GalagonGame game) {
		this.game = game;
	}
	//별 좌표 및 크기 생성
	void addStar() {
		for(int i = 0; i < STAR; i++) {
			Point p = new Point((int)(Math.random()*game.getWidth()), (int)(Math.random()*game.getHeight()));
			starVector.add(p);
			int size = (int) (Math.random() * STAR_SIZE) + 1;
			Point p2 = new Point(size, size);
			starVector2.add(p2);
//			int select = (int)(Math.random() * 5) + 1;
//			switch(select) {
//			case 1: colors.add(Color.WHITE); break;
//			case 2: colors.add(Color.BLUE); break;
//			case 3: colors.add(Color.RED); break;
//			case 4: colors.add(Color.YELLOW); break;
//			case 5: colors.add(Color.GREEN); break;
//			}
		}
	}
	//별 그리기
	public void draw(Graphics g) {
		for(int i = 0; i < starVector.size(); i++) {
			Point p = starVector.get(i);
			Point p2 = starVector2.get(i);
			if(p.x%2 == 0)g.setColor(Color.WHITE);
			else if(p.x%3 == 0) g.setColor(Color.BLUE);
			else if(p.x%5 == 0) g.setColor(Color.RED);
			else if(p.x%7 == 0) g.setColor(Color.YELLOW);
			else g.setColor(Color.GREEN);
			if(p.x%2 == 0 && p.y > 50 && p.y < 100) g.setColor(Color.BLACK);
//			if(p.x%3 == 0 && p.y > 150 && p.y < 200) g.setColor(Color.BLACK);
			if(p.x%3 == 0 && p.y > 250 && p.y < 300) g.setColor(Color.BLACK);
//			if(p.x%7 == 0 && p.y > 350 && p.y < 400) g.setColor(Color.BLACK);
			if(p.x%5 == 0 && p.y > 450 && p.y < 500) g.setColor(Color.BLACK);
//			if(p.x%3 == 0 && p.y > 550 && p.y < 600) g.setColor(Color.BLACK);
			if(p.x%7 == 0 && p.y > 650 && p.y < 700) g.setColor(Color.BLACK);
//			if(p.x%7 == 0 && p.y > 750 && p.y < 800) g.setColor(Color.BLACK);
//			g.setColor(colors.get(i));
			g.fillOval(p.x, p.y, p2.x, p2.y);
		}
	}
	//별 움직임
	public void move() {
		//offsetY는 별이 y축으로 움직일 값 생성
		int offsetY = 2;
		for(int i = 0; i < STAR; i++) {
			//starVector의 i번째 포인트 좌표를 빼와서 저장하고
			Point p = starVector.get(i);
			//i번째 별의 y좌표에 offsetY값 만큼 추가
			p.y += offsetY;
			//y좌표가 화면 높이보다 크면 (화면 아래로 나가면)
			if(p.y > game.getHeight()) {
				//x좌표를 화면 가로 크기중 랜덤한 위치로 설정
				p.x = (int)(Math.random()*game.getWidth());
				//y좌표를 5로 설정
				p.y = 5;
			}
		}
		
	}
}
