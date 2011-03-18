rcc = YAML.load_file("#{Rails.root}/config/recaptcha.yml")
RCC_PUB = rcc['RCC_PUB']
RCC_PRIV = rcc['RCC_PRIV']
