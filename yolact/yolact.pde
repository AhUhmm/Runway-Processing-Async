import com.runwayml.*;

JSONArray file;
JSONObject data;
String name = "yolact-";
int frameN = 0;
PImage runwayResult; 
boolean ciclo = true;

void setup() {
  size(1920, 1080);
  background(0);
  // JSON data filename have to be placed in sketch folder
  file = loadJSONArray("yolact.JSON");
}

void draw() {
  
  if (ciclo) {
    
    for(int i = 0 ; i < file.size(); i++){
      
      data = file.getJSONObject(i);
      runwayDataEvent(data);
      runwayResult.resize(1920, 1080);
      image(runwayResult, 0, 0);
      String filename = name + str(frameN) + ".png";
      save(filename);
      frameN++;
    }
    ciclo = false;
    // print message when done
    println("Fatto!");
  }
}

void runwayDataEvent(JSONObject runwayData){
  // point the sketch data to the Runway incoming data 
  String base64ImageString = runwayData.getString("output_image");
  // try to decode the image from
  try{
    runwayResult = ModelUtils.fromBase64(base64ImageString);
  }catch(Exception e){
    e.printStackTrace();
  }
}
