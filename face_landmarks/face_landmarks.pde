JSONArray file;
JSONObject data;
String name = "face-";
int frameN = 0;
PGraphics alpha;
boolean ciclo = true;

void setup() {
  size(1920, 1080);
  alpha = createGraphics(width,height, JAVA2D);
  //fill(255);
  //stroke(255);
  background(0);
  file = loadJSONArray("Face-Landmarks.JSON");
}

void draw() {
  //background(3, 255, 50);
  if (ciclo) {
    for(int i = 0 ; i < file.size(); i++){
      data = file.getJSONObject(i);
      alpha = createGraphics(width,height, JAVA2D);
      alpha.beginDraw();
      if(data != null){
        JSONArray landmarks = data.getJSONArray("points");
        if (landmarks != null){
          for (int k = 0; k < landmarks.size(); k++) {
            // Body parts are relative to width and weight of the input
            JSONArray point = landmarks.getJSONArray(k);
            float x = point.getFloat(0);
            float y = point.getFloat(1);
            alpha.noStroke();
            alpha.fill(232, 16, 207);
            alpha.ellipse(x * width, y * height, 10, 10);
          }
        }
      }
      alpha.endDraw();
      String filename = name + str(frameN) + ".png";
      alpha.save(filename);
      alpha.clear();
      frameN++;
    }
    ciclo = false;
    println("Fatto!");
  }
}
