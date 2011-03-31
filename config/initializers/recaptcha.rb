if File.exists? "#{Rails.root}/config/recaptcha.yml"
  rcc = YAML.load_file("#{Rails.root}/config/recaptcha.yml")
else
  rcc = YAML.load_file("/etc/jessedearing/recaptcha.yml")
end
RCC_PUB = rcc['RCC_PUB']
RCC_PRIV = rcc['RCC_PRIV']
