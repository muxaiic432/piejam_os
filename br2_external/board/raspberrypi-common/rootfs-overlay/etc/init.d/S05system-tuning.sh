#!/bin/sh

start()
{
    # CPU governor for audio performance
    echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
    echo performance > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
    echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
    
    # Disable CPU idle states for consistent latency
    echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/state1/disable
    echo 1 > /sys/devices/system/cpu/cpu1/cpuidle/state1/disable
    echo 1 > /sys/devices/system/cpu/cpu2/cpuidle/state1/disable
    echo 1 > /sys/devices/system/cpu/cpu3/cpuidle/state1/disable
    
    # Set I/O scheduler to deadline for better audio performance
    echo deadline > /sys/block/mmcblk0/queue/scheduler
    
    # Increase USB buffer sizes
    echo 16384 > /sys/module/usbcore/parameters/usbfs_memory_mb
    
    # Set swappiness to minimum
    echo 1 > /proc/sys/vm/swappiness
    
    # Audio-specific kernel parameters
    echo 2048 > /proc/sys/dev/hpet/max-user-freq
    echo 1 > /proc/sys/kernel/sched_rt_runtime_us
    
    # Create audio group if it doesn't exist
    if ! getent group audio > /dev/null; then
        addgroup -S audio
    fi
    
    # Add root to audio group
    adduser root audio
}

stop()
{
    # Reset CPU governor to ondemand
    echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo ondemand > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
    echo ondemand > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
    echo ondemand > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart|reload)
        stop
        start
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|reload}" >&2
        exit 1
        ;;
esac