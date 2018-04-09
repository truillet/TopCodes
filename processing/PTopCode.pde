/*
 *
 *
 *
 */
 
import processing.video.*;
import topcodes.*; // librairie TopCode
import java.awt.image.BufferedImage;
import java.util.List;

/* objets utilisés */
Capture c;
PImage img;
BufferedImage b;

/** TopCode scanner */
protected Scanner scanner;
List<topcodes.TopCode> codes; 

void setup() {
  size(640,480);
  //fullScreen();
  scanner = new Scanner();
  codes = null;
  c = new Capture(this,640,480);
  c.start();
  
}

void draw() {
  try {
    img=c.copy(); // extract image from camera
    image(img,0,0);

    b = (BufferedImage) img.getImage();
    codes = scanner.scan(b);
  }
  catch (Exception e) {}
  
  if (codes != null) {
    for (topcodes.TopCode top : codes) {
      // Draw the topcode in place
      String code = String.valueOf(top.getCode());
      fill(255);
      ellipse(top.getCenterX(),top.getCenterY(),top.getDiameter(),top.getDiameter()); 
      fill(0);
      text(code,top.getCenterX(),top.getCenterY());
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}


/* == PImage <-> BufferedImage == */
public PImage getAsImage(BufferedImage bimg) {
  try { 
    PImage img=new PImage(bimg.getWidth(),bimg.getHeight(),PConstants.ARGB);
    bimg.getRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);
    img.updatePixels();
    return img;
  }
  catch(Exception e) {
    System.err.println("Can't create image from buffer");
    e.printStackTrace();
  }
  return null;
}