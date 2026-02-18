require("codecompanion").setup({
  interactions = {
    chat = {
      adapter = {
        name = "openai",
        model = "gpt-4.1",
      },
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
