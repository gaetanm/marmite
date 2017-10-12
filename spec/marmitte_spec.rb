require "spec_helper"

RSpec.describe Marmite do
  it "has a version number" do
    expect(Marmite::VERSION).not_to be nil
  end
end
