<?php

return [
    'utf_mode' =>
        [
            'value' => true,
            'readonly' => true,
        ],
    'cache_flags' =>
        [
            'value' =>
                [
                    'config_options' => 3600.0,
                    'site_domain' => 3600.0,
                ],
            'readonly' => false,
        ],
    'cache' => [
        'value' => [
            'type' => 'memcache',
            'sid' => 'master',
            'memcache' => [
                'host' => 'memcached',
                'port' => '11211'
            ],
        ],
        'readonly' => true,
    ],
    'cookies' =>
        [
            'value' =>
                [
                    'secure' => false,
                    'http_only' => true,
                ],
            'readonly' => false,
        ],
    'exception_handling' =>
        [
            'value' =>
                [
                    'debug' => true,
                    'handled_errors_types' => 4437,
                    'exception_errors_types' => 4437,
                    'ignore_silence' => false,
                    'assertion_throws_exception' => true,
                    'assertion_error_type' => 256,
                    'log' => NULL,
                ],
            'readonly' => false,
        ],
    'connections' =>
        [
            'value' =>
                [
                    'default' =>
                        [
                            'className' => '\\Bitrix\\Main\\DB\\MysqliConnection',
                            'host' => 'db',
                            'database' => 'bitrix',
                            'login' => 'root',
                            'password' => '123',
                            'options' => 2.0,
                        ],
                ],
            'readonly' => true,
        ],
];
