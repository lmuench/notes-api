# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.describe 'Notes API' do
  let!(:notebook) { create(:notebook) }
  let!(:notes) { create_list(:note, 10, notebook_id: notebook.id) }
  let(:notebook_id) { notebook.id }
  let(:id) { notes.first.id }

  # Test suite for GET /notebooks/:notebook_id/notes
  describe 'GET /notebooks/:notebook_id/notes' do
    before { get "/notebooks/#{notebook_id}/notes" }

    context 'when notebook exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all notebook notes' do
        expect(json.size).to eq(10)
      end
    end

    context 'when notebook does not exist' do
      let(:notebook_id) { 11 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Notebook/)
      end
    end
  end

  describe 'GET /notebooks/:notebook_id/notes/:id' do
    before { get "/notebooks/#{notebook_id}/notes/#{id}" }

    context 'when notebook note exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the note' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when notebook note does not exist' do
      let(:id) { 11 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Note/)
      end
    end
  end

  describe 'POST /notebooks/:notebook_id/notes' do
    let(:valid_attributes) { { subject: 'My subject', content: 'My content' } }

    before do
      post "/notebooks/#{notebook_id}/notes", params: valid_attributes
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end

  describe 'PUT /notebooks/:notebook_id/notes/:id' do
    let(:valid_attributes) { { subject: 'New subject', content: 'New content' } }

    before do
      put "/notebooks/#{notebook_id}/notes/#{id}", params: valid_attributes
    end

    context 'when note exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the note' do
        updated_note = Note.find(id)
        expect(updated_note.subject).to match(/New subject/)
        expect(updated_note.content).to match(/New content/)
      end
    end

    context 'when the note does not exist' do
      let(:id) { 11 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Note/)
      end
    end
  end

  describe 'DELETE /notebooks/:id' do
    before { delete "/notebooks/#{notebook_id}/notes/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

# rubocop:enable Metrics/BlockLength
