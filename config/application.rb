require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
require "openssl" # for decryption

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

# Decode enc_application.yml into temp application.yml
    # "key" and "iv" used to create enc_application.yml file
key = "\x8D\xEBc\x99Hw\rH\xE3\xACa\xAF\xDE4lnm\x9D!s\xEB\xB0\x96\xBF\xA8\xCC\x84\x87s\xBC\xDB\x8E"
iv = "!\x1EMjNp\xC6c\xDD\xDC[\xCE\xB6\x18\xD5\xFC"
alg = "AES-256-CBC"
# Create decipher instance with "alg" characteristics
decipher = OpenSSL::Cipher.new(alg)
decipher.decrypt
decipher.key = key
decipher.iv = iv
# Decode enc_application.yml file into temporary application.yml file
File.open(File.expand_path('../application.yml', __FILE__), 'w:UTF-8') do |dec|
    File.open(File.expand_path('../enc_application.yml', __FILE__)) do |f|
        loop do
            r = f.read(4096)
            break unless r
            decoded = decipher.update(r)
            dec << decoded
        end
    end

    dec << decipher.final
end



# Create CONFIG[:foo] constants from application.yml file
CONFIG = YAML.load(File.read(File.expand_path('../application.yml', __FILE__)))
CONFIG.merge! CONFIG.fetch(Rails.env, {})
CONFIG.symbolize_keys!

# Delete the temporary application.yml file
File.delete(File.expand_path('../application.yml', __FILE__))

module Startup4002
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
