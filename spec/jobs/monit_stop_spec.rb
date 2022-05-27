# frozen_string_literal: true

require 'bosh/template/test'

describe 'monit_stop errand job' do
  let(:release) { Bosh::Template::Test::ReleaseDir.new(File.join(File.dirname(__FILE__), '../..')) }
  let(:job) { release.job('monit_stop') }

  describe 'run.sh' do
    let(:template) { job.template('bin/run') }

    it 'renders with no errors' do
      expect do
        template.render({ 'jobs' => ['lol'] }).to_not raise_error
      end
    end

    it 'renders with the correct paths' do
      rendered = template.render({ 'jobs' => ['lol'] })
      expect(rendered).to include("enabled_file=$(find /var/vcap/monit/job -name '*lol*.monitrc')")
      expect(rendered).to include('monit_file="/var/vcap/jobs/lol/monit"')
      expect(rendered).to include('disabled_file="$enabled_file.disable"')
    end
  end
end
