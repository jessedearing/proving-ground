if File.exists? "/etc/jessedearing/recaptcha.yml"
  rcc = YAML.load_file("/etc/jessedearing/recaptcha.yml")
else
  rcc = YAML.load_file("#{Rails.root}/config/recaptcha.yml")
end
RCC_PUB = rcc['RCC_PUB']
RCC_PRIV = rcc['RCC_PRIV']
