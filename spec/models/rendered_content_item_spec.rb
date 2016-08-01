require 'rails_helper'

RSpec.describe RenderedContentItem, type: :model do
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_presence_of(:checksum) }
  it { is_expected.to validate_presence_of(:pipeline) }
  it { is_expected.to allow_value('default').for(:pipeline) }
  it { is_expected.to allow_value('v1_bio').for(:pipeline) }
  it { is_expected.to allow_value('v1_content').for(:pipeline) }
  it { is_expected.to allow_value('v1_summary_120').for(:pipeline) }
  it { is_expected.to allow_value('v1_summary_160').for(:pipeline) }
  it { is_expected.to allow_value('notification_email').for(:pipeline) }
  it { is_expected.not_to allow_value('noop-pipeline').for(:pipeline) }
end
