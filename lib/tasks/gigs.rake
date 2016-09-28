namespace :gigs do

  desc "Sync events to gignado"
  task :sync => :environment do
    gigs = GigOMatic::Service.new().gigs
    Gig::SyncFromGigo.new(gigs).update()
  end
end
