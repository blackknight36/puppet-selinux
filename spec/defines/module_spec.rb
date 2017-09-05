require 'spec_helper'
require 'shared_contexts'

describe 'selinux::module' do
  let(:title) { 'selinux_module' }

  let(:facts) {{
    :selinux_simple => true,
  }}

  context "ensure => present" do
    let(:params) {{
      :ensure => "present",
      :modules_dir => "/usr/share/selinux",
    }}

    it do
      is_expected.to contain_file("/usr/share/selinux/#{title}")
          .with({
            "ensure" => "directory",
            "source" => "puppet:///modules/selinux/#{title}",
            "recurse" => "remote",
            "ignore" => nil,
            })
    end

    it do
      is_expected.to contain_file("/usr/share/selinux/#{title}/#{title}.te")
          .with({
            "ensure" => "file",
            "source" => "puppet:///modules/selinux/#{title}/#{title}.te",
            })
    end

    it do
      is_expected.to contain_exec("#{title}-makemod")
          .with({
            "command" => "make -f /usr/share/selinux/devel/Makefile",
            "refreshonly" => true,
            })
    end

    it do
      is_expected.to contain_selmodule("#{title}")
          .with({
            "ensure" => "present",
            "selmodulepath" => "/usr/share/selinux/#{title}/#{title}.pp",
            })
    end

    it do
      is_expected.to contain_exec("#{title}-enable")
          .with({
            "command" => "semodule -e #{title}",
            "onlyif" => "test -f /etc/selinux/targeted/modules/active/modules/#{title}.pp.disabled",
            })
    end
  end

  context "ensure => enabled" do
    let(:params) {{
      'ensure' => 'enabled'
    }}

    it do
      is_expected.to contain_exec("#{title}-enabled")
          .with({
            "command" => "semodule -e #{title}",
            "onlyif" => "test -f /etc/selinux/targeted/modules/active/modules/#{title}.pp.disabled",
            })
    end
  end

  context "ensure => disabled" do
    let(:params) {{
      'ensure' => 'disabled'
    }}

    it do
      is_expected.to contain_exec("#{title}-disabled")
          .with({
            "command" => "semodule -d #{title}",
            "onlyif" => "test -f /etc/selinux/targeted/modules/active/modules/#{title}.pp",
            })
    end
  end

  context "ensure => absent" do
    let(:params) {{
      'ensure' => 'absent'
    }}

    it { is_expected.to contain_selmodule(title) .with({ 'ensure' => 'absent' }) }

    it do
      is_expected.to contain_file("/usr/share/selinux/#{title}")
          .with({
            "ensure" => "absent",
            "purge" => true,
            "force" => true,
            })
    end
  end

end
