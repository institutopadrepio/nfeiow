# frozen_string_literal: true

RSpec.describe Nfeiow::Client do
  subject { described_class }

  describe 'includes' do
    it 'is expected to include helpers' do
      expect(subject.ancestors).to include(Nfeiow::Helpers)
    end
  end

  describe 'headers' do
    let(:client) do
      described_class.new('123', '123')
    end

    let(:expected_headers) do
      {
        "Content-Type": 'application/json',
        'Accept': 'application/json',
        'Authorization': '123'
      }
    end

    it 'has the correct headers' do
      expect(client.headers).to eq expected_headers
    end
  end
end
