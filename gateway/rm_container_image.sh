#!/bin/bash

# Переменные
DOCKER_IMAGE_NAME="gateway:1.0"
DOCKER_CONTAINER_NAME="gateway"

# Шаг 1: Остановка и удаление контейнера
docker stop "$DOCKER_CONTAINER_NAME"
docker rm "$DOCKER_CONTAINER_NAME"

# Проверка успешности удаления контейнера
if [ $? -ne 0 ]; then
    echo "Ошибка при удалении контейнера"
    exit 1
fi

# Шаг 2: Удаление Docker-образа
docker rmi "$DOCKER_IMAGE_NAME"

# Проверка успешности удаления образа
if [ $? -ne 0 ]; then
    echo "Ошибка при удалении образа"
    exit 1
fi

echo "Контейнер и образ успешно удалены"
