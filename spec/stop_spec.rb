describe 'autotags stop' do
  let(:root) { tmpdir }

  after do
    clean_dir root
  end

  context 'with a pidfile and running process' do
    let(:pid) { dummy_proc }

    before do
      (root + '.autotags.pid').write pid
    end

    it 'should kill the process' do
      autotags 'stop', root

      sleep 0.1

      expect(pid_running? pid).to be false
    end

    it 'should return 0' do
      expect(autotags 'stop', root).to eq 0
    end
  end

  context 'with a pidfile but no running process' do
    it 'should complain' do
      (root + '.autotags.pid').write 9999

      expect(autotags 'stop', root).not_to eq 0
    end
  end

  context 'with no pidfile' do
    it 'should complain' do
      expect(autotags 'stop', root).not_to eq 0
    end
  end
end
