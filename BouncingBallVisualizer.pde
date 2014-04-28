import processing.net.*;
import org.json.*;

Client client;
int width = 1400;
int height = 800;

void setup() {
  size(width, height, P3D);
  client = new Client(this, "127.0.0.1", 8080);
}

void draw() {
  background(255);
  String messageSoFar = null;
  while (messageSoFar == null) {
    try {
      messageSoFar = client.readStringUntil('\n');
//      System.out.print(messageSoFar);
      org.json.JSONObject scene = new org.json.JSONObject(messageSoFar);
      org.json.JSONArray lines = scene.getJSONArray("lines");
      for (int index = 0; index < lines.length(); index++) {
        stroke(0, 0, 0);
        pushMatrix();
        float x1 = (float) lines.optJSONObject(index).getJSONArray("Point1").getDouble(0);
        float y1 = (float) lines.optJSONObject(index).getJSONArray("Point1").getDouble(1);
        float x2 = (float) lines.optJSONObject(index).getJSONArray("Point2").getDouble(0);
        float y2 = (float) lines.optJSONObject(index).getJSONArray("Point2").getDouble(1);
        float width = x2 - x1;
        float height = y2 - y1;
        translate(x1 + (width / 2), y1 + (height / 2));
        box(width, height, 50);
        popMatrix();
      }
      org.json.JSONArray results = scene.getJSONArray("boxes");
      for (int index = 0; index < results.length(); index++) {
        org.json.JSONObject box = results.optJSONObject(index);
        pushMatrix();
        float radius = 25;
        int i = box.getInt("Id");
        float x = (float)box.getDouble("X");
        float y = (float)box.getDouble("Y");
        float a  = (float)box.getDouble("A");
        float px = x + cos(radians(a))*radius;
        float py = y + sin(radians(a))*radius;
        stroke(i%255, i*10%255, i*100%255);
        fill(i%255, i*10%255, i*100%255);
        translate(x, y);
        rotate(a);
        box(50, 50, 50);
        popMatrix();
      }
    }
    catch(Exception e) {
    }
  }
  camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, mouseY, 0, 0, 1, 0);
}

