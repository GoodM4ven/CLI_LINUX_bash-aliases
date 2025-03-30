<div align="center">بسم الله الرحمن الرحيم<br><br></div>
<div align="left">

# bash-aliases

Some quick helper scripts that I use in Ubuntu; added in `.bashrc` as aliases.


## Ubuntu Linux

### `update`

Updates the system packages, including [Flatpak](https://flatpak.org)'s and [Snap](https://snapcraft.io/)'s.

```bash
alias update='sudo apt update && sudo apt upgrade && sudo flatpak update && sudo snap refresh'
```

### `clean`

Cleans off various directories of temporary files and dependency accumulated update caches. Moreover, it does clean the system logs (keeping only the last 7 days') that could do accumulate size over time.

```bash
alias clean='sudo rm -rf /var/lib/snapd/cache/* && flatpak uninstall --unused && sudo rm -rf /tmp/* /var/tmp/* && sudo journalctl --vacuum-time=7d'
```

### `gdmres`

Attempts to recover from Gnome-Shell display manager (GDM) crashes... -Which usually fails anyway!

```bash
alias gdmres='sudo systemctl stop gdm3 && sudo systemctl restart display-manager && sudo systemctl start gdm3 && sudo loginctl terminate-user $(whoami) && sudo reboot now'
```


## Arabic

Dealing with Arabic strings.

### `aranum`

Converts Arabic-to-Indian numerals and vice-versa.

Input:
```bash
aranum 1234
```

Output:
```bash
١٢٣٤
```

### `arastrip`

Strips away common Arabic tashkeel real quick.

Input:
```bash
arastrip "أَيُّ سَمَاءٍ تُظِلُّنِي ، أَوْ أَيُّ أَرْضٍ تُقِلُّنِي ، إِنْ أَنَا قُلْتُ فِي كِتابِ اللَّهِ مَا لَا أَعْلَمُ ؟"
```

Output:
```
أي سماء تظلني ، أو أي أرض تقلني ، إن أنا قلت في كتاب الله ما لا أعلم ؟
```


## Development - Version Control

### `oops`

Resolves the situation of an accidental last push commit without checking for possible commits to pull them first; basically being stuck between pulling and pushing. And it works in 2 steps:

- Pulls in the latest changes from the correct remote repository.
- Rebases the local commits on top of those prior to keep the commit history clean.

```bash
alias oops='git pull --rebase origin $(git rev-parse --abbrev-ref HEAD)'
```

### `grim`

Removes files/folders from the cached version control, when they have been committed before.

```bash
alias girm='f() { git rm -r --cached "$1"; }; f'
```

</div>

> [!IMPORTANT]  
> It obviously needs the correct path of a file/directory, passed as an argument, in order to be removed.

<div align=""left>

### `chest`

Stashes the current changes local changes properly; meaning that it's done including the untracked files. **(New files that weren't committed from before!)**

```bash
alias chest='git stash push -u'
```

> [!NOTE]
> Who would have thought that this was not the default bahavior to `git stash push` command, am I right?! (curbs furiousness)

### `grit`

When dealing with `dev`-branch conflict resolving, this command eases out the default process by miles; since it accounts for the `dev` branch to be the "source of truth" during the merging process.

```bash
alias grit='git merge -X theirs origin/dev'
```


## Development - [TALL](https://tallstack.dev) Stack

### `cda`

Stands for `composer dump-autoload`, which is a very common back-end packages stabalizer!

```bash
alias cda='composer dump-autoload'
```

### `art`

The awesome shortcut for using [Laravel](https://laravel.com)'s [Artisan](https://laravel.com/docs/artisan) scripts runner.

```bash
alias art='php artisan'
```

### `wipe`

Wipes out the current database content, using the [art](#art) above.

```bash
alias wipe='php artisan db:wipe'
```

### `fresh`

Cleans and migrates the database, using the [art](#art) above.

```bash
alias fresh='php artisan migrate:fresh'
```

### `mfs`

Stands for migrate-fresh and seed; bascially, doing the [wipe](#wipe) and [fresh](#fresh) together.

```bash
alias mfs='php artisan migrate:fresh --seed'
```

### `opt`

A shortcut for running `optimize:clear`, which is another [art](#art) to quickly clear all possible caching techniques in Laravel; ensuring there is no Cache driver failure that results "stuck" files and stuff!

```bash
alias opt='php artisan optimize:clear'
```

### `dev`

Quickly spins up [ViteJS](https://vitejs.dev) watcher to keep track of front-end asset changes; depending on your configuration file.

```bash
alias dev='bun run dev'
```

### `pail`

Another quick [art](#art) to start listening and capturing Laravel's [dumps](https://laravel.com/docs/helpers#method-dump), [dies](https://laravel.com/docs/helpers#method-dd) and [logs](https://laravel.com/docs/logging) within the terminal.

```bash
alias pail='php artisan pail'
```

### `que`

Runs a Laravel's [Queues](https://laravel.com/docs/queues) worker real quick.

```bash
alias que='php artisan queue:work'
```

### `pest`

Executes a huge amount of processes regarding testing the TALL app, including:

- Formatting Laravel [Blade](https://laravel.com/docs/blade) files, via the superb, yet unofficial, [Laravel Blade Formatter](https://github.com/shufo/blade-formatter).
- Formatting CSS/JS files using [Prettier](https://prettier.io/).
- Formatting PHP files, using Laravel's official: [Pint](https://laravel.com/docs/pint).
- Performing static-analysis over PHP files using [Larastan](https://github.com/larastan/larastan).
- Running [PestPHP](https://pestphp.com) for powerful and expressive PHP testing; in [parallel](https://pestphp.com/docs/optimizing-tests#content-parallel-testing) mode, and while logging the results to a [phpunit.results.xml] file.

```bash
alias pest='f() { bunx blade-formatter --write "resources/views/**/*.blade.php"; bunx prettier --write "resources/js/**/*.js" "resources/css/**/*.css"; ./vendor/bin/pint; ./vendor/bin/phpstan; ./vendor/bin/pest "$1" --parallel --processes=8 --log-junit phpunit.results.xml; }; f'
```

</div>

> [!NOTE]
> Possible `pest` **arguments** can be passed to the command as well.

<div align=""left>

### `bench`

Calls Testbench's Artisan script that is used for simulating a Laravel environment and test packages.

```bash
alias bench='f() { ./vendor/bin/testbench "$1"; }; f'
```

### `lara` (Extra)

It's just a shortcut to run [lara-stacker](https://github.com/GoodM4ven/CLI_LARAVEL_lara-stacker) CLI, in order to manage simultaneous development of TALL stack apps on Linux.

```bash
alias lara='cd /home/goodm4ven/Code/Scripts/lara-stacker && sudo ./lara-stacker.sh'
```


## Personal Preferences (AKA. *Opinions*)

### `code`

Typing [`codium`](https://vscodium.com/) is much harder than just `code`, where the latter is the official VSC's by default, sadly...

```bash
alias code='f() { codium "$1"; }; f' 
```

### `vsix`

Since I'm still on team-VSC, techincally, building [VSIX](https://learn.microsoft.com/en-us/visualstudio/extensibility/shipping-visual-studio-extensions) packages is quite usual for me, hence the command.

```bash
alias vsix='bun install && vsce package'
```


## Todos

- // TODO A command for "clearing" TALL apps
- // TODO A command for logging in the PHPUnit results log using Bash
  - // TODO Adding it to the `pest` command, and running it right after the tests.
  - // TODO Meaning separating it to a full Bash script file
- // TODO A command to pull in and display a random aya, plus its transcriptive aathar
- // TODO A command to pull in and display a random hadeeth, plus its English translation


## Support

Support ongoing package maintenance as well as the development of **other projects** through [sponsorship](https://github.com/sponsors/GoodM4ven) or one-time [donations](https://github.com/sponsors/GoodM4ven?frequency=one-time&sponsor=GoodM4ven) if you prefer.

And may Allah accept your strive; aameen.

### License

This package is open-sourced software licensed under the [MIT license](LICENSE.md).

### Credits

- [ChatGPT](https://chat.openai.com)
- [TALL Stack](https://tallstack.dev/)'s Entire Community
- [GNOME](https://gnome.org/)
- [Ubuntu](https://ubuntu.com/)
- [Linux](https://kernel.org/)

</div>
<div align="center"><br>والحمد لله رب العالمين</div>
