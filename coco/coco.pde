// this sketch renders the bounding box of COCO to png with alpha

JSONArray file;
JSONObject data;
String name = "coco-";
int frameN = 0;
PGraphics alpha;
boolean ciclo = true;

void setup() {
  size(1920, 1080);
  alpha = createGraphics(width,height, JAVA2D);
  //fill(255);
  //stroke(255);
  background(0);
  file = loadJSONArray("coco.JSON");
}

void draw() {
  if (ciclo){
    for(int i = 0 ; i < file.size(); i++){
      data = file.getJSONObject(i);
      drawCaptions();    
    }
    ciclo = false;
    // when done print a message
    println("Fatto!");
  }
}

// A function to display the captions
void drawCaptions() {
  // if no data is loaded yet, exit
  if(data == null){
    return;
  }
  println(data);
  // access boxes and labels JSON arrays within the result
  JSONArray boxes = data.getJSONArray("boxes");
  JSONArray labels = data.getJSONArray("labels");
  // as long the array sizes match
  alpha = createGraphics(width,height, JAVA2D);
  alpha.beginDraw();
  if(boxes.size() == labels.size()){
    // for each array element
    for(int i = 0 ; i < boxes.size(); i++){
      //background(3, 255, 50);
      String label = labels.getString(i);
      JSONArray box = boxes.getJSONArray(i);
      // extract values from the float array
      float x = box.getFloat(0) * width;
      float y = box.getFloat(1) * height;
      float w = (box.getFloat(2) * width) - x;
      float h = (box.getFloat(3) * height) - y;
      // display bounding boxes
      //alpha.noFill();
      // bounding box color and stroke weight
      alpha.stroke(16, 75, 232);
      // regola l'alpha del fill del rettangolo cambiando il quarto valore
      alpha.fill(255, 224, 67, 40);
      alpha.strokeWeight(5);
      alpha.rect(x,y,w,h);
      // text color and text size
      alpha.fill(16, 75, 232);
      alpha.textSize(20);
      alpha.text(label,x,y-10);
    }
  }
  alpha.endDraw();
  String filename = name + str(frameN) + ".png";
  alpha.save(filename);
  alpha.clear();
  frameN++;
}
