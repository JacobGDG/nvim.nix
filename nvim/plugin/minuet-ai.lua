require('minuet').setup {
  provider = 'openai_fim_compatible',
  n_completions = 1, -- keep to 1 for local models to save resources
  context_window = 512, -- start small, raise once you know your tok/s
  provider_options = {
    openai_fim_compatible = {
      api_key = 'TERM', -- llama.cpp doesn't check this, but the field can't be empty
      name = 'Llama.cpp',
      end_point = 'http://127.0.0.1:8012/v1/completions', -- note: v1/completions, not /infill
      model = 'PLACEHOLDER', -- model is fixed by llama-server at launch, this is ignored
      optional = {
        max_tokens = 56,
        top_p = 0.9,
      },
    },
  },
}
