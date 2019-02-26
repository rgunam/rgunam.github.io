

const int canalA = A0;  // Define entrada analógica A0

int datoA = 0;        // variable entera para guardar dato decimal 
                      // resultado de la conversión ADC
float voltajeA = 0;   // variable flotante para guardar la conversión
                      // de decimal a voltaje

void setup() {
  // inicia comunicación serial a 9600 bauds
  Serial.begin(9600);
  // limpia el buffer UART 
  Serial.flush();
}

void loop() {
  // lee el canalA = A0, y guarda el dato decimal en datoA
  datoA = analogRead(canalA);

  // convierte el dato decimal a voltaje
  voltajeA = (datoA * 5.0) / 1023; // 1023 = 2^m - 1 ; m=10 bits

  // envía el voltaje por el puerto serial con un salto de línea 
  Serial.println(voltajeA);

  // espera 100 ms entre cada envío, es equivalente a un periodo de muestreo 
  // de 100ms = 0.1 s
  delay(100);
}
