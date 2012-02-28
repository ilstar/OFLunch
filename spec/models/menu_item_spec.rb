require 'spec_helper'

describe MenuItem do
  it { should belong_to(:vendor) }
end
