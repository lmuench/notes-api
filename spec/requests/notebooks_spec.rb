# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.describe 'Notebooks API', type: :request do
  let!(:notebooks) { create_list(:notebook, 10) }
  let(:notebook_id) { notebooks.first.id }

  describe 'GET /notebooks' do
    before { get '/notebooks' }

    it 'returns all notebooks' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /notebooks/:id' do
    before { get "/notebooks/#{notebook_id}" }

    context 'when the notebook exists' do
      it 'returns the notebook' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(notebook_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the notebook does not exist' do
      let(:notebook_id) { 11 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Notebook/)
      end
    end
  end

  describe 'POST /notebooks' do
    let(:valid_attributes) { { title: 'My title' } }

    context 'when the payload body is valid' do
      before { post '/notebooks', params: valid_attributes }

      it 'creates a notebook' do
        expect(json['title']).to eq('My title')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the payload body is invalid' do
      before { post '/notebooks' }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(
          /Validation failed: Title can't be blank/
        )
      end
    end
  end

  describe 'PUT /notebooks/:id' do
    let(:valid_attributes) { { title: 'My new title' } }

    context 'when the record exists' do
      before { put "/notebooks/#{notebook_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /notebooks/:id' do
    before { delete "/notebooks/#{notebook_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

# rubocop:enable Metrics/BlockLength
