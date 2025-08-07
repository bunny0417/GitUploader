# Git Uploader 

A beginner-friendly Windows batch script to quickly upload all files from a local folder to a specified Git repository and branch. Designed for simplicity, with helpful prompts, logging, and basic Git checks.

## Features

* **Git Check**: Verifies if Git is installed; provides an error message and link if not.
* **Working Directory Prompt**: Asks for the folder path and validates its existence.
* **Branch Selection**: Allows specifying a branch name (defaults to `main`).
* **Optional .gitignore**: Offers to generate a basic `.gitignore` file for compiled artifacts.
* **Repository Initialization**: Initializes a Git repo if one doesn’t exist, or uses the existing one.
* **Remote Setup**: Prompts for an SSH/HTTPS repository URL, replaces any existing origin.
* **Pull & Rebase**: Fetches and rebases the latest from the target branch to avoid merge conflicts.
* **Staging & Commit**: Stages all files, asks for a commit message, and commits changes.
* **Push to Remote**: Pushes to the specified branch and sets the upstream.
* **Colored Prompts**: Uses green text for user inputs for better visibility.
* **Logging**: Appends timestamps and key actions to `git_uploader.log` in the script’s directory.

## Usage

1. **Save** the script (`upload_to_github.bat`) on your machine.
2. **Double-click** `upload_to_github.bat` or run it from a Command Prompt.
3. Follow the on-screen prompts:

   * Enter the folder path to upload.
   * (Optional) Create a `.gitignore`.
   * Specify the branch (or press Enter for `main`).
   * Provide the Git repository URL.
   * Enter a commit message (or press Enter for the default).
4. The script will:

   * Initialize or verify the repository.
   * Pull the latest changes.
   * Stage and commit your files.
   * Push to the remote branch.
5. Check `git_uploader.log` for a detailed log of actions.

## Requirements

* Windows environment with Command Prompt.
* [Git for Windows](https://git-scm.com/) installed and added to `PATH`.

---

*Script maintained by BUNNY0417.*
