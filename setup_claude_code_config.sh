#!/bin/bash

# Claude dotfiles setup script
# This script creates symbolic links for .claude/ directory

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"

# Source and target paths
SOURCE_CLAUDE_DIR="$DOTFILES_DIR/.claude"
TARGET_CLAUDE_DIR="$HOME/.claude"

print_status "Starting Claude dotfiles setup..."
print_status "Dotfiles directory: $DOTFILES_DIR"
print_status "Source: $SOURCE_CLAUDE_DIR"
print_status "Target: $TARGET_CLAUDE_DIR"

# Check if source .claude directory exists
if [ ! -d "$SOURCE_CLAUDE_DIR" ]; then
    print_error "Source directory $SOURCE_CLAUDE_DIR does not exist!"
    exit 1
fi

# Function to backup existing directory/file
backup_existing() {
    local target="$1"
    local backup_name="${target}.backup.$(date +%Y%m%d_%H%M%S)"

    if [ -e "$target" ]; then
        print_warning "Existing $target found. Creating backup..."
        mv "$target" "$backup_name"
        print_success "Backup created: $backup_name"
    fi
}

# Function to create symbolic link
create_symlink() {
    local source="$1"
    local target="$2"

    # Create parent directory if it doesn't exist
    local parent_dir="$(dirname "$target")"
    if [ ! -d "$parent_dir" ]; then
        mkdir -p "$parent_dir"
        print_status "Created parent directory: $parent_dir"
    fi

    # Backup existing file/directory if it exists
    backup_existing "$target"

    # Create symbolic link
    ln -sf "$source" "$target"
    print_success "Created symbolic link: $target -> $source"
}

# Main setup function
setup_claude_dotfiles() {
    print_status "Setting up .claude/ directory..."

    # Create symbolic link for .claude directory
    create_symlink "$SOURCE_CLAUDE_DIR" "$TARGET_CLAUDE_DIR"

    # Verify the symbolic link
    if [ -L "$TARGET_CLAUDE_DIR" ] && [ -d "$TARGET_CLAUDE_DIR" ]; then
        print_success "Successfully created symbolic link for .claude/"
        print_status "Link verification: $(ls -la "$TARGET_CLAUDE_DIR")"
    else
        print_error "Failed to create symbolic link for .claude/"
        exit 1
    fi
}

# Function to show help
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -v, --verify   Verify existing symbolic links"
    echo "  -r, --restore  Restore from backup (interactive)"
    echo ""
    echo "This script creates symbolic links for .claude/ directory from your dotfiles."
}

# Function to verify existing links
verify_links() {
    print_status "Verifying Claude dotfiles links..."

    if [ -L "$TARGET_CLAUDE_DIR" ]; then
        local link_target="$(readlink "$TARGET_CLAUDE_DIR")"
        if [ "$link_target" = "$SOURCE_CLAUDE_DIR" ]; then
            print_success ".claude/ is correctly linked to $SOURCE_CLAUDE_DIR"
        else
            print_warning ".claude/ is linked to $link_target (expected: $SOURCE_CLAUDE_DIR)"
        fi
    elif [ -d "$TARGET_CLAUDE_DIR" ]; then
        print_warning ".claude/ exists but is not a symbolic link"
    else
        print_error ".claude/ does not exist"
    fi
}

# Function to restore from backup
restore_from_backup() {
    print_status "Available backups:"
    local backups=("$HOME"/.claude.backup.*)

    if [ ${#backups[@]} -eq 1 ] && [ ! -e "${backups[0]}" ]; then
        print_error "No backups found"
        return 1
    fi

    local i=1
    for backup in "${backups[@]}"; do
        if [ -e "$backup" ]; then
            echo "$i) $(basename "$backup")"
            ((i++))
        fi
    done

    echo -n "Select backup to restore (1-$((i-1)), or 'q' to quit): "
    read -r choice

    if [ "$choice" = "q" ]; then
        print_status "Restore cancelled"
        return 0
    fi

    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -lt "$i" ]; then
        local selected_backup="${backups[$((choice-1))]}"
        print_status "Restoring from $selected_backup..."

        # Remove current symlink/directory
        rm -rf "$TARGET_CLAUDE_DIR"

        # Restore backup
        mv "$selected_backup" "$TARGET_CLAUDE_DIR"
        print_success "Restored from backup: $selected_backup"
    else
        print_error "Invalid selection"
        return 1
    fi
}

# Parse command line arguments
case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    -v|--verify)
        verify_links
        exit 0
        ;;
    -r|--restore)
        restore_from_backup
        exit 0
        ;;
    "")
        # No arguments, proceed with setup
        ;;
    *)
        print_error "Unknown option: $1"
        show_help
        exit 1
        ;;
esac

# Main execution
print_status "Claude dotfiles setup starting..."
setup_claude_dotfiles
print_success "Claude dotfiles setup completed!"

# Show final status
echo ""
print_status "Final verification:"
verify_links
