# How to contribute

## Bug reports, Questions & Comments

If you have a bug to report, a question to ask or just a comment, feel free to
open an [issue](https://github.com/dotboris/autotags/issues/new).

## Contributing code

1. [Fork](https://github.com/dotboris/autotags#fork-destination-box) this
  repository
1. Clone your fork
1. Make, commit & push your changes
1. Open a [pull request](https://github.com/dotboris/autotags/compare)

Be sure to write tests for your new code. If you don't someone might
accidentally break your feature without realizing it.

## Development Environment

You can setup your development environment with the following steps:

1. Download and install [Vagrant](https://www.vagrantup.com/)
1. Build the vagrant VM (this may take a while)

    ```sh
    vagrant up
    ```

1. Ssh into the VM

    ```sh
    vagrant ssh
    cd /vagrant
    ```

1. Run the setup script

    ```sh
    ./bin/setup
    ```

Once you're done, you can stop the VM with:

```sh
exit
vagrant suspend
```

You can run the tests with:

```sh
./bin/rake
```

You can have tests be run automatically when you make changes with:

```sh
./bin/guard
```

## Releasing

For this to work, you'll need to be able to write to this repository.

1. Bump the version

    ```sh
    ./bin/semver inc [major|minor|patch] # pick one
    ```

1. Commit the version bump
1. Run the release script

    ```sh
    ./bin/rake release
    ```

1. Edit the `autotags` link in _Other Linux distributions_ in `README.md` to
    point to the latest version.

1. Commit & push the changes to `README.md`

### Update the AUR package

For this to work you'll need write access to the AUR repository for the autotags
package.

1. Clone the AUR repository (https://aur.archlinux.org/packages/autotags/)
1. Edit `PKGBUILD`

    1. Update the `pkgver` variable
    1. Reset the `pkgrel` variable back to `1`

1. Run `mksrcinfo`
1. Run `makepkg -g` and update the md5sums variable
1. Run `makepkg`
1. Run `namcap autotags-<version>-1-any.pkg.tar.xz` and fix all the errors and
    warnings

    You can ignore the dependency warnings for `inotify-tools` and `ctags`

1. Install the package with `sudo pacman -U autotags-<version>-1-any.pkg.tag.xz`
1. Make sure that autotags is well installed and that it works.
1. Commit and push your changes
