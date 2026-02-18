require("codecompanion").setup({
  interactions = {
    chat = {
      adapter = "openai",
    },
    inline = {
      adapter = "openai",
    },
    cmd = {
      adapter = "openai",
    },
  },
  opts = {
    log_level = "DEBUG",
  }
})
