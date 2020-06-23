class FlowField {

  PVector[][] cells;
  PVector[][]offsets;
  int spacing;

  FlowField(int spc) {
    spacing = spc;
    rows = height/spacing;
    cols = width/spacing;
    cells = new PVector[cols][rows];
    offsets = new PVector[cols][rows];
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        cells[i][j] = new PVector(0, 0, 0);
      }
    }
  }

  void show() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        pushMatrix();
        translate(i*spacing, j*spacing);
        float x = spacing*cos(cells[i][j].z);
        float y = spacing*sin(cells[i][j].z);
        line(x, y, 0, 0);
        popMatrix();
      }
    }
  }

  float lookup(PVector lookup_) {
    int column = int(constrain(lookup_.x/spacing, 0, cols-1));
    int row = int(constrain(lookup_.y/spacing, 0, rows-1));
    return cells[column][row].z;
  }
}
