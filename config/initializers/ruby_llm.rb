RubyLLM.configure do |config|
  config.default_model = 'gemini-flash-lite-latest'
  config.gemini_api_key = ENV.fetch('GEMINI_API_KEY')
  config.request_timeout = 30
  config.max_retries = 1
end