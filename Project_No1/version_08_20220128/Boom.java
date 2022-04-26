package version_08_20220128;

import java.awt.Image;

public class Boom extends Common {
	private GalagonGame game;
	private int count;
	
	public Boom(GalagonGame game, Image image, int x, int y) {
		super(image, x, y);
		this.game = game;
	}
	
	public void move() {
		count++;
		
		//카운트 10 되면 이 객체 제거되며 이미지 사라짐
		if(count == 10)
			game.removeSprite(this);
	}
}

