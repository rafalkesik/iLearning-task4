class GroqClient
  API_URL       = 'https://api.groq.com/openai/v1/chat/completions'
  MODEL         = 'openai/gpt-oss-20b'
  QUERY_PROMPT  = 'User will ask you about the users table data in natural
                   language. Your task is to help construct API call to query
                   the database. Answer strictly in this hash format:
                   {"name_regex": "", "job_regex": "", "email_regex": "",
                   "status": "", "last_seen_start": "", "last_seen_end": "",
                   "sort_by": ["", ""], "count": "", "list": ""}.
                   If user wants only certain names, create needed regex string
                   sorrounded by "/". Same applies to job_position string and
                   email. Note that name column can contain "Gov. Efren Lehner",
                   or "Rikki Mohr II", etc. When user asks for surname, please
                   note that it does not have to be the last element. Status can
                   be either "blocked" if user is blocked, or "active". table
                   has "last_seen" DateTime column. If user wants to see users
                   that logged in after certain date, supply only
                   last_seen_start. If time range is fixed, supply both
                   last_seen_start and last_seen_end. Input these two strings
                   in format: "YYYY-MM-DDTHH:MM:SS". If user wants to sort the
                   results by some column, input an array, where first element
                   is string with column name, and second string is either "asc"
                   or "desc". Count should be 1 if user wants to know the amount
                   of users matching criteria. If not, do not input it. If user
                   wants some data about users, list should be 1. If he wants
                   only count, omit this key. If any key should not have value,
                   omit it. Respond with hash only.'
  ANSWER_PROMPT = ""

  def self.chat(message)
    response = HTTParty.post(
      API_URL,
      body: { 'model': MODEL,
              'messages': [{ 'role':    'system',
                             'content': QUERY_PROMPT },
                           { 'role':    'user',
                             'content': message }],
            }.to_json,
      headers: { 'Content-Type' => 'application/json',
                  'Authorization' => "Bearer #{ENV['GROQ_API_KEY']}" }
    )
    
    puts "response: #{response.parsed_response}"
    JSON.parse(response.parsed_response.dig('choices', 0, 'message', 'content'))
  end    
end
