describe 'autotags watch' do
  let(:root) { tmpdir }

  after do
    clean_dir root
  end

  context 'without a pidfile' do
    it 'should succeed' do
      expect(autotags 'watch', root).to eq 0
      sleep 0.1 # give time for the pidfile to get created
    end

    it 'should create a pidfile' do
      autotags 'watch', root

      sleep 0.1

      expect(root + '.autotags.pid').to exist
    end

    it 'should start a process' do
      autotags 'watch', root

      sleep 0.1

      pid = (root + '.autotags.pid').read.to_i
      expect(pid_running? pid).to be true
    end

    context 'when killed' do
      it 'should remove its own pidfile' do
        autotags 'watch', root
        sleep 0.1
        pidfile = root + '.autotags.pid'
        pid = pidfile.read.to_i

        Process.kill :SIGTERM, pid
        sleep 0.1

        expect(pidfile).not_to exist
      end
    end

    it 'should generate ctags'
    it 'should add tags when adding a ruby function'
    it 'should remove tags when removing a function'
  end

  context 'with a pidfile and proc running' do
    it 'should complain' do
      pid = dummy_proc
      (root + '.autotags.pid').write pid

      expect(autotags 'watch', root).not_to eq 0
    end
  end

  context 'with a pidfile but no process' do
    it 'should complain' do
      (root + '.autotags.pid').write 9999

      expect(autotags 'watch', root).not_to eq 0
    end
  end
end
