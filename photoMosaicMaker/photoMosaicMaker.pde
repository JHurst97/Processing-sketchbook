void setup(){
  size(700,700);
  red = loadImage("red.jpg");
  green = loadImage("green.jpg");
  blue = loadImage("blue.jpg");
  rgb = loadImage("rgb.jpg");



  PImage currImg = rgb;
  //loop through cover image squares.
  for(int y = 0; y < currImg.height; y+=spacing){
    for(int x = 0; x < currImg.width; x+=spacing){
      //get average from area.
      int[] rgbArr = getAverageFromArea(currImg, x, y, x+spacing, y+spacing);
      //find dominant value.
      int dom = max(rgbArr[0], rgbArr[1], rgbArr[2]);
      if(rgbArr[0] > rgbArr[1] && rgbArr[0] > rgbArr[2]){
        image(red, x, y, spacing, spacing);
      } else if(rgbArr[1] > rgbArr[0] && rgbArr[1] > rgbArr[2]){
        image(green, x, y, spacing, spacing);
      } else if(rgbArr[2] > rgbArr[0] && rgbArr[2] > rgbArr[1]){
        image(blue, x, y, spacing, spacing);
      }
    }
  }
}

PImage red, green, blue, rgb ;
int spacing = 2;

void draw(){



}

int[] getAverageFromArea(PImage image_, int x1, int y1, int x2, int y2){
  PImage img = image_.get(x1, y1, x2, y2);
  int[]rgbArr = getAverageFromImg(img);
  println("red: "+rgbArr[0]+", green:"+rgbArr[1]+", blue:"+rgbArr[2]);
  return rgbArr;
}

int[] getAverageFromImg(PImage img_){
  int r= 0;
  int g= 0;
  int b= 0;
  int pixelCount = 0;
  PImage currImg = img_;
  //loop through image
  for(int x = 0; x < currImg.width; x+=1){
    for(int y = 0; y < currImg.width; y+=1){
      r += red(currImg.get(x,y));
      g += green(currImg.get(x,y));
      b += blue(currImg.get(x,y));
      pixelCount++;
    }
  }
  //calculate average from rgb totals
  r /= pixelCount;
  g /= pixelCount;
  b /= pixelCount;
  int[]rgbArr = {r,g,b};
  //println("red: "+r+", green:"+g+", blue:"+b);
  return rgbArr;
}

/*  1 loop through squares of rgb image, determine average colour of square.
*   2 find image with similar average colour.
*       to find averge colour -> add up r,g,b values and divide by pixels processed.
*   3 find dominant colour in area of cover image (10x10), use max(int1, int2, int3).
*
*/
