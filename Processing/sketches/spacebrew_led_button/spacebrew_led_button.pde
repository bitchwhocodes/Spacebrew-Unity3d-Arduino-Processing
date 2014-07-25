import processing.serial.*;
import cc.arduino.*;
import spacebrew.*;



Arduino arduino;
Spacebrew spacebrewConnection;  // Spacebrew connection object

/*Future versions of the Spacebrew library will not support WS*/
String server = "ws://10.0.1.69:9000/";
String name = "Bitchwhocodes_PROCESSING";
String description = "Testing Unity to Arduino";

int led = 12;
int button = 2;
int value = 0;
Boolean isOn = false;
Boolean hasMessage =false;
/*


*/
void setup() {
  size(400, 200);

  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(led, Arduino.OUTPUT);
  arduino.pinMode(button,Arduino.INPUT);
  spacebrewConnection = new Spacebrew( this );
  
  // add each thing you publish to
  spacebrewConnection.addPublish( "button_pressed", "string",true ); 
  spacebrewConnection.addSubscribe( "button_pressed","string" ); 
  // connect to spacebrew
  spacebrewConnection.connect(server, name, description );

}

void draw() {
  background(0, 0, 0 );
  fill(255,255,255);
  textAlign(CENTER);
  textSize(16);
  value = arduino.digitalRead(button);   
  if(value==1 ){
     text("BANG! THERE GOES THE BUTTON ", width/2, 25 );  
     spacebrewConnection.sendMessage("button_pressed","on");
     isOn = true;
  }else{
     isOn = false;

  }
  
    if (spacebrewConnection.connected()) {
      // print client name to screen
      text("Connected as: " + name, width/2, 25 );  
      // print current bright value to screen
      textSize(14);
      text("Waiting for messages", width/2, height/2 + 20); 
    }
  else {
      text("Not Connected to Spacebrew", width/2, 25 );      
  }
  
// Yes this could be more elegant. I just wanted to run it in the loop. So I have a variable that
// checks if the physical button pressed it, or if it received a message. THat way I can use the button
// to turn it off
  if(isOn || hasMessage){
    blinkButton();
  }else{
    arduino.digitalWrite(led,Arduino.LOW);
  }
}

void onStringMessage( String name, String value ){
  
  if(value.indexOf("on")!=-1)
  {
    hasMessage = true;
  }else{
  //arduino.digitalWrite(led,Arduino.LOW);
    hasMessage = false;
  }
}

void blinkButton(  ){
   
  //let's blink the led
   
   arduino.digitalWrite(led, Arduino.HIGH);
   delay(100);
   arduino.digitalWrite(led, Arduino.LOW);
   delay(100);
}
