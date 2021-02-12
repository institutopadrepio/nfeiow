# frozen_string_literal: true

RSpec.describe Nfeiow::Client do
  let(:company_id) { '123' }
  let(:api_key) { 'we123' }
  subject { described_class.new(company_id, api_key) }

  describe 'includes' do
    it 'is expected to include helpers' do
      expect(described_class.ancestors).to include(Nfeiow::Helpers)
    end
  end

  describe 'headers' do
    let(:expected_headers) do
      {
        "Content-Type": 'application/json',
        'Accept': 'application/json',
        'Authorization': api_key
      }
    end

    it 'has the correct headers' do
      expect(subject.headers).to eq expected_headers
    end
  end

  describe '#create_invoice', :vcr do
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
    end

    let!(:client) do
      subject.create_invoice(params)
    end

    it 'creates a new invoice and returns the correct result' do
      expect(client.success?).to eq true
      expect(client.error).to eq nil
      expect(client.value['id']).to eq '60264c29003cad1fdc8e06f0'
      expect(client.value['status']).to eq 'Created'
      expect(client.value['baseTaxAmount']).to eq 99.9
    end
  end

  describe '#cancel_invoice', :vcr do
    let(:invoice_id) { '60264c29003cad1fdc8e06f0' }
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
    let(:invoice_id) { '602653321f8db412f4b3a89a' }
    let!(:client) do
      subject.download_invoice_pdf(invoice_id)
    end

    it 'downloads an invoice and return the correct result' do
      expect(client.success?).to eq true
      expect(client.error).to eq nil
      expect(client.value).to eq 'https://nfse.blob.core.windows.net/44282121000149/dev/21/NFSE_00002609_MJYW.pdf?sv=2018-03-28&sr=b&sig=8IhdSLvlwa50GqeMCEcol2fsSbCJIoio7gRKWS%2BNmME%3D&st=2021-02-12T09%3A47%3A27Z&se=2021-02-12T10%3A37%3A27Z&sp=r'
    end
  end

  describe '#send_invoice_via_email', :vcr do
    let(:invoice_id) { '602653321f8db412f4b3a89a' }
    let!(:client) do
      subject.send_invoice_via_email(invoice_id)
    end

    it 'sends an invoice to the customer and returns the correct result' do
      expect(client.success?).to eq true
      expect(client.error).to eq nil
      expect(client.value).to eq "Executed"
    end
  end
end
