from i3pystatus import Status

status = Status()

# Datetime
status.register("clock",
        format=" %a %-d %b %X")

# Volume
status.register("pulseaudio",
        format=" V: {volume:3d}% ")

# Battery
status.register("battery",
        format=" B: {percentage:5.1f}% {remaining} {status} ")

# Load
status.register("load",
        format=" L: {avg1} {avg5} {avg15} ")

# CPU Usage
status.register("cpu_usage",
        format=" CPU:{usage_cpu0:3d}%{usage_cpu1:3d}%{usage_cpu2:3d}%{usage_cpu3:3d}% ")

# CPU Temperature
#status.register("temp",
#        format=" T: {temp} ")

# Memory Usage
status.register("mem",
        format=" M:{percent_used_mem:5.1f}% ")

# Interface
status.register("network",
        interface="wlp2s0",
        format_up=" {essid} {v4} ")

# Bandwidth
status.register("network",
        interface="wlp2s0",
        format_up=" D: {bytes_recv}KB/s U: {bytes_sent}KB/s ",
        format_down="")

status.run()
