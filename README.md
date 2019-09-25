![Alt text](assets/logo.jpg?raw=true "BitrixDock")

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
Желательно использовать Virtualbox, сделать сеть "Сетевой мост", поставить Ubuntu Server.
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
curl -L "https://github.com/docker/compose/releases/download/1.18.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose && \
echo "alias dc='docker-compose'" >> ~/.bash_aliases && \
source ~/.bashrc
```

### Начало работы
```
mkdir -p /var/www/bitrix && \
cd /var/www/bitrix && \
wget http://www.1c-bitrix.ru/download/scripts/bitrixsetup.php && \
cd /var/www/ && \
git clone https://github.com/bitrixdock/bitrixdock.git && \
cd /var/ && chmod -R 775 www/ && chown -R root:www-data www/ && \
cd /var/www/bitrixdock
```

- Выполните настройку окружения

Скопируйте файл `.env_template` в `.env`

```
cp -f .env_template .env
```
⚠️ Если у вас мак или windows, то удалите строчку /etc/localtime:/etc/localtime/:ro из docker-compose

По умолчнию используется nginx php7, эти настройки можно изменить в файле ```.env```. Также можно задать путь к каталогу с сайтом и параметры базы данных MySQL.


```
PHP_VERSION=php7           # Версия php 
WEB_SERVER_TYPE=nginx      # Веб-сервер nginx/apache
MYSQL_DATABASE=bitrix      # Имя базы данных
MYSQL_USER=bitrix          # Пользователь базы данных
MYSQL_PASSWORD=123         # Пароль для доступа к базе данных
MYSQL_ROOT_PASSWORD=123    # Пароль для пользователя root от базы данных
INTERFACE=0.0.0.0          # На данный интерфейс будут проксироваться порты
SITE_PATH=/var/www/bitrix  # Путь к директории Вашего сайта

```

- Запустите bitrixdock
```
docker-compose up -d
```
Чтобы проверить, что все сервисы запустились посмотрите список процессов ```docker ps```.  
Посмотрите все прослушиваемые порты, должны быть 80, 11211, 9000 ```netstat -plnt```.  
Откройте IP машины в браузере.

Если у вас всё получилось будем благодарны за звёздочку :)  
Ошибки ждём в [issue](https://github.com/bitrixdock/bitrixdock/issues)  
Приятной работы!  

## Как заполнять подключение к БД
![db](https://raw.githubusercontent.com/bitrixdock/bitrixdock/master/db.png)

## Примечание
- По умолчанию стоит папка ```/var/www/bitrix/```
- В настройках подключения требуется указывать имя сервиса, например для подключения к mysql нужно указывать "mysql", а не "localhost". Пример [конфига](configs/.settings.php)  с подклчюением к mysql и memcached.
- Для загрузки резервной копии в контейнер используйте команду: ```cat /var/www/bitrix/backup.sql | docker exec -i mysql /usr/bin/mysql -u root -p123 bitrix```

## Отличие от виртуальной машины Битрикс
Виртуальная машина от разработчиков битрикс решает ту же задачу, что и BitrixDock - предоставляет готовое окружение. Разница лишь в том, что Docker намного удобнее, проще и легче в поддержке.

Как только вы запускаете виртуалку, Docker сервисы автоматически стартуют, т.е. вы запускаете свой минихостинг для проекта и он сразу доступен.

Если у вас появится новый проект и поменяется окружение, достаточно скопировать чистую виртуалку (если вы на винде), скопировать папку BitrixDock, добавить или заменить сервисы и запустить.

P.S.
Виртуальная машина от разработчиков битрикс на Apache, а у нас на Nginx, а он работает намного быстрее и кушает меньше памяти.

# Ищем контрибьюторов  
Помогите развитию проекта! Требуется закрывать задачи в [issue](https://github.com/bitrixdock/bitrixdock/issues)

# Пример
Пример реального Docker проекта для Bitrix - Single Node    
https://github.com/bitrixdock/production-single-node   

Ещё один проект с php7 и отправкой почты, взят с боевого проекта, вырезаны пароли, сертификаты и тп   
https://github.com/bitrixdock/bitrixdock-production
