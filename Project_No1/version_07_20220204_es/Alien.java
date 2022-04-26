package version_07_20220204_es;

import java.awt.Image;

//적 클래스
public class Alien extends Common {
	private GalagonGame game;
	
	private int count = 0;
	
	//생성자 : 게임판, 이미지 파일명, 이미지 x, y 좌표 받아서 멤버 초기화
	public Alien(GalagonGame game, Image image, int x, int y) {
		//이미지 파일명, 이미지 x, y 좌표는 부모 클래스 생성자에서 초기화
		super(image, x, y);
		this.game = game;
		//y축 이동량 -3으로 초기화
		dx = 1;
		dy = 3;
	}
	//적 움직임 오버라이딩
	@Override
	public void move() {
		if(count > 100) {
			dx = -dx;
			count = 0;
		}
		if(y > 350 || y < 0) {
			dy = -dy;
		}
		
		int attack = (int)(Math.random() * 4000)+1;
		if(attack == 7)
			game.Attack();
		
		//x축 이동량이 0보다 작고 x축 위치가 10보다 작거나
		//x축 이동량이 0보다 크고 x축 위치가 800보다 크면
		if(((dx < 0) && (x < 10)) || ((dx > 0) && (x > 800))) {
			//x축 이동 방향 반대로
			dx = -dx;
			//y축 10만큼 이동
//			y += 10;
			//y축 위치가 600보다 크면 게임 종료
			if(y > game.getHeight())
				game.endGame();
		}
		//부모 클래스 move 실행
		super.move();
		
		count++;
	}
}
