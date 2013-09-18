desc "This task will find and export users without debtor_id but with orders"
namespace :mapia do
  task :start => :environment do
    Parse::Mapia.create_roots
  end

  task :parse, [:count] => [:environment] do |t, args|
    count = args[:count] || 1000
    count.to_i.times{Parse::Mapia.where(:children_found => nil).where('item_type != ?', 'Place').first.process}
  end
end