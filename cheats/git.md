###Everyday Git in twenty commands or so
```
git help everyday
```

###Show helpful guides that come with Git
```
git help -g
```

###Search change by content
```
git log -S'<a term in the source>'
```

###Show changes over time for specific file
```
git log -p <file_name>
```

###Remove sensitive data from history, after a push
```
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch <path-to-your-file>' --prune-empty --tag-name-filter cat -- --all && git push origin --force --all
```

###Sync with remote, overwrite local changes
```
git fetch origin && git reset --hard origin/master && git clean -f -d
```

###List of all files till a commit
```
git ls-tree --name-only -r <commit-ish>
```

###Git reset first commit
```
git update-ref -d HEAD
```

###Reset: preserve uncommitted local changes
```
git reset --keep <commit>
```

###List all the conflicted files
```
git diff --name-only --diff-filter=U
```

###List of all files changed in a commit
```
git diff-tree --no-commit-id --name-only -r <commit-ish>
```

###Unstaged changes since last commit
```
git diff
```

###Changes staged for commit
```
git diff --cached
```

###Show both staged and unstaged changes
```
git diff HEAD
```

###List all branches that are already merged into master
```
git branch --merged master
```

###Quickly switch to the previous branch
```
git checkout -
```

###Remove branches that have already been merged with master
```
git branch --merged master | grep -v '^\*' | xargs -n 1 git branch -d
```

###List all branches and their upstreams, as well as last commit on branch
```
git branch -vv
```

###Track upstream branch
```
git branch -u origin/mybranch
```

###Delete local branch
```
git branch -d <local_branchname>
```

###Delete remote branch
```
git push origin --delete <remote_branchname>
```

###Delete local tag
```
git tag -d <tag-name>
```

###Delete remote tag
```
git push origin :refs/tags/<tag-name>
```

###Undo local changes with the last content in head
```
git checkout -- <file_name>
```

###Revert: Undo a commit by creating a new commit
```
git revert <commit-ish>
```

###Reset: Discard commits, advised for private branch
```
git reset <commit-ish>
```

###Reword the previous commit message
```
git commit -v --amend
```

###See commit history for just the current branch
```
git cherry -v master
```

###Amend author.
```
git commit --amend --author='Author Name <email@address.com>'
```

###Reset author, after author has been changed in the global config.
```
git commit --amend --reset-author --no-edit
```

###Changing a remote's URL
```
git remote set-url origin <URL>
```

###Get list of all remote references
```
git remote
```

###Get list of all local and remote branches
```
git branch -a
```

###Get only remote branches
```
git branch -r
```

###Stage parts of a changed file, instead of the entire file
```
git add -p
```

###Get git bash completion
```
curl -L http://git.io/vfhol > ~/.git-completion.bash && echo '[ -f ~/.git-completion.bash ] && . ~/.git-completion.bash' >> ~/.bashrc
```

###What changed since two weeks?
```
git log --no-merges --raw --since='2 weeks ago'
```

###See all commits made since forking from master
```
git log --no-merges --stat --reverse master..
```

###Pick commits across branches using cherry-pick
```
git checkout <branch-name> && git cherry-pick <commit-ish>
```

###Find out branches containing commit-hash
```
git branch -a --contains <commit-ish>
```

###Git Aliases
```
git config --global alias.<handle> <command> 
git config --global alias.st status
```

###Saving current state of tracked files without commiting
```
git stash
```

###Saving current state of unstaged changes to tracked files
```
git stash -k
```

###Saving current state including untracked files
```
git stash -u
```

###Saving current state with message
```
git stash save <message>
```

###Saving current state of all files (ignored, untracked, and tracked)
```
git stash -a
```

###Show list of all saved stashes
```
git stash list
```

###Apply any stash without deleting from the stashed list
```
git stash apply <stash@{n}>
```

###Apply last stashed state and delete it from stashed list
```
git stash pop
```

###Delete all stored stashes
```
git stash clear
```

###Grab a single file from a stash
```
git checkout <stash@{n}> -- <file_path>
```

###Show all tracked files
```
git ls-files -t
```

###Show all untracked files
```
git ls-files --others
```

###Show all ignored files
```
git ls-files --others -i --exclude-standard
```

###Create new working tree from a repository (git 2.5)
```
git worktree add -b <branch-name> <path> <start-point>
```

###Create new working tree from HEAD state
```
git worktree add --detach <path> HEAD
```

###Untrack files without deleting
```
git rm --cached <file_path>
```

###Before deleting untracked files/directory, do a dry run to get the list of these files/directories
```
git clean -n
```

###Forcefully remove untracked files
```
git clean -f
```

###Forcefully remove untracked directory
```
git clean -f -d
```

###Update all the submodules
```
git submodule foreach git pull
```

###Show all commits in the current branch yet to be merged to master
```
git cherry -v master
```

###Rename a branch
```
git branch -m <new-branch-name>
```

###Rebases 'feature' to 'master' and merges it in to master 
```
git rebase master feature && git checkout master && git merge -
```

###Archive the `master` branch
```
git archive master --format=zip --output=master.zip
```

###Modify previous commit without modifying the commit message
```
git add --all && git commit --amend --no-edit
```

###Prunes references to remote branches that have been deleted in the remote.
```
git fetch -p
```

###Retrieve the commit hash of the initial revision.
```
 git rev-list --reverse HEAD | head -1
```

###Visualize the version tree.
```
git log --pretty=oneline --graph --decorate --all
```

###Visualize the tree including commits that are only referenced from reflogs
```
git log --graph --decorate --oneline $(git rev-list --walk-reflogs --all)
```

###Deploying git tracked subfolder to gh-pages
```
git subtree push --prefix subfolder_name origin gh-pages
```

###Adding a project to repo using subtree
```
git subtree add --prefix=<directory_name>/<project_name> --squash git@github.com:<username>/<project_name>.git master
```

###Get latest changes in your repo for a linked project using subtree
```
git subtree pull --prefix=<directory_name>/<project_name> --squash git@github.com:<username>/<project_name>.git master
```

###Export a branch with history to a file.
```
git bundle create <file> <branch-name>
```

###Import from a bundle
```
git clone repo.bundle <repo-dir> -b <branch-name>
```

###Get the name of current branch.
```
git rev-parse --abbrev-ref HEAD
```

###Ignore one file on commit (e.g. Changelog).
```
git update-index --assume-unchanged Changelog; git commit -a; git update-index --no-assume-unchanged Changelog
```

###Stash changes before rebasing
```
git rebase --autostash
```

###Fetch pull request by ID to a local branch
```
git fetch origin pull/<id>/head:<branch-name>
```

###Show the most recent tag on the current branch.
```
git describe --tags --abbrev=0
```

###Show inline word diff.
```
git diff --word-diff
```

###Show changes using common diff tools.
```
git difftool [-t <tool>] <commit1> <commit2> <path>
```

###Don’t consider changes for tracked file.
```
git update-index --assume-unchanged <file_name>
```

###Undo assume-unchanged.
```
git update-index --no-assume-unchanged <file_name>
```

###Clean the files from `.gitignore`.
```
git clean -X -f
```

###Restore deleted file.
```
git checkout <deleting_commit>^ -- <file_path>
```

###Restore file to a specific commit-hash
```
git checkout <commit-ish> -- <file_path>
```

###Always rebase instead of merge on pull.
```
git config --global pull.rebase true
```

###List all the alias and configs.
```
git config --list
```

###Make git case sensitive.
```
git config --global core.ignorecase false
```

###Add custom editors.
```
git config --global core.editor '$EDITOR'
```

###Auto correct typos.
```
git config --global help.autocorrect 1
```

###Check if the change was a part of a release.
```
git name-rev --name-only <SHA-1>
```

###Dry run. (any command that supports dry-run flag should do.)
```
git clean -fd --dry-run
```

###Marks your commit as a fix of a previous commit.
```
git commit --fixup <SHA-1>
```

###Squash fixup commits normal commits.
```
git rebase -i --autosquash
```

###Skip staging area during commit.
```
git commit --only <file_path>
```

###Interactive staging.
```
git add -i
```

###List ignored files.
```
git check-ignore *
```

###Status of ignored files.
```
git status --ignored
```

###Commits in Branch1 that are not in Branch2
```
git log Branch1 ^Branch2
```

###List n last commits
```
git log -<n>
```

###Reuse recorded resolution, record and reuse previous conflicts resolutions.
```
git config --global rerere.enabled 1
```

###Open all conflicted files in an editor.
```
git diff --name-only | uniq | xargs $EDITOR
```

###Count unpacked number of objects and their disk consumption.
```
git count-objects --human-readable
```

###Prune all unreachable objects from the object database.
```
git gc --prune=now --aggressive
```

###Instantly browse your working repository in gitweb.
```
git instaweb [--local] [--httpd=<httpd>] [--port=<port>] [--browser=<browser>]
```

###View the GPG signatures in the commit log
```
git log --show-signature
```

###Remove entry in the global config.
```
git config --global --unset <entry-name>
```

###Checkout a new branch without any history
```
git checkout --orphan <branch_name>
```

###Extract file from another branch.
```
git show <branch_name>:<file_name>
```

###List only the root and merge commits.
```
git log --first-parent
```

###Change previous two commits with an interactive rebase.
```
git rebase --interactive HEAD~2
```

###List all branch is WIP
```
git checkout master && git branch --no-merged
```

###Find guilty with binary search
```
git bisect start                    # Search start 
git bisect bad                      # Set point to bad commit 
git bisect good v2.6.13-rc2         # Set point to good commit|tag 
git bisect bad                      # Say current state is bad 
git bisect good                     # Say current state is good 
git bisect reset                    # Finish search 

```

###Bypass pre-commit and commit-msg githooks
```
git commit --no-verify
```

###List commits and changes to a specific file (even through renaming)
```
git log --follow -p -- <file_path>
```

###Clone a single branch
```
git clone -b <branch-name> --single-branch https://github.com/user/repo.git
```

###Create and switch new branch
```
git checkout -b <branch-name>
```

###Ignore file mode changes on commits
```
git config core.fileMode false
```

###Turn off git colored terminal output
```
git config --global color.ui false
```

###Specific color settings
```
git config --global <specific command e.g branch, diff> <true, false or always>
```

###Show all local branches ordered by recent commits
```
git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads/
```

###Find lines matching the pattern (regex or string) in tracked files
```
git grep --heading --line-number 'foo bar'
```

###Clone a shallow copy of a repository
```
git clone https://github.com/user/repo.git --depth 1
```

###Search Commit log across all branches for given text
```
git log --all --grep='<given-text>'
```

###Get first commit in a branch (from master)
```
git log --oneline master..<branch-name> | tail -1
```

###Unstaging Staged file
```
git reset HEAD <file-name>
```

###Force push to Remote Repository
```
git push -f <remote-name> <branch-name>
```

###Adding Remote name
```
git remote add <remote-nickname> <remote-url>
```

###List all currently configured remotes
```
git remote -v
```

###Show the author, time and last revision made to each line of a given file
```
git blame <file-name>
```

###Group commits by authors and title
```
git shortlog
```

###Forced push but still ensure you don't overwrite other's work
```
git push --force-with-lease <remote-name> <branch-name>
```

###Show how many lines does an author contribute
```
git log --author='_Your_Name_Here_' --pretty=tformat: --numstat | gawk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s removed lines: %s total lines: %s
", add, subs, loc }' -
```

###Revert: Reverting an entire merge
```
git revert -m 1 <commit-ish>
```

###Number of commits in a branch
```
git rev-list --count <branch-name>
```

###Alias: git undo
```
git config --global alias.undo '!f() { git reset --hard $(git rev-parse --abbrev-ref HEAD)@{${1-1}}; }; f'
```

###Add object notes
```
git notes add -m 'Note on the previous commit....'
```

###Show all the git-notes
```
git log --show-notes='*'
```

###Apply commit from another repository
```
git --git-dir=<source-dir>/.git format-patch -k -1 --stdout <SHA1> | git am -3 -k
```

###Specific fetch reference
```
git fetch origin master:refs/remotes/origin/mymaster
```

###Find common ancestor of two branches
```
git merge-base <branch-name> <other-branch-name>
```

###List unpushed git commits
```
git log --branches --not --remotes
```

###Add everything, but whitespace changes
```
git diff --ignore-all-space | git apply --cached
```

###Edit [local/global] git config
```
git config [--global] --edit
```

###blame on certain range
```
git blame -L <start>,<end>
```

###Show a Git logical variable.
```
git var -l | <variable>
```

###Preformatted patch file.
```
git format-patch -M upstream..topic
```

###Get the repo name.
```
git rev-parse --show-toplevel
```

###logs between date range
```
git log --since='FEB 1 2017' --until='FEB 14 2017'
```

###Exclude author from logs
```
git log --perl-regexp --author='^((?!excluded-author-regex).*)$'
```

###Generates a summary of pending changes
```
git request-pull v1.0 https://git.ko.xz/project master:for-linus
```

###List references in a remote repository
```
git ls-remote git://git.kernel.org/pub/scm/git/git.git
```

###Backup untracked files.
```
git ls-files --others -i --exclude-standard | xargs zip untracked.zip
```

###List all git aliases
```
git config -l | grep alias | sed 's/^alias\.//g'
```

###Show git status short
```
git status --short --branch
```

###Checkout a commit prior to a day ago
```
git checkout master@{yesterday}
```

###Push a new local branch to remote repository and track
```
git push -u origin <branch_name>
```

###Change a branch base
```
git rebase --onto <new_base> <old_base>
```

###Use SSH instead of HTTPs for remotes
```
git config --global url.'git@github.com:'.insteadOf 'https://github.com/'
```

###Update a submodule to the latest commit
```
cd <path-to-submodule>
git pull origin <branch>
cd <root-of-your-main-project>
git add <path-to-submodule>
git commit -m "submodule updated"
```

