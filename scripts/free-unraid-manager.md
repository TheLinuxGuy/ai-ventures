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
Create a Python CLI script `free-unraid.py` that manages physical hard drives and logical storage configurations on Linux systems. The script integrates with bcache and the [nonraid project](https://github.com/qvr/nonraid).

## Core Architecture

### Command Line Interface
- **Required**: At least one positional argument
- **Core commands**: `show`, `configure`, `reset`
- **Global flags**:
  - `-v, --verbose`: Enable detailed output for debugging (default: disabled)
  - `-y, --yes`: Auto-approve destructive operations (configure mode only)

### System Discovery and Data Structure
Implement a system-wide discovery function that scans and stores all disk information in a dictionary structure for use across all commands:

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
            "type": "DATA"
        }
    }
}
```

### Dependency Management
Implement a `dependency_check()` function that validates required system tools. Update this list as new functionality requires additional dependencies:

**Initial dependencies**:
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
Automated disk configuration workflow with user interaction:

**Workflow per disk**:
1. **Bcache Setup**: `make-bcache -B /dev/sda`
   - Creates new `/dev/bcacheN` device
   - Updates system dictionary with bcache paths

2. **Partitioning**: `sgdisk -o -a 8 -n 1:32K:0 /dev/bcache0`
   - Creates single partition on bcache device

3. **Size Calculation**: 
   ```python
   def calculate_nmdcmd_size(device_path):
       """
       Calculate partition size for nonraid import command.
       
       Process:
       - Verify device exists and is valid block device
       - Get total sectors using: blockdev --getsz
       - Round down to nearest multiple of 8 sectors
       - Convert to KB (divide by 2, since 2 sectors = 1KB)
       - Return size in KB or error code
       """
   ```

4. **Nonraid Configuration**:
   - Interactive prompts (unless CLI args provided):
     - "Will this disk be used for DATA storage? (y/n)"
       - If **No**: "Will this disk be primary parity (slot 0)? (y/n/quit)"
         - Yes → slot = 0
         - No → slot = 29  
       - If **Yes**: "Select data disk slot (1-28):" (validate integer input)
   
   - Generate nonraid import command:
     ```
     import {slot} {part_path} 0 {part_size} 0 {bcache_by_id}
     ```

5. **Multi-disk Support**: Ask user if additional disks need configuration

**Safety Features**:
- Always prompt before destructive operations
- Use `-y` flag to bypass prompts for automation
- Validate all user inputs
- Verify device existence before operations

### RESET Command
*[Implementation details to be defined based on requirements]*

## Implementation Guidelines

### Error Handling
- Validate all external command executions
- Provide clear error messages with suggested solutions
- Graceful handling of missing dependencies

### Verbose Mode
- Log all external command executions
- Show intermediate results and calculations
- Display decision trees and user input validation

### Code Organization
- Modular functions for each major operation
- Separate classes/modules for disk discovery, bcache management, nonraid integration
- Configuration validation functions
- Comprehensive logging framework

### Testing Considerations
- Mock external commands for unit testing
- Validate against various disk configurations
- Test error conditions and edge cases
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
