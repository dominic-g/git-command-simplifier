# Git Command Simplifier

This program provides a streamlined approach to interacting with Git repositories, reducing the need for repetitive typing of tokens and usernames during common Git operations. By utilizing this program, you can save time and enhance your development workflow.

## Features

1. **Efficient Commit and Push:**

   Instead of the usual sequence of commands:
   
```bash
git add .
git commit -m "commit message"
git push
```

You can simply use:

```bash
push "commit message" (optional)
```

If no commit message is provided, a message is automatically generated based on file changes.

2. **Cloning Repositories:**

Instead of writing:

```bash
git clone https://{token}@github.com/{username}/{repository}
```

You can use:

```bash
clone repository_name
```

3. **Pulling Changes:**

Replace ``` `git pull` ``` with:

```
pull
```

4. **Easy Token and Username Update:**

To update your token and username for different accounts/repositories, simply run:

```
github_token
```

This command will prompt you to enter the new token and username, making it easy to switch between different credentials.

## Installation

1. Clone the repository or download the files.

2. Navigate to the repository directory.

3. Ensure `install.sh` script is executable if not run:

```
chmod +x install.sh
```

4. Install the `expect` package (if not already installed):

```
sudo apt-get install expect -y
```

5. Run the installation script:

```
./install.sh
```

If the installation fails due to permissions, ensure the script is executable as mentioned in step 3.

## Usage

Once installed, you can start using the simplified commands immediately:

- Push changes:

```
push "commit message" (optional)
```

- Clone a repository:

```
clone repository_name
```

- Pull changes:

```
pull
```

- Update token and username:

```
github_token
```

## Benefits

By using the Git Command Simplifier, you'll experience:

- Reduced development time by eliminating repetitive token and username entries.
- Enhanced security as your details are stored safely.
- Quick switching between different accounts and repositories.

Feel free to tailor this tool to your workflow and enjoy a more efficient Git experience!

---

**Note:** This tool requires the `expect` package. If you encounter issues during installation or usage, ensure that `expect` is properly installed.

