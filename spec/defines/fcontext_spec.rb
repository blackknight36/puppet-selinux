require 'spec_helper'
require 'shared_contexts'

describe 'selinux::fcontext' do
  let(:title) { 'selinux_fcontext' }

  let(:facts) {{
    :selinux_simple => true,
  }}

  let(:params) {{
    :type => "default_t",
  }}

  it do
    is_expected.to contain_class('selinux')
  end

  it do
    is_expected.to contain_exec("/usr/sbin/semanage fcontext -a -t \"default_t\" \"#{title}\"")
        .with({
          :unless => "/usr/sbin/semanage fcontext -l | grep -q '^#{title}.*default_t'",
        })
        .that_requires('Class[selinux]')
  end

end
