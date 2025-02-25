#!/bin/bash

get_cpu_usage() {
    echo "=== CPU Usage ==="
    top -bn1 | grep "Cpu(s)" | awk '{print "User:", $2"% | System:", $4"% | Idle:", $8"%"}'
    echo
}

get_memory_usage() {
    echo "=== Memory Usage ==="
    free -h | awk '/Mem:/ {print "Total:", $2, "| Used:", $3, "| Free:", $4, "| Usage:", $3/$2 * 100 "%"}'
    echo
}

get_disk_usage() {
    echo "=== Disk Usage ==="
    df -h --total | grep total | awk '{print "Total:", $2, "| Used:", $3, "| Free:", $4, "| Usage:", $5}'
    echo
}

get_top_cpu_processes() {
    echo "=== Top 5 Processes by CPU Usage ==="
    ps -eo pid,comm,%cpu --sort=-%cpu | head -6
    echo
}

get_top_mem_processes() {
    echo "=== Top 5 Processes by Memory Usage ==="
    ps -eo pid,comm,%mem --sort=-%mem | head -6
    echo
}

get_system_info() {
    echo "=== System Information ==="
    echo "Hostname: $(hostname)"
    echo "OS: $(lsb_release -d | awk -F'\t' '{print $2}')"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime -p)"
    echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
    echo "Logged in users: $(who | wc -l)"
    echo
}

get_failed_logins() {
    echo "=== Last 10 Failed Login Attempts ==="
    journalctl _SYSTEMD_UNIT=sshd.service | grep "Failed password" | tail -10
    echo
}

get_system_info
get_cpu_usage
get_memory_usage
get_disk_usage
get_top_cpu_processes
get_top_mem_processes
get_failed_logins
