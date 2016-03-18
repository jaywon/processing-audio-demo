  
import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 1024;
float[] spectrum = new float[bands];

void setup() {
  size(1024, 620);
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
  background(100);
  fft.analyze(spectrum);

  for(int i = 0; i < bands; i++){
    // The result of the FFT is normalized 
    // draw input with rectangles for frequency band i scaling it up by 25 to get more amplitude.
    rect(i, 0, 20, height - spectrum[i]*height*25);
  } 
}