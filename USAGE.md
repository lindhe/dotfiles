# Using dotfiles

## Cloning
* `git clone https://github.com/lindhe/dotfiles.git --recursive`

## Linking
* `ln -s ~/git/dotfiles/.vimrc`
* `ln -s ~/git/dotfiles/.vimrc /home/andreas/.vimrc`

## Apply commits from another branch
* To apply the four last commits from foo: `git cherry-pick foo~4..foo`
* To apply the forth last commit from branch foo: `git cherry-pick foo~4`
