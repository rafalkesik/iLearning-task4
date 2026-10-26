class GroqClient
  API_URL       = 'https://api.groq.com/openai/v1/chat/completions'
  MODEL         = 'openai/gpt-oss-20b'
  SYSTEM_PROMPT = "User will ask you about the users table data. Construct "

  def self.chat(message)
    response = HTTParty.post(
      API_URL,
      body: { 'model': MODEL,
              'messages': [{ 'role':     'system',
                             'content': SYSTEM_PROMPT },
                           { 'role':     'user',
                             'content':  message }],
            }.to_json,
      headers: { 'Content-Type' => 'application/json',
                  'Authorization' => "Bearer #{ENV['GROQ_API_KEY']}" }
    )
    
    puts "response: #{response.parsed_response}"
    response.parsed_response.dig('choices', 0, 'message', 'content')
  end    
end
