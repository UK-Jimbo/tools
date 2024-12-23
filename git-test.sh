git_branch_status() {
        if git rev-parse --is-inside-work-tree &>/dev/null; then
            # Get the status of the Git repo (staged, modified, untracked)
            status=$(git status --short | awk 'NF')
            echo "$status"

            # Check for staged, modified, and untracked files
            staged_count=$(echo "$status" | grep -c '^[AM]')  # Count staged changes
            modified_count=$(echo "$status" | grep -c '^[^AM?]')  # Count modified, but not staged
            untracked_count=$(echo "$status" | grep -c '^\?\?')  # Count untracked files

            echo "$staged_count"
            echo "$modified_count"
            echo "$untracked_count"
            echo "x"

            echo '\[\033[0;32m\]'
            # Determine color based on status
            # if [ $untracked_count -gt 0 ]; then
            #     echo '\[\033[0;31m\]'  # Red for untracked files
            # elif [ $staged_count -gt 0 ] || [ $modified_count -gt 0 ]; then
            #     echo '\[\033[0;33m\]'  # Yellow for staged or modified files
            # else
            #     echo '\[\033[0;32m\]'  # Green for no changes
            # fi
        fi
    }

git_branch_status