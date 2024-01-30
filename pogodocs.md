<a name="line-46"></a>
# POGODOCS

This document presents the simple API available to control the differents functions of the robot

<a name="line-52"></a>
## Global API

<a name="line-56"></a><a name="pogobot_init"></a>
### :arrow_right: pogobot_init

```cpp
void pogobot_init( void ) /* line 67 */
```

Global API Initialisation
This function is mandatory inside your program

#### Parameters
- none

#### Return
- none


<a name="line-70"></a>
## Infrared communication API Values

<a name="line-74"></a>
### Maximum size of a payload in a IR message
MAX_PAYLOAD_SIZE_BYTES 384

<a name="line-83"></a>
### Maximum number of word from IR recovers in one step
MAX_NUMBER_OF_WORD 20

<a name="line-92"></a>
### IR power level values:

- pogobot_infrared_emitter_power_max      - 3
- pogobot_infrared_emitter_power_twoThird - 2
- pogobot_infrared_emitter_power_oneThird - 1
- pogobot_infrared_emitter_power_null     - 0

<a name="line-161"></a>
### IR direction id list

- ir_front - 0
- ir_right - 1
- ir_back  - 2
- ir_left  - 3
- ir_all   - 4

<a name="line-182"></a>
### IR message header structure

message_header_t :

The parameters that begin with "_" are not completed by the user

- uint8_t _packet_type         - allows to give type of a packet (fixed for now)
- uint8_t _emitting_power_list - used to define the emission power on each IR
- uint16_t _sender_id          - id of the robot which send the message
- uint8_t _sender_ir_index     - IR id direction of the sender robot
- uint16_t receiver_id         - id of the recipient robot
- uint8_t _receiver_ir_index   - IR id direction that received the message
- uint16_t payload_length      - size of the payload


<a name="line-210"></a>
### IR message header structure

message_t :

- message_header_t header                  - header of the message
- uint8_t payload[MAX_PAYLOAD_SIZE_BYTES]  - payload of the message

<a name="line-225"></a>
### IR short message header structure

message_short_header_t :

The parameters that begin with "_" are not completed by the user

- uint8_t _packet_type         - allows to give type of a packet (fixed for now)
- uint16_t payload_length      - size of the payload


<a name="line-243"></a>
### IR short message header structure

short_message_t :

- message_short_header_t header            - header of the message
- uint8_t payload[MAX_PAYLOAD_SIZE_BYTES]  - payload of the message

<a name="line-258"></a>
### IR type message list

- ir_t_cmd  : type use to send command to the robot
- ir_t_flash : type use to send part of a program
- ir_t_short : type use to send short message between robot in user space
- ir_t_user : type use to send message between robot in user space

<a name="line-288"></a>
## Infrared communication API Functions

<a name="line-292"></a><a name="pogobot_infrared_ll_init"></a>
### :arrow_right: pogobot_infrared_ll_init

```cpp
void pogobot_infrared_ll_init( void ) /* line 303 */
```

Initialise Infrared hardware and software struture
(already made inside pogobot_init)

#### Parameters
- none

#### Return
- none


<a name="line-305"></a><a name="pogobot_infrared_update"></a>
### :arrow_right: pogobot_infrared_update

```cpp
void pogobot_infrared_update( void ) /* line 315 */
```

Infrared checks for received data and send to decode messages
Decoded messages are placed in a Fifo

#### Parameters
- none

#### Return
- none

<a name="line-317"></a><a name="pogobot_infrared_message_available"></a>
### :arrow_right: pogobot_infrared_message_available

```cpp
int pogobot_infrared_message_available( void ) /* line 327 */
```

Infrared new message checks fonction

#### Parameters
- none

#### Return
- none


<a name="line-329"></a><a name="pogobot_infrared_recover_next_message"></a>
### :arrow_right: pogobot_infrared_recover_next_message

```cpp
void pogobot_infrared_recover_next_message( message_t *mes ) /* line 339 */
```

Recover the next message inside the message queue

#### Parameters
- 'mes' - Allocated structure of type 'message_t'

#### Return
- none


<a name="line-341"></a><a name="pogobot_infrared_clear_message_queue"></a>
### :arrow_right: pogobot_infrared_clear_message_queue

```cpp
void pogobot_infrared_clear_message_queue( void ) /* line 351 */
```

Clears Infrared message queue

#### Parameters
- none

#### Return
- none


<a name="line-353"></a><a name="pogobot_infrared_set_power"></a>
### :arrow_right: pogobot_infrared_set_power

```cpp
void pogobot_infrared_set_power( uint8_t power ) /* line 362 */
```

set the power level used to send all the next messages

#### Parameters
- 'power' - use the pogobot_infrared_emitter_power_* or the values {0,1,2,3}

#### Return
- none

<a name="line-364"></a><a name="pogobot_infrared_sendMessageOnce"></a>
### :arrow_right: pogobot_infrared_sendMessageOnce

```cpp
uint32_t pogobot_infrared_sendMessageOnce( message_t *const message ) /* line 376 */
```

 Prepare and send one packet, with the specified emitters and
 powers, to the recipient, containing the specified message.

#### Parameters
- 'message' - fully filled message_t variable

#### Return
- '0' in case of success
- '1' in case of payload too long


<a name="line-378"></a><a name="pogobot_infrared_sendShortMessageOnce"></a>
### :arrow_right: pogobot_infrared_sendShortMessageOnce

```cpp
uint32_t pogobot_infrared_sendShortMessageOnce( ir_direction dir, short_message_t *const message ) /* line 391 */
```

 Prepare and send one packet, with a short header
 containing the specified message.

#### Parameters
- 'dir' - indicates the direction to send the message
- 'message' - fully filled short_message_t variable

#### Return
- '0' in case of success
- '1' in case of payload too long


<a name="line-393"></a><a name="pogobot_infrared_sendMessageOneDirection"></a>
### :arrow_right: pogobot_infrared_sendMessageOneDirection

```cpp
uint32_t pogobot_infrared_sendMessageOneDirection( ir_direction dir, uint16_t receiver_id, uint8_t *message, uint16_t message_size ) /* line 407 */
```

Send a message in only direction at defined power
Use pogobot_infrared_sendMessageOnce

#### Parameters
- 'dir' - indicates the direction to send the message
- 'receiver_id' - is the id of the robot we want to send the message
- 'message' - the current payload to send
- 'message_size' - the size of the payload

#### Return
- '0' in case of success
- '1' in case of payload too long

<a name="line-409"></a><a name="pogobot_infrared_sendMessageAllDirection"></a>
### :arrow_right: pogobot_infrared_sendMessageAllDirection

```cpp
uint32_t pogobot_infrared_sendMessageAllDirection( uint16_t receiver_id, uint8_t *message, uint16_t message_size ) /* line 423 */
```

Send the same message in all direction at defined power
Use pogobot_infrared_sendMessageOnce
Their no infrared sender ID

#### Parameters
- 'receiver_id' - is the id of the robot we want to send the message
- 'message' - the current payload to send
- 'message_size' - the size of the payload

#### Return
- '0' in case of success
- '1' in case of payload too long

<a name="line-425"></a><a name="pogobot_infrared_sendMessageAllDirectionWithId"></a>
### :arrow_right: pogobot_infrared_sendMessageAllDirectionWithId

```cpp
uint32_t pogobot_infrared_sendMessageAllDirectionWithId( uint16_t receiver_id, uint8_t *message, uint16_t message_size ) /* line 440 */
```

Send successively the same message with the origin infrared ID on each Infrared
It is 4 times slower that without ID
Use pogobot_infrared_sendMessageOnce

#### Parameters
- 'receiver_id' - is the id of the robot we want to send the message
- 'message' - the current payload to send
- 'message_size' - the size of the payload

#### Return
- '0' in case of success
- '1' in case of payload too long


<a name="line-443"></a><a name="pogobot_infrared_sendShortMessageOneDirection"></a>
### :arrow_right: pogobot_infrared_sendShortMessageOneDirection

```cpp
uint32_t pogobot_infrared_sendShortMessageOneDirection( ir_direction dir, uint8_t *message, uint16_t message_size ) /* line 456 */
```

Send a short header message in only direction at defined power
Use pogobot_infrared_sendShortMessageOnce

#### Parameters
- 'dir' - indicates the direction to send the message
- 'message' - the current payload to send
- 'message_size' - the size of the payload

#### Return
- '0' in case of success
- '1' in case of payload too long

<a name="line-458"></a><a name="pogobot_infrared_sendShortMessageAllDirection"></a>
### :arrow_right: pogobot_infrared_sendShortMessageAllDirection

```cpp
uint32_t pogobot_infrared_sendShortMessageAllDirection( uint8_t *message, uint16_t message_size ) /* line 470 */
```

Send a short header message in all direction at defined power
Use pogobot_infrared_sendShortMessageOnce

#### Parameters
- 'message' - the current payload to send
- 'message_size' - the size of the payload

#### Return
- '0' in case of success
- '1' in case of payload too long

<a name="line-473"></a><a name="pogobot_infrared_get_receiver_error_counter"></a>
### :arrow_right: pogobot_infrared_get_receiver_error_counter

```cpp
void pogobot_infrared_get_receiver_error_counter( slip_error_counter_s *error_counter, uint8_t ir_index ) /* line 483 */
```

Get the receiver error counter value

#### Parameters
- 'error_counter' - allocated structure 'slip_error_counter_s'
- 'ir_index' - index of the ir receiver (0 to 3)

#### Return
- none

<a name="line-485"></a><a name="pogobot_infrared_reset_receiver_error_counter"></a>
### :arrow_right: pogobot_infrared_reset_receiver_error_counter

```cpp
void pogobot_infrared_reset_receiver_error_counter( void ) /* line 495 */
```

Reset all reveiver error counter

#### Parameters
- none

#### Return
- none


<a name="line-497"></a>
## RGB LED API

<a name="line-501"></a><a name="pogobot_led_setColor"></a>
### :arrow_right: pogobot_led_setColor

```cpp
void pogobot_led_setColor( const uint8_t r, const uint8_t g, const uint8_t b ) /* line 514 */
```

Set the value of red, green and blue of the head led in static mode
each value goes from 0 to 255 to determine the intensity.

#### Parameters
- 'r' - value of the RED part
- 'g' - value of the GREEN part
- 'b' - value of the BLUE part

#### Return
- none


<a name="line-517"></a><a name="pogobot_led_setColors"></a>
### :arrow_right: pogobot_led_setColors

```cpp
void pogobot_led_setColors( const uint8_t r, const uint8_t g, const uint8_t b, uint8_t id ) /* line 532 */
```

Set the value of red, green and blue of the led with the number (ID) in static mode
each value goes from 0 to 255 to determine the intensity.
(only available with a belly with multiple LEDs)

#### Parameters
- 'r' - value of the RED part
- 'g' - value of the GREEN part
- 'b' - value of the BLUE part
- 'id' - Led ID (0 = head, 1 = belly front, 2 = belly right, 3 = belly back, 4 = belly left)

#### Return
- none


<a name="line-535"></a>
## Photosensors API Values

<a name="line-539"></a>
### Photosensor id definition
- 0 is the back sensor
- 1 is the front-left sensor
- 2 is the front-right sensor

<a name="line-553"></a>
## Photosensors API Functions

<a name="line-557"></a><a name="pogobot_photosensors_read"></a>
### :arrow_right: pogobot_photosensors_read

```cpp
int16_t pogobot_photosensors_read( uint8_t sensor_number ) /* line 567 */
```

Read one ambient light sensor.
Sensor number must be between 0 and 2.

#### Parameters
- 'sensor_number' - id of the sensor (Photosensor definition)

#### Return
Return a value proportional to the light

<a name="line-569"></a>
## IMU API

<a name="line-573"></a><a name="pogobot_imu_read"></a>
### :arrow_right: pogobot_imu_read

```cpp
void pogobot_imu_read( float *acc, float *gyro ) /* line 593 */
```

Read the accelaration on the IMU. <br>
Returns in acc and gyro the IMU values.

usage : <br>
float acc[3], gyro[3];

index :

- 0 - X axis
- 1 - Y axis
- 2 - Z axis

#### Parameters
- 'acc' - allocated float table (size 3)
- 'gyro' - allocated float table (size 3)

#### Return
- none

<a name="line-595"></a><a name="pogobot_imu_readTemp"></a>
### :arrow_right: pogobot_imu_readTemp

```cpp
float pogobot_imu_readTemp( void ) /* line 604 */
```

Read the temparature sensor on the IMU.

#### Parameters
- none

#### Return
Returns the temperature in degres celsius

<a name="line-607"></a>
## Battery API

<a name="line-611"></a><a name="pogobot_battery_voltage_read"></a>
### :arrow_right: pogobot_battery_voltage_read

```cpp
int16_t pogobot_battery_voltage_read( void ) /* line 620 */
```

Recovers the value of the battery in mV

#### Parameters
- none

#### Return
Returns a value in mV

<a name="line-622"></a>
## Motors API Values

<a name="line-626"></a>
### Motor id definition :

- motorR  - 0
- motorL  - 1
- motorB  - 2

<a name="line-641"></a>
### Motor range :

- motorStop                   - 0
- motorQuarter                - 256
- motorHalfmotorThreeQuarter  - 716
- motorFull                   - 1023

<a name="line-659"></a>
## Motors API Functions

<a name="line-663"></a><a name="pogobot_motor_power_set"></a>
### :arrow_right: pogobot_motor_power_set

```cpp
void pogobot_motor_power_set( motor_id motor, uint16_t value ) /* line 674 */
```

set the value of pwm that commands the motor (active)

#### Parameters
- 'motor' - is the id of the motor you want to command
- 'value' - is PWM ratio apply to the motor (between 0 and 1023)

#### Return
- none


<a name="line-677"></a><a name="pogobot_motor_dir_current_status"></a>
### :arrow_right: pogobot_motor_dir_current_status

```cpp
uint32_t pogobot_motor_dir_current_status( void ) /* line 687 */
```

recover the value of the motor direction bit field.

#### Parameters
- none

#### Return
- bit field ( XXXX XMLR )


<a name="line-689"></a><a name="pogobot_motor_dir_mem_get"></a>
### :arrow_right: pogobot_motor_dir_mem_get

```cpp
int8_t pogobot_motor_dir_mem_get( uint8_t *data ) /* line 700 */
```

get the value of pwm that commands the motor.

#### Parameters
- 'data' - is the value of each direction 0:R 1:L 2:B
           data is an array of size 3.

#### Return
- the success or not of the read in memory (0: Ok, -1: NOk)


<a name="line-702"></a><a name="pogobot_motor_dir_mem_set"></a>
### :arrow_right: pogobot_motor_dir_mem_set

```cpp
int8_t pogobot_motor_dir_mem_set( uint8_t *data) /* line 713 */
```

set the value of pwm that commands the motor (persistent).

#### Parameters
- 'data' - is the value of each direction 0:R 1:L 2:B
           data is an array of size 3.

#### Return
- the success or not of the read in memory (0: Ok, -1: NOk)


<a name="line-715"></a><a name="pogobot_motor_dir_set"></a>
### :arrow_right: pogobot_motor_dir_set

```cpp
void pogobot_motor_dir_set( motor_id motor, uint16_t value ) /* line 726 */
```

set the value of pwm that commands the motor (active).

#### Parameters
- 'motor' - is the id of the motor you want to command
- 'value' - is the choosen direction (0 or 1)

#### Return
- none


<a name="line-728"></a><a name="pogobot_motor_power_mem_get"></a>
### :arrow_right: pogobot_motor_power_mem_get

```cpp
uint8_t pogobot_motor_power_mem_get( uint16_t *p_motors ) /* line 738 */
```

recover the value of the motor power memorized.

#### Parameters
- 'p_motors' - is a pointer to a table [R, L, B]

#### Return
- read status


<a name="line-740"></a><a name="pogobot_motor_power_mem_set"></a>
### :arrow_right: pogobot_motor_power_mem_set

```cpp
uint8_t pogobot_motor_power_mem_set( uint16_t *p_motors ) /* line 750 */
```

write the value of the motor power in memory (persistent).

#### Parameters
- 'p_motors' - is a pointer to a table [R, L, B]

#### Return
- read status


<a name="line-752"></a>
## Helper API

<a name="line-756"></a><a name="pogobot_helper_getid"></a>
### :arrow_right: pogobot_helper_getid

```cpp
uint16_t pogobot_helper_getid( void ) /* line 766 */
```

gives an unique identifier or an random number if no id is register inside the robot

#### Parameters
- none

#### Return
Returns an unique id on 16bits


<a name="line-768"></a><a name="pogobot_helper_getRandSeed"></a>
### :arrow_right: pogobot_helper_getRandSeed

```cpp
int16_t pogobot_helper_getRandSeed( void ) /* line 778 */
```

gives an seed base on the ADC read of the battery

#### Parameters
- none

#### Return
Returns an random id on 16bits


<a name="line-780"></a><a name="pogobot_helper_print_version"></a>
### :arrow_right: pogobot_helper_print_version

```cpp
void pogobot_helper_print_version( void ) /* line 791 */
```

print the version inside the prompt
It is also possible to use the define RELEASE_VERSION in release.h

#### Parameters
- none

#### Return
- none
