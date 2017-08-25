# BitrixDock
BitrixDock позволяет легко и просто запускать **Bitrix CMS** на **Docker**.

## Введение
BitrixDock облегчает разработку на Битрикс предоставляя готовые сервисы PHP, NGINX, MySQL и многие другие.

### Преимущества данной сборки
- Сервис PHP запакован в отдельный образ, чтобы избавить разработчиков от долгого компилирования.
- Остальные сервисы так же "причёсаны" и разворачиваются моментально.
- Ничего лишнего.

## Порядок разработки в Windows
Если вы работаете в Windows, то требуется установить виртуальную машину.
Желательно использовать Virtualbox, сделать сеть "Сетевой мост", поставить Ubuntu Server 16.04.
Сетевой мост даст возможность обращаться к машине по IP и не делать лишних пробросов портов.
Ваш рабочий проект должен хранится в двух местах, первое - локальная папка с проектами на хосте (открывается в IDE), второе - виртуальная машина
(например ```/var/www/bitrix```). Проект на хосте мапится в IDE к гостевой OC.

## Зависимости
- Git
```
apt-get install -y git
```
- Docker & Docker-Compose
```
cd /usr/local/src && wget -qO- https://get.docker.com/ | sh && \
curl -L "https://github.com/docker/compose/releases/download/1.15.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose && \
echo "alias dc='docker-compose'" >> ~/.bash_aliases && \
source ~/.bashrc
```

### Начало работы
- Разверните bitrixdock в папке ```/var/www```
```
git clone git@github.com:bitrixdock/bitrixdock.git
```
- Запустите bitrixdock
```
cd /var/www/bitrixdock && dc up -d
```
Чтобы проверить, что все сервисы запустились посмотрите список процессов ```docker ps```.  
Посмотрите все прослушиваемые порты, должны быть 80, 11211, 9000 ```netstat -plnt```.  
Откройте IP машины в браузере.

Если у вас всё получилось поставьте звёздочку проекту. Ошибки пишите в [issue](https://github.com/bitrixdock/bitrixdock/issues)  
Приятной работы!  

## Примечание
- Если вы хотите начать с чистой установки Битрикса, скачайте файл [bitrixsetup.php](link=http://www.1c-bitrix.ru/download/scripts/bitrixsetup.php) в папку с сайтом. По умолчанию стоит папки ```/var/www/bitrix/```
- Переименуйте название сайта на свой, сейчас везде стоит "bitrix".
- В настройках подключения требуется указывать имя сервиса, например для подключения к mysql нужно указывать "mysql", а не "localhost". Пример [конфига](configs/.settings.php)  с подклчюением к mysql и memcached.
