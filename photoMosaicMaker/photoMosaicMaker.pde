void setup(){
  size(700,700);
   blue = loadImage("blue.jpg");
   landscape = loadImage("landscape.jpg");
  green = loadImage("green.jpg");
}
PImage green, blue, landscape;
void draw(){
  for(int i = 0; i < 10; i++){
    image(landscape, i, i);
  }
}

/*  1 loop through squares of landscape image, determine average colour of square.
*   2 find image with similar average colour.
*
*
*/
