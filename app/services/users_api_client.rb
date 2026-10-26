class UsersApiClient
  API_URL = ENV['API_BASE_URL'] + '/api/users'
  
  def self.getUsers(filters)
    HTTParty.get(API_URL, query: filters)
  end
end