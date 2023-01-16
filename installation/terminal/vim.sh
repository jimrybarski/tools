# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# install neovim
git clone https://github.com/neovim/neovim.git
pushd neovim 2>&1 > /dev/null
make -j8 CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$HOME/.local install
