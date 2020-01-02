# `domain` folder

The core of the feature.

## `entities` folder

Holds entities used by usecases and repositories.

## `repositories` folder

Holds interfaces only of the repositories needed by usecases.

## `usecases` folder

Holds each usecase needed for the feature to work.
They are called by the presentation layer and use the repositories to handle logic.