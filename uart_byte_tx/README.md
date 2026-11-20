## UART串口通信尝试

### uart_byte_tx:
![总要求](images/总要求.png)
![要求1](images/要求1.png)
![要求2](images/要求2.png)
![要求3](images/要求3.png)

### uart_byte_tx_univ:
逻辑变为按一下按键，使得send_go变为低点位，然后发送数据（仅在按键按下时发送，按键弹起则停止发送）
然后去除了led的每次发送翻转逻辑