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
2. Set up the script
