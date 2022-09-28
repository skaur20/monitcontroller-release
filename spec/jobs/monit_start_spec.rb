# frozen_string_literal: true

require 'bosh/template/test'

describe 'monit_start errand job' do
  let(:release) { Bosh::Template::Test::ReleaseDir.new(File.join(File.dirname(__FILE__), '../..')) }
  let(:job) { release.job('monit_start') }

  describe 'run.sh' do
    let(:template) { job.template('bin/run') }

    it 'renders with no errors' do
      expect do
        template.render({ 'jobs' => ['lol'] }).to_not raise_error
      end
    end

    it 'renders with the correct paths' do
      rendered = template.render({ 'jobs' => ['lol'] })
      expect(rendered).to include('enabled_file=${disabled_file%.disable}')
      expect(rendered).to include('monit_file="/var/vcap/jobs/lol/monit"')
      expect(rendered).to include("disabled_file=$(find /var/vcap/monit/job -iname '*lol*.monitrc.disable')")
      expect(rendered).to_not include('exit $?')
    end

    describe 'instances property' do
      it 'will override job functioality' do
        spec = Bosh::Template::Test::InstanceSpec.new(name: 'myinstance')
        rendered = template.render({ 'jobs' => ['lol'], 'instances' => ['myinstance'] }, spec: spec)
        expect(rendered).to include('exit $?')
      end

      it 'will not affect other undeclared instances' do
        spec = Bosh::Template::Test::InstanceSpec.new(name: 'anotherinstance')
        rendered = template.render({ 'jobs' => ['lol'], 'instances' => ['myinstance'] }, spec: spec)
        expect(rendered).to_not include('exit $?')
      end
    end
  end
end
