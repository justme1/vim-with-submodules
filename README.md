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

    git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive
    git add .
    git commit -m 'plugin added comment'

if you want to add changes to a specific plugin, you need to fork it: https://help.github.com/articles/fork-a-repo
    
remove the submodule:
    Delete the relevant section from the .gitmodules file.
    Delete the relevant section from .git/config.
    Run git rm --cached path_to_submodule (no trailing slash).
    git add .gitmodules
    Commit
    Delete the now untracked submodule files rm -rf path_to_submodule

then add the fork submodule as instructed above.

for more instruction visit: http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
