# `data` folder

## `datasources` folder

Holds interfaces and implementations of external services usage.

## `models` folder

Holds application model for external service entities.
(eg: They can convert __from__ json and __to__ json)

## `repositories` folder

Holds implementation of _~/lib/game/domain/repositories_ interfaces.
They can use datasources if they need to.