describe 'autotags' do
  context 'with no arguments' do
    it 'should fail' do
      expect(raw_autotags).not_to eq 0
    end
  end

  describe '-h' do
    it 'should succeed' do
      expect(raw_autotags '-h').to eq 0
    end
  end

  describe 'help' do
    it 'should succeed' do
      expect(autotags 'help').to eq 0
    end
  end
end
