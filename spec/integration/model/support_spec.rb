require 'rails_helper'

RSpec.describe Support, type: :integration do
  describe '#last_revision' do
    it 'should fetch the last revision'
  end

  describe '#reviewable?' do
    it 'need to be implemented'
  end

  describe '#languages_updatable?' do
    it 'need to be implemented'
  end
end
