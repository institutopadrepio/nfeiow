# frozen_string_literal: true

module Nfeiow
  class Client
    include Nfeiow::Helpers

    attr_reader :client_id, :api_key

    def initialize(company_id, api_key)
      @company_id = company_id
      @api_key = api_key
    end

    def connection
      @connection ||= Excon.new(
        'https://api.nfe.io/'
      )
    end

    def create_invoice(params)
      safe_http_call do
        connection.post(
          path: "/v1/companies/#{company_id}/serviceinvoices",
          headers: headers(api_key),
          body: params.to_json
        )
      end
    end

    def cancel_invoice(invoice_id)
      safe_http_call do
        connection.delete(
          path: "/v1/companies/#{company_id}/serviceinvoices/#{invoice_id}",
          headers: headers(api_key)
        )
      end
    end

    def download_invoice_pdf(invoice_id)
      safe_http_call do
        connection.get(
          path: "/v1/companies/#{company_id}/serviceinvoices/#{invoice_id}/pdf",
          headers: headers(api_key)
        )
      end
    end

    def send_invoice_via_email(invoice_id)
      safe_http_call do
        connection.put(
          path: "/v1/companies/#{company_id}/serviceinvoices/#{invoice_id}/sendemail",
          headers: headers(api_key)
        )
      end
    end

    private

    def safe_http_call
      response = yield
      raise response.body unless success_http_status(response.status)

      result(true, nil, JSON.parse(response.body))
    rescue StandardError => e
      result(false, e.message, nil)
    end

    def success_http_status(status)
      [200, 201, 202].include?(status)
    end
  end
end
