package version_07_20220204_es;

import java.awt.Image;

//내 유닛 클래스
public class StarShip extends Common {
	private GalagonGame game;
	//생성자 : 게임판, 이미지 파일명, 이미지 x, y 좌표 받아서 멤버 초기화
	public StarShip(GalagonGame game, Image image, int x, int y) {
		//이미지 파일명, 이미지 x, y 좌표는 부모 클래스 생성자에서 초기화
		super(image, x, y);
		this.game = game;
		//x, y축 이동량 0으로 초기화
		dx = 0;
		dy = 0;
	}
	//내 유닛 움직임 오버라이딩
	@Override
	public void move() {
		//x축 이동량이 0보다 작고 좌표가 10보다 작으면 움직임 종료 
		if((dx < 0) && (x < 10))
			return;
		//x축 이동량이 0보다 크고 좌표가 800보다 크면 움직임 종료
		if((dx > 0) && ((x + getWidth()) > game.getWidth()))
			return;
		//부모 클래스 move 실행
		super.move();
	}
	//적고 부딪힘 오버라이딩
	@Override
	public void handleCollision(Common other) {
		//other 객체가(부딪힌 객체가) AlienSprite(적)이면
		if(other instanceof Alien)
			//ES 1.28 게임 종료 메세지 출력
			game.endGamemg();
	}
}
