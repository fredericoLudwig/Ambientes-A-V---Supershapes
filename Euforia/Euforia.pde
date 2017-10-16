import peasy.*;
import processing.sound.*;
SoundFile file; 

PeasyCam cam;
float x = random(0.1, -0.1) ;
float n = 0.5;
float xb ;
float xb2;
float y = random(0.1, -0.1) ;
float rx =    0.1 ;
float ry =    0.1 ;
float rz =  random(0.01, -0.01);
float offset;
PVector[][] globe;
int total = 75;

float m = 0;
float mchange = 0;
void setup() {
file = new SoundFile(this,"3.wav");
  file.play();
 //colorMode(HSB);
 fullScreen(P3D);
 // size(300, 300, P3D);
  cam = new PeasyCam(this, 200);
  globe = new PVector[total+1][total+1];
}
float a = 1;
float b = 1;

float supershape(float theta, float m, float n1, float n2, float n3) {
  float t1 = abs((1/a)*cos(m * theta / 4));
  t1 = pow(t1, n2);
  float t2 = abs((1/b)*sin(m * theta/4));
  t2 = pow(t2, n3);
  float t3 = t1 + t2;
  float r = pow(t3, - 1 / n1);
  return r;
}
void draw() {
 frameRate(18);
xb+=0.5;


  m = map(sin(mchange), -1, 1, 0, 7);
  mchange += 0.02;

background(240,xb,mchange%m,100);
  lights();
  
  rotate(mchange);
 // rotateZ(random(rz-0.0001,rz+0.0005));
  float r = 200;
  for (int i = 0; i < total+1; i++) {
    float lat = map(i, 0, total, HALF_PI, -HALF_PI);
    float r2 = supershape(lat, mchange, 0.2, 1.7, 1.7);
    //float r2 = supershape(lat, 200, 3, 5, mchange);
    for (int j = 0; j < total+1; j++) {
      float lon = map(j, 0, total, -PI, PI);
      float r1 = supershape(lon, m, 0.2, 1.7, 1.7);
     // float r1 = supershape(lon, 100, 2.4, 5,m);
      float x = r * r1 * cos(lon) * r2 * cos(lat);
      float y = r * r1 * sin(lon) * r2 * cos(lat);
      float z = r * r2 * sin(lat);
      globe[i][j] = new PVector(x, y, z);
    }

  }
    offset+=5;
    for (int i = 0; i < total; i++) {
       float hu = noise((n% i)) *255;

        fill(hu,210,230,70);
      for (int j = 0; j < total; j++) {
       float huw = noise((n* j)) *255;
        //noStroke();
        strokeWeight(3);
        stroke(huw,25,250);

      }
         n+=4;

      beginShape(TRIANGLE_STRIP);
      for (int j = 0; j < total+1; j++) {
        PVector v1 = globe[i][j];
        vertex(v1.x, v1.y, v1.z);
        PVector v2 = globe[i+1][j];
        vertex(v2.x, v2.y, v2.z);
      }
      endShape();
      for (x = 0; x<width; x++) {
        float rx=0.03  ;
        rx = rx+0.3;
        float ry =(0.03 );

        ry = ry+0.1;//
        rz= rz+0.01;
      }
  
      

  
  
  }
  
  }