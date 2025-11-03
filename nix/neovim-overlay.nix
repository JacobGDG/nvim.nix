{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Use this to create a plugin from a flake input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  pkgs-locked = inputs.nixpkgs.legacyPackages.${pkgs.system};
  mkNeovim = pkgs.callPackage ./mkNeovim.nix {
    inherit (pkgs-locked) wrapNeovimUnstable neovimUtils;
  };

  # A plugin can either be a package or an attrset, such as
  # { plugin = <plugin>; # the package, e.g. pkgs.vimPlugins.nvim-cmp
  #   config = <config>; # String; a config that will be loaded with the plugin
  #   # Boolean; Whether to automatically load the plugin as a 'start' plugin,
  #   # or as an 'opt' plugin, that can be loaded with `:packadd!`
  #   optional = <true|false>; # Default: false
  #   ...
  # }
  # https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=vimPlugins
  all-plugins = with pkgs.vimPlugins; [
    oil-nvim # Buffer based file explorer | https://github.com/stevearc/oil.nvim

    # --- Navigation ---
    nvim-treesitter.withAllGrammars
    nvim-treesitter-context # nvim-treesitter-context | https://github.com/nvim-treesitter/nvim-treesitter-context
    nvim-treesitter-textobjects # https://github.com/nvim-treesitter/nvim-treesitter-textobjects/

    fzf-lua # | https://github.com/ibhagwan/fzf-lua

    smart-splits-nvim # TMUX navigation | https://github.com/mrjones2014/smart-splits.nvim

    # --- LSP ---
    nvim-lspconfig

    # --- Completion ---
    nvim-cmp # https://github.com/hrsh7th/nvim-cmp
    lspkind-nvim # vscode-like LSP pictograms | https://github.com/onsails/lspkind.nvim/
    # Sources
    cmp-buffer # current buffer as completion source | https://github.com/hrsh7th/cmp-buffer/
    cmp-cmdline # cmp command line suggestions
    cmp-cmdline-history # cmp command line history suggestions
    cmp-emoji # cmp for emojies | https://github.com/hrsh7th/cmp-emoji/
    cmp-nvim-lsp # LSP as completion source | https://github.com/hrsh7th/cmp-nvim-lsp/
    cmp-nvim-lsp-signature-help # https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/
    cmp-nvim-lua # neovim lua API as completion source | https://github.com/hrsh7th/cmp-nvim-lua/
    cmp-path # file paths as completion source | https://github.com/hrsh7th/cmp-path/
    cmp-spell # | https://github.com/f3fora/cmp-spell
    cmp_luasnip # snippets autocompletion extension for nvim-cmp | https://github.com/saadparwaiz1/cmp_luasnip/
    # Snippets
    luasnip # | https://github.com/L3MON4D3/LuaSnip
    friendly-snippets

    # --- Formatter ---
    conform-nvim

    # --- GIT ---
    gitsigns-nvim # | https://github.com/lewis6991/gitsigns.nvim/
    committia # git commit UI template | https://github.com/rhysd/committia.vim

    # --- Coding ---
    undotree
    vim-abolish # primarily for case switching | https://github.com/tpope/vim-abolish#coercion

    # COMMENTS
    mini-comment # | https://github.com/nvim-mini/mini.comment/
    nvim-ts-context-commentstring # https://github.com/joosepalviste/nvim-ts-context-commentstring/
    ts-comments-nvim #  customize comment string | https://github.com/folke/ts-comments.nvim/

    # --- UI ---
    lualine-nvim # Status line | https://github.com/nvim-lualine/lualine.nvim/
    mini-icons # | https://github.com/nvim-mini/mini.icons/
    bufresize-nvim

    snacks-nvim # a few things | https://github.com/folke/snacks.nvim/

    # --- THEME ---
    gruvbox-material # | https://github.com/sainnhe/gruvbox-material/

    # --- LIBRARY ---
    plenary-nvim # "lua functions you don't want to write" namely `curl` | https://github.com/nvim-lua/plenary.nvim
  ];

  extraPackages = with pkgs; [
    # LSPs
    lua-language-server
    terraform-ls # | https://github.com/hashicorp/terraform-ls
    ruby-lsp
    yaml-language-server
  ];
in {
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  nvim-dev = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
    appName = "nvim-dev";
    wrapRc = false;
  };

  nvim-luarc-json = final.mk-luarc-json {
    plugins = all-plugins;
  };

  # You can add as many derivations as you like.
  # Use `ignoreConfigRegexes` to filter out config
  # files you would not like to include.
  #
  # For example:
  #
  # nvim-pkg-no-telescope = mkNeovim {
  #   plugins = [];
  #   ignoreConfigRegexes = [
  #     "^plugin/telescope.lua"
  #     "^ftplugin/.*.lua"
  #   ];
  #   inherit extraPackages;
  # };
}
