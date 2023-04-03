import de.voidplus.leapmotion.*;
import java.util.*;

LeapMotion leap;

LineDrawer drawer = new LineDrawer();

boolean firstUpdateLoop = true;
float prevXPos = 0;
float prevYPos = 0;


void setup() {
  size(800, 500);
  background(200);
  
  leap = new LeapMotion(this);
  loadPrevious();
  drawer.drawLines();
}

void draw() {
  updateDrawing();
  drawer.drawLines();
}

void updateDrawing() {
  for (Hand h : leap.getHands()) {
    //left hand for color
    if (h.isLeft()) {
      Finger f = h.getFrontFinger();
      println(f.getType());
      switch (f.getType()) {
        case 0:
          fill(255, 0, 0);
          break;
        case 1:
          fill(0, 255, 0);
          break;
        case 2:
          println("have some manners");
          fill(200, 0); 
          break;
        case 4:
          saveStrings("data.txt", new String[] {});
          fill(255);
          background(200);
          break;
      }
    }
    //right hand for drawing
    if (h.isRight()) {      
      Finger f = h.getFrontFinger();
      
      float xPos;
      //float zPos = f.getStabilizedPosition().z;
      float yPos;
      
      float intendedXPos = f.getStabilizedPosition().x;
      float intendedYPos = f.getStabilizedPosition().y;
      
      if (firstUpdateLoop) {
        xPos = intendedXPos;
        yPos = intendedYPos;
        prevXPos = xPos;
        prevYPos = yPos;
        firstUpdateLoop = false;
      }
      else {
         //xPos = abs(intendedXPos - prevXPos) < 20 ? intendedXPos : prevXPos + (intendedXPos / abs(intendedXPos)) * 20;
         //yPos = abs(intendedYPos - prevYPos) < 20 ? intendedYPos : prevXPos + (intendedYPos / abs(intendedYPos)) * 20;
         xPos = intendedXPos;
         yPos = intendedYPos;
      }
      
      drawWithCircles(xPos, yPos, 1);
      
      prevXPos = xPos;
      prevYPos = yPos;
    }
  }
}

void loadPrevious() {
   String[] data = loadStrings("data.txt");
   
   if (!(data.length > 0)) return;
   
   for (int i = 0; i < data.length - 3; i+=4) {
      fill(parseInt(data[i+3]));
      noStroke();
      //ellipse(parseInt(data[i]), parseInt(data[i+1]), parseInt(data[i+2]), parseInt(data[i+2]));
      ellipse(parseFloat(data[i]), parseFloat(data[i+1]), 1, 1);
   }
}

void drawWithCircles(float xPos, float yPos, float size) {
  noStroke();
  ellipse(xPos, yPos, size, size);
  ArrayList<String> prevData = new ArrayList<String>(Arrays.asList(loadStrings("data.txt")));
  prevData.add(""+xPos);
  prevData.add(""+yPos);
  prevData.add(""+size);
  prevData.add(""+g.fillColor);
  String[] data = new String[prevData.size()];
  data = prevData.toArray(data);
  saveStrings("data.txt", data);
}
