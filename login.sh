#!/bin/bash

# Получаем текущий день недели (1 - понедельник, 7 - воскресенье)
DAY_OF_WEEK=$(date +%u)

# Проверяем, является ли день выходным (6 - суббота, 7 - воскресенье)
if [ "$DAY_OF_WEEK" -eq 6 ] || [ "$DAY_OF_WEEK" -eq 7 ]; then
    # Проверяем, принадлежит ли пользователь к группе admin
    if ! id -nG "$PAM_USER" | grep -qw "admin"; then
        # Запрещаем вход
        echo "$(date): Access denied for user $PAM_USER on weekend" >> /var/log/login_attempts.log
        exit 1
    fi
fi

# Разрешаем вход
echo "$(date): Access granted for user $PAM_USER" >> /var/log/login_attempts.log
exit 0