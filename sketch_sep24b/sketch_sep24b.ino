const int LED = 13;
const int BUTTON = 7;

int val = 0;
int old_val = 0; 
int state = 0; // LEDの状態(0ならオフ、1ならオン)


void setup() {
  // put your setup code here, to run once:
  pinMode(LED,OUTPUT); //LEDが出力であることを伝える
  pinMode(BUTTON,INPUT);
  
}

void loop() {
  // put your main code here, to run repeatedly:
  val = digitalRead(BUTTON);
  
  if(val == HIGH && old_val == LOW){
    state = 1-state; 
    delay(10);
  }
  old_val = val;

    if(state == 1){
    digitalWrite(LED,HIGH); //LEDオン
    }
    else{
    digitalWrite(LED,LOW);
    }
}
