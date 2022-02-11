# frozen_string_literal: true

RSpec.describe Nfeiow::Client do # rubocop:disable Metrics/BlockLength
  before(:each) do
    Nfeiow::ClientConfiguration.configure do |config|
      config.nfe_company_id = '123'
      config.nfe_api_key = '123abc'
    end
  end

  subject { described_class.new }

  describe '#create_invoice', :vcr do # rubocop:disable Metrics/BlockLength
    let(:params) do
      {
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
              code: 4_113_700,
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
    end

    let!(:client) do
      subject.create_invoice(params)
    end

    it 'creates a new invoice and returns the correct result' do
      expect(client.success?).to eq true
      expect(client.error).to eq nil
      expect(client.value['id']).to eq '6206f389003cad6df0f36459'
      expect(client.value['status']).to eq 'Created'
      expect(client.value['baseTaxAmount']).to eq 99.9
    end
  end

  describe '#cancel_invoice', :vcr do
    let(:invoice_id) { '6206f261003cad6df0f34f8e' }
    let!(:client) do
      subject.cancel_invoice(invoice_id)
    end

    it 'cancels an invoice and return the correct result' do
      expect(client.success?).to eq true
      expect(client.error).to eq nil
      expect(client.value['flowStatus']).to eq 'WaitingSendCancel'
    end
  end

  describe '#download_invoice_pdf', :vcr do
    let(:invoice_id) { '6206f389003cad6df0f36459' }
    let!(:client) do
      subject.download_invoice_pdf(invoice_id)
    end

    it 'downloads an invoice and return the correct result' do
      expect(client.success?).to eq true
      expect(client.error).to eq nil
      expect(client.value).to eq 'https://nfse.blob.core.windows.net/44282121000149/dev/22/NFSE_00002800_MJGW.pdf?sv=2018-03-28&sr=b&sig=M%2Fqrj4b1br4LwvjwpVlL2KzVh0dgQsc8FsiUsZ2tX50%3D&st=2022-02-11T23%3A16%3A48Z&se=2022-02-12T00%3A06%3A48Z&sp=r'
    end
  end

  describe '#send_invoice_via_email', :vcr do
    let(:invoice_id) { '6206f389003cad6df0f36459' }
    let!(:client) do
      subject.send_invoice_via_email(invoice_id)
    end

    it 'sends an invoice to the customer and returns the correct result' do
      expect(client.success?).to eq true
      expect(client.error).to eq nil
      expect(client.value).to eq 'Executed'
    end
  end
end
