#!/bin/bash

#colors
RED="\e[31m"
ENDCOLOR="\e[0m"

#the resolution of the video
RESOLUTION=$1

#name of the folder
Folder='yt-dlp-downloader/'

#the workingdir
Workingdir=$HOME/

#logfile
LOGFILE=${Workingdir}${Folder}other/logs/yt-dlp-automated.log
exec 3>&1 4>&2 >>$LOGFILE 2>&1

if [[ $RESOLUTION == '480p' || $RESOLUTION == '720p' || $RESOLUTION == '1080p' || $RESOLUTION == '2160p' ]]; then
RESOLUTION2=${RESOLUTION%p}

cd $Workingdir
cd $Folder
yt-dlp --download-archive /root/yt-dlp/other/config/downloaded.txt -i -o 'Downloads/channels/%(channel)s/%(upload_date)s - %(title)s - (%(duration)ss) [%(resolution)s].%(ext)s' -f bv[height="$RESOLUTION2"][ext=mp4]+ba[ext=m4a]/best[ext=mp4]/best --batch-file other/config/channel-list.txt
elif  [[ $RESOLUTION == 'bv' ]]; then

cd $Workingdir
cd $Folder
yt-dlp --download-archive /root/yt-dlp/other/config/downloaded.txt -i -o 'Downloads/channels/%(channel)s/%(upload_date)s - %(title)s - (%(duration)ss) [%(resolution)s].%(ext)s' -f bv[ext=mp4]+ba[ext=m4a]/best[ext=mp4]/best --batch-file /other/config/channel-list.txt
else
    echo -e "${RED}ERORR${ENDCOLOR}"
    echo -e "${RED}Wrong Resolution${ENDCOLOR}"
    echo ""
    echo "Use:"
    echo "480p                                    SD Quality"
    echo "720p                                    HD Quality"
    echo "1080p                                   FULL HD Quality"
    echo "2160p                                   4K Quality"
    echo "bv                                      Best Resolution available"
fi
