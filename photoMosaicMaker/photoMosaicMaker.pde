void setup(){
  size(700,700);
   blue = loadImage("blue.jpg");
   landscape = loadImage("landscape.jpg");
  green = loadImage("green.jpg");
}
PImage green, blue, landscape;
void draw(){

  int r= 0;
  int g= 0;
  int b= 0;
  int pixelCount = 0;

  for(int x = 0; x < green.width; x+=1){
    for(int y = 0; y < green.width; y+=1){
      r += red(blue.get(x,y));
      g += green(blue.get(x,y));
      b += blue(blue.get(x,y));
      pixelCount++;
    }
  }
  r /= pixelCount;
  g /= pixelCount;
  b /= pixelCount;
  println("red: "+r+", green:"+g+", blue:"+b);
  image(blue,0,0);
}

/*  1 loop through squares of landscape image, determine average colour of square.
*   2 find image with similar average colour.
*       to find averge colour -> add up r,g,b values and divide by pixels processed.
*
*/
