rcc = YAML.load_file("#{RAILS_ROOT}/config/recaptcha.yml")
RCC_PUB = rcc['RCC_PUB']
RCC_PRIV = rcc['RCC_PRIV']
