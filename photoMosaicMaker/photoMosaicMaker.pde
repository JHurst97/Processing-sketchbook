void setup(){
  background(51);
  size(700,700);
  colorMode(HSB, 360);
  stroke(0);
  imageMode(CORNERS);


  allImgs = new PImage[howManyImgs];

  // we'll have a look in the data folder
  java.io.File folder = new java.io.File(dataPath(sketchPath() + "\\images"));
  // list the files in the data folder
  String[] filenames = folder.list();

  //set cover image and cell spacings.
  PImage coverImg = loadImage("elton.jpg");
  coverImg.resize(200,200);
  cellWidth = coverImg.width / numCellsPerSide;
  cellHeight = coverImg.height / numCellsPerSide;

  // put images in array
  for (int i = 0; i < howManyImgs; i++) {
    println(filenames[i]);
    String path = filenames[i];
    allImgs[i] = loadImage(sketchPath("images/" + filenames[i]));
    allImgs[i].resize(cellWidth * outputScale, cellHeight * outputScale);
  }

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

  go(coverImg);
}

int[] brights;
PImage[] allImgs;
int cellWidth, cellHeight;
int numCellsPerSide = 200;
int outputScale = 2;
int howManyImgs = 25;

void go(PImage coverImg){
  //translate(-5, -5);
  //loop through cover image squares.

  PImage workingImage = createImage(cellWidth, cellHeight, RGB);

  for(int y = 0; y < numCellsPerSide; y++){
    for(int x = 0; x < numCellsPerSide; x++){
      workingImage.copy(coverImg, x*cellWidth, y*cellHeight, cellWidth, cellHeight, 0, 0, cellWidth, cellHeight);
      //get average from area.
      float brightness = getAverageFromImg(workingImage);
      //println(brightness);
      int imageIndex = floor(map(brightness, 0, 255, 0, brights.length - 10));
      println(brightness);
      PImage cellImage = allImgs[imageIndex];
      image(cellImage, x*cellWidth*outputScale, y*cellHeight*outputScale);
    }
  }
  image(workingImage, 0, 0);
}

//x + y * width

float getAverageFromImg(PImage img_){
  float b = 0;
  PImage currImg = img_;
  currImg.loadPixels();
  //loop through image
  for (int i = 0; i < img_.pixels.length; i++) {
    b += brightness(img_.pixels[i]);
  }
  //calculate average from rgb totals
  b /= img_.pixels.length;
  //println("red: "+r+", green:"+g+", blue:"+b);
  return b;
}


/*  1 loop through squares of rgb image, determine average colour of square.
*   2 find image with similar average colour.
*       to find averge colour -> add up r,g,b values and divide by pixels processed.
*   3 find dominant colour in area of cover image (10x10), use max(int1, int2, int3).
*
*/
