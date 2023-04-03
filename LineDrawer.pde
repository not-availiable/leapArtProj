public class LineDrawer {
   public LineDrawer() {
   }
   
   public void drawLines() {
     String[] data = loadStrings("data.txt");
   
     if (!(data.length > 4)) return;
     println(data.length);
     for (int i = 0; i < data.length - 8; i+=4) {
        stroke(parseInt(data[i+3]));
        line(parseFloat(data[i]), parseFloat(data[i+1]), parseFloat(data[i+4]), parseFloat(data[i+5]));
     }
   }
}
