Dotenv.load Rails.root.join(".env.#{Rails.env}") rescue nil
