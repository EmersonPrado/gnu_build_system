require 'spec_helper'
describe 'gnu_build_system' do
  context 'with default values for all parameters' do
    it { should contain_class('gnu_build_system') }
  end
end
