
import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 64;
int randomR;
int randomG;
int randomB;

float[] spectrum = new float[bands];

void setup() {
  textSize(32);
  fullScreen();
  background(255);

  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);

  // start the Audio Input
  in.start();

  // patch the AudioIn
  fft.input(in);
}      

void draw() { 
  fft.analyze(spectrum);

  PImage img; //Create image variable
  
  //Load Beiber or Daft Punk image
  //img = loadImage("beiber.jpg");
  img = loadImage("daftpunk.jpg");
  
  //Make image size of screen
  img.resize(width, height);
  
  //Place image on screen and anchor to top/left
  image(img, 0, 0);
  
  //Display FPS to show how many frames have played
  text("FPS: " + frameCount, 10, 30); 
  
  //Do some randomization based on frequency readings for color
  for (int i = 0; i < bands; i++) {
    if(spectrum[i] * 10000 > 5){
      randomR = (int) Math.floor(Math.random() * spectrum[i] * 10000 * 255);
      if(randomR > 255){
        randomR = randomR / 2;
      }
     
      randomG = (int) Math.floor(Math.random() * spectrum[i] * 10000 * 255);
      if(randomG > 255){
        randomG = randomG / 2;
      }
      
      randomB = (int) Math.floor(Math.random() * spectrum[i] * 10000 * 255);
      if(randomB > 255){
        randomB = randomB / 2;
      }
      
      //Add tint to background image based on randomized values
      tint(randomR, randomG, randomB);
    }
  }
}