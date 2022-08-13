
Setting up automatic crontab downloads:

To set up automatic downloads you will need to put this Line into your crontab using crontab -e
"* */3 * * * /root/yt-dlp/other/scripts/start-download.sh 1080p"
This will automaticly download your specified channels every 3 hours in 1080p quality.
If the folder isn't located in the root directory you will have to adjust that


Other settings can be found in download.sh
