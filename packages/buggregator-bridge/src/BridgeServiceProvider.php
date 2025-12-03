<?php

declare(strict_types=1);

namespace LaravelSandbox\Buggregator;

use Illuminate\Contracts\Http\Kernel;
use Illuminate\Support\ServiceProvider;

final class BridgeServiceProvider extends ServiceProvider
{
    /** @inheritdoc **/
    public function register(): void
    {
        $this->mergeConfigFrom(__DIR__ . '/config/monolog.php', 'logging.channels');
    }

    /** @inheritdoc **/
    public function boot(): void
    {
        $this->publishes([
            __DIR__ . '/config/monolog.php' => config_path('buggregator/monolog.php'),
        ]);

        /** @var \Illuminate\Foundation\Http\Kernel $kernel */
        $kernel = $this->app->get(Kernel::class);
        $kernel->pushMiddleware(\Inspector\Laravel\Middleware\WebRequestMonitoring::class);
    }
}
