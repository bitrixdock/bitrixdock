<?php

return [
    'utf_mode' => [
        'value' => true,
        'readonly' => true,
    ],
    'cache_flags' => [
        'value' => [
            'config_options' => 3600,
            'site_domain' => 3600,
        ],
        'readonly' => false,
    ],
    'session' => [
        'value' => [
            'mode' => 'default',
            'handlers' => [
                'general' => [
                    'type' => 'memcache',
                    'keyPrefix' => '#01',
                    'port' => 11211,
                    'host' => 'memcached',
                ],
            ],
        ],
    ],
    'cache' => [
        'value' => [
            'type' => 'memcached',
            'sid' => 'master',
            'memcached' => [
                'host' => 'memcached',
                'port' => '11211',
            ],

            // Сериализатор igbinary уменьшает размер кэша на ~50% по сравнению с
            // стандартным PHP-сериализатором и работает быстрее при десериализации.
            // Значение 2 = Memcached::SERIALIZER_IGBINARY
            // Требует установленного расширения php-igbinary
            'serializer' => 2,

            // Режим блокировки (use_lock) предотвращает одновременную регенерацию
            // кэша несколькими процессами. При высокой нагрузке только один процесс
            // генерирует кэш, остальные получают устаревшие данные.
            // Требует главного модуля (main) версии 24.0.0 или выше.
            // Подробнее: https://dev.1c-bitrix.ru/learning/course/?COURSE_ID=43&LESSON_ID=3485
             'use_lock' => true,
        ],
        'readonly' => true,
    ],
    'cookies' => [
        'value' => [
            'secure' => false,
            'http_only' => true,
        ],
        'readonly' => false,
    ],
    'exception_handling' => [
        'value' => [
            'debug' => true,
            'handled_errors_types' => 4437,
            'exception_errors_types' => 4437,
            'ignore_silence' => false,
            'assertion_throws_exception' => true,
            'assertion_error_type' => 256,
            'log' => null,
        ],
        'readonly' => false,
    ],
    'connections' => [
        'value' => [
            'default' => [
                'className' => '\\Bitrix\\Main\\DB\\MysqliConnection',
                'host' => 'db',
                'database' => 'bitrix',
                'login' => 'bitrix',
                'password' => '123',
                'options' => 2.0,
            ],
        ],
        'readonly' => true,
    ],
];
