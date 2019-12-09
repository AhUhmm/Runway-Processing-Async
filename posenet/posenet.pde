import com.runwayml.*;

JSONArray file;
JSONObject data;
// Png sequence filename
String name = "posenet-";
int frameN = 0;
PGraphics alpha;
boolean ciclo = true;

int[][] connections = {
  {ModelUtils.POSE_NOSE_INDEX, ModelUtils.POSE_LEFT_EYE_INDEX},
  {ModelUtils.POSE_LEFT_EYE_INDEX, ModelUtils.POSE_LEFT_EAR_INDEX},
  {ModelUtils.POSE_NOSE_INDEX,ModelUtils.POSE_RIGHT_EYE_INDEX},
  {ModelUtils.POSE_RIGHT_EYE_INDEX,ModelUtils.POSE_RIGHT_EAR_INDEX},
  {ModelUtils.POSE_RIGHT_SHOULDER_INDEX,ModelUtils.POSE_RIGHT_ELBOW_INDEX},
  {ModelUtils.POSE_RIGHT_ELBOW_INDEX,ModelUtils.POSE_RIGHT_WRIST_INDEX},
  {ModelUtils.POSE_LEFT_SHOULDER_INDEX,ModelUtils.POSE_LEFT_ELBOW_INDEX},
  {ModelUtils.POSE_LEFT_ELBOW_INDEX,ModelUtils.POSE_LEFT_WRIST_INDEX}, 
  {ModelUtils.POSE_RIGHT_HIP_INDEX,ModelUtils.POSE_RIGHT_KNEE_INDEX},
  {ModelUtils.POSE_RIGHT_KNEE_INDEX,ModelUtils.POSE_RIGHT_ANKLE_INDEX},
  {ModelUtils.POSE_LEFT_HIP_INDEX,ModelUtils.POSE_LEFT_KNEE_INDEX},
  {ModelUtils.POSE_LEFT_KNEE_INDEX,ModelUtils.POSE_LEFT_ANKLE_INDEX}
};

void setup() {
  size(1920, 1080);
  alpha = createGraphics(width,height, JAVA2D);
  background(0);
  // JSON data filename have to be placed in sketch folder
  file = loadJSONArray("posenet.JSON");
}

void draw() {
  
  if (ciclo) {
    
    for(int i = 0 ; i < file.size(); i++){
      
      data = file.getJSONObject(i);
      alpha = createGraphics(width,height, JAVA2D);
      alpha.beginDraw();
      
      if(data != null){
        
        JSONArray humans = data.getJSONArray("poses");
        
        for(int h = 0; h < humans.size(); h++) {
          
          JSONArray keypoints = humans.getJSONArray(h);
          
          // Now that we have one human, let's draw its body parts
          for(int c = 0 ; c < connections.length; c++){
            
            JSONArray startPart = keypoints.getJSONArray(connections[c][0]);
            JSONArray endPart   = keypoints.getJSONArray(connections[c][1]);
            // extract floats fron JSON array and scale normalized value to sketch size
            float startX = startPart.getFloat(0) * width;
            float startY = startPart.getFloat(1) * height;
            float endX   = endPart.getFloat(0) * width;
            float endY   = endPart.getFloat(1) * height;
            alpha.stroke(9,130,250);
            alpha.strokeWeight(3);
            alpha.line(startX,startY,endX,endY);
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
    // print message when done
    println("Fatto!");
  }
}
