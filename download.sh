#!/bin/bash
# Bash Menu Script Example

#IMPORTANT:

#The yt-dlp folder has to be located in the root folder or this script won't work.

#Setting up automatic crontab downloads:
#To set up automatic downloads you will need to put this Line into your crontab using crontab -e
#* */3 * * * /root/yt-dlp/other/scripts/start-download.sh 1080p
#This will automaticly download your specified channels every 3 hours in 1080p quality

#name of the folder
Folder='yt-dlp-downloader/'

#the workingdir
Workingdir=$HOME/

#location of the start-download script
Start='other/scripts/start-download.sh';
Startdir=$Workingdir$Folder$Start

#location of the automated log file
View='other/logs/yt-dlp-automated.log';

#location of the specified channels list
Channels='other/config/channel-list.txt'

#location of the already downloaded videos
Downloaded='other/config/downloaded.txt'

#the resolution that you want to download the specified channels with.
#resolution can only be 480p, 720p, 1080p, 2160p, bv.
#bv stands for best video or best resolution
Resolution='1080p'

if ! command -v yt-dlp >/dev/null ; then
	echo "This script requires yt-dlp to be installed"
	echo ""
	apt install yt-dlp -y
fi

PS3='Please enter Download Option: '
options=("Download" "Start" "Stop" "View" "Edit" "Help" "Exit")
select opt in "${options[@]}"
do
    case $opt in
	"Download")
	    printf "%s\n" "" "Paste a youtube video link: " ""
	    read link
	    echo ""
	    PS3='Please enter Download Resolution: '
	    quality=("480p" "720p" "1080p" "2160p" "Best")
	    select opt2 in "${quality[@]}"
	    do
		case $opt2 in 
		     "480p")
		     			echo "Downloading $link in 480p"
						cd $Workingdir
						cd $Folder
						yt-dlp -i -o 'Downloads/manual-downloads/%(upload_date)s - %(title)s - (%(duration)ss) [%(resolution)s].%(ext)s' -f bv[height=480][ext=mp4]+ba[ext=m4a]/best[ext=mp4]/best $link
			break
		     	;;
		     "720p")
                        echo "Downloading $link in 720p"
						cd $Workingdir
						cd $Folder
						yt-dlp -i -o 'Downloads/manual-downloads/%(upload_date)s - %(title)s - (%(duration)ss) [%(resolution)s].%(ext)s' -f bv[height=720][ext=mp4]+ba[ext=m4a]/best[ext=mp4]/best $link
			break
		     	;;
		     "1080p")
                        echo "Downloading $link in 1080p"
						cd $Workingdir
						cd $Folder
						yt-dlp -i -o 'Downloads/manual-downloads/%(upload_date)s - %(title)s - (%(duration)ss) [%(resolution)s].%(ext)s' -f bv[height=1080][ext=mp4]+ba[ext=m4a]/best[ext=mp4]/best $link
		     	break
			;;
		     "2160p")
                        echo "Downloading $link in 2160p"
						cd $Workingdir
						cd $Folder
						yt-dlp -i -o 'Downloads/manual-downloads/%(upload_date)s - %(title)s - (%(duration)ss) [%(resolution)s].%(ext)s' -f bv[height=2160][ext=mp4]+ba[ext=m4a]/best[ext=mp4]/best $link
		     	break
			;;
		     "Best")
			echo "Downloading $link in Best Resolution possible"
						cd $Workingdir
						cd $Folder
						yt-dlp -i -o 'Downloads/manual-downloads/%(upload_date)s - %(title)s - (%(duration)ss) [%(resolution)s].%(ext)s' -f bv[ext=mp4]+ba[ext=m4a]/best[ext=mp4]/best $link
			break
			;;
		     *) echo "$REPLY is not an valid Resolution";;
		    esac
		done
	break
;;
    "Start")
        if [ -x $Workingdir$Folder$Start ]
        then
        :
        else
            cd $Workingdir
            cd $Folder
            chmod +x $Start
	    fi

        echo "Starting the download of the specified Channels"
	    echo "You can Edit the specified channels using the Edit option"
	    echo "You wont be able to see the progess in this window"
	    echo "but if you quit the download will stop"
	    echo ""
	    echo "to see the download progress use the "View" option"
	    /bin/bash $Startdir $Resolution
	    break 
        ;;
    "Stop")
        echo "Stopping running downloading process"
        echo "Be careful this will break your video if not fully downloaded"
	    killall -g start-download.sh
	    break
	    ;;
	"View")
        echo "View running and past downloading processes"
		cd $Workingdir
		cd $Folder
        tail -f $View
        break
	    ;;
	"Edit")
	    PS3='Please choose config you wanna edit: '
	    options3=("Channels" "Downloaded")
	    select opt3 in "${options3[@]}"
	    do
    		case $opt3 in
	    		"Channels")
				echo "Editing Channels"
				cd $Workingdir
				cd $Folder
				nano $Channels
				break
				;;
			"Downloaded")
				echo "Editing Downloaded"
				cd $Workingdir
				cd $Folder
				nano $Downloaded
				break
				;;
			*) echo "$REPLY is not an valid config";;
		       esac
		done
	break
;;
	"Help")
	    echo "Download:"
	    echo " Download is a function to manually download youtube videos"
	    echo "Start:"
	    echo " Start is a function to download the normally"
	    echo " automaticly downloaded channels manually."
	    echo "Stop:"
	    echo " Stop is a function to stop every currently running download."
	    echo " Be careful this will break not fully downloaded videos."
	    echo "View:"
	    echo " View is a function to view the log file and"
	    echo " track the progress of automated download."
	    echo "Edit:"
	    echo " Edit is a function to Edit the config files."
	    echo " The Channels Config is the config for the specified"
	    echo " channels that are automaticly getting downloaded."
	    echo " The Downloaded Config is the archive file for the"
	    echo " already automaticly downloaded videos."
	    ;;
    "Exit")
        break
        ;;
    *) echo "$REPLY is not an valid option";;
    esac
done