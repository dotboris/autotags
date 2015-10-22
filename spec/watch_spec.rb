describe 'autotags watch' do
  context 'without a pidfile' do
    it 'should create a pidfile'
    it 'should start a process'

    it 'should generate ctags'
    it 'should add tags when adding a ruby function'
    it 'should remove tags when removing a function'
  end

  context 'with a pidfile and proc running' do
    it 'should complain'
  end

  context 'with a pidfile but no process' do
    it 'should complain'
  end
end
