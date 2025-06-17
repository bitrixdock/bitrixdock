# Руководство по миграции на защищенную конфигурацию

Это руководство поможет вам перейти на защищенную конфигурацию с сохранением обратной совместимости.

## Обзор

Улучшения безопасности являются **опциональными**, чтобы существующие процессы продолжали работать. Все функции безопасности по умолчанию отключены.

## Этапы миграции

### Шаг 1: Тестирование в режиме разработки (рекомендуется)

1. Скопируйте `.env_template.secure` в `.env`:
   ```bash
   cp .env_template.secure .env
   ```

2. Включайте функции безопасности постепенно:
   ```bash
   # Начните с базовой защиты
   SECURITY_HARDENING=true
   DEVELOPMENT_MODE=true  # Сначала оставьте режим разработки
   ```

3. Тщательно протестируйте вашу установку Битрикс

### Шаг 2: Включение контейнера Cron (опционально)

Если вам нужна функциональность cron:

1. Используйте защищенный docker-compose файл с профилем cron:
   ```bash
   docker-compose -f docker-compose.secure.yml --profile cron up -d
   ```

### Шаг 3: Развертывание в production

1. Обновите `.env` для production:
   ```bash
   SECURITY_HARDENING=true
   DISABLE_DANGEROUS_FUNCTIONS=true
   BLOCK_CRON_ACCESS=true
   DEVELOPMENT_MODE=false
   ```

2. Разверните с использованием защищенной конфигурации:
   ```bash
   docker-compose -f docker-compose.secure.yml --profile cron up -d
   ```

## Параметры конфигурации

### Переменные окружения

| Переменная | По умолчанию | Описание |
|------------|--------------|----------|
| `SECURITY_HARDENING` | `false` | Главный переключатель функций безопасности |
| `DISABLE_DANGEROUS_FUNCTIONS` | `true` | Отключить exec, system и т.д. (при включенной защите) |
| `BLOCK_CRON_ACCESS` | `true` | Добавить www-data в /etc/cron.deny |
| `DEVELOPMENT_MODE` | `true` | Режим разработки: отображение ошибок PHP (при false - настройки production) |

### Поэтапный путь миграции

1. **Фаза 1**: Только блокировка доступа к cron
   ```
   SECURITY_HARDENING=false
   BLOCK_CRON_ACCESS=true
   ```

2. **Фаза 2**: Включение защиты в разработке
   ```
   SECURITY_HARDENING=true
   DEVELOPMENT_MODE=true
   DISABLE_DANGEROUS_FUNCTIONS=false  # Сначала протестируйте
   ```

3. **Фаза 3**: Полная защита для production
   ```
   SECURITY_HARDENING=true
   DEVELOPMENT_MODE=false
   DISABLE_DANGEROUS_FUNCTIONS=true
   ```

## Решение проблем

### Проблема: Модули Битрикс не работают

Некоторые модули Битрикс могут требовать `curl_exec`. При возникновении проблем:

1. Проверьте логи ошибок: `docker-compose logs php`
2. Временно отключите ограничения функций:
   ```bash
   DISABLE_DANGEROUS_FUNCTIONS=false
   ```
3. Создайте собственный список disable_functions, исключив нужные функции

### Проблема: Задания cron не выполняются

1. Убедитесь, что контейнер cron запущен:
   ```bash
   docker-compose --profile cron ps
   ```

2. Проверьте логи cron:
   ```bash
   docker-compose logs cron
   tail -f ./logs/cron/bitrix.log
   ```

### Проблема: Права доступа к файлам

При возникновении ошибок прав доступа после включения безопасности:

1. Убедитесь в правильных правах владения:
   ```bash
   docker-compose exec php chown -R www-data:www-data /var/www/bitrix/upload
   ```

2. Проверьте, не слишком ли ограничен open_basedir

## План отката

Для отката к исходной конфигурации:

1. Используйте оригинальный docker-compose.yml:
   ```bash
   docker-compose -f docker-compose.yml up -d
   ```

2. Или отключите все функции безопасности:
   ```bash
   SECURITY_HARDENING=false
   BLOCK_CRON_ACCESS=false
   ```

## Чек-лист безопасности

- [ ] Протестируйте всю функциональность Битрикс с включенной безопасностью
- [ ] Проверьте выполнение заданий cron (если используете контейнер cron)
- [ ] Убедитесь, что загрузка файлов работает корректно
- [ ] Проверьте работу отправки email
- [ ] Убедитесь в доступности нужных PHP функций
- [ ] Просмотрите логи на наличие ошибок безопасности
- [ ] Обновите скрипты, которые могут использовать отключенные функции