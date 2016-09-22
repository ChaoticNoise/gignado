class Gig
  class SyncWithGigo

    def update
      @gigo = ::Resource::GigOMatic::Service.new
      @gigo.gigs.each do |gigo|
        gig = find_or_new_gig(gigo)
        sync_gig_from_gigo(gig, gigo)
      end
    end

    def find_or_new_gig(gigo)
      Gig.find_by(gigo_key: gigo.key) || Gig.new(gigo_key: gigo.key)
    end

    def sync_gig_from_gigo(gig, gigo)
      gig.title = gigo.title
      gig.start_time = gigo.start
      gig.end_time = gigo.end
      gig.location = gigo.location
      gig.details = gigo.details
      gig.status = gigo.status
      gig.synced_at = DateTime.now
      gig.save
    rescue => e
      Rails.logger.warn("Gig::SyncWithGigo - could not sync #{gigo.title}\n#{e.message}")
    end
  end
end
