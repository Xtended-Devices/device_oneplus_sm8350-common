#
# Copyright (C) 2023 StatiXOS
# SPDX-License-Identifier: Apache-2.0
#

# Custom tuning for Lahaina SoC

# Runtime fs tuning
echo 128 > /sys/block/sda/queue/read_ahead_kb
echo 128 > /sys/block/sda/queue/nr_requests
echo 1 > /sys/block/sda/queue/iostats
echo 128 > /sys/block/dm-0/queue/read_ahead_kb
echo 128 > /sys/block/dm-1/queue/read_ahead_kb
echo 128 > /sys/block/dm-2/queue/read_ahead_kb
echo 128 > /sys/block/dm-3/queue/read_ahead_kb
echo 128 > /sys/block/dm-4/queue/read_ahead_kb
echo 128 > /sys/block/dm-5/queue/read_ahead_kb
echo 128 > /sys/block/dm-6/queue/read_ahead_kb
echo 128 > /sys/block/dm-7/queue/read_ahead_kb
echo 128 > /sys/block/dm-8/queue/read_ahead_kb
echo 128 > /sys/block/dm-9/queue/read_ahead_kb

# cpuset
echo 0-1 > /dev/cpuset/background/cpus
echo 0-3 > /dev/cpuset/system-background/cpus
echo 0-3 > /dev/cpuset/restricted/cpus
echo 0-6 > /dev/cpuset/foreground/cpus
echo 0-3 > /dev/cpuset/audio-app/cpus
echo 4-6 > /dev/cpuset/display/cpus

# Setup runtime schedTune
echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo "schedutil" > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
echo 10000 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
echo 5000 > /sys/devices/system/cpu/cpu7/cpufreq/schedutil/down_rate_limit_us
echo 1 > /dev/stune/foreground/schedtune.prefer_idle
echo 0 > /dev/stune/foreground/schedtune.prefer_high_cap
echo 0 > /dev/stune/foreground/schedtune.boost
echo 0 > /dev/stune/schedtune.prefer_idle
echo 0 > /dev/stune/schedtune.prefer_high_cap
echo 0 > /dev/stune/schedtune.boost
echo 1 > /dev/stune/top-app/schedtune.prefer_idle
echo 0 > /dev/stune/top-app/schedtune.prefer_high_cap
echo 10 > /dev/stune/top-app/schedtune.boost 10

# uclamp tuning
echo 50 > /dev/cpuctl/background/cpu.uclamp.max
echo 50 > /dev/cpuctl/system-background/cpu.uclamp.max
echo 60 > /dev/cpuctl/dex2oat/cpu.uclamp.max
# Setup cpu.shares to throttle background groups (bg ~ 5% sysbg ~ 5% dex2oat ~2.5%)
echo 1024 > /dev/cpuctl/background/cpu.shares
echo 1024 > /dev/cpuctl/system-background/cpu.shares
echo 512 > /dev/cpuctl/dex2oat/cpu.shares
echo 20480 > /dev/cpuctl/system/cpu.shares
# We only have system and background groups holding tasks and the groups below are empty
echo 20480 > /dev/cpuctl/camera-daemon/cpu.shares
echo 20480 > /dev/cpuctl/foreground/cpu.shares
echo 20480 > /dev/cpuctl/nnapi-hal/cpu.shares
echo 20480 > /dev/cpuctl/rt/cpu.shares
echo 20480 > /dev/cpuctl/top-app/cpu.shares
