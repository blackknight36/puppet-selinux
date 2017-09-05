require 'spec_helper'
require 'shared_contexts'

describe 'selinux::boolean' do
  let(:title) { 'selinux_boolean' }

  let(:facts) {{
    :selinux_simple => true,
  }}

  [true, false].each do |persistent|
    context "value => on, persistent => #{persistent}" do
      let(:params) {{
        :value => 'on',
        :persistent => persistent,
      }}

      it do
        is_expected.to contain_selboolean("#{title}")
            .with({
              "persistent" => persistent,
              "value" => 'on',
              })
      end
    end
  end

  [true, false].each do |persistent|
    context "value => off, persistent => #{persistent}" do
      let(:params) {{
        :value => 'off',
        :persistent => persistent,
      }}

      it do
        is_expected.to contain_selboolean("#{title}")
            .with({
              "persistent" => persistent,
              "value" => 'off',
              })
      end
    end
  end
end
