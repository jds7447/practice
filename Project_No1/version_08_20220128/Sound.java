package version_08_20220128;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;

import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;

public class Sound extends Thread {

    boolean isloop;//반복여부 정하기
    public String name;//음악파일이름(확장자까지) 넣기
//    Player player;
    FileInputStream fis;
    BufferedInputStream bis;
    
    File file;
    Clip clip;
    AudioInputStream ais;
    int loopCount;

    //생성자 부분
    public Sound(String filename, boolean isloop, int loopCount) {
        try {
            this.isloop = isloop;
            name = filename;
            //프로그램내의 src아래 Musicfile패키지를 생성하고 그곳에 음악파일을 넣었을때의 경로
            // C:/ ~ src/패키지이름/음악파일이름.mp3 까지 해도 상관없음
//            fis = new FileInputStream("src/Musicfile/" + name);
//            bis = new BufferedInputStream(fis);
//            player = new Player(bis);

            if(loopCount == 0)
            	this.loopCount = Clip.LOOP_CONTINUOUSLY;
            else if(loopCount != 0)
            	this.loopCount = loopCount - 1;
            file = new File(name);
            ais = AudioSystem.getAudioInputStream(file);
            clip = AudioSystem.getClip();
            clip.open(ais);
            clip.loop(this.loopCount);
            clip.start();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    
    //재생음악 변경
//    public void change(String filename, boolean isloop) {
//        player.close();
//        this.interrupt();
//        name = filename;
//        this.isloop = isloop;
//    }

    //음악종료
    
    public void close() {
        isloop = false;
//        player.close();
        clip.close();
        this.interrupt();
    }

    @Override
    public void run() {
    	while(isloop) {
    		clip.start();
    		try {sleep(100);} catch(Exception e) {}
    	}
//        try {
//            do {
//                fis = new FileInputStream("src/Musicfile/" + name);
//                bis = new BufferedInputStream(fis);
//                player = new Player(bis);
//                player.play();
//            } while (isloop);
//        } catch (Exception e) {
//        }
    }
}


