<?php

declare(strict_types=1);

return [
    'socket' => [
        'driver'       => 'monolog',
        'level'        => env('LOG_LEVEL', 'debug'),
        'handler'      => \Monolog\Handler\SocketHandler::class,
        'formatter'    => \Monolog\Formatter\JsonFormatter::class,
        'handler_with' => [
            'connectionString' => env('LOG_SOCKET_URL', '127.0.0.1:9913'),
        ],
    ]
];
