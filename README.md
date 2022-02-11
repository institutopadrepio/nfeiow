# Nfeiow

[NFE.io](https://nfe.io) wrapper to create, cancel, download (pdf) and send invoices via email.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nfeiow'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install nfeiow

## Usage

### Initialize

```rb
# Create an initializer and configure your nfe_company_id and nfe_api_key
Nfeiow::ClientConfiguration.configure do |config|
  config.nfe_company_id = '123'
  config.nfe_api_key = '123abc'
end
```

### Create invoice - [Api Reference](https://nfe.io/docs/desenvolvedores/rest-api/nota-fiscal-de-servico-v1/#/ServiceInvoices/ServiceInvoices_Post)

```rb
params = {
    borrower: {
        federalTaxNumber: '65043222018', # Only numbers
        name: 'José Anchieta',
        email: 'anchieta@jose.com',
        address: {
        country: 'BRA',
        postalCode: '86055620', # Only numbers
        street: 'Rua Ulrico Zuinglio',
        number: '870',
        additionalInformation: 'Apto. 550',
        district: 'Gleba Palhano',
        city: {
            code: 4113700,
            name: 'Londrina'
        },
        state: 'PR'
        }
    },
    cityServiceCode: '8599699',
    cnaeCode: '8599699',
    description: 'Cursos online.',
    servicesAmount: 99.9
}

Nfeiow::Client.new.create_invoice(params)
```

### Cancel invoice - [Api Reference](https://nfe.io/docs/desenvolvedores/rest-api/nota-fiscal-de-servico-v1/#/ServiceInvoices/ServiceInvoices_Delete)

```rb
Nfeiow::Client.new.cancel_invoice(invoice_id)
```

### Download invoice (pdf) - [Api Reference](https://nfe.io/docs/desenvolvedores/rest-api/nota-fiscal-de-servico-v1/#/ServiceInvoices/ServiceInvoices_GetDocumentPdf)

```rb
Nfeiow::Client.new.download_invoice_pdf(invoice_id)
```

### Send invoice by email - [Api Reference](https://nfe.io/docs/desenvolvedores/rest-api/nota-fiscal-de-servico-v1/#/ServiceInvoices/ServiceInvoices_SendEmail)

```rb
Nfeiow::Client.new.send_invoice_via_email(invoice_id)
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
