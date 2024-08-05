#!/bin/bash

# Подсчет общего количества запросов
total_requests=$(wc -l < access.log)

# Подсчет количества уникальных IP-адресов
unique_ips=$(awk '{print $1}' access.log | sort -u | wc -l)

# Подсчет количества запросов по методам
request_methods=$(awk '{print $6}' access.log | tr -d '"' | sort | uniq -c | awk '{print "    " $1 " " $2}')

# Нахождение самого популярного URL
popular_url=$(awk '{print $7}' access.log | sort | uniq -c | sort -rn | awk 'NR==1 {print $1 " " $2}')

cat <<EOT > report.txt
Отчет о логе веб-сервера
========================
1. Общее количество запросов: $total_requests

2. Количество уникальных IP-адресов: $unique_ips

3. Количество запросов по методам:
$request_methods

4. Самый популярный URL: $popular_url
EOT
