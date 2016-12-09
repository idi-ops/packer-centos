require_relative 'spec_helper'

describe 'box' do
  it 'should have a root user' do
    expect(user 'root').to exist
  end

  it 'should have a vagrant user' do
    expect(user 'vagrant').to exist
  end

  it 'should not have a .vbox_version file' do
    expect(file '/home/vagrant/.vbox_version').to_not be_file
  end

  it 'should disable SELinux' do
    expect(selinux).to be_permissive
  end

  describe package('systemd-journal-gateway') do
    it {should be_installed}
  end

  describe yumrepo('epel') do
    it { should exist  }
  end

  describe yumrepo('idi') do
    it { should exist  }
  end

  # Should be only one kernel
  describe command('ls -1 /boot/System.map* | wc -l') do
    its(:stdout) {should eq "1\n"}
  end

  # Ansible should be installed
  describe package('ansible') do
    it {should be_installed}
  end

  # Docker should be installed
  describe package('docker') do
    it {should be_installed}
  end

  # Docker sould be running
	describe service('docker') do
		it { should be_enabled }
		it { should be_running }
	end
end
