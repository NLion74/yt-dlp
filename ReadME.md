This Script won't work if its not in the /root folder.

Setting up automatic crontab downloads:

To set up automatic downloads you will need to put this Line into your crontab using crontab -e
"* */3 * * * /root/yt-dlp/other/scripts/start-download.sh 1080p"
This will automaticly download your specified channels every 3 hours in 1080p quality.

Other settings can be found in download.sh