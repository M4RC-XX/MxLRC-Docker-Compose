# MxLRC Docker-Compose on Raspberry Pi (ARM64)

This repository provides a simple way to run [mxlrc](https://github.com/fashni/MxLRC) a command-line tool for downloading .lrc lyric files from [Musixmatch](https://www.musixmatch.com/), inside a Docker container. The setup is optimized for use on a Raspberry Pi (ARM64).

## Configuration

Adapt the following `docker-compose.yml` to your needs.

```
services:
  mxlrc:
    container_name: mxlrc
    image: ghcr.io/m4rc-xx/mxlrc:latest
    restart: 'no'

    # --- Volumes ---
    # This is where the user's local music directory is "mounted" into the container.
    # The user needs to adjust the path on the left to their actual path.
    volumes:
      - /media/pi/Harddrive/Music::/music # Example: Mounts a 'music' folder from the current directory

    environment:
      # The user's personal Musixmatch token
      - MX_TOKEN= #Musixmatch Usertoken

      # The directory inside the container to be scanned.
      # Must match the target path in the "volumes" section.
      - MUSIC_DIR=/music

      # Time in seconds to wait between individual downloads.
      - SLEEP_TIME=15

      # Set to "true" to overwrite existing .lrc files.
      # Otherwise, set to "false".
      - UPDATE_FILES=false
```

### Explanation of Configuration Options

#### `volumes`

-   `- /path/to/your/music:/music`
    
    -   **Left Side:** Replace `/path/to/your/music` with the absolute path to the music folder on your host system (e.g., `/media/pi/Toshiba/Musik/Rap/Interpreten`).
        
    -   **Right Side:**  `/music` is the path inside the container. This should not be changed.
        

#### `environment`

-   `MX_TOKEN`: **(Required)** Insert your personal Musixmatch token here. Instructions on how to get one can be found [here](https://spicetify.app/docs/faq#sometimes-popup-lyrics-andor-lyrics-plus-seem-to-not-work "null").
    
-   `MUSIC_DIR`: The directory _inside_ the container that will be scanned. Must match the target path of the volume (`/music`).
    
-   `SLEEP_TIME`: The pause in seconds between each API request to avoid overloading the Musixmatch servers. The default is `15`.
    
-   `UPDATE_FILES`: Set this value to `true` if you want existing `.lrc` files to be downloaded again and overwritten.   

## Credits

This project is a Docker wrapper for the excellent `mxlrc` tool. All credits for the actual functionality go to the original developer.

-   **Original mxlrc Repository:**  [github.com/fashni/MxLRC](https://github.com/fashni/MxLRC "null")
-   **Spicetify Lyrics Plus:** [github.com/spicetify/spicetify-cli](https://github.com/spicetify/spicetify-cli/tree/master/CustomApps/lyrics-plus "null")
