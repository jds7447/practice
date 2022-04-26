package version_10_20220205;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;

import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;

//게임의 소리 출력 스레드 클래스
public class Sound {
	//필드
    FileInputStream fis;
    BufferedInputStream bis;
    File file;
    Clip clip;
    AudioInputStream ais;
    int loopCount;

    //생성자
    public Sound(String filename, int loopCount) {
        try {
            if(loopCount == 0) {
            	this.loopCount = Clip.LOOP_CONTINUOUSLY;
            }
            else if(loopCount != 0) {
            	this.loopCount = loopCount - 1;
            }
            file = new File(filename);
            ais = AudioSystem.getAudioInputStream(file);
            clip = AudioSystem.getClip();
            clip.open(ais);
            clip.loop(this.loopCount);
            clip.start();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            clip.close();
        }
    }
    
    //음악종료
    public void close() {
        clip.stop();
        clip.close();
    }
}


