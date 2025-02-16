# AutoEmptyTorrentCleaner 🗑️
AutoEmptyTorrentCleaner is a script that removes empty torrents (0 bytes) from Qbittorrent Web UI and refreshes Sonarr to prevent import issues.

##Reason for this script
For the past month, I have encountered an issue when it came to TV shows. There have been torrents that have been published a week before the actual show episode release, and they were releasing a .lnk file. Sonarr would get stuck on trying to import this unknown file type.


##Requirements
- Qbittorent
- Sonar
- Linux

## Features
- Deletes empty torrents from Qbittorrent
- Refreshes the Sonarr queue
- Triggers a Sonarr rescan to clean up missing files

##Setup
1. In your Qbittorent installation, in the settings menu, make sure you set up the file types you don't want downloaded. You go in the download tab and set up "Excluded file names"
   I have the following inputs setup
   ```
   *.txt
   *.jpg
   *.png
   *.lnk
   *.nfo
   ```
   ![image](https://github.com/user-attachments/assets/1a58b277-5a16-46dc-a8ad-590cef0ab43f)
2. Clone this repo and change directory:  
   ```
   git clone https://github.com/YOUR_GITHUB_USERNAME/AutoTorrentCleaner.git
   cd AutoTorrentCleaner
   ```
3. Set up the script
   ```nano AutoEmptyTorrentCleaner.sh```
Change the following on top of the script. Make sure to add the correct ip address. (If you are using docker, you can use `172.17.0.1` or `localhost` as the IP address). Make sure the API key and username and password are correct
```
QB_URL="http://localhost:8080"
QB_USER="USERNAME"
QB_PASS="PASSWORD"
COOKIE_FILE="/tmp/qb_cookie"
SONARR_URL="http://172.17.0.1:8989"
SONARR_API_KEY="APIKEY"
```
4. Make sure the file is executeable
   ```chmod +x AutoEmptyTorrentCleaner.sh```
5. Run Script to make sure it works.
   ```./AutoEmptyTorrentCleaner.sh```
6. (Optional) Add it to cron for automatic execution:
   ```sudo crontab -e```
   Then add this to the bottom to run every 60 minutes. (You can change the interval to what you want.) Make sure you put the correct path, otherwise it won't work
```*/60 * * * * /path/to/AutoTorrentCleaner/remove_empty_torrents.sh```
7. Thats it! Feel free to make an issue, if you have any issues.
