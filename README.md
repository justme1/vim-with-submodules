Installation:

    git clone  https://github.com/justme1/vim-with-submodules.git ~/.vim

create symlink:

    ln -s ~/.vim/vimrc ~/.vimrc

update submodules

    cd ~/.vim/
    git submodule init
    git submodule update

Upgrading a plugin bundle:

    cd ~/.vim/bundle/fugitive
    git pull origin master

Upgrading all bundled plugins:

    git submodule foreach git pull origin master



NOTE:

if you want to add another plugin:
    git submodule add repo bundle/plugin name
    git add .
    git commit -m 'plugin added comment'
