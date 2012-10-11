import processing.video.*;
Movie myMovie;

PImage img;
int counter = 0;

void setup() {
  size(640 * 2, 426, JAVA2D);
  myMovie = new Movie(this, "matt.mov");
  myMovie.play();
  frameRate( 30 );
}

void draw() {
  if (myMovie.available()) {
    myMovie.read();
    println( counter );
    counter++;
  } 
  image(myMovie, width/2, 0 );
  PImage frame_grab = get(width/2, 0, width/2, height);
  frame_grab.save("frame.jpg");
  glitch(); 
}

void glitch() {
  byte raw[] = loadBytes( "frame.jpg" );
  
  int _start = ( int ) random( 0, raw.length );
  int _end = ( int ) random( _start, raw.length );

  for ( int i = _start; i < _end; i++ ) {
    //print( hex( raw[ i ] ) + "" );
    if (raw[i] == 'b') {
      raw[i] = 'B';
    }
  }
  int stamp = day() + hour() + minute() + second() + millis();
  saveBytes("data/" + stamp + ".jpg", raw);
  PImage glitched = loadImage(stamp + ".jpg" );
  image( glitched, 0, 0 );
  println( "frame saved: " + counter);
  
  if( myMovie.available() == false ) {
   myMovie.stop(); 
  }

}

