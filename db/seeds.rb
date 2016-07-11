inserts = Array.new
File.open("db/urls").each_line do |row|
	inserts << "('#{row.chomp.tr('(),;', '')}', '#{SecureRandom.hex(6)}','#{Time.now}', '#{Time.now}')"
end

sql = "INSERT INTO urls (long_url, short_url, created_at, updated_at) VALUES #{inserts.join(', ')};"

Url.connection.execute sql