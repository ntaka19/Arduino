const int LED = 13;
int val = 0;


void setup() {
  // put your setup code here, to run once:
  pinMode(LED,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  val = analogRead(0); //センサから値を読み取る

  digitalWrite(13,HIGH); //LEDをオン
  delay(val);

  digitalWrite(13,LOW);
  delay(val);
}
