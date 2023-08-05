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

if the commit message you are using has no spaces ie its one word, then there is no need for quotes you can type

```
push commit
```

If you are in a hurry and do not want to keep writing the commit message just type

```
push
```

and the program will write the files affected and timestamp.

If the files edited, created and deleted are many,
the message will be clipped at 72 characters to meet [github commit message length requirement](https://www.gitkraken.com/learn/git/best-practices/git-commit-message#git-commit-message-structure).

**Note:** **__Kindly use a helpful commit message to help your team track the changes.__**
**__This feature is only added for when there is time limitations, otherwise try and use helpful commit messages.__**

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

If you get the following error or similar messgae while running the script

```
bash: ./install.sh: Permission denied
```
**DO NOT** run it with super user access ```~~su~~``` just run the command above to make it executable

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

