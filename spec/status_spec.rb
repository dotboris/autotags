describe 'autotags status' do
  let(:root) { tmpdir }

  after do
    clean_dir root
  end

  context 'with no pidfile' do
    it 'should return 1' do
      expect(autotags 'status', root).to eq 1
    end
  end

  context 'with pidfile but no process' do
    it 'should return 2' do
      (root + '.autotags.pid').write '99999'

      expect(autotags 'status', root).to eq 2
    end
  end

  context 'with pidfile and process' do
    it 'should return 0' do
      pid = dummy_proc
      (root + '.autotags.pid').write pid

      expect(autotags 'status', root).to eq 0
    end
  end
end
