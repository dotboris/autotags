describe 'autotags status' do
  let(:root) { tmpdir }

  after do
    begin
      pidfile = root + '.autotags.pid'
      if pidfile.exist?
        pid = pidfile.read.to_i
        Process.kill 9, pid
        Process.wait pid
      end
    rescue # rubocop:disable Lint/HandleExceptions
      # ignore error
    end

    root.rmtree
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
