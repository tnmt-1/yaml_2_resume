class Config
  class << self
    @@settings = {
      VERSION: '0.4.0'
    }

    @@settings.each do |key, value|
      define_method key.to_sym do
        value.freeze
      end
    end
  end
end
