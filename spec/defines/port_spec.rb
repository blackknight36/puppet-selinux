require 'spec_helper'
require 'shared_contexts'

describe 'selinux::port' do
  let(:title) { 'test_port' }

  let(:facts) do
    {}
  end

  context "ensure => present" do
    let(:params) do
      {
        :port => 89,
        :seltype => 'http_port_t',
        :ensure => "present",
        :proto => "tcp",
      }
    end

    it do
      is_expected.to contain_exec("semanage port -a -t http_port_t -p tcp 89")
          .with({
            "path" => "/bin:/usr/bin:/usr/sbin",
            "unless" => "semanage port -l | grep -qw 89",
            "onlyif" => nil,
          })
    end
  end

  context "ensure => absent" do
    let(:params) do
      {
        :port => 89,
        :seltype => 'http_port_t',
        :ensure => "absent",
        :proto => "tcp",
      }
    end

    it do
      is_expected.to contain_exec("semanage port -d -t http_port_t -p tcp 89")
          .with({
            "path" => "/bin:/usr/bin:/usr/sbin",
            "unless" => nil,
            "onlyif" => "semanage port -l | grep -qw 89",
          })
    end
  end
end
