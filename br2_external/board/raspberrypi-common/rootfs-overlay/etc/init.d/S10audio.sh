#!/bin/sh

start()
{
    # Set audio group permissions
    chgrp audio /dev/snd/*
    chmod g+rw /dev/snd/*
    
    # Load ALSA state if available
    if [ -f /etc/asound.state ]; then
        alsactl restore
    fi
    
    # Set up audio priorities for low latency
    echo "@audio - rtprio 95" >> /etc/security/limits.conf
    echo "@audio - memlock unlimited" >> /etc/security/limits.conf
    echo "@audio - nice -10" >> /etc/security/limits.conf
    
    # Start JACK daemon for low-latency audio
    # Optimized for Behringer Flow 8 (USB audio interface)
    su -c "jackd -R -P95 -dalsa -dhw:1 -r48000 -p128 -n2 -S &" audio
}

stop()
{
    killall jackd
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