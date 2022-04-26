package version_08_20220128;

import java.awt.Image;

//적 탄환 클래스
public class AlienShot extends Common {
	private GalagonGame game;
	//생성자 : 게임판, 이미지 파일명, 이미지 x, y 좌표 받아서 멤버 초기화
	public AlienShot(GalagonGame game, Image image, int x, int y, int dx) {
		//이미지 파일명, 이미지 x, y 좌표는 부모 클래스 생성자에서 초기화
		super(image, x, y);
		this.game = game;
		//x, y축 이동량 초기화
		this.dx = dx;
		dy = 3 * game.stage;
	}
	//적 탄환 이미지 움직임 오버라이딩
	@Override
	public void move() {
		//부모 클래스의 move 실행
		super.move();
		if(y > game.getWidth() + 100)
			//해당 탄환 제거
			game.removeSprite(this);
	}
	//우주선과 부딪힘 오버라이딩
	@Override
	public void handleCollision(Common other) {
		//other 객체가(부딪힌 객체가) AlienSprite(적)이면
		if(other instanceof StarShip) {
			//나와 적 모두 제거
			game.endGame();
		}
	}
}
