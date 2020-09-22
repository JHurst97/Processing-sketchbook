void setup(){
  background(51);
  size(700,700);
  colorMode(HSB, 360);
  stroke(0);
  imageMode(CORNERS);


  allImgs = new PImage[23];

  // we'll have a look in the data folder
  java.io.File folder = new java.io.File(dataPath(sketchPath() + "\\images"));
  // list the files in the data folder
  String[] filenames = folder.list();

  //set cover image and cell spacings.
  PImage coverImg = loadImage("elton.jpg");
  rows = 80;
  cols = 80;
  cellWidth = width / cols;
  cellHeight = height / rows;

  // put images in array
  for (int i = 0; i < filenames.length; i++) {
    println(filenames[i]);
    String path = filenames[i];
    allImgs[i] = loadImage(sketchPath("images/" + filenames[i]));
    allImgs[i].resize(cellWidth, cellHeight);
  }

  println("CW: " + cellWidth + " CH: " + cellHeight);

  //work out brightness for each image.
  brights = new int[allImgs.length];
  for(int i = 0; i < allImgs.length; i++){
    int avg = 0;
    allImgs[i].loadPixels();
    for(int j = 0; j < allImgs[i].pixels.length; j++){
      float h = brightness(allImgs[i].pixels[j]);
      avg += h;
    }
  avg /= allImgs[i].pixels.length;
  brights[i] = avg;
  }
  brights = sort(brights);

  for(int i = 0; i < brights.length; i++){
    println(brights[i]);
  }

  go(coverImg);
}

int scl = 5;
int[] brights;
PImage[] allImgs;
int cellWidth, cellHeight, rows, cols;

void go(PImage coverImg){
  //loop through cover image squares.
  for(int y = 0; y < rows; y++){
    for(int x = 0; x < cols; x++){
      //get average from area.
      PImage img = coverImg.get(x, y, x+cellWidth, y+cellHeight);
      int brightness = getAverageFromImg(img);
      //println(brightness);
      int imageIndex = (int) map(brightness, 0, 255, 0, brights.length);

      println(imageIndex);
      PImage cellImage = allImgs[imageIndex];
      image(cellImage, x*cellWidth, y*cellHeight);
    }
  }
}

//x + y * width

public int getAverageFromImg(PImage img_){
  int b= 0;
  PImage coverImg = img_;
  coverImg.loadPixels();
  //loop through image
  for (int x =0; x < img_.width; x++) {
    for (int y = 0; y < img_.height; y++) {
      int index = x + y * img_.width;
      b += hue(coverImg.pixels[index]);
    }
  }
  //calculate average from rgb totals
  b /= coverImg.pixels.length;
  //println("red: "+r+", green:"+g+", blue:"+b);
  return b;
}

/*  1 loop through squares of rgb image, determine average colour of square.
*   2 find image with similar average colour.
*       to find averge colour -> add up r,g,b values and divide by pixels processed.
*   3 find dominant colour in area of cover image (10x10), use max(int1, int2, int3).
*
*/
