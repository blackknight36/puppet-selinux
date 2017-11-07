require 'spec_helper'
require 'shared_contexts'

describe 'selinux' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      ["libselinux", "libselinux-utils", "policycoreutils-python", "selinux-policy", "selinux-policy-devel", "selinux-policy-targeted"].each do |package|
        it { is_expected.to contain_package(package) .with({ "ensure" => "installed", }) }
      end

      it do
        is_expected.to contain_file("/etc/selinux/config")
      end

      # selinux_simple returns false when the current SELinux mode is not set to Enforcing
      # This exec ensure that SELinux is always set to Enforcing mode
      context "mode => enforcing" do
        let(:facts) {
          facts.merge({ :selinux_simple => false })
        }

        let(:params) {{ 'mode' => 'enforcing' }}

        it do
          is_expected.to contain_exec("/usr/sbin/setenforce 1")
        end
      end

      context "mode => permissive" do
        let(:facts) {
          facts.merge({ :selinux_simple => true })
        }

        let(:params) {{ 'mode' => 'permissive' }}

        it do
          is_expected.to contain_exec("/usr/sbin/setenforce 0")
        end
      end

    end
  end
end
