require 'spec_helper'

describe Vendor do
  it { should have_many(:menu_items) }
end
