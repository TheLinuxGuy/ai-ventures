# Free Unraid Manager

- Goal: all-in-one configuration tool for managing bcache, noraid array and partitions.
- Date: 2025-10-04
- Model: <e.g., gpt-4o mini>  | Version: <if known>
- Env/OS: macOS
- Inputs/Context: [free-unraid](https://github.com/TheLinuxGuy/free-unraid)

## Prompt
<prompt>

# Python Script Requirements: free-unraid.py

## Overview

Create a Python CLI script `free-unraid.py` that manages physical hard drives and logical storage configurations on Linux systems. The script integrates with **bcache** and the [nonraid project](https://github.com/qvr/nonraid).

## Core Architecture

### Command Line Interface

- **Usage**: `./free-unraid.py <command> [options]`
- **Core commands**:
    - `show`
    - `configure`
    - `reset`
- **Global flags**:
    - `-v, --verbose`: Enable detailed output for debugging (default: disabled)
    - `-y, --yes`: Auto-approve destructive operations (configure mode only)


### System Discovery and Data Structure

Implement a discovery function that scans and stores all disk information in a nested dictionary for use by all commands:

```python
system = {
    "/dev/sda": {
        "raw_disk_size": "18TB",
        "disk_model": "WD140EDFZ",
        "disk_serial": "QBJ2NRVT",
        "disk_path": "/dev/sda",
        "disk_smart_status": "HEALTHY",
        "disk_hours": 8760,
        "ata_slot": "ata1.00",
        "partitions": [],
        "bcache": {
            "device": "/dev/bcache0",
            "by_id": "/dev/disk/by-id/bcache-WDC_WD140EDFZ-11A0VA0-QBJ2NRVT"
        },
        "nonraid_config": {
            "slot": 1,
            "part_path": "/dev/bcache0p1",
            "part_size": 27344764815,
            "type": "DATA",
            "import_cmd": "echo \"import 1 /dev/bcache0p1 0 27344764815 0 bcache-WDC_WD140EDFZ-11A0VA0-QBJ2NRVT\" > /proc/nmdcmd"
        }
    }
}
```


### Dependency Management

Implement a `dependency_check()` function to validate required system tools. Update this list as new functionality adds dependencies:

- `parted` (partition management)
- `sgdisk` (GPT partitioning)
- `make-bcache` (bcache creation)
- `blockdev` (device information)
- `smartctl` (SMART status)


## Command Implementations

### SHOW Command

Display comprehensive system storage information:

**Output format**:

- Timestamp
- Hostname
- For each physical disk:
    - Disk path (e.g., `/dev/sda`)
    - All partitions and filesystems
    - Bcache mapping (if configured)
    - Nonraid array membership
    - SMART health status
    - Power-on hours
    - Physical ATA/SATA slot mapping


### CONFIGURE Command

Automated disk configuration workflow with user interaction and a final commit step:

1. **Bcache Setup**
    - Command: `make-bcache -B /dev/sda`
    - Updates `system[disk]["bcache"]` with new `/dev/bcacheN` device and by-id path
2. **Partitioning**
    - Command: `sgdisk -o -a 8 -n 1:32K:0 /dev/bcache0`
3. **Size Calculation**

```python
def calculate_nmdcmd_size(device_path):
    """
    Calculate partition size for nonraid import command.
    Steps:
    1. Verify block device exists
    2. Get sector count: blockdev --getsz
    3. Round down to nearest multiple of 8 sectors
    4. Convert to KB (sectors / 2)
    5. Return size in KB or error code
    """
```

4. **Nonraid Configuration**
    - Prompt: “Will this disk be used for DATA storage? (y/n)”
        - If “n”: Prompt “Primary parity (slot 0)? (y/n/quit)”
            - Yes → slot = 0
            - No → slot = 29
        - If “y”: Prompt “Select data disk slot (1–28):” (validate integer)
    - Store `slot`, `part_path`, `part_size`, `type`, and build `import_cmd`
5. **Multi-disk Loop**
    - After configuring one disk, prompt: “Configure additional disks? (y/n)”
6. **Final Commit Step**
    - Prompt: “Commit configuration and exit? (y/n)”
        - If **y**:
            - Loop through each disk with `nonraid_config.import_cmd`
            - Execute its `import_cmd` (e.g.,
`echo "import 1 /dev/bcache0p1 0 27344764815 0 bcache-WDC_WD140EDFZ-11A0VA0-QBJ2NRVT" > /proc/nmdcmd`)
            - In verbose mode, print each command and its exit status
        - If **n**:
            - Discard pending commands and quit without changes

**Safety Features**

- Always prompt before destructive operations unless `-y` is used
- Validate device existence before execution


### RESET Command

*[Implementation details to be defined]*

## Implementation Guidelines

- **Error Handling**: Check exit codes of all external commands and provide clear error messages.
- **Verbose Mode**: Log every external command, its parameters, exit status, and intermediate data.
- **Modular Code**: Organize into separate modules for discovery, bcache management, nonraid logic, and CLI parsing.
- **Testing**: Mock external commands for unit tests; validate workflows on diverse disk configurations; cover error conditions and edge cases.

</prompt>

## Acceptance Criteria
- [ ] Script is able to detect physical hard drives and all logical configurations (partitions, bcache, noraid, filesystems, etc)
- [ ] Script can be used to wipe hard disks and configure new disks without any partitions or bcache configurations. 
- [ ] A global verbose flag should exist to output what the script may be doing on the background and for debugging purposes. 
- [ ] Primary functionality should be: SHOW, CONFIGURE, RESET.

## Expected Artifacts
- <script path and name>
- <config files, if any>

## Changelog / History
- <YYYY-MM-DD> — v<version or increment> — <short summary of change>
  - Model: <name> | Version: <if known> | Temperature: <if used>
  - Changes: <what changed in the prompt/context>
  - Impact/Notes: <behavior differences, validation notes, risks>
