  
import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 1024;
int interval = 100;
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
  fft.analyze(spectrum);
  
  //setup text settings
  textAlign(CENTER);
  
  //create an RGB color and add as "fill"
  color c = color(100, 204, 156);
  fill(c);

  for(int i = 0; i < bands; i++){
    //Render text less FPS and adjust size based on frequency
    if(i % interval == 0){
      textSize(spectrum[i]*1000*10);
      text("DJ Owls", width/2, 200);
    }
    // The result of the FFT is normalized
    // draw the line for frequency band i scaling it up by 25 to get more amplitude.
    line( i, height, i, height - spectrum[i]*height*25 );
  } 
}