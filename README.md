ENG:  
Due to the latest security updates, you can only connect to marzban via SSH or HTTPS.  
But, if you need an HTTP connection, then an automatic script will do all the work for you.  
The script is perfect for you if you only have marzban and no web servers are configured (there are no nginx configs)  
  
You will be asked to enter the port to which you will connect to work with marzban.  
Enter any unoccupied port, or leave the field empty, then the standard port will be 7000.  
```  
wget https://raw.githubusercontent.com/VadimBoev/marzban_http_enable/main/script.sh && bash script.sh
```
Result:  
<img src="screen.png" alt="shell" width="700px">

Ready! Getting connected:  
```http://YOUR_IP_SERVER:YOUR_PORT/dashboard``` (YOUR_IP_SERVER is the IP of your VDS/VPS server, YOUR_PORT is the port that you specified in the script, or according to the 7000 standard)  
For example: ```http://46.78.89.99:6545/dashboard```

**RU:**  
В связи с последними обновлениями безопасности, к marzban можно подключиться только по SSH или по HTTPS.  
Но, если вам требуется подключение по HTTP, то автоматический скрипт выполнит всю работу за вас.  
Скрипт идеально подойдет Вам, если у вас только marzban и никаких веб серверов не настроено (нет конфигов nginx)  
  
Вас попросят ввести порт, к которому вы будете подключаться чтобы работать с marzban.  
Введите любой незанятый порт, либо оставьте поле пустым, тогда порт по стандарту будет 7000.  
```  
wget https://raw.githubusercontent.com/VadimBoev/marzban_http_enable/main/script.sh && bash script.sh
```
Результат:  
<img src="screen.png" alt="shell" width="700px">

Готово! Подключаемся:  
```http://YOUR_IP_SERVER:YOUR_PORT/dashboard``` (YOUR_IP_SERVER - IP вашего сервера VDS/VPS, YOUR_PORT - порт который вы указали в скрипте, либо по стандарту 7000)  
К примеру: ```http://46.78.89.99:6545/dashboard```
