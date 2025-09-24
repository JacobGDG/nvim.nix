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
    # nvim-treesitter-textobjects # https://github.com/nvim-treesitter/nvim-treesitter-textobjects/
    # nvim-ts-context-commentstring # https://github.com/joosepalviste/nvim-ts-context-commentstring/
    #
    # # --- LSP ---
    nvim-lspconfig



    # nvim-cmp # https://github.com/hrsh7th/nvim-cmp
    # cmp-nvim-lsp # LSP as completion source | https://github.com/hrsh7th/cmp-nvim-lsp/
    # cmp-buffer # current buffer as completion source | https://github.com/hrsh7th/cmp-buffer/
    # cmp-path # file paths as completion source | https://github.com/hrsh7th/cmp-path/
    # cmp-nvim-lua # neovim lua API as completion source | https://github.com/hrsh7th/cmp-nvim-lua/
    # cmp-cmdline # cmp command line suggestions | https://github.com/hrsh7th/cmp-cmdline
    # cmp-cmdline-history # cmp command line history suggestions
    # nvim-navic # | show context on location https://github.com/SmiteshP/nvim-navic
    #
    # luasnip # snippets | https://github.com/l3mon4d3/luasnip/

    # --- GIT ---
    gitsigns-nvim # https://github.com/lewis6991/gitsigns.nvim/
    neogit
    # --- Utils ---
    undotree

    # --- UI ---
    lualine-nvim # Status line | https://github.com/nvim-lualine/lualine.nvim/
    mini-icons # | https://github.com/nvim-mini/mini.icons/
  ];

  extraPackages = with pkgs; [
    lua-language-server
    nil # nix LSP
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
