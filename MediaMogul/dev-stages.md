# AI development changelog

This page lists a changelog on how and what I have tried to do, while evolving the codebase. Useful for future retrospectives and lessons learned. 
* Others may benefit from reading through my experience and history.

## Overview
- STEP 1: `docs/` are defined and created.
- STEP 2: `stories/` are created and refined through iterations with AI model.

## Stage 1: SPEC development
- Model used and interface: `gemini-2.5pro` via gemini.google.com UI using `gems` configured with 
  
After setting up BMAD on the projects respository, we need to create the PRD files and related documentation before starting to build anything. 

### Prompt: Define the Product Requirements

We're going to build project 'MediaMogul' a web based application to help manage and monitor files/media/disks on users servers where they have many independent hard disks in different mount points (e.g: /mnt/hdd/disk1 ... /mnt/hdd/disk2). These are the primary features and capabilities that our users will depend on: 

(1) Planning and migrating data between different disks using `rsync` to ensure certain folder hierarchies are stored together on the same disk, or if the user choses to manually scatter certain folders amongst any selected disks the tool will help them plan and forecast how much disk space will be freed once the data is moved away from the current source disk and how much disk space will be left at the new destination disk.
  *   Users should be able to select individual files, or folders within a hierarchy and be able to select which disk they wish to move the data to, our tool will do some 'planning checks' and present the user with a data migration proposal the user must accept to schedule the data migration tasks. The majority of data migrations are expected to maintain the data hierarchy, unless overriden by the user which explicitly accepted to break the hierarchy and move the files to a different folder location in any of the available disks (including the source). 
      *   Example migration of `/mnt/hdd/disk1/tv/Foundation (2021)/Season 1/S01E01.mkv` to `/mnt/ssd/disk1/tv/Foundation (2021)/Season 1/S01E01.mkv` our tool should check its own database of previous crawls of `/mnt/ssd/disk1` to check if the `tv/Foundation (2021)/Season 1/` path exist in full, or partially. The program should by default always suggest the user to move files to other disks that may contain the other `tv/Foundation (2021)/Season 1/` paths and data already so that information stays together in the same physical disk, but users should be able to override this recommendation in UI during planning. If `/mnt/ssd/disk1` does not have any `tv/Foundation (2021)/Season 1/` under its path but `/mnt/ssd/disk7` has `tv/Foundation (2021)/Season 1/` then our app should propose the user to move their data to disk7 instead after ensuring that there is enough disk space free on disk7 for the data migration of the selected files.
  *   File and folder migrations should be a scheduled task stored in a database table 'tasks'

(2) File monitoring and history changelog. Our application will scan all of the disks and paths the user has configured for the tool to monitor. It will be able to track all of the files and folders essential metadata, as well as its changes overtime allowing our users to view how their media files and folders may have changed overtime. 

This feature needs to automatically detect and consider any 'created', 'modified', 'deleted', 'moved' actions then store it in a database. Both folders and individual files should be tracked in terms of its unique signatures like MD5 but also some media metadata (fetched using [MediaInfo](https://mediaarea.net/en/MediaInfo)). 
  * For files, we should store the MD5 signature of them when they are first discovered by our application, then we should implement some smart logic to decide if the MD5sum should be recalculated later or not.
  * MD5 calculations should be a scheduled task stored in a database table 'tasks' - it might be possible to obtain the MD5 signature of a file during `rsync` migration operations, but there may be cases where we need to calculate a MD5 signature without a data migration. The program should handle these conditions.
  * Users should be able to view a specific folder path in our web UI (e.g: `/mnt/hdd/disk1/tv/Foundation (2021)/Season 1/`) and we should be able to display a history of information we have on changes to files and folders under this path.
  * Our application should leverage [MediaInfo](https://mediaarea.net/en/MediaInfo) libraries and binary to analize important metadata from discovered files. 
    * MediaInfo queries should be a scheduled task stored in a database table 'tasks'
    * A MediaInfo query is executed like this: `./mediainfo --Output=JSON ~/Downloads/Solomun\ WE2\ ｜\ Tomorrowland\ 2025.mp4` which then outputs this JSON data that our program should then selectively pick certain fields from the output and store in our database. Example output:
    ```
    {
    "creatingLibrary":{"name":"MediaInfoLib","version":"25.07","url":"https://mediaarea.net/MediaInfo"},
    "media":{"@ref":"/Users/gfm/Downloads/Solomun WE2 ｜ Tomorrowland 2025.mp4","track":[{"@type":"General","VideoCount":"1",
    "AudioCount":"1",
    "FileExtension":"mp4",
    "Format":"MPEG-4",
    "Format_Profile":"Base Media",
    "CodecID":"isom",
    "CodecID_Compatible":"isom/iso2/mp41",
    "FileSize":"13616342725",
    "Duration":"8573.876",
    "OverallBitRate":"12704959",
    "FrameRate":"50.000",
    "FrameCount":"428691",
    "StreamSize":"10534436",
    "HeaderSize":"10534420",
    "DataSize":"13605808305",
    "FooterSize":"0",
    "IsStreamable":"Yes",
    "File_Modified_Date":"2025-07-30 17:37:31 UTC",
    "File_Modified_Date_Local":"2025-07-30 13:37:31",
    "Encoded_Application":"Lavf60.16.100"},{"@type":"Video","StreamOrder":"0",
    "ID":"1",
    "Format":"VP9",
    "CodecID":"vp09",
    "Duration":"8573.820",
    "BitRate":"12567212",
    "Width":"3840",
    "Height":"2160",
    "PixelAspectRatio":"1.000",
    "DisplayAspectRatio":"1.778",
    "Rotation":"0.000",
    "FrameRate_Mode":"CFR",
    "FrameRate":"50.000",
    "FrameRate_Num":"50",
    "FrameRate_Den":"1",
    "FrameCount":"428691",
    "ColorSpace":"YUV",
    "ChromaSubsampling":"4:2:0",
    "StreamSize":"13468626175",
    "Title":"ISO Media file produced by Google Inc. Created on: 07/30/2025.",
    "colour_description_present":"Yes",
    "colour_description_present_Source":"Container",
    "colour_range":"Limited",
    "colour_range_Source":"Container",
    "colour_primaries":"BT.709",
    "colour_primaries_Source":"Container",
    "transfer_characteristics":"BT.709",
    "transfer_characteristics_Source":"Container",
    "matrix_coefficients":"BT.709",
    "matrix_coefficients_Source":"Container"},{"@type":"Audio","StreamOrder":"1",
    "ID":"2",
    "Format":"AAC",
    "Format_AdditionalFeatures":"LC",
    "CodecID":"mp4a-40-2",
    "Duration":"8573.876",
    "BitRate_Mode":"CBR",
    "BitRate":"128000",
    "Channels":"2",
    "ChannelPositions":"Front: L R",
    "ChannelLayout":"L R",
    "SamplesPerFrame":"1024",
    "SamplingRate":"44100",
    "SamplingCount":"378107932",
    "FrameRate":"43.066",
    "FrameCount":"369246",
    "Compression_Mode":"Lossy",
    "StreamSize":"137182114",
    "Title":"ISO Media file produced by Google Inc.",
    "Language":"en",
    "Default":"Yes",
    "AlternateGroup":"1"}]}
    }
    ```
  * If a file has been renamed, our UI should make it easy for our users to know the file has been renamed but data kept the same (MD5). Likewise, if the same file name has been replaced with a different file (in-place) and there was a prior record of this same filename, our UI should highlight this and flag the new MD5 as a replacement of an original entry in our changelog history table. 
    * When a file is replaced in-place with the same naming, our reporting table tracking the current file MD5 should calculate and store in our file tracking:
      * Did the video codec of the file change between previous and its current version? Example we should report if '720p version was upgraded to 1080p' and so on.
      * Did the audio codec of the file change between previous and its current version? Similar to the previous case but for audio.
      * What was the disk space usage delta change between file versions (current and prior)? e.g: 'Increased by 711.22MB' or 'Decreased by 1.21GB'
  * There should be a history entry record if some data was moved from one disk to another. The UI history log should display when and what happened as users may use our tool to schedule and complete data migrations. These records should be highlighted in a different color tone than others to highlight to our users that those changes were made using our tool, since data could have been changed outside of our tool by other applications. 
  * Our monitoring system should be capable to integrate with [Sonarr](https://sonarr.tv/) and [Radarr](https://radarr.tv/) applications via its API. If the user has these enabled and the file is tracked by both our application and theirs, we should:
    * Tag files and folders in our database with application name ('Sonarr', 'Radarr') so we display to our users our tools are seeing the same data.
    * Keep in mind that these third party applications may have a unified folder path prefix that does not indicate which physical disk the data is actually stored on, as an example Sonarr might have `/downloads/tv/Foundation (2021)/Season 1/S01E01.mkv` in its database while our tool knows the actual file path is `/mnt/hdd/disk1/tv/Foundation (2021)/Season 1/S01E01.mkv` and it may change if a user schedules a migration our tool will execute in the background. We should have a configuration option to allow users to provide path prefixes that should be handled if these conditions ocurr. 

(3) System overview and status. The frontpage of our application will give our users a quick summary of their disks and data stored on the system (the disks and paths being monitored).

This dashboard page will show information such as:
- aggregate view of system free and used disk space amongst all storage disks.
- individual disk or mount point view (how much free disk space does each mountpoint or disk has at this time)
- An indicator of if the physical disk is currently sleeping (spun-down) or if the disk may be actively being used or read from, if the disk is active in use, the user should be shown some real-time activity metrics such as MB/s and IOPS for active disks.
- If the user ended up scheduling data migration, MD5 calculation or MediaInfo queries on files they should be shown the current executing `tasks` on each disk and the list of pending tasks to be executed once existing `tasks` are completed. Our application should have a `task` manager to manage the execution queue and verify jobs are completed before starting working on the next queued `task`.

The users of our application are single users running their own server media server at home, these kind of users focus on low-power consumption. Therefore our application should make sure to not wake up hard drives that may be `spun-down` or in a low power mode state unless the user has explicitly used our application to request and execute data migrations or other tasks. 
  *   This is the reason why our program should have its own database of files and metadata, so that planning activities carried out in our web interface do not require reading data from disks until its absolutely necessary for a task. (golang should have a method to detect if new files were added or modified in the system by other applications - in those cases we should opportunistically read data to execute tasks if the hard disks are already awake due to other processes).

Our application should be written mostly in Golang for the backend and the frontend should inclue the use of modern frameworks with nice looking UI elements like shadcn. There are dependencies on [rsync](https://linux.die.net/man/1/rsync), [MediaInfo](https://mediaarea.net/en/MediaInfo), [smartctl](https://linux.die.net/man/8/smartctl) binaries which must be present in the system as a pre-requisite for certain actions. 

Our application will be open-source, we will use github.com actions to automatically package and distribute docker containers with our application and its dependencies. Our users should only be required to download and run our docker container with appropriate settings to map their disks and gain capabilities offered by our app. Since this tool will be free, our application web interface as well as our github repository should remind users to donate to the developer @TheLinuxGuy via buymeacoffee.com/TheLinuxGuy

## Stage 2: Generated plans (prd, etc)

After following the framework instructions, we should now have the following files.
-   `docs/architecture.md`
-   `docs/front-end-spec.md`
-   `docs/prd.md`

