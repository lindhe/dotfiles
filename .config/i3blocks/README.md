# i3blocks-contrib

The `i3blocks/contrib` directory is a subtree of the vivien/i3blocks-contrib
repo on GitHub. To update it with the latest changes, run the following command:

```shell
# Must be at the repo root
pushd "$(git rev-parse --show-toplevel)"

git subtree --prefix .config/i3blocks/contrib pull --squash https://github.com/vivien/i3blocks-contrib master

popd
```
