{ config, pkgs, ... }:
{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      let mapleader = ","
      filetype indent on
      filetype plugin on
      set number
      syntax enable
      set noswapfile
      set incsearch
      set hlsearch
      set nobackup
      set nowb
      set expandtab
      set smarttab
      set ai
      set si
      set wrap
      set shiftwidth=2
      set tabstop=2
      set laststatus=2
      map <leader>ss :setlocal spell!<cr>
      map <leader>pp :setlocal paste!<cr>
    '';
  };
}
