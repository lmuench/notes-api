# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_notebook
  before_action :set_notebook_note, only: %i[show update destroy]

  # GET /notebooks/:notebook_id/notes
  def index
    json_response(@notebook.notes)
  end

  # GET /notebooks/:notebook_id/notes/:id
  def show
    json_response(@note)
  end

  # POST /notebooks/:notebook_id/notes
  def create
    @note = @notebook.notes.create!(note_params)
    json_response(@note, :created)
  end

  # PUT /notebooks/:notebook_id/notes/:id
  def update
    @note.update(note_params)
    head :no_content
  end

  # DELETE /notebooks/:notebook_id/notes/:id
  def destroy
    @note.destroy
    head :no_content
  end

  private

  def note_params
    params.permit(:subject, :content)
  end

  def set_notebook
    @notebook = Notebook.find(params[:notebook_id])
  end

  def set_notebook_note
    @note = @notebook.notes.find_by!(id: params[:id]) if @notebook
  end
end
