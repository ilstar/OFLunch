require "spec_helper"

describe MealTimeMailer do
  describe "close_reminder" do
    let(:mail) { MealTimeMailer.close_reminder }

    it "renders the headers" do
      mail.subject.should eq("Close reminder")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
