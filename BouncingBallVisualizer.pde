// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 19-2: Simple therapy client

// Import the net libraries
import processing.net.*;
// Declare a client
Client client;

// Used to indicate a new message
float newMessageColor = 0;
// A String to hold whatever the server says
String messageFromServer = "";
// A String to hold what the user types
String typing ="";
int width = 1400;
int height = 800;
int rectSize = 4;
PFont f;

void setup() {
  size(width, height, P3D);

  // Create the Client, connect to server at 127.0.0.1 (localhost), port 5204
  client = new Client(this, "127.0.0.1", 8080);
  f = createFont("Arial", 16, true);
  background(255);
}

void draw() {
  // If there is information available to read
  // (we know there is a message from the Server when there are greater than zero bytes available.)
  while (client.available () > 0) {
    
    background(255);
    stroke(0, 0, 0);
    line(111, 580, 1107, 580.0);
    line(1107, 580, 1107, 343);
    while (true) {
      String messageSoFar = null;
      while (messageSoFar == null) {
        messageSoFar = client.readStringUntil('\n');
      }
      if (messageSoFar.contains("refresh")) {
        camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
        return;
      }
      String[] s1 = messageSoFar.split(",");

      try {
        pushMatrix();
        float radius = 25;

        int i = Integer.parseInt(s1[0]);
        float x = Float.parseFloat(s1[1]);
        float y = Float.parseFloat(s1[2]);
        float a  = Float.parseFloat(s1[3]);

        float px = x + cos(radians(a))*radius;
        float py = y + sin(radians(a))*radius;

        stroke(i%255, i*10%255, i*100%255);
        fill(i%255, i*10%255, i*100%255);
  
        translate(x, y);
        sphere(25);
        popMatrix();        

        //ellipse(x, y, 50, 50);
    //    fill(0);
  //      stroke(0);
//        line(x, y, px, py);  
        //System.out.println(a);

      }
      catch(Exception e) {
        System.out.println(e);
      }
    }
  }
}

