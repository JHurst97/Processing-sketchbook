void setup(){
  background(51);
  size(700,700);
  colorMode(HSB, 360);
  stroke(0);
  imageMode(CORNERS);


  allImgs = new PImage[8];

  // we'll have a look in the data folder
java.io.File folder = new java.io.File(dataPath(sketchPath() + "\\images"));

// list the files in the data folder
String[] filenames = folder.list();

// get and display the number of jpg files
println(filenames.length + " jpg files in specified directory");

// display the filenames
for (int i = 0; i < filenames.length; i++) {
  println(filenames[i]);
  String path = filenames[i];
  allImgs[i] = loadImage(sketchPath("images/" + filenames[i]));
}


  PImage currImg = allImgs[1];
  //track brightness for each image.
  hues = new int[allImgs.length];
  newImgs = new PImage[currImg.width][currImg.height];



  for(int i = 0; i < allImgs.length; i++){
    int avg = 0;
    allImgs[i].loadPixels();
    for(int j = 0; j < allImgs[i].pixels.length; j++){
      float h = hue(allImgs[i].pixels[j]);
      avg += h;
    }
  avg /= allImgs[i].pixels.length;
  hues[i] = avg;
  println(avg);
  }
  hues = sort(hues);

  go(currImg);
}

PImage red, green, blue, white, black, rgb, landscape, elton;
int scl = 5;
int[] hues;
PImage[] allImgs;
PImage[][] newImgs;

void draw(){

}

PImage findClosest(int hue_){
  //find closest brightness

  int bri = hue_;
  PImage best = new PImage();
    for (int j = 0; j < hues.length; j++) {
      float record = 256;
      if(bri > hues[j]){
        float diff = bri - hues[j];
        if(diff < record){
          record = diff;
          best = allImgs[j];
        }
      }
      else if(bri < hues[j]){
        float diff =  hues[j] - bri;
        if(diff < record){
          record = diff;
          best = allImgs[j];
        }
      }



    }
  return best;
}

void go(PImage currImg){
  //loop through cover image squares.
  for(int y = 0; y < currImg.height; y+=scl){
    for(int x = 0; x < currImg.width; x+=scl){
      //get average from area.
      PImage img = currImg.get(x, y, x+scl, y+scl);
      int hue = getAverageFromImg(img);
      //println(brightness);
      int imageIndex = (int) map(hue, 0, 255, 0, hues.length);


      PImage cellImage = allImgs[imageIndex];
      image(cellImage, x*scl, y*scl);
    }
  }
  //build new image.
  for(int y = 0; y < currImg.height; y+=scl){
    for(int x = 0; x < currImg.width; x+=scl){
      //rect(x*scl, y*scl, (x*scl)+scl, (y*scl)+scl);
      image(newImgs[x][y], x, y, x+scl, y+scl);
    }
  }
}

//x + y * width

int getAverageFromImg(PImage img_){
  int b= 0;
  PImage currImg = img_;
  currImg.loadPixels();
  //loop through image
  for (int x =0; x < img_.width; x++) {
    for (int y = 0; y < img_.height; y++) {
      int index = x + y * img_.width;
      b += hue(currImg.pixels[index]);
    }
  }
  //calculate average from rgb totals
  b /= currImg.pixels.length;
  //println("red: "+r+", green:"+g+", blue:"+b);
  return b;
}

/*  1 loop through squares of rgb image, determine average colour of square.
*   2 find image with similar average colour.
*       to find averge colour -> add up r,g,b values and divide by pixels processed.
*   3 find dominant colour in area of cover image (10x10), use max(int1, int2, int3).
*
*/
