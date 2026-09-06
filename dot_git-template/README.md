# git-templates


## Features

- [x] Copies hooks into `.git/hooks` on `git clone` and `git init` given the
      install settings in this README
- [ ] Fork from
      [greg0ire/git_template](https://github.com/greg0ire/git_template) and add
      aw hooks there (advantage: activate and deactivate hooks, e.g., depending
      on language, use of aw)

### ActivityWatch (aw)

- [x] Send events to bucket `aw-git-hooks_$HOSTNAME` on post-commit or post-checkout
- [x] Add unique list of issues to the aw event
- [x] Support Jira issues, e.g., `MYPROJECT-123`
- [x] Support GitHub/GitLab issues, e.g., `#123`
- [x] Use commit timestamp for post-commit event
- [x] Check effect wenn using duration (e.g., 1h) in event. Needs duration > 0
      to be visible in timeline -> 2s. If set to 1h and another event is sent to
      the bucket within the same hour, the events are overlapping, i.e., a new
      event does not stop the previous one.
- [x] Add remote.origin.url
- [x] Add branch
- [x] Add first line of commit message (summary/title)


## Install

Make this repository the template for the `.git` directory of a repository.

```bash
$ git clone git@github.com:dratasich/git-templates.git
$ ln -s git-templates/template $HOME/.git-template
$ git config --global init.templatedir '~/.git-template'
```

As soon as a new repo is cloned or initialized the hooks are copied to the repo's `.git/hooks` folder.

To update an existing `.git` directory use:
```bash
$ cd <a-repository>
$ rsync --archive --verbose --compress --cvs-exclude $HOME/.git-template/hooks/ .git/hooks --delete
```

For convenience you can use the `update` script
to recursively sync all `.git` folders given a root directory.

```bash
$ ./update.sh <path-to-repos>
```

For more infos check `./update.sh -h`.

## References

- [Customizing git hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
- [Customizable git template example](https://github.com/greg0ire/git_template)
