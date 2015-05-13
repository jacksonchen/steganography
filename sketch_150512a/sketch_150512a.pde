PImage sunflower;
PImage ill;
final int hueMask = 0xFCFCFCFC;
final int hueMask2 = 0xC0C0C0C0;
final boolean alpha = true;
boolean decrypted = false;

void setup() {
  sunflower = loadImage("Barack_Obama.jpg");
  ill = loadImage("illluminati.jpg");
  
  sunflower.resize(sunflower.width, sunflower.height);
  if( (double)(ill.height)/ill.width < (double)(sunflower.height)/sunflower.width ) {  // sunflower portrait, ill landscape
    ill.resize(sunflower.width, (int)( (double)(ill.height)/ill.width * sunflower.height ) );
  }
  else {  // sunflower landscape, ill portrait
    ill.resize( (int)( (double)(ill.width)/ill.height * sunflower.height ), sunflower.height );
  }
  
  size(sunflower.width, sunflower.height);
  image(sunflower, 0, 0);
  encrypt();
}

void mousePressed() {
  if (!decrypted) {
    decrypt();
  }
  
}

void draw() {}

void encrypt() {
  for (int sunflowerSeed = 0; sunflowerSeed < ill.height; sunflowerSeed++) {
     for (int sunflowerStalk = 0;  sunflowerStalk < ill.width; sunflowerStalk++) {
       int sunflowerHue = sunflower.get(sunflowerStalk, sunflowerSeed);
       int sickHue = ill.get(sunflowerStalk, sunflowerSeed);
       sunflowerHue = sunflowerHue & hueMask;
       sickHue = sickHue & hueMask2;
       sickHue = sickHue >> 6;
       if( !alpha ) sickHue = sickHue & 0xFFFFFF;
       sunflowerHue = sunflowerHue + sickHue; // huehuehuehuehue
       sunflower.set(sunflowerStalk, sunflowerSeed, sunflowerHue);
     }
  }
  image(sunflower, 0, 0);
}

void decrypt() {
  for (int sunflowerSeed = 0; sunflowerSeed < ill.height; sunflowerSeed++) {
     for (int sunflowerStalk = 0;  sunflowerStalk < ill.width; sunflowerStalk++) {
       int sunflowerHue = sunflower.get(sunflowerStalk, sunflowerSeed);
       sunflowerHue = sunflowerHue << 6;
       sunflowerHue = sunflowerHue & hueMask2;
       sunflower.set(sunflowerStalk, sunflowerSeed, sunflowerHue);
     }
  }
  background( 255 );
  image( sunflower, 0, 0 );
  decrypted = true;
}
