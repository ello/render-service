require 'rails_helper'

RSpec.describe SourceContentItem, type: :model do
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_presence_of(:checksum) }
end
