require 'spec_helper'
require 'facter'

describe :selinux_simple, :type => :fact do
  before :all do
    # perform any action that should be run for the entire test suite
  end

  before :each do
    # perform any action that should be run before every test
    Facter.clear
    allow(Facter.fact("osfamily")).to receive(:value).and_return('replace_me')
    # This will mock the facts that confine uses to limit facts running under certain conditions
    allow(Facter.fact(:kernel)).to receive(:value).and_return(:linux)
  end

  it 'should return a value' do
    expect(Facter.fact(:selinux_simple).value).not_to be_nil
  end
end
