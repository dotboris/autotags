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

      it 'should kill its children' do
        autotags 'watch', root
        sleep 0.1
        pidfile = root + '.autotags.pid'
        pid = pidfile.read.to_i
        children = `pgrep -P #{pid}`.split(/\s/)

        Process.kill :SIGTERM, pid
        sleep 0.1

        children.each do |child|
          expect(pid_running? child).to be false
        end
      end
    end

    it 'should generate ctags' do
      autotags 'watch', root
      sleep 0.1

      expect(root + '.ctags').to exist
    end

    it 'should add tags when adding a file with code' do
      autotags 'watch', root
      sleep 0.1

      (root + 'something.rb').write 'def some_function; end'
      sleep 0.1

      expect((root + '.ctags').read).to include 'some_function'
    end

    it 'should remove tags when removing file with code' do
      (root + 'something.rb').write 'def some_function; end'
      autotags 'watch', root
      sleep 0.1

      (root + 'something.rb').delete
      sleep 0.1

      expect((root + '.ctags').read).not_to include 'some_function'
    end

    it 'should not change tags when moving a file' do
      (root + 'something.rb').write 'def some_function; end'
      autotags 'watch', root
      sleep 0.1

      expect((root + '.ctags').read).to include 'some_function'
      (root + 'something.rb').rename(root + 'something_else.rb')
      sleep 0.1

      expect((root + '.ctags').read).to include 'some_function'
    end
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
