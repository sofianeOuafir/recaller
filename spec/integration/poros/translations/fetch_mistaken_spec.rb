require 'rails_helper'

RSpec.describe Translations::FetchMistaken, type: :integration do
  let(:revision) { spy(Review) }
  describe '#process' do
    it 'should fetch the translations that have been mistaken'
  end
end
