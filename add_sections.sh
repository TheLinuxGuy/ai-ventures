#!/bin/bash

# List of files that need standard sections added
files=(
"2.2.story.md"
"2.3.story.md"  
"2.4.story.md"
"2.5.story.md"
"3.1.story.md"
"3.2.story.md"
"3.3.story.md"
"3.4.story.md"
"3.5.story.md"
"4.1.story.md"
"4.2.story.md"
"4.3.story.md"
"5.1.story.md"
"5.2.story.md"
"5.3.story.md"
)

# Standard sections to append
sections='

## File List

*To be populated during implementation*

## Dev Agent Record

### Implementation Notes
*To be populated during development*

### Completion Notes
*To be populated upon completion*

### Debug Log References
*To be populated if debugging required*

## QA Results

*To be populated during QA review*'

cd /Users/gfm/Library/CloudStorage/SynologyDrive-home/GitHub/ai-ventures/MediaMogul/docs/stories

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        # Check if file already has "## File List" section
        if ! grep -q "## File List" "$file"; then
            echo "Adding standard sections to $file"
            echo "$sections" >> "$file"
        else
            echo "Skipping $file - already has sections"
        fi
    fi
done
