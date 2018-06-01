# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  it { should belong_to(:notebook) }
end
