desc "generate balance for each user"

task :generate_balance_for_user => [:environment] do
  User.all.each do |user|
    user.balance = Balance.new(:amount => 0) if user.balance.nil?
  end
end

