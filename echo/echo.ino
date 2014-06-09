#include <SPI.h>
#include <boards.h>
#include <RBL_nRF8001.h>

void setup()
{
  ble_set_name("BlendMicro");
  ble_begin();
}

void loop()
{
  if(ble_connected()){
    pinMode(13, true);
    digitalWrite(13, true);
  }
  else{
    pinMode(13, false);
    digitalWrite(13, false);
  }

  ble_do_events();

  if ( ble_available() ){
    ble_print("echo>");
    while ( ble_available() ){
      ble_write(ble_read());
    }
  }
 
  delay(100);
}

void ble_print(char *str){
  char i = 0;
  while(char c = str[i]){
    ble_write(str[i]);
    i++;
  }
}
