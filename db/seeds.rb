require "json"

path = Rails.root.join("db/seeds/users.json")

if File.exist?(path)
  rows = JSON.parse(File.read(path))
  created = skipped = 0

  User.transaction do
    rows.each do |attributes|
      if User.exists?(email: attributes['email'])
        skipped += 1
        puts "→ User skipped"
        next
      end

      user = User.new(
        email: attributes['email'],
        full_name: attributes['full_name'],
        job_position: attributes['job_position'],
        current_sign_in_at: attributes['last_seen'],
        status: attributes['status'],
        password: SecureRandom.hex(16)
      )
  
      user.save!
      created += 1
    end
  end

  puts "Users seeded: #{created} created, #{skipped} skipped"
end
